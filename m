Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B7AC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 17:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEE62075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 17:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQzA5qIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLZRWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:22:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43979 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZRWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 12:22:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so13114773pga.10;
        Thu, 26 Dec 2019 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l6FNc4QNuGPNE1Oy+AsJ/HcUQQhUOJ+/HyK0yE0YRTo=;
        b=vQzA5qImmRfD2Viy4OoHhSeUm+QmovQe6k6UgmOfo4fvkM/CXD/vijtbh+JKdxcHay
         hALLMOacPTTCyq3X11raB4Ud2m9xBznin3q/EetWqHSFXNN+QRvQ14dufx1PH8DHOYQy
         KDW47SB9NQTgo2kIT3MvPdv6UjPE/q70LSPpG8A4ndSKDxsIZ5k5UO8xmv0fSvRGN8lI
         BzAnNrBosEPg29fQb0QKTCMghBlJ6OMcGC3I8MSCdBmk9Hwo2PIUeTw203HjQrqxbnRt
         a6JmPOhY2YEo9rV5lPbCfoaK4B8lUC0RzUVnnTA1wWm2qyovHBJtSlm2iiQGLjWxBcyS
         mJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l6FNc4QNuGPNE1Oy+AsJ/HcUQQhUOJ+/HyK0yE0YRTo=;
        b=ka35tkT2NC29tx/7u92RsyqFmqhf2uqVJF38yiQZ8XuKsjsPby3sZ4VPVSoVWid7d4
         PQUQf3aM/8d8/Ns/21VCuYeDlUwhktFJ0MtUbH48rzQj1v+sKIXKHljRbsb44y9hlklg
         DbvoudhmfMuoOf3i8rhAw5KzPDkcaKQ8Kw65MfaWBSYJfbUzluJsxyIR4tdmgdb5eEQq
         djKjRN4YqeVMKwLjcV5Uv9CHklOtUl39Sx1/LmodwVljEok77LOOD+2t4cf3B68uNyCu
         jgnBT/74nNTsxCWUxmSakGRjpd9RFfCBT7v5tnvpNqotl/QkepJ2xOhzTBzSbgtFBoQ7
         eadg==
X-Gm-Message-State: APjAAAXaGC5Cm4XNcFGK9W3NWtq5LOKnUXP6tJL7bYLIyd4BXKsIAviG
        tXqySHgrU4LS4u/RVDWvmK6C9rwA
X-Google-Smtp-Source: APXvYqyEvJWlsXAytZd921Rhph3L83NAE4icdA/dphchI5YRrfhXDV06kSFwOM+s/HucnNokBs3wzA==
X-Received: by 2002:aa7:8181:: with SMTP id g1mr50402760pfi.215.1577380932643;
        Thu, 26 Dec 2019 09:22:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d23sm36583295pfo.176.2019.12.26.09.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:22:11 -0800 (PST)
Subject: Re: [PATCH] clk: Don't try to enable critical clocks if prepare
 failed
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191225163429.29694-1-linux@roeck-us.net>
 <1jd0cbpg77.fsf@starbuckisacylon.baylibre.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fed37460-6097-1a3d-3c05-e203871610ac@roeck-us.net>
Date:   Thu, 26 Dec 2019 09:22:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1jd0cbpg77.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/19 1:51 AM, Jerome Brunet wrote:
> 
> On Wed 25 Dec 2019 at 17:34, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> The following traceback is seen if a critical clock fails to prepare.
>>
>> bcm2835-clk 3f101000.cprman: plld: couldn't lock PLL
>> ------------[ cut here ]------------
>> Enabling unprepared plld_per
>> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:1014 clk_core_enable+0xcc/0x2c0
>> ...
>> Call trace:
>>   clk_core_enable+0xcc/0x2c0
>>   __clk_register+0x5c4/0x788
>>   devm_clk_hw_register+0x4c/0xb0
>>   bcm2835_register_pll_divider+0xc0/0x150
>>   bcm2835_clk_probe+0x134/0x1e8
>>   platform_drv_probe+0x50/0xa0
>>   really_probe+0xd4/0x308
>>   driver_probe_device+0x54/0xe8
>>   device_driver_attach+0x6c/0x78
>>   __driver_attach+0x54/0xd8
>> ...
>>
>> Check return values from clk_core_prepare() and clk_core_enable() and
>> bail out if any of those functions returns an error.
>>
>> Cc: Jerome Brunet <jbrunet@baylibre.com>
>> Fixes: 99652a469df1 ("clk: migrate the count of orphaned clocks at init")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/clk/clk.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 6a11239ccde3..772258de2d1f 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -3426,11 +3426,17 @@ static int __clk_core_init(struct clk_core *core)
>>   	if (core->flags & CLK_IS_CRITICAL) {
>>   		unsigned long flags;
>>   
>> -		clk_core_prepare(core);
>> +		ret = clk_core_prepare(core);
>> +		if (ret)
>> +			goto out;
>>   
>>   		flags = clk_enable_lock();
>> -		clk_core_enable(core);
>> +		ret = clk_core_enable(core);
>>   		clk_enable_unlock(flags);
>> +		if (ret) {
>> +			clk_core_unprepare(core);
>> +			goto out;
>> +		}
> 
> Hi Guenter,
> 
> It looks like it was a mistake to discard the possibility of a failure
> here. Thanks for correcting this.
> 
> However, we would not want a critical clock to silently fail to
> enable. This might lead to unexpected behavior which are generally hard
> (and annoying) to debug.
> 
> Would you mind adding some kind of warning trace in case this fails ?
> 

The really relevant information is:

bcm2835-clk 3f101000.cprman: plld: couldn't lock PLL

which is already displayed (and not surprising since cprman isn't implemented
in qemu). While I agree that an error message might be useful, replacing
one traceback with another doesn't really make sense to me, and I am not
really a friend of spreading tracebacks throughout the kernel. Please feel
free to consider this patch to be a bug report, and feel free to ignore it
and suggest something else.

Thanks,
Guenter
