Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B810C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B874279BB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 18:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfFBSX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 14:23:28 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:50700 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFBSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:23:28 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 65491803AE;
        Sun,  2 Jun 2019 20:23:21 +0200 (CEST)
Date:   Sun, 2 Jun 2019 20:23:19 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH 1/2] dt-bindings: display: Add King Display KD035G6-54NT
 panel documentation
Message-ID: <20190602182319.GA10060@ravnborg.org>
References: <20190602164844.15659-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602164844.15659-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=N0__P5O1gIEKdnP-nygA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

As already said on irc, maybe add:

"The generic bindings for the SPI slaves documented in [1] also applies"
as we see other binding using spi already does.

Looking at: sitronix,st7789v.txt
should reg also be specified as required here?

	Sam

On Sun, Jun 02, 2019 at 06:48:43PM +0200, Paul Cercueil wrote:
> The KD035G6-54NT is a 3.5" 320x240 24-bit TFT LCD panel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../panel/kingdisplay,kd035g6-54nt.txt        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
> new file mode 100644
> index 000000000000..a6e4a9af4925
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
> @@ -0,0 +1,27 @@
> +King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "kingdisplay,kd035g6-54nt"
> +- power-supply: See panel-common.txt
> +- reset-gpios: See panel-common.txt
> +
> +Optional properties:
> +- backlight: see panel-common.txt
> +
> +Example:
> +
> +&spi {
> +	display-panel {
> +		compatible = "kingdisplay,kd035g6-54nt";
> +		reg = <0>;
> +
> +		spi-max-frequency = <3125000>;
> +		spi-3wire;
> +		spi-cs-high;
> +
> +		reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
> +
> +		backlight = <&backlight>;
> +		power-supply = <&ldo6>;
> +	};
> +};
> -- 
> 2.21.0.593.g511ec345e18
