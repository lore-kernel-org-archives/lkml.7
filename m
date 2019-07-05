Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28861C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EF2216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfGEQ3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:29:11 -0400
Received: from foss.arm.com ([217.140.110.172]:43616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfGEQ3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:29:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 736042B;
        Fri,  5 Jul 2019 09:29:10 -0700 (PDT)
Received: from [10.1.38.41] (unknown [10.1.38.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90FC3F246;
        Fri,  5 Jul 2019 09:29:07 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 6/8] iommu/arm-smmu-v3: Support auxiliary domains
To:     Will Deacon <will@kernel.org>
Cc:     Will Deacon <Will.Deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-7-jean-philippe.brucker@arm.com>
 <20190626175959.ubxvb2qn4taclact@willie-the-truck>
Message-ID: <7cad065e-5eba-bd22-5c1d-c55ad315ace0@arm.com>
Date:   Fri, 5 Jul 2019 17:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626175959.ubxvb2qn4taclact@willie-the-truck>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2019 18:59, Will Deacon wrote:
>> +static void arm_smmu_aux_detach_dev(struct iommu_domain *domain, struct device *dev)
>> +{
>> +	struct iommu_domain *parent_domain;
>> +	struct arm_smmu_domain *parent_smmu_domain;
>> +	struct arm_smmu_master *master = dev_to_master(dev);
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +
>> +	if (!arm_smmu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
>> +		return;
>> +
>> +	parent_domain = iommu_get_domain_for_dev(dev);
>> +	if (!parent_domain)
>> +		return;
>> +	parent_smmu_domain = to_smmu_domain(parent_domain);
>> +
>> +	mutex_lock(&smmu_domain->init_mutex);
>> +	if (!smmu_domain->aux_nr_devs)
>> +		goto out_unlock;
>> +
>> +	if (!--smmu_domain->aux_nr_devs) {
>> +		arm_smmu_write_ctx_desc(parent_smmu_domain, smmu_domain->ssid,
>> +					NULL);
>> +		/*
>> +		 * TLB doesn't need invalidation since accesses from the device
>> +		 * can't use this domain's ASID once the CD is clear.
>> +		 *
>> +		 * Sadly that doesn't apply to ATCs, which are PASID tagged.
>> +		 * Invalidate all other devices as well, because even though
>> +		 * they weren't 'officially' attached to the auxiliary domain,
>> +		 * they could have formed ATC entries.
>> +		 */
>> +		arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> 
> I've been struggling to understand the locking here, since both
> arm_smmu_write_ctx_desc and arm_smmu_atc_inv_domain take and release the
> devices_lock for the domain. Is there not a problem with devices coming and
> going in-between the two calls?

Yes it's a problem. I suppose we could take the parent's init_mutex
(making sure that it protects detach_dev() as well.

First I need to figure out how to prevent the parent domain from
disappearing when auxiliary domains are attached, I seem to have forgotten
that. I think checking if AUXD is enabled in the device passed to
attach_dev() should be sufficient - that's what I do for SVA. But the
IOMMU API isn't quite ready to handle failure in iommu_detach_device() at
the moment. VFIO will free the domain even if it's still attached.

> 
>> +	} else {
>> +		struct arm_smmu_cmdq_ent cmd;
>> +
>> +		/* Invalidate only this device's ATC */
>> +		if (master->ats_enabled) {
>> +			arm_smmu_atc_inv_to_cmd(smmu_domain->ssid, 0, 0, &cmd);
>> +			arm_smmu_atc_inv_master(master, &cmd);
>> +		}
>> +	}
>> +out_unlock:
>> +	mutex_unlock(&smmu_domain->init_mutex);
>> +}
>> +
>> +static int arm_smmu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>> +{
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +
>> +	return smmu_domain->ssid ?: -EINVAL;
>> +}
>> +
>>  static struct iommu_ops arm_smmu_ops = {
>>  	.capable		= arm_smmu_capable,
>>  	.domain_alloc		= arm_smmu_domain_alloc,
>> @@ -2539,6 +2772,13 @@ static struct iommu_ops arm_smmu_ops = {
>>  	.of_xlate		= arm_smmu_of_xlate,
>>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>>  	.put_resv_regions	= arm_smmu_put_resv_regions,
>> +	.dev_has_feat		= arm_smmu_dev_has_feature,
>> +	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
>> +	.dev_enable_feat	= arm_smmu_dev_enable_feature,
>> +	.dev_disable_feat	= arm_smmu_dev_disable_feature,
> 
> Why can't we use the existing ->capable and ->dev_{get,set}_attr callbacks
> for this?

->capable isn't very useful because it applies to all SMMUs in the
system. The existing ->{get,set}_attr callbacks apply to an
iommu_domain. The main reason for doing it on endpoints was that it
would be tedious to keep track of capabilities when attaching and
detaching devices to a domain, especially for drivers that allow
multiple IOMMUs per domain [1]. There were more discussions, and in the
end Joerg proposed the current API for device attributes [2]

[1]
https://lore.kernel.org/lkml/aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com/
[2] https://lore.kernel.org/linux-iommu/20181207102926.GM16835@8bytes.org/

Thanks,
Jean
