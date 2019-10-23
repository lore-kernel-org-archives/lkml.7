Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A599C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4D0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luap40pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407069AbfJWQLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:11:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42633 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404582AbfJWQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:11:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id s20so10199000edq.9;
        Wed, 23 Oct 2019 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEjYGuFDJrMtrXX28Gh+2EM+3SRNT/CDGLTrMQV4RPQ=;
        b=luap40pq1IOiaysCcwqoFg5JhvjuYI58xG336hxCAjC5t7l0ZIBbxPCs9DtlY4XHE8
         m30O1POKuGyjb8TrPzy5UnowNQur79oppVRXH6t2HJ76jY8QPjgsg+ZAVnbZrWaYaLM/
         /8Jxd28WWa5LVaCpHkf7W9CJbcdduXyUdTQU64VZmn8MmJOG3yewBiXxgy6L+L0t2eOd
         EKRbooz7We/J/CEDWQMGe5ZvPJKN8oqzBG1us9KPJ/MsC6zvuHfeZUJ3dhkQRU//0q0I
         RaeEW+mf6/vwdSrnKYbg7Nx024JnlPrBWNljq5oAGt1xQ6ltJmkE1h0jxjuwE2erAtLF
         9h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEjYGuFDJrMtrXX28Gh+2EM+3SRNT/CDGLTrMQV4RPQ=;
        b=gv2HTAUQsfF0dNcMV1mblNGbh8Lk1MBB0n1EuV6kQLqcviuL4FN4TxG6L1eQkhqvwe
         d/nNLA6drCiPueWMa7Jw8ZQkNnkLigih52vQm9Sb2Vxi77msyeP9oZyC1SW1wNVdCIeH
         CJmDOVEKJyte1ZtURD7nlq2fSD3ZlhQbnsfL6ibVHC6AqoWCdqbg0LCl/n6eTiO4w7r0
         9c7Zt8EJjj58aPsUL6toZ7nEf2JaLZdDQ/mePmZQcrjrEvADP+YVUgZvGSj9SuGh0O2x
         clBXS67J5F6p6nRDrKcbk9OPMDG/+vH/mJgotPWLePgV9u5twnlOR5KRGT+p0v05GgGN
         ojww==
X-Gm-Message-State: APjAAAUgGDFaq6EpTXzmhq/EerUgPnWy227JME8isYx3DBuo6HsVWmwX
        5/VfDBzJn6p6UCziLu91E39F1Ycv1TM=
X-Google-Smtp-Source: APXvYqz6G69Xr/QHHsEOv7Z9RPjQiaDFNG9k4aq6vlk+hxuv9mV24MHbULGrRGBGRc6JlOGNv7h/Og==
X-Received: by 2002:a17:906:6087:: with SMTP id t7mr33950448ejj.58.1571847093904;
        Wed, 23 Oct 2019 09:11:33 -0700 (PDT)
Received: from localhost (ip1f113d5e.dynamic.kabel-deutschland.de. [31.17.61.94])
        by smtp.gmail.com with ESMTPSA id p9sm68270edx.4.2019.10.23.09.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 09:11:32 -0700 (PDT)
Date:   Wed, 23 Oct 2019 18:11:32 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     m.felsch@pengutronix.de, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv6 2/2] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
Message-ID: <20191023161132.GD20321@ripley>
References: <1569342022-15901-1-git-send-email-oliver.graute@gmail.com>
 <1569342022-15901-3-git-send-email-oliver.graute@gmail.com>
 <20191014072047.GG12262@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014072047.GG12262@dragon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/19, Shawn Guo wrote:
> On Tue, Sep 24, 2019 at 06:20:21PM +0200, Oliver Graute wrote:
> > This patch adds DeviceTree Source for the i.MX6 UltraLite DART NAND/WIFI
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Changelog:
> > v6:
> >  - added some muxing
> >  - added codec in sound node
> >  - added adc1 node
> > 
> >  arch/arm/boot/dts/Makefile                      |   1 +
> >  arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts | 221 ++++++++++++++++++++++++
> >  2 files changed, 222 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index a24a6a1..a2a69e4 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -579,6 +579,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
> >  	imx6ul-tx6ul-0010.dtb \
> >  	imx6ul-tx6ul-0011.dtb \
> >  	imx6ul-tx6ul-mainboard.dtb \
> > +	imx6ul-var-6ulcustomboard.dtb \
> >  	imx6ull-14x14-evk.dtb \
> >  	imx6ull-colibri-eval-v3.dtb \
> >  	imx6ull-colibri-wifi-eval-v3.dtb \
> > diff --git a/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> > new file mode 100644
> > index 00000000..031d8d4
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: (GPL-2.0)
> > +/*
> > + * Support for Variscite DART-6UL Module
> > + *
> > + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> > + * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
> > + * Copyright (C) 2018-2019 Oliver Graute <oliver.graute@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/input/input.h>
> > +#include "imx6ul-imx6ull-var-dart-common.dtsi"
> > +
> > +/ {
> > +	model = "Variscite i.MX6 UltraLite Carrier-board";
> > +	compatible = "variscite,6ulcustomboard", "fsl,imx6ul";
> 
> The compatible needs to be documented.

I'am not sure if I got this right. Is this the way to document it?
or is there more to do?

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 41db01d..3ed497b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -173,6 +173,7 @@ properties:
               - armadeus,imx6ul-opos6uldev # OPOS6UL (i.MX6UL) SoM on OPOS6ULDev board
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
               - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
+              - variscite,6ulcustomboard" # i.MX UltraLite Carrier-board
           - const: fsl,imx6ul

Best Regards,

Oliver
