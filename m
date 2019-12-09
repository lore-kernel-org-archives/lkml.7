Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788E9C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F420663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyWaTa3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLIUTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:19:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39003 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:19:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so17154048ljj.6;
        Mon, 09 Dec 2019 12:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n1EdrnRTVcraROl5/h8aaMtwkvgNtthE6B0nadUQmNM=;
        b=YyWaTa3gnmdIYwVKVbmo7iBU4bN5OGGRfD/62puTS0gNvrMO2Gn52AUyhSnCwq8CMd
         wR03rB0TUPJbC5zMlN44+k7hjCwO+baR8t4mgLtW40gBXm/sehCBVm5s5M+xKBVhoGhr
         W/ev/YydmL+HcKZLZvpcF7/hBtf/4WOgcYSrxRDzXmzCDtgZVbXlj5Dnl38zVEgiPBMC
         S5Ar3nDEgmaur+OOaj3gG60Pb+KKkNB1wit28dY2jcQhMKrG3TL3IQkdm520wfV07mtg
         J4SGJavVx2XoiPZWucDtJiYVUC0192OwXrhD/noBjLMJGN5Fw2PeTQfe6oUeJoGpxhzF
         SS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n1EdrnRTVcraROl5/h8aaMtwkvgNtthE6B0nadUQmNM=;
        b=CYVX9Rtlna9fLL7/k/no4qcrIwTK9BKv+iWZABLKD36PltZLT6HWT8Rjv7enQWiTYT
         fD12LODkf8agla1cuHCFLrYnsxZeVgD44TQyS4d+7KkmXJctbSTJYj4YGfSIZJ65fp7J
         iQkg4eP/9ylkUWlUefGGy94+3w4qoAt3CLiv1HBbuQ/hzB6OWW1sszVLmAYhnbl8uDgL
         iRy0HJiMIn5WOsMRtauahfQObtsulHshrf+5O3CtgK3k5GK7a/yMhAJvJjWBZDDPSz0p
         TSe0UhLG1ycbiNqLFl8/Qg3utX6ZDRyUBBQw7WiBJJhB6F3XsLueke4+eTCjeKHftOJo
         6saA==
X-Gm-Message-State: APjAAAUZ+Kz55wy0rtuK8HsmFqPNGewPabYB2puAhD0BMT1tmYOqqUhd
        jX1NsYzz4RUESHo67rag5a0=
X-Google-Smtp-Source: APXvYqyfu7gL7wbNI0OOFWaQIsqDNwc4LTHSY9AuWl7rOPaR/iVf8RbBzzn3iTnZxmGFFwaacn/o1A==
X-Received: by 2002:a2e:5751:: with SMTP id r17mr18245968ljd.254.1575922742313;
        Mon, 09 Dec 2019 12:19:02 -0800 (PST)
Received: from rikard (h-158-174-187-196.NA.cust.bahnhof.se. [158.174.187.196])
        by smtp.gmail.com with ESMTPSA id i19sm237269lfj.17.2019.12.09.12.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 12:19:01 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Mon, 9 Dec 2019 21:18:58 +0100
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>, kishon@ti.com
Cc:     megous@megous.com, arnd@arndb.de, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, icenowy@aosc.io, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org
Subject: Re: [PATCH v2] phy: allwinner: Fix GENMASK misuse
Message-ID: <20191209201858.GA1223@rikard>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191110124355.1569-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110124355.1569-1-rikard.falkeborn@gmail.com>
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

Ping.
