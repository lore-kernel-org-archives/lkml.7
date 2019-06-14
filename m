Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC013C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D521841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534042;
	bh=picnxEZ2Wx6Xt/xYCo+RIPwm3gjIvkVmQnAkykkOUfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VRvbvQSmpeI9zJoVAF1QvV3WcLPXTAMrNWwhIwopPJFypa3Q8w19Gpzth8izxGzM/
	 kI28E9aQ/ggoWIVRAhcEHNvtXrgMZYUZ7xsVIFASWHnQ1rSwDVup2vKv9vp6gn54Qq
	 MoQV+/JiZ6FnUy/PYAH2LQpYYxYdanCS0/HI7YTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFNRkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:40:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34414 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfFNRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:40:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so3450033qtu.1;
        Fri, 14 Jun 2019 10:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wPpnwqyMUwz4SjcLvux0hAtQhIO7tvhlsaBTqk5BtFQ=;
        b=aeOLEXhAUBlKVEX6xUuNUcJiPqFBUt5wPo1E48xyyyjUYISE1QJIkjclf1ZplcQKXb
         vNPYaWwouLzTrQ7LLxf2RH9dZTbHxQkHc8TcblDcwyHB8bqllXKhDZ29SEeNsAmCx+QB
         se+XSIZwk4niInJsxsgKnA86AehhoONbwz5NhrvnqFpBcOnM7XTFvtNarcZuLnGu3HNE
         tYrX45x1j5CR6annID1xEvRXrpe7FNAPnfUo35d9Jv4fbqZvvDCzBtptqW+78+VIgtV+
         49B/FhEP0FpUZQBQai68BEwBbXu8vWq95JJCN4/Hfc/lbXhE1X79ajyhe+LGotePXWNu
         yr4A==
X-Gm-Message-State: APjAAAV/46fiPy+TqHknOpcS53CptU1fxPptDgjGvUG4S7DTytTl3LyV
        88TWhS1wlfzFM0LEW3cyDQ==
X-Google-Smtp-Source: APXvYqxo44A52mZTtb6SOTHwe53kddQe2wYjOh2ybh83i+aLF200ttNmY0LQpx9l952MRTesaOIZBw==
X-Received: by 2002:ad4:43e3:: with SMTP id f3mr9527578qvu.108.1560534039177;
        Fri, 14 Jun 2019 10:40:39 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id f25sm2592067qta.81.2019.06.14.10.40.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 10:40:38 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:40:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 4/6] dt-bindings: display: bridge: Add ICN6211
 MIPI-DSI to RGB converter bridge
Message-ID: <20190614174036.GA31068@bogus>
References: <20190524104317.20287-1-jagan@amarulasolutions.com>
 <20190524104317.20287-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524104317.20287-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 04:13:15PM +0530, Jagan Teki wrote:
> ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> It has a flexible configuration of MIPI DSI signal input
> and produce RGB565, RGB666, RGB888 output format.
> 
> Add dt-bingings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../display/bridge/chipone,icn6211.txt        | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> new file mode 100644
> index 000000000000..53a9848ef8b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.txt
> @@ -0,0 +1,78 @@
> +Chipone ICN6211 MIPI-DSI to RGB Converter Bridge
> +
> +ICN6211 is MIPI-DSI/RGB converter bridge from chipone.
> +It has a flexible configuration of MIPI DSI signal input
> +and produce RGB565, RGB666, RGB888 output format.
> +
> +Required properties for RGB:
> +- compatible: must be "chipone,icn6211"
> +- reg: the virtual channel number of a DSI peripheral
> +- reset-gpios: a GPIO phandle for the reset pin
> +
> +The device node can contain following 'port' child nodes,
> +according to the OF graph bindings defined in [1]:
> +  0: DSI Input, not required, if the bridge is DSI controlled
> +  1: RGB Output, mandatory
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +
> +	panel {
> +		compatible = "bananapi,s070wv20-ct16", "simple-panel";

'simple-panel' is not a valid compatible string.

> +		enable-gpios = <&pio 1 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PB7 */
> +		backlight = <&backlight>;
> +
> +		port {
> +			panel_out_bridge: endpoint {
> +				remote-endpoint = <&bridge_out_panel>;
> +			};
> +		};
> +	};
> +
> +&dsi {
> +	vcc-dsi-supply = <&reg_dcdc1>;		/* VCC-DSI */
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dsi_out: port@0 {
> +			reg = <0>;
> +
> +			dsi_out_bridge: endpoint {
> +				remote-endpoint = <&bridge_out_dsi>;
> +			};
> +		};
> +	};
> +
> +	bridge@0 {
> +		compatible = "chipone,icn6211";
> +		reg = <0>;
> +		reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* LCD-RST: PL5 */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			bridge_in: port@0 {
> +				reg = <0>;
> +
> +				bridge_out_dsi: endpoint {
> +					remote-endpoint = <&dsi_out_bridge>;
> +				};
> +			};
> +
> +			bridge_out: port@1 {
> +				reg = <1>;
> +
> +				bridge_out_panel: endpoint {
> +					remote-endpoint = <&panel_out_bridge>;
> +				};
> +			};
> +		};
> +	};
> +};
> -- 
> 2.18.0.321.gffc6fa0e3
> 
