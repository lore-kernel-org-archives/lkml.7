Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BA221479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEIMFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:05:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfEIMFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:05:16 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6199B880AAE572A87EC2;
        Thu,  9 May 2019 20:05:14 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.55) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 May 2019
 20:05:07 +0800
Subject: Re: Why do we mark vpending table as non-shareable in
 GICR_VPENDBASER?
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <fbee07c9-ec3b-d443-2132-7208dae38539@huawei.com>
 <867eb09i00.wl-marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        wanghaibin 00208455 <wanghaibin.wang@huawei.com>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <a19a1ce8-866a-d1da-12c5-8508485d64aa@huawei.com>
Date:   Thu, 9 May 2019 20:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <867eb09i00.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After thinking about it for a while, I feel it difficult to image how non shareable plus normal cacheable works for vpending table. Supposing the shareability bits are to direct the corresponding GICR to read/write table memory, if a vPE is first scheduled on pCPU0 with GICR0 and an VLPI is triggered, so a pending bit in vpending table is set by GICR0 (or ITS?); before the interrupt is activated, the vPE is then scheduled on pCPU1 with GICR1, could GICR1 still be guaranteed to see the pending bit in vpending table when the shareability is non-shareable?

It seems more reasonable for physical pending table to be non-shareable, for it is pinned with one GICR. Even with this assumption, the code will still fall back to non-cacheable cacheability when we have no more choice for shareability attribute other than non-shareable, as the comment says:

         /*
          * The HW reports non-shareable, we must remove the
          * cacheability attributes as well.
          */

Did I miss something?

Thanks,
Heyi

On 2019/5/9 15:58, Marc Zyngier wrote:
> On Thu, 09 May 2019 08:10:09 +0100,
> Heyi Guo <guoheyi@huawei.com> wrote:
>> Hi Marc,
>>
>> We can see in its_vpe_schedule() the shareability bits of
>> GICR_VPENDBASER are set as non-shareable, But we set physical
>> PENDBASER as inner-shareable. Is there any special reason for doing
>> this? If it is because the vpending table is GICR specific, why
>> don't we do the same for physical pending table?
> That's a good question. They should have similar attributes.
>
>> We have not seen function issue with this setting, but a special
>> detector in our hardware warns us that there are non-shareable
>> requests sent out while some inner shareable cache entries still
>> present in the cache, and it may cause data inconsistent.
> The main issue with the inner-shareable attributes and the GIC is that
> nothing in the spec says that CPUs and GIC have to be in the same
> inner-shareable domain, as the system can have as many as you want.
>
> You obviously have built it with GICR in the same inner-shareability
> domain as the CPU. I'm happy to change the VPENDBASER attributes,
> given that the CPU has a mapping to that memory already, and that
> shouldn't affect systems where GICR isn't in the same inner shareable
> domain anyway.
>
> Thanks,
>
> 	M.
>


