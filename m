Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3467AC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B274215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfFSNMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:12:12 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:59066 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFSNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:12:12 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A46E720023;
        Wed, 19 Jun 2019 15:12:08 +0200 (CEST)
Date:   Wed, 19 Jun 2019 15:12:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add support for
 Raydium RM67191 panel
Message-ID: <20190619131207.GA31903@ravnborg.org>
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com>
 <1560864646-1468-2-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560864646-1468-2-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=8AirrxEcAAAA:8
        a=7gkXJVJtAAAA:8 a=lZts8jThXrmayUhYaWoA:9 a=CjuIK1q_8ugA:10
        a=ST-jHhOKWsTCqRlWije3:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert.

Thanks for the contribution.

On Tue, Jun 18, 2019 at 04:30:45PM +0300, Robert Chiras wrote:
> Add dt-bindings documentation for Raydium RM67191 DSI panel.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  .../bindings/display/panel/raydium,rm67191.txt     | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> new file mode 100644
> index 0000000..0952610
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> @@ -0,0 +1,43 @@
> +Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
> +
> +Required properties:
> +- compatible: 		"raydium,rm67191"
> +- reg:			virtual channel for MIPI-DSI protocol
> +			must be <0>
> +- dsi-lanes:		number of DSI lanes to be used
> +			must be <3> or <4>
> +- port: 		input port node with endpoint definition as
> +			defined in Documentation/devicetree/bindings/graph.txt;
> +			the input port should be connected to a MIPI-DSI device
> +			driver
> +
> +Optional properties:
> +- reset-gpios:		a GPIO spec for the RST_B GPIO pin
> +- pinctrl-0		phandle to the pin settings for the reset pin
pinctrl is not included in bindings, they are implicit.

> +- width-mm:		physical panel width [mm]
> +- height-mm:		physical panel height [mm]
Please refer to panel-common.txt for the above.

> +- display-timings:	timings for the connected panel according to [1]
> +- video-mode:		0 - burst-mode
> +			1 - non-burst with sync event
> +			2 - non-burst with sync pulse
> +
> +[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
> +
> +Example:
> +
> +	panel@0 {
> +		compatible = "raydium,rm67191";
> +		reg = <0>;
> +		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
> +		pinctrl-names = "default";
> +		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +		dsi-lanes = <4>;
> +		width-mm = <68>;
> +		height-mm = <121>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mipi_out>;
> +			};
> +		};
> +	};

With the above fixed:
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Note: You need r-b from DT maintainer before we can apply it.

	Sam
