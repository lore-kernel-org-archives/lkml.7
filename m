Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF8C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967192075E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 22:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsezpdM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKXWK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 17:10:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38060 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKXWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 17:10:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so2923184ljh.5;
        Sun, 24 Nov 2019 14:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIvimmxh61dh33akQLRBV+SVzQv3ghkQ1Q6FQN6YS14=;
        b=MsezpdM/SL8BGidO6m96mQyZq3dgBheFqqSMSkoG4YaIeDNuSYA6AeFyyBk6zeHl3V
         NJSrxbdSM4NdqK5rSO7pBoJzLexnpfZxJVOK2S5hr96jwiOzOzu/b7TvExUDB8GxJ+oT
         NGqPpfbToHv/Ue5gqhP7Q9DmE0ObQfG0amvwJIDMfBDMjruqQP87X087xf7tSsFb3+uM
         73UGOUaqCTqJ/HFEzqd6BApM89Zdsl9lG9POtnWHKRUxJHjYxbY1Uq6DFWMHXBzPUXAg
         kSpkLn0YNMFhsKxeV4DpUOvKSYs3lf+casYTlwCbUfW+mkFJowM8GByk7mwPxIbBYKla
         xFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIvimmxh61dh33akQLRBV+SVzQv3ghkQ1Q6FQN6YS14=;
        b=WBM/2OaTecAGWotepjJW4uEyoc3odSPZkTfbJGpmarRQfpDHo6rXoc0dIGLwTBXEF3
         wF8erVxDg4laBidgu63ivRZ8SJCC3bZJUzGYUf7OFCY16dMwkC9t7fh2EY6/M7p2XPDQ
         HwcwzUZ+KLWlycLUb/togGMaPMQ4TlFhFDyhZDPjltd8P4dnexLqKN4Ty+G8ZfoSvTGj
         cSfnGjYCJDyJLoxSJ2wxYl1/7pyBgSoKz5b0loywg3f3MMecyG9nzi++ggBAoYdp4BGB
         SEGW60daYHZokdaXGB4N/AJb/W0KFytkYA4fzE2+9F7VgPW1WDjHb5tDvOkqWB8rJJMW
         yqbg==
X-Gm-Message-State: APjAAAVydjb7LCSrjdkbF7olJ4o4boEX1E+DFB5Ip5jnxVKFDCCAjJdD
        vlFNkHynnTyFXSCM6SqHAwY=
X-Google-Smtp-Source: APXvYqxFCft8hR8zRGvNRTTQX6k36aIdaD7aUsAXdVvrlmDU9JMDkWZ6LlEGDnzokv3GWCC6lpcI3A==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr20099211ljk.118.1574633424128;
        Sun, 24 Nov 2019 14:10:24 -0800 (PST)
Received: from rikard (h-158-174-187-196.NA.cust.bahnhof.se. [158.174.187.196])
        by smtp.gmail.com with ESMTPSA id m18sm2868238ljg.3.2019.11.24.14.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 14:10:23 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Sun, 24 Nov 2019 23:10:19 +0100
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     megous@megous.com, arnd@arndb.de, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, icenowy@aosc.io, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org
Subject: Re: [PATCH v2] phy: allwinner: Fix GENMASK misuse
Message-ID: <20191124221019.GA1186@rikard>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191110124355.1569-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110124355.1569-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 01:43:55PM +0100, Rikard Falkeborn wrote:
> Arguments are supposed to be ordered high then low.
> 
> Fixes: a228890f9458 ("phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Tested-by: Ondrej Jirman <megous@megous.com>
> ---
> v1->v2: Add fixes tax. Add Ondrejs Tested-by. No functional change.
> 
>  drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
> index 1169f3e83a6f..b1c04f71a31d 100644
> --- a/drivers/phy/allwinner/phy-sun50i-usb3.c
> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
> @@ -49,7 +49,7 @@
>  #define SUNXI_LOS_BIAS(n)		((n) << 3)
>  #define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
>  #define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
> -#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
> +#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(2, 0)
>  
>  struct sun50i_usb3_phy {
>  	struct phy *phy;
> -- 
> 2.24.0
> 

Ping
