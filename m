Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F99C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDD02186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfHHDcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:32:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728167AbfHHDcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:32:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3D4052C20B76651BD2F9;
        Thu,  8 Aug 2019 11:32:13 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 11:32:04 +0800
Subject: Re: [PATCH v5 02/10] powerpc: move memstart_addr and kernstart_addr
 to init-common.c
To:     Michael Ellerman <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>
References: <20190807065706.11411-1-yanaijie@huawei.com>
 <20190807065706.11411-3-yanaijie@huawei.com>
 <874l2tuo0t.fsf@concordia.ellerman.id.au>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <d2e0d1e5-cf6d-1c82-bae6-60e34f651cc1@huawei.com>
Date:   Thu, 8 Aug 2019 11:32:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <874l2tuo0t.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/7 21:02, Michael Ellerman wrote:
> Jason Yan <yanaijie@huawei.com> writes:
>> These two variables are both defined in init_32.c and init_64.c. Move
>> them to init-common.c.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Cc: Diana Craciun <diana.craciun@nxp.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
>> Tested-by: Diana Craciun <diana.craciun@nxp.com>
>> ---
>>   arch/powerpc/mm/init-common.c | 5 +++++
>>   arch/powerpc/mm/init_32.c     | 5 -----
>>   arch/powerpc/mm/init_64.c     | 5 -----
>>   3 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
>> index a84da92920f7..152ae0d21435 100644
>> --- a/arch/powerpc/mm/init-common.c
>> +++ b/arch/powerpc/mm/init-common.c
>> @@ -21,6 +21,11 @@
>>   #include <asm/pgtable.h>
>>   #include <asm/kup.h>
>>   
>> +phys_addr_t memstart_addr = (phys_addr_t)~0ull;
>> +EXPORT_SYMBOL_GPL(memstart_addr);
>> +phys_addr_t kernstart_addr;
>> +EXPORT_SYMBOL_GPL(kernstart_addr);
> 
> Would be nice if these can be __ro_after_init ?
> 

Good idea.

> cheers
> 
> .
> 

