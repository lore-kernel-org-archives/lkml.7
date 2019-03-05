Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26823C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8922B2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyYU/Zvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfCEVaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:30:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCEVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:30:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so6685554pfn.1;
        Tue, 05 Mar 2019 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OsiD+pEO2P34HR4UNyclDcmDzcvZo8GusN5e2ks18qY=;
        b=ZyYU/ZvdH9jesfqXrV0pbeWH8Vkrh2An5eHtQr9fmenRZwsBbS1o53waSsGfuU8mX7
         EPi0EuXvK1BzAZIbH4viBat17ccdDUTAQZ93JugBzIgzj6y7mu8jqFgM5nLVdiDCKFC/
         aSnGqVWOZeXz54vuzjyDjzDVlq5fI3lChfw++yJQuiU9tgviUMMLhRjzA7sz95ZSQrJ/
         WOm/rFe0M1Bm8nCgeEuon/ZO85uQBQEalbGVpFzAho5Evw0H2Q6bwmQUm4rXgy2G2fb5
         NSx4M3Uo+gTrWvZs2yiDj+sR0o4xD7U7OOOBQbYhdPpHDfIDn2GFpiex5kSDBHM8WgeS
         hfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OsiD+pEO2P34HR4UNyclDcmDzcvZo8GusN5e2ks18qY=;
        b=LzCxWFwlBnhNqAiIAmIJheiOJArNrPC0lNIWLb9/B5RsltPogEaE+5ftpzlhrLLeI4
         GG+SUE3s6HWfxDI3MBWIWwmcsoX577e0Nlt/om2lxcr4Dln52AeQzFlyWoWTZVuxBcEv
         eiJcosVp3KwYE6TRO7AcGEIgnvGFWg15C4O4KXR9L9g+yfllmRiuRQTi6BtUxWEVrTLZ
         f6Jp2un944F2+Lfd2CeE/QBCh7KJjECZDgfylYh0wu7VVi1syXaYfGtoMCQPybU+c0yT
         iye3/IToxah9/ydX3pjee+0FJHdWbXbuddTgapGDYTL3ifKH3Su7unaoGu2L7UmAPm8S
         ZjRw==
X-Gm-Message-State: APjAAAWg56IhkR+WUf0tKCWYs1JWimOgGMBeZcbdD0itPyVO9+UAsTQ5
        QvbdPgXJKQgBW0s3XIap7s4=
X-Google-Smtp-Source: APXvYqxkjI60stzBqC6DFKRLyybbwrnwfNuJHp5+4Ml9xlR1McfDpq6Txjeh+soXB6RWo245jjF1VA==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr3423091plr.188.1551821409820;
        Tue, 05 Mar 2019 13:30:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k18sm18431374pfj.92.2019.03.05.13.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 13:30:08 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:30:07 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: armada-38x: add interrupts for watchdog
Message-ID: <20190305213007.GA2825@roeck-us.net>
References: <20190305201924.14853-1-chris.packham@alliedtelesis.co.nz>
 <20190305201924.14853-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305201924.14853-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:19:22AM +1300, Chris Packham wrote:
> The first interrupt is for the regular watchdog timeout. Normally the
> RSTOUT line will trigger a reset before this interrupt fires but on
> systems with a non-standard reset it may still trigger.
> 
> The second interrupt is for a timer1 which is used as a pre-timeout for
> the watchdog.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - new, split out from "watchdog: orion_wdt: use timer1 as a pretimeout"
> 
>  arch/arm/boot/dts/armada-38x.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 929459c42760..fc550c640ca8 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -376,6 +376,8 @@
>  				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
>  				clocks = <&coreclk 2>, <&refclk>;
>  				clock-names = "nbclk", "fixed";
> +				interrupts-extended = <&gic GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&gic GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>;

This will need to be documented, possibly including the use of
interrupts-extended (currently only interrupts is documented in
Documentation/devicetree/bindings/watchdog/marvel.txt).

Also, how would it be handled if the primary interrupt is not specified ?
After all, it is optional.

Thanks,
Guenter
