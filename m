Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C5AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FAC2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfHHIUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:20:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731281AbfHHIUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:20:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11ECB394B576ED660B8E;
        Thu,  8 Aug 2019 16:20:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 16:19:50 +0800
Subject: Re: [PATCH v5 09/10] powerpc/fsl_booke/kaslr: support nokaslr cmdline
 parameter
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
 <20190807065706.11411-10-yanaijie@huawei.com>
 <87y305t9dv.fsf@concordia.ellerman.id.au>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <7218f89b-8724-55f3-e834-5dc4722fdb8f@huawei.com>
Date:   Thu, 8 Aug 2019 16:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87y305t9dv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/7 21:03, Michael Ellerman wrote:
> Jason Yan <yanaijie@huawei.com> writes:
>> diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
>> index c6b326424b54..436f9a03f385 100644
>> --- a/arch/powerpc/kernel/kaslr_booke.c
>> +++ b/arch/powerpc/kernel/kaslr_booke.c
>> @@ -361,6 +361,18 @@ static unsigned long __init kaslr_choose_location(void *dt_ptr, phys_addr_t size
>>   	return kaslr_offset;
>>   }
>>   
>> +static inline __init bool kaslr_disabled(void)
>> +{
>> +	char *str;
>> +
>> +	str = strstr(boot_command_line, "nokaslr");
>> +	if (str == boot_command_line ||
>> +	    (str > boot_command_line && *(str - 1) == ' '))
>> +		return true;
> 
> This extra logic doesn't work for "nokaslrfoo". Is it worth it?
> 

Seems nobody likes this logic. Maybe I can delete this logic for now and
see if anyone has any objections.

> cheers
> 
> .
> 

