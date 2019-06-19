Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E81C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5826A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfFSLyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:54:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfFSLyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:54:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89DB6360;
        Wed, 19 Jun 2019 04:54:16 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F893F738;
        Wed, 19 Jun 2019 04:56:01 -0700 (PDT)
Subject: Re: [PATCH 3/8] iommu/arm-smmu-v3: Support platform SSID
To:     Will Deacon <will.deacon@arm.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
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
 <20190610184714.6786-4-jean-philippe.brucker@arm.com>
 <20190618180851.GK4270@fuggles.cambridge.arm.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <73cfb797-5ae7-b9d9-01ea-fe98a1bed5c3@arm.com>
Date:   Wed, 19 Jun 2019 12:53:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618180851.GK4270@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 19:08, Will Deacon wrote:
>> +	/*
>> +	 * If the SMMU doesn't support 2-stage CD, limit the linear
>> +	 * tables to a reasonable number of contexts, let's say
>> +	 * 64kB / sizeof(ctx_desc) = 1024 = 2^10
>> +	 */
>> +	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB))
>> +		master->ssid_bits = min(master->ssid_bits, 10U);
> 
> Please introduce a #define for the 10, so that it is computed in the way
> you describe in the comment (a bit like we do for things like queue sizes).

Ok

>> +
>>  	group = iommu_group_get_for_dev(dev);
>>  	if (!IS_ERR(group)) {
>>  		iommu_group_put(group);
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index f04a6df65eb8..04f4f6b95d82 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -206,8 +206,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>  			if (err)
>>  				break;
>>  		}
>> -	}
>>  
>> +		fwspec = dev_iommu_fwspec_get(dev);
>> +		if (!err && fwspec)
>> +			of_property_read_u32(master_np, "pasid-num-bits",
>> +					     &fwspec->num_pasid_bits);
>> +	}
> 
> Hmm. Do you know if there's anything in ACPI for this?

Yes, IORT version D introduced a "substream width" field for the Named
component node (platform device). I don't think it existed last time I
checked, so I'll see about supporting it.

Thanks,
Jean
