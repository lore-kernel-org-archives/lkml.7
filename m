Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAEEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00964218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCPU7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:59:52 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:35953 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfCPU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:59:51 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 9B2BE8053A;
        Sat, 16 Mar 2019 21:59:46 +0100 (CET)
Date:   Sat, 16 Mar 2019 21:59:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] dt-bindings: Add doc for the ingenic-drm driver
Message-ID: <20190316205945.GA11309@ravnborg.org>
References: <20190315170701.29670-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315170701.29670-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=p6pI0oa4AAAA:8 a=ebqaEtIYvt-xgtW2S2sA:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=9cw2y2bKwytFd151gpuR:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Fri, Mar 15, 2019 at 06:06:59PM +0100, Paul Cercueil wrote:
> Add documentation for the devicetree bindings of the DRM driver for the
> JZ47xx family of SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Notes:
>     v2: Remove ingenic,panel property.
> 
>  .../devicetree/bindings/display/ingenic,drm.txt    | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,drm.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/ingenic,drm.txt b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> new file mode 100644
> index 000000000000..f57a4ae0f7ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> @@ -0,0 +1,29 @@
> +Ingenic JZ47xx DRM driver
> +
> +Required properties:
> +- compatible: one of:
> +  * ingenic,jz4740-drm
> +  * ingenic,jz4725b-drm
> +- reg: LCD registers location and length
> +- clocks: LCD pixclock and device clock specifiers.
> +	   The device clock is only required on the JZ4740.
> +- clock-names: "lcd_pclk" and "lcd"
> +- interrupts: Specifies the interrupt line the LCD controller is connected to.
> +
> +Optional properties:
> +- ingenic,lcd-mode: LCD mode to use with the display panel.
> +		    See <dt-bindings/display/ingenic,drm.h> for all the
> +		    possible values.

The value of the ingenic,lcd-mode depends on the panel used.
So this looks like a panel property and not a display property.

The panel should be specified using an OF graph binding
in a port sub-node.
The remote-endpoint will specifify the panel properties
and if the panel requires something special from the display driver,
the panle should specify this.
So one can change panel without touching the display node
in the DT.


> +
> +Example:
> +
> +lcd: lcd-controller@13050000 {
> +	compatible = "ingenic,jz4725b-drm";
> +	reg = <0x13050000 0x1000>;
> +
> +	interrupt-parent = <&intc>;
> +	interrupts = <31>;
> +
> +	clocks = <&cgu JZ4725B_CLK_LCD>;
> +	clock-names = "lcd";
> +};

As hinted above the panel is not specified above and to follow the
modern way to do so would be to use a OF graph binding.

	Sam
