Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D69EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69864208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfENHgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfENHgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F01F308622E;
        Tue, 14 May 2019 07:36:49 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F6C862724;
        Tue, 14 May 2019 07:36:42 +0000 (UTC)
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
 <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
 <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
 <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
 <20190513151637.79c273e2@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <0da76e57-76f6-06fa-d34e-30cd0c294984@redhat.com>
Date:   Tue, 14 May 2019 09:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190513151637.79c273e2@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 14 May 2019 07:36:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 5/14/19 12:16 AM, Jacob Pan wrote:
> On Mon, 13 May 2019 18:09:48 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 13/05/2019 17:50, Auger Eric wrote:
>>>> struct iommu_inv_pasid_info {
>>>> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
>>>> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
>>>> 	__u32	flags;
>>>> 	__u32	archid;
>>>> 	__u64	pasid;
>>>> };  
>>> I agree it does the job now. However it looks a bit strange to do a
>>> PASID based invalidation in my case - SMMUv3 nested stage - where I
>>> don't have any PASID involved.
>>>
>>> Couldn't we call it context based invalidation then? A context can
>>> be tagged by a PASID or/and an ARCHID.  
>>
>> I think calling it "context" would be confusing as well (I shouldn't
>> have used it earlier), since VT-d uses that name for device table
>> entries (=STE on Arm SMMU). Maybe "addr_space"?
>>
> I am still struggling to understand what ARCHID is after scanning
> through SMMUv3.1 spec. It seems to be a constant for a given SMMU. Why
> do you need to pass it down every time? Could you point to me the
> document or explain a little more on ARCHID use cases.
> We have three fileds called pasid under this struct
> iommu_cache_invalidate_info{}
> Gets confusing :)
archid is a generic term. That's why you did not find it in the spec ;-)

On ARM SMMU the archid is called the ASID (Address Space ID, up to 16
bits. The ASID is stored in the Context Descriptor Entry (your PASID
entry) and thus characterizes a given stage 1 translation
"context"/"adress space".

At the moment the ASID is allocated per iommu domain. With aux domains
we should have one ASID per aux domain, Jean-Philippe said.

ASID tags IOTLB S1 entries. As the ASID is part of the "context
descriptor" which is owned by the guest, the API must pass it somehow.

4.4.1.2 CMD_TLBI_NH_ASID(VMID, ASID) invalidation command allows to
invalidate all IOTLB S1 entries for a given VMID/ASID and this is the
functionality which is currently missing in the API. This is not an
address based invalidation or a "pure" PASID based invalidation. At the
moment we don't support PASIDs on ARM and I need this capability.

Thanks

Eric



>> Thanks,
>> Jean
>>
>>>
>>> Domain invalidation would invalidate all the contexts belonging to
>>> that domain.
>>>
>>> Thanks
>>>
>>> Eric  
> 
> [Jacob Pan]
> 
