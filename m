Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A2C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634EE217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfHEFkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 01:40:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfHEFki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 01:40:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E8C9ECD7BFBC6A7A222D;
        Mon,  5 Aug 2019 13:40:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 13:40:28 +0800
Subject: Re: [PATCH v3 06/10] powerpc/fsl_booke/32: implement KASLR
 infrastructure
To:     Diana Madalina Craciun <diana.craciun@nxp.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "jingxiangfeng@huawei.com" <jingxiangfeng@huawei.com>,
        "fanchengyang@huawei.com" <fanchengyang@huawei.com>,
        "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>
References: <20190731094318.26538-1-yanaijie@huawei.com>
 <20190731094318.26538-7-yanaijie@huawei.com>
 <VI1PR0401MB24637B79618C29684168D831FFD90@VI1PR0401MB2463.eurprd04.prod.outlook.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <356a9697-8208-3a63-8358-77422be482b2@huawei.com>
Date:   Mon, 5 Aug 2019 13:40:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB24637B79618C29684168D831FFD90@VI1PR0401MB2463.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Diana,

On 2019/8/2 16:41, Diana Madalina Craciun wrote:
>> diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
>> index de0980945510..6d2967673ac7 100644
>> --- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
>> +++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
>> @@ -161,17 +161,16 @@ skpinv:	addi	r6,r6,1				/* Increment */
>>   	lis	r6,(MAS1_VALID|MAS1_IPROT)@h
>>   	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_64M))@l
>>   	mtspr	SPRN_MAS1,r6
>> -	lis	r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@h
>> -	ori	r6,r6,MAS2_VAL(PAGE_OFFSET, BOOK3E_PAGESZ_64M, M_IF_NEEDED)@l
>> -	mtspr	SPRN_MAS2,r6
>> +	lis     r6,MAS2_EPN_MASK(BOOK3E_PAGESZ_64M)@h
>> +	ori     r6,r6,MAS2_EPN_MASK(BOOK3E_PAGESZ_64M)@l
>> +	and     r6,r6,r20
>> +	ori	r6,r6,M_IF_NEEDED@l
>> +	mtspr   SPRN_MAS2,r6
>>   	mtspr	SPRN_MAS3,r8
>>   	tlbwe
>>   
>>   /* 7. Jump to KERNELBASE mapping */
> The code has changed, but the comment reflects the old code (it no
> longer jumps to KERNELBASE, but to kimage_vaddr). This is true for step
> 6 as well.
> 

Good catch, I will update the comment.

Thanks,
Jason

