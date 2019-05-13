Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8575C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D715208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfEMRKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:10:12 -0400
Received: from foss.arm.com ([217.140.101.70]:33826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbfEMRKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:10:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2DEE341;
        Mon, 13 May 2019 10:10:11 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFA893F71E;
        Mon, 13 May 2019 10:10:09 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To:     Auger Eric <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
 <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
 <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
Date:   Mon, 13 May 2019 18:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2019 17:50, Auger Eric wrote:
>> struct iommu_inv_pasid_info {
>> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
>> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
>> 	__u32	flags;
>> 	__u32	archid;
>> 	__u64	pasid;
>> };
> I agree it does the job now. However it looks a bit strange to do a
> PASID based invalidation in my case - SMMUv3 nested stage - where I
> don't have any PASID involved.
> 
> Couldn't we call it context based invalidation then? A context can be
> tagged by a PASID or/and an ARCHID.

I think calling it "context" would be confusing as well (I shouldn't
have used it earlier), since VT-d uses that name for device table
entries (=STE on Arm SMMU). Maybe "addr_space"?

Thanks,
Jean

> 
> Domain invalidation would invalidate all the contexts belonging to that
> domain.
> 
> Thanks
> 
> Eric
