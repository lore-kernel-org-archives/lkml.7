Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DBAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6522080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfD3Uh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:37:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3Uh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:37:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF71A30A3AFE;
        Tue, 30 Apr 2019 20:37:57 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E406299C;
        Tue, 30 Apr 2019 20:37:55 +0000 (UTC)
Subject: Re: [PATCH] iommu/vt-d: Fix intel_pasid_max_id
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org
References: <20190430072940.10467-1-eric.auger@redhat.com>
 <20190430110108.7c751195@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <1f71902d-28c6-4e63-b4b8-dafbb8881694@redhat.com>
Date:   Tue, 30 Apr 2019 22:37:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190430110108.7c751195@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 30 Apr 2019 20:37:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/30/19 8:01 PM, Jacob Pan wrote:
> On Tue, 30 Apr 2019 09:29:40 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Extended Capability Register PSS field (PASID Size Supported)
>> corresponds to the PASID bit size -1.
>>
>> "A value of N in this field indicates hardware supports PASID
>> field of N+1 bits (For example, value of 7 in this field,
>> indicates 8-bit PASIDs are supported)".
>>
>> Fix the computation of intel_pasid_max_id accordingly.
>>
>> Fixes: 562831747f62 ("iommu/vt-d: Global PASID name space")
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 28cb713d728c..c3f1bfc81d2e 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -3331,7 +3331,7 @@ static int __init init_dmars(void)
>>  		 * than the smallest supported.
>>  		 */
>>  		if (pasid_supported(iommu)) {
>> -			u32 temp = 2 << ecap_pss(iommu->ecap);
>> +			u32 temp = 2 << (ecap_pss(iommu->ecap) + 1);
> here it is "2 << bits" not "1 << bits", so the original code is correct.
> 
> But I agree it would be more clear to the spec. if we do:
> 1 << (ecap_pss(iommu->ecap) + 1);
Oups OK, my eyes. Forget it :-(

Thanks

Eric
>>  
>>  			intel_pasid_max_id = min_t(u32, temp,
>>  						   intel_pasid_max_id);
> 
