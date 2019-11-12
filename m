Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481B3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19798206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lih8wHUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKLMxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:53:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38248 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLMxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:53:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so11487391wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 04:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PdLF3CON3lp+JHyPTH8iGB32KYNSuh1vXTDxtTcv+s=;
        b=lih8wHUSa7JBlyBDdzv3ehKrIStkykUffs0LjwQlGIX1DCqltL0ZDvNUwSrS9mHScW
         z/Kh91aAul5A5bSP7D70WhHFwNHwYfNUEJ3U7Y+WxI49gKH2fvkMyyOVToU6H/XUDxz+
         EakToBLTINmWE0ISpPUfi4qlc6iBtBBKVP5Saa5fLObEBjBDJKn7wbE46mBp0Ov3wXiu
         rhncLWw+b5KjNyRsv3bptwjPhvDE5fOZogP33ulTOyds9WERqwneFyNuYzOK6TqJlDgE
         DlXDWD7IZAFffIkzSYYUchBVxuz2XCAVz8G5KFELxH2O+5HdnkcVhkLALU0G3r7Bc9/P
         ZjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PdLF3CON3lp+JHyPTH8iGB32KYNSuh1vXTDxtTcv+s=;
        b=cAfUoc0u+WGgzJXsuMpoiEgWlPb+7vKVWq7vwiiefM1bVJVemiNknm73Goy+3sHnso
         mWynH9gM5E3lyVrOspKbf69gvu6LNG9TSmeTBv42Z5icWLKi9kSeRKUSlORvo8XbQ0Cr
         nHMn0G07aaoFyDX2rzVfJfXY8gR1XZdBgXe/dM0u3jJ9lRAa1V/5GBCrowxZd1CSbQja
         q9CZDdAr/VQgVGHgONj4ccRCxOhkXcA3G85MoUp6AAiKpjP3y46S5yzk8xIVdSZOCPzE
         Nn8uq7FIzfSByG3Jn37bE+zv7UgWBb+iUDCDCf8ejCjOiMSAYOTloDJM/1yUhb6UtOe/
         40SA==
X-Gm-Message-State: APjAAAVbVCoSp//dttE7Zl4g0rUXOdPwzRRwmUlAca7qDgTXeHU9rZgJ
        urCgi+RA/vOUrhQoh07gNa9RJwcmdwaINQ==
X-Google-Smtp-Source: APXvYqwyh6aG2sQ7lJc1UUG8l6HtLNK7oWi0ME1YR2Fm3vqBO9eHCcpDkoRXlWg6DiqsP1+DywQS8w==
X-Received: by 2002:adf:e701:: with SMTP id c1mr17609377wrm.166.1573563188372;
        Tue, 12 Nov 2019 04:53:08 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id b8sm17748271wrt.39.2019.11.12.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:53:07 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:53:05 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/2] ARM64: dts: allwinner: add pineh64 model B
Message-ID: <20191112125305.GD18647@Red>
References: <1573316433-40669-1-git-send-email-clabbe@baylibre.com>
 <1573316433-40669-3-git-send-email-clabbe@baylibre.com>
 <20191112120455.GY4345@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112120455.GY4345@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 01:04:55PM +0100, Maxime Ripard wrote:
> On Sat, Nov 09, 2019 at 04:20:33PM +0000, Corentin Labbe wrote:
> > This patch adds the model B of the PineH64.
> > The model B is smaller than the pine64 model A and has no PCIE slot.
> >
> > The only devicetree difference with the pineH64 model A, is the PHY
> > regulator and the HDMI connector node.
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../devicetree/bindings/arm/sunxi.yaml        |  5 +++++
> >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >  .../allwinner/sun50i-h6-pine-h64-modelB.dts   | 21 +++++++++++++++++++
> >  3 files changed, 27 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts
> >
> > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > index b8ec616c2538..227217bf28df 100644
> > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > @@ -604,6 +604,11 @@ properties:
> >            - const: pine64,pine-h64-modelA
> >            - const: allwinner,sun50i-h6
> >
> > +      - description: Pine64 PineH64 model B
> > +        items:
> > +          - const: pine64,pine-h64-modelB
> > +          - const: allwinner,sun50i-h6
> > +
> >        - description: Pine64 LTS
> >          items:
> >            - const: pine64,pine64-lts
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > index d2418021768b..bda89b9ccb4a 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -26,4 +26,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-3.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-lite2.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-modelB.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts
> > new file mode 100644
> > index 000000000000..063a85223faa
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelB.dts
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > +/*
> > + * Copyright (C) 2019 Corentin LABBE <clabbe@baylibre.com>
> > + */
> > +
> > +#include "sun50i-h6-pine-h64.dts"
> > +
> > +/ {
> > +	model = "Pine H64 model B";
> > +	compatible = "pine64,pine-h64-modelB", "allwinner,sun50i-h6";
> 
> compatibles are usually lowercase, what about pine64,pine-h64-model-b?
> 

Perfect, I will use it.

Regards
