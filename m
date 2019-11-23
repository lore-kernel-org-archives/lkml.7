Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B0C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F3E2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574469279;
	bh=sh0oGjQjzaoQRngBcUGyNL6OqSYWToyQMtu4tTsGkH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wpRMH4G+DFVBOL4l244A7F0rZX7+lPzqKarumNY8ga7xpVZlCqy2NpESK4PlIBl0g
	 MOLZp+KGBj/iuNnfjuqVxA76sdYomUVwhGEmtfaidAQ9W4G6Ntt82K+QriIhuYAjey
	 BH0+zOcrZYhjUfKksiZlSgFG+cwClWji38lAbNmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKWAei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:34:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36512 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 19:34:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so7794208oto.3;
        Fri, 22 Nov 2019 16:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=phRtDY+6nhN89i9bxspsg5KDJ+w/2SxWdZGysdx9BMs=;
        b=cRgO+rIlmTKEoSDuDrFow8Pxg8yedXk2gqSHraMxu7OOEHq+RajnF5u4pfwA5P25Jy
         0UeKAhvT2X2IrD5q6nwo922X8/Jm29vFXeKJCzq6hkRE01gBshfHBlY8fyVp1VC8dcwU
         wd/3JA93nfQ7NgjX/gt0r2h8g/L7mY5H/g61h8xm17p70tixZcpaPkLfSdVHr6M54KFy
         l3oqOL9p1RECppRtlv+JDTD9w0+QRF0z28D3KuKyiDh4BOo+56fpv8i5XIOOYGWThtZd
         WwiVAn3GCLbBKH5ByCp6xzjnWQlBVNUoHl2p0Jp9dV+YqbfD2P3P/TxRRaFPMLzSex1h
         Wgsw==
X-Gm-Message-State: APjAAAVtcbm9yMJ4mjL0+/JwKXQoJVD+fM+THSiap5I5ruZsDmjkSlwt
        kuCpMQBHn8c6wZI8rrCh3Q==
X-Google-Smtp-Source: APXvYqwxsOHf0eCMmkU5FDfUzE8g5eAjnd7zYHNf1mNs7HEBS8YeT4sL4wp4ZPy2y5mZa+0w7UHfDA==
X-Received: by 2002:a9d:6e12:: with SMTP id e18mr12968418otr.63.1574469274945;
        Fri, 22 Nov 2019 16:34:34 -0800 (PST)
Received: from localhost (ip-70-5-93-147.ftwttx.spcsdns.net. [70.5.93.147])
        by smtp.gmail.com with ESMTPSA id a23sm2575394oia.41.2019.11.22.16.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 16:34:34 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:34:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com, kernel@collabora.com
Subject: Re: [PATCH v3 4/4] dt-bindings: display: add IMX MIPI DSI host
 controller doc
Message-ID: <20191123003432.GA334@bogus>
References: <20191118152518.3374263-1-adrian.ratiu@collabora.com>
 <20191118152518.3374263-5-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118152518.3374263-5-adrian.ratiu@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 05:25:18PM +0200, Adrian Ratiu wrote:
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  .../bindings/display/imx/mipi-dsi.txt         | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/mipi-dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/mipi-dsi.txt b/Documentation/devicetree/bindings/display/imx/mipi-dsi.txt
> new file mode 100644
> index 000000000000..3f05c32ef963
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/mipi-dsi.txt
> @@ -0,0 +1,56 @@
> +Freescale i.MX6 DW MIPI DSI Host Controller
> +===========================================
> +
> +The DSI host controller is a Synopsys DesignWare MIPI DSI v1.01 IP
> +with a companion PHY IP.
> +
> +These DT bindings follow the Synopsys DW MIPI DSI bindings defined in
> +Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt with
> +the following device-specific properties.
> +
> +Required properties:
> +
> +- #address-cells: Should be <1>.
> +- #size-cells: Should be <0>.
> +- compatible: "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi".
> +- reg: See dw_mipi_dsi.txt.
> +- interrupts: The controller's CPU interrupt.
> +- clocks, clock-names: Phandles to the controller's pll reference
> +  clock(ref) and APB clock(pclk), as described in [1].
> +- ports: a port node with endpoint definitions as defined in [2].
> +- gpr: Should be <&gpr>.

fsl,gpr

> +       Phandle to the iomuxc-gpr region containing the multiplexer
> +       control register.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +
> +	mipi_dsi: mipi@21e0000 {

dsi@...

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,imx6q-mipi-dsi", "snps,dw-mipi-dsi";
> +		reg = <0x021e0000 0x4000>;
> +		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
> +		gpr = <&gpr>;
> +		clocks = <&clks IMX6QDL_CLK_MIPI_CORE_CFG>,
> +			 <&clks IMX6QDL_CLK_MIPI_IPG>;
> +		clock-names = "ref", "pclk";
> +		status = "okay";

Don't show status in examples.

> +
> +		ports {
> +			port@0 {
> +				reg = <0>;
> +				mipi_mux_0: endpoint {
> +					remote-endpoint = <&ipu1_di0_mipi>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				mipi_mux_1: endpoint {
> +					remote-endpoint = <&ipu1_di1_mipi>;
> +				};
> +			};
> +		};
> +        };
> -- 
> 2.24.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
