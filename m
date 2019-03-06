Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC01C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC4520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9zPxo9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfCFPt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:49:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfCFPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wg9YyR9jm3cYOM6tiDzT7E7sgKI2jmCpliy2yz57EwY=; b=F9zPxo9duHtjG3o2oieO4xwBw
        xYXL8ZtyS+ST44gC/En6Hrm80jY+oH1mco2WC/jKx4iJ/0WPm5SnY2ylQk8rK2T+cmZiE38/dmDZb
        Rp2dBKa+a3jvFCg4M6w8UsGHY/mX3MW8STou12WB+brGCLuIb88oAIpOdQPItuyRRbfNmiVYvXACG
        YBvgtXO/haP9JeSpJo8NnKTuhzUEqofrL7PROR5cTTGEobdw/O+h5X14grRwYdll4VmmNw/JYYpZz
        Y1aw2kMtPmCq+wzeb4kt61cyZz/WBqPRV1V3y99faou9Mg9z254Xp5RcAF9UHS2cMDSP55qak8kKU
        rWQiN0Zfg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1YnQ-000660-AM; Wed, 06 Mar 2019 15:49:28 +0000
Subject: Re: [PATCH] extcon-ptn5150: fix COMPILE_TEST dependencies
To:     Arnd Bergmann <arnd@arndb.de>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190306110906.2622957-1-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bcfbf645-c865-a7ad-ada6-bd77ac665f32@infradead.org>
Date:   Wed, 6 Mar 2019 07:49:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306110906.2622957-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 3:08 AM, Arnd Bergmann wrote:
> The PTN5150 dependencies look like they were meant to do the
> right thing, but they actually should not allow building without
> I2C for compile testing, as that results in a Kconfig warning
> and subsequent build failure:
> 
> WARNING: unmet direct dependencies detected for REGMAP_I2C
>   Depends on [m]: I2C [=m]
>   Selected by [y]:
>   - EXTCON_PTN5150 [=y] && EXTCON [=y] && (I2C [=m] && GPIOLIB [=y] || COMPILE_TEST [=y])
>   Selected by [m]:
>   - EEPROM_AT24 [=m] && I2C [=m] && SYSFS [=y]
>   - KEYBOARD_CAP11XX [=m] && !UML && INPUT [=y] && INPUT_KEYBOARD [=y] && OF [=y] && I2C [=m]
>   - INPUT_DRV260X_HAPTICS [=m] && !UML && INPUT_MISC [=y] && INPUT [=y] && I2C [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>   - ... [many others]
> 
> Add parentheses around the expression so we can compile-test
> without GPIOLIB but not without I2C.
> 
> Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Chanwoo,

You might want to drop my patch and use this one from Arnd instead...


> ---
>  drivers/extcon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 8e17149655f0..540e8cd16ee6 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -116,7 +116,7 @@ config EXTCON_PALMAS
>  
>  config EXTCON_PTN5150
>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
> -	depends on I2C && GPIOLIB || COMPILE_TEST
> +	depends on I2C && (GPIOLIB || COMPILE_TEST)
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable support for USB peripheral and USB host
> 


-- 
~Randy
