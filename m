Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78857C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F236204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E69EF/g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEOAKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:10:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38508 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfEOAKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:10:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so390559plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4SoXHx5mpTgQd7eRTwT5Sm5OnDgP1mzN+IrEBUFaD40=;
        b=E69EF/g95+Q9j1KG6Xl2+AVFojp2ZvLQehQtGcHEDQI30LUzCeKkzUELWAP8Lygal5
         fCY5ft15dY/uMkUWpO16TnfAH0g47mFItMeB/3MbZAlAjsUhnD/Uzl+pzOSvltAjZ95s
         w1OjSeOjh1RH7vOEoZ/RgyWvki3YPCL1tHYWCT9Zht16sbiPXDR7lUbOZQ8TSQlo8y5d
         tzgtD3LEZNVbd/ODAmhp9vEvgVy9PKOK4JPIzfdBpjtRNzb04n/SIBGGhniOvI5Azefi
         N8qc4vkLObwZrdwB9N2Kp823NlOh1okPQfSK02sKK01s7OYwo/MAym27QWcHJ7VDv/AH
         oW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4SoXHx5mpTgQd7eRTwT5Sm5OnDgP1mzN+IrEBUFaD40=;
        b=KE2M3TY8yu5FbrCZWBpdeBDlSmBUzl8vVzc9hH+0T794Kg6eas8nfK1OEqJIAelGBI
         Vwt8o+8WRTjrBxdDwrScjSLiNhbor3tj9SWERrl8SUb8JvLlfUsX1Zlc4IlEmX24w4fE
         2sM7+LHvrDLd0RVEMbw79/PhE5rdeSpC7xOGG2AlmDcWf/A6aBGOnM/0sJ5DPRw/K6mI
         qA/an24ukHwycY3nFRFOL/XfROH2iqEYBcI13EwtrUKmAAqnbd1EF+OnVkEZ0w9SANUW
         CyZarOa07bpRXyBt+vaCJnWXUF+CxxqeQE2CUy8qCZis4CfWSpsK94Bg89XI3HFHB9i9
         WV2g==
X-Gm-Message-State: APjAAAUDLmhme2HmWfdEdTDLDhKlkSa6TtGzfpsrlOllyHBK2DTFK9p5
        cXACx3Z/JqjN5HsvmNy0afc3lshH7ORr2Q==
X-Google-Smtp-Source: APXvYqykgYRCTCRHHO487dD/RFNDIaE47TVbzBDS/rehZQT2tkG9YHa+22a4vtWuLib/YQQYxsq9rA==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr28155221pld.204.1557879049023;
        Tue, 14 May 2019 17:10:49 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id f17sm262534pgv.16.2019.05.14.17.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:10:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: meson: g12a: add ethernet pinctrl definitions
In-Reply-To: <7244c6d3e81e7bbb84ac508399ab64e236051673.camel@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com> <20190510164940.13496-3-jbrunet@baylibre.com> <CAFBinCAmGRHDU5QX2VEsV8vLBXD6fJtcRHbjdW8=p9Yti0V4qA@mail.gmail.com> <7244c6d3e81e7bbb84ac508399ab64e236051673.camel@baylibre.com>
Date:   Tue, 14 May 2019 17:10:47 -0700
Message-ID: <7hpnokd1bs.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Sat, 2019-05-11 at 19:06 +0200, Martin Blumenstingl wrote:
>> Hi Jerome,
>> 
>> On Fri, May 10, 2019 at 6:49 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> > Add the ethernet pinctrl settings for RMII, RGMII and internal phy leds
>> > 
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > ---
>> >  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
>> >  1 file changed, 37 insertions(+)
>> > 
>> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> > index a32db09809f7..fe0f73730525 100644
>> > --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
>> > @@ -206,6 +206,43 @@
>> >                                                 };
>> >                                         };
>> > 
>> > +                                       eth_leds_pins: eth-leds {
>> > +                                               mux {
>> > +                                                       groups = "eth_link_led",
>> > +                                                                "eth_act_led";
>> > +                                                       function = "eth";
>> > +                                                       bias-disable;
>> > +                                               };
>> > +                                       };
>> > +
>> > +                                       eth_rmii_pins: eth-rmii {
>> > +                                               mux {
>> > +                                                       groups = "eth_mdio",
>> > +                                                                "eth_mdc",
>> > +                                                                "eth_rgmii_rx_clk",
>> > +                                                                "eth_rx_dv",
>> > +                                                                "eth_rxd0",
>> > +                                                                "eth_rxd1",
>> > +                                                                "eth_txen",
>> > +                                                                "eth_txd0",
>> > +                                                                "eth_txd1";
>> > +                                                       function = "eth";
>> > +                                                       bias-disable;
>> > +                                               };
>> > +                                       };
>> > +
>> > +                                       eth_rgmii_pins: eth-rgmii {
>> > +                                               mux {
>> > +                                                       groups = "eth_rxd2_rgmii",
>> > +                                                                "eth_rxd3_rgmii",
>> > +                                                                "eth_rgmii_tx_clk",
>> > +                                                                "eth_txd2_rgmii",
>> > +                                                                "eth_txd3_rgmii";
>> > +                                                       function = "eth";
>> > +                                                       bias-disable;
>> > +                                               };
>> > +                                       };
>> it seems that the group definition is incomplete (missing things like
>> eth_mdc, eth_rx_dv, ...)
>> 
>> we could also mix the eth_rmii_pins and eth_rgmii_pins in a board.dts
>> (maybe that was your idea in the first place?):
>
> yes that's the idea
>
>>   phy-mode = "rgmii";
>>   pinctrl-0 = <&eth_rmii_pins>, <&eth_rgmii_pins>;
>>   pinctrl-names = "default";
>> however, in this case I would prefer if "eth_rmii_pins" was named only
>> "eth_pins" (following mostly what Amlogic does with the pin group
>> naming: eth_* for pins that are valid in both, rmii and rgmii mode and
>> eth*rgmii* for pins that are only valid in rgmii mode)
>
> I can't say I share your preference. I let Kevin decide what he wants.
>
It seems we've gone the eth_pins route for meson-gxl.dtsi, so I'd prefer
to be consistent with that.

Kevin
