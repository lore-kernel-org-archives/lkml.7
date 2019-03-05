Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4F3C10F03
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CED20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tDMvnmOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCEAJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:09:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfCEAJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eoj9pOY4iQ5+Pipyb8CxFtPlpusxpsKNR/L48Welrc4=; b=tDMvnmOq/jiq1cnbsHnWdvI9/
        npqNcAGNu4Hcx3xPdCYc3ZcfL1PEOG30krsf9Ziz05+1f+G3GRXH9pQNoUE8RpKGFTxhURs6UpDRB
        wZ2+HxuF0UgHfPgtmIXFtDZVzcTRoTipC7dNRp+p/zcbC9/3b1CesTxn+tYsEgMoquI2LtuB9LFoa
        lGF6WO72Ky8Cp+SkSI/Alj7Y5ahLsR6eqEr2OvaI5WiNKyvLsPjFA8eBXbjOijoIh17r/RDvLupy6
        kHQXftKSjpLw7Izqz0XQ0ihyfOn22SDAjaM1tubWAxBmExo7tB8qf8nhxrjxSChmwq1hKfaNZsLKK
        o0VmKborw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0xdv-0000Ef-Et; Tue, 05 Mar 2019 00:09:11 +0000
Subject: Re: [PATCH 3/3] x86: apuv2: select LEDS_CLASS
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Linus Walleij <linusw@kernel.org>, Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190304201930.1622839-1-arnd@arndb.de>
 <20190304201930.1622839-3-arnd@arndb.de>
 <24c191e1-f607-1320-2474-3db92383e383@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5f1511e-c750-8fb2-0bfe-c73bc7905b22@infradead.org>
Date:   Mon, 4 Mar 2019 16:09:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <24c191e1-f607-1320-2474-3db92383e383@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 4:03 PM, Enrico Weigelt, metux IT consult wrote:
> On 04.03.19 21:19, Arnd Bergmann wrote:
>> LEDS_GPIO can only be selected when LEDS_CLASS is already enabled:
>>
>> WARNING: unmet direct dependencies detected for LEDS_GPIO
>>   Depends on [m]: NEW_LEDS [=y] && LEDS_CLASS [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>>   Selected by [y]:
>>   - PCENGINES_APU2 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && INPUT_KEYBOARD [=y]
>>
>> Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/platform/x86/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 4d65d37b0c86..d64529352a9c 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1308,6 +1308,7 @@ config PCENGINES_APU2
>>  	depends on INPUT && INPUT_KEYBOARD
>>  	select GPIO_AMD_FCH
>>  	select KEYBOARD_GPIO_POLLED
>> +	select LEDS_CLASS
>>  	select LEDS_GPIO
>>  	help
>>  	  This driver provides support for the front button and LEDs on
>>
> 
> ACK. Just was about to post the same :)
> 
> Reviewed-by: Enrico Weigelt, metux It consult <info@metux.net>
> 

Enrico, you were also cc-ed on this patch on Feb.25, 2019:

https://marc.info/?l=linux-kernel&m=155113875310485&w=2


> 
> thx.
> 
> --mtx
> 


-- 
~Randy
