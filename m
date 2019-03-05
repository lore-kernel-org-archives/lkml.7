Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E86C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA39C2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq2FRKya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfCERRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:17:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35475 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCERRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:17:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id e17so6073918pgd.2;
        Tue, 05 Mar 2019 09:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/7b8M0CCW3SEgOA19Z77npMOfEbrkCdOfgSC9V3ldzA=;
        b=Aq2FRKyaCLZfMmBCVmMIVj/oamfkzpu94Me1uEtD+2zjW/xunUlr0omBsnqeLWXE0o
         HMStnCZ0KRq32j45gFIemCmA5Ol+kiqHsyTcc6qk1Lkw7AAHzu9apy3LX7uxKyeBzMK5
         ZNojdp5D66tuPtUGuN4SUpa8Td+6Qs++/LYwvVL96YE5ov0Er/PXFl/LfnUkdQu+G2OM
         l7DLAXSdAikJWxfht3C75YNdM8lv/DZT2jxk6gxj/qNwcrn1CtBsqRR3Ae3lnvCNXxKo
         WQ++nRHCSGRzHX5WJDEvs34ZglcZNqFZpDvU9wxFunkpKXFiZrEYu4Y0uQUOhqJSgCau
         n62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/7b8M0CCW3SEgOA19Z77npMOfEbrkCdOfgSC9V3ldzA=;
        b=a793CijgL/s+wbe4jan7R70mgqHiR77mR/Ap5kZbATX5Zl2zitnxnforTZvn6m0GyI
         sBPXRkHOCtoFxE2oyVN0oxsUJSDJy1ilP/aXmURURfxZHBbdGM6jGLDSU5vfePkHv2bj
         CICnPtaJ6LeL6loE4jFtBQ1isiYBRidH31mPdp9caUzCE9NZ3A2mXiC+bkw7+St2p+Qf
         GC7bCo6t2KSrNFae9GRrHRB19pbuPIl27kPFHrnAX041oTsX7rpPAxQAyYN3StY/QlE0
         3P6hzMOxi6YEO0y0es15Pe1yOtk/6J+Y+awO0i72ZwjONJLI90DL9qE1FRjCeojefzp+
         EJ4Q==
X-Gm-Message-State: APjAAAW4TLtQ4Zyx8WuXX5OD9xTJo4mElSmMDYX/PtNYuBPj8RTMEhub
        JUE0TH55wFr6axWZFT7jhxvByBq3
X-Google-Smtp-Source: APXvYqzaYE/OsigMrxfC1lVCexn+jJlDUflfoUv86uqCZvrOFmcIAOfXYq5b8lSGeb1pkcEXu9xEMg==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr2316459plp.183.1551806265797;
        Tue, 05 Mar 2019 09:17:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k125sm29772645pgc.51.2019.03.05.09.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 09:17:45 -0800 (PST)
Date:   Tue, 5 Mar 2019 09:17:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com, jason@lakedaemon.net,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH 1/2] watchdog: orion_wdt: remove orion_wdt_set_timeout
Message-ID: <20190305171744.GA32623@roeck-us.net>
References: <20190227230707.GA28635@roeck-us.net>
 <20190304225152.26831-1-chris.packham@alliedtelesis.co.nz>
 <20190304225152.26831-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304225152.26831-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:51:51AM +1300, Chris Packham wrote:
> The watchdog core will do the same thing if no set_timeout
> is supplied so we can safely remove orion_wdt_set_timeout.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/orion_wdt.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 9db3b09f7568..8b259c712c52 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -349,13 +349,6 @@ static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
>  	return readl(dev->reg + dev->data->wdt_counter_offset) / dev->clk_rate;
>  }
>  
> -static int orion_wdt_set_timeout(struct watchdog_device *wdt_dev,
> -				 unsigned int timeout)
> -{
> -	wdt_dev->timeout = timeout;
> -	return 0;
> -}
> -
>  static const struct watchdog_info orion_wdt_info = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>  	.identity = "Orion Watchdog",
> @@ -366,7 +359,6 @@ static const struct watchdog_ops orion_wdt_ops = {
>  	.start = orion_wdt_start,
>  	.stop = orion_wdt_stop,
>  	.ping = orion_wdt_ping,
> -	.set_timeout = orion_wdt_set_timeout,
>  	.get_timeleft = orion_wdt_get_timeleft,
>  };
>  
> -- 
> 2.21.0
> 
