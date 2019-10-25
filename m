Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B47CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768A021D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 18:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="TkkERhIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbfJYSKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 14:10:39 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:58994 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732355AbfJYSIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ukusdiIWPioOyFF8K+EMog1oWe2UbKn/QGBiyiSBlcI=; b=TkkERhIk8BBAwoGeaxAN1ziqjG
        l+PP57GcZFlFrZe+8Ex1cit7g7VgrEpsXkPptk1n8IbWDzMu4ghOXS5+62xp6kJ68ILnVYvF6h+T/
        HtNN8wIp29Z8E9XjPQBeBDXoJGiW4TzIZZPdYPZ+jLas/GjF5jghcn34foMfTYFkiKO8=;
Received: from p200300ccff09ca001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:ca00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iO401-0005qr-ID; Fri, 25 Oct 2019 20:07:45 +0200
Date:   Fri, 25 Oct 2019 20:07:43 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marex@denx.de, angus@akkea.ca, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx: add devicetree for Kobo Clara HD
Message-ID: <20191025200743.48455cc9@aktux>
In-Reply-To: <20191025134621.GN3208@dragon>
References: <20191010192357.27884-1-andreas@kemnade.info>
        <20191010192357.27884-4-andreas@kemnade.info>
        <20191025134621.GN3208@dragon>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Oct 2019 21:46:24 +0800
Shawn Guo <shawnguo@kernel.org> wrote:

[...]
> > +
> > +		pinctrl_wifi_reset: wifi_reset_grp {
> > +			fsl,pins = <
> > +				MX6SLL_PAD_SD2_DATA7__GPIO5_IO00	0x10059		/* WIFI_RST */
> > +			>;
> > +		};
> > +
> > +		pinctrl_wifi_power: wifi_power_grp {  
> 
> I guess you can have one pinctrl node to include both reset and power
> pins?  Also, to be consistent with other pinctrl nodes on naming, the
> node name should probably be wifigrp.
> 
well, the problems they are used in different nodes, so I cannot do
that:

       reg_wifi: regulator-wifi {
                compatible = "regulator-fixed";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_wifi_power>;
                regulator-name = "SD3_SPWR";
                regulator-min-microvolt = <3000000>;
                regulator-max-microvolt = <3000000>;
                gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
                enable-active-high;
        };

        wifi_pwrseq: wifi_pwrseq {
                compatible = "mmc-pwrseq-simple";
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_wifi_reset>;
                post-power-on-delay-ms = <20>;
                reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
        };

So having them combined breaks the mux where you use it rule.
I got in earlier mails:

> > +	wifi_pwrseq: wifi_pwrseq {
> > +		compatible = "mmc-pwrseq-simple";
> > +		post-power-on-delay-ms = <20>;
> > +		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;  

> Can you add a pinctrl-entry here please? The general rule is to mux
> things where you use it
[...]
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "SD3_SPWR";
> > +			regulator-min-microvolt = <3000000>;
> > +			regulator-max-microvolt = <3000000>;
> > +
> > +			gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;  

> Please add a pinctrl here to mux this gpio.

Regards,
Andreas
