Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E687FC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E0B20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfGKNV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:21:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfGKNV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:21:29 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 195C15D88BFEB4F3D97C;
        Thu, 11 Jul 2019 21:21:26 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 21:21:20 +0800
Subject: Re: [PATCH] hpet: Fix division by zero in hpet_time_div()
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Clemens Ladisch <clemens@ladisch.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190711112619.57256-1-wangkefeng.wang@huawei.com>
 <CAK8P3a3M3cNZm4meO+_vPkJcjtq7Fu5SrnJ11FAkOtGW3WBvNw@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <54205e31-30e3-ec2f-015d-7ba65d0d4927@huawei.com>
Date:   Thu, 11 Jul 2019 21:21:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3M3cNZm4meO+_vPkJcjtq7Fu5SrnJ11FAkOtGW3WBvNw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/11 20:32, Arnd Bergmann wrote:
> On Thu, Jul 11, 2019 at 1:20 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> The base value in do_div() called by hpet_time_div() is truncated from
>> unsigned long to uint32_t, resulting in a divide-by-zero exception.
> 
> Good catch!
> 
>> --- a/drivers/char/hpet.c
>> +++ b/drivers/char/hpet.c
>> @@ -567,7 +567,7 @@ static inline unsigned long hpet_time_div(struct hpets *hpets,
>>         unsigned long long m;
>>
>>         m = hpets->hp_tick_freq + (dis >> 1);
>> -       do_div(m, dis);
>> +       div64_ul(m, dis);
>>         return (unsigned long)m;
>>  }
> 
> This still looks wrong to me: div64_ul() unlike do_div() does not
> modify its argument, so you have to assign the output like
> 
>        return div64_ul(m, dis);

right, should check div64_ul more carefully， will resend v2, thanks

> 
>        Arnd
> 
> 

