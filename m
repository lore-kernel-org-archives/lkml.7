Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1492EC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2562173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1mDD1bzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfEKR1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:27:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37959 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfEKR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:27:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so10137548wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ugYp5dhniPXHr02G59QHXf3+78cHsNWpN1Q+YKzxEj4=;
        b=1mDD1bzrGGV6SNyFAqYnkyZPqZA/z1+1EBO918vqkFMiIE8ORcFDL7UFwnOxAFMZx3
         ROipS+ZEyLlkoizefpbo5eZBXFHpWuZ/Z5/gkvy9IBnxUmVtm0hvIlyFFVIRUA6UMDty
         6gZV0qvYPxgM79T3cu3VQjJus6Up9+6raiJWPV0/LRIawGGUjTfp1oDa06Yktu4OVkAQ
         R04g4VPnE5KhQSY9m6VDXxiZyb4MkYK/k3kTtUjfFyQbhbtVFBYFIDUGPSWA/bfm0kYU
         Fcyyj58q1ZFJlp3Lfk7OhSofGmbLcihznfCjYusINULg2zsNVKJ+iAsD55JHB//J/zHp
         k4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ugYp5dhniPXHr02G59QHXf3+78cHsNWpN1Q+YKzxEj4=;
        b=SpXUU04OkiXeCAcLYXgCWX2IcYmIl1r9fk3AkZWBfNeGzNysfo6Lo02z0D9ZffPVu6
         YaTDsqzeHbkd9IxtlbpFFpR5OJraRRj+rI5Llp8muD+CJJPH4Ov9pTEPrugVwlA1pSTA
         4/TIq1QKZNNIbkcieauUf2Q595lczqxVCXVSAnJvnFhWszeQLm86cCpaawlVM7fc6DDA
         WhfoqTYR1Oxt1X9RfExlq40rxPHXN421bKZOyWQKcY7usJ5McmfIDbHlWhlNtqVud1TK
         N4SSromYdAl/gq85btpg5DtQdLxqklskZDPu8J1iXovGr794ieiSQOizZXbHN8E/BIFL
         Q50g==
X-Gm-Message-State: APjAAAXfNFghxrBVOH+yWVWKekjbvoer9URE46s5uBcnkMSJsaIYiuAN
        05gQ2d0/4HcnYzAABjoIiwS45A==
X-Google-Smtp-Source: APXvYqy9MKkZc7Ku2c7o8LbKyEi1zO+hTm+WXU4uGdfyOBQIVnCrnBZXdmHpFVoCOxWLpqyI9FTugw==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr10510136wma.120.1557595671603;
        Sat, 11 May 2019 10:27:51 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id l21sm7128970wmh.35.2019.05.11.10.27.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 11 May 2019 10:27:50 -0700 (PDT)
Message-ID: <7244c6d3e81e7bbb84ac508399ab64e236051673.camel@baylibre.com>
Subject: Re: [PATCH 2/5] arm64: dts: meson: g12a: add ethernet pinctrl
 definitions
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 May 2019 19:27:49 +0200
In-Reply-To: <CAFBinCAmGRHDU5QX2VEsV8vLBXD6fJtcRHbjdW8=p9Yti0V4qA@mail.gmail.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
         <20190510164940.13496-3-jbrunet@baylibre.com>
         <CAFBinCAmGRHDU5QX2VEsV8vLBXD6fJtcRHbjdW8=p9Yti0V4qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 19:06 +0200, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Fri, May 10, 2019 at 6:49 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Add the ethernet pinctrl settings for RMII, RGMII and internal phy leds
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> > index a32db09809f7..fe0f73730525 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> > @@ -206,6 +206,43 @@
> >                                                 };
> >                                         };
> > 
> > +                                       eth_leds_pins: eth-leds {
> > +                                               mux {
> > +                                                       groups = "eth_link_led",
> > +                                                                "eth_act_led";
> > +                                                       function = "eth";
> > +                                                       bias-disable;
> > +                                               };
> > +                                       };
> > +
> > +                                       eth_rmii_pins: eth-rmii {
> > +                                               mux {
> > +                                                       groups = "eth_mdio",
> > +                                                                "eth_mdc",
> > +                                                                "eth_rgmii_rx_clk",
> > +                                                                "eth_rx_dv",
> > +                                                                "eth_rxd0",
> > +                                                                "eth_rxd1",
> > +                                                                "eth_txen",
> > +                                                                "eth_txd0",
> > +                                                                "eth_txd1";
> > +                                                       function = "eth";
> > +                                                       bias-disable;
> > +                                               };
> > +                                       };
> > +
> > +                                       eth_rgmii_pins: eth-rgmii {
> > +                                               mux {
> > +                                                       groups = "eth_rxd2_rgmii",
> > +                                                                "eth_rxd3_rgmii",
> > +                                                                "eth_rgmii_tx_clk",
> > +                                                                "eth_txd2_rgmii",
> > +                                                                "eth_txd3_rgmii";
> > +                                                       function = "eth";
> > +                                                       bias-disable;
> > +                                               };
> > +                                       };
> it seems that the group definition is incomplete (missing things like
> eth_mdc, eth_rx_dv, ...)
> 
> we could also mix the eth_rmii_pins and eth_rgmii_pins in a board.dts
> (maybe that was your idea in the first place?):

yes that's the idea

>   phy-mode = "rgmii";
>   pinctrl-0 = <&eth_rmii_pins>, <&eth_rgmii_pins>;
>   pinctrl-names = "default";
> however, in this case I would prefer if "eth_rmii_pins" was named only
> "eth_pins" (following mostly what Amlogic does with the pin group
> naming: eth_* for pins that are valid in both, rmii and rgmii mode and
> eth*rgmii* for pins that are only valid in rgmii mode)

I can't say I share your preference. I let Kevin decide what he wants.

> 
> 
> Regards
> Martin


