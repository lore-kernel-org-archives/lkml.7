Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45837205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600434;
	bh=GahPQZ6N3hO5eSxNfV+Mx8O8TFW1AFXzTpjRbdcBK50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=czZZDWYPrK8aC+oaRKw75MCh09tvpFH/Nq79NSrdQd4rS+BkJruuCHsnx65hKwSID
	 qQY8wImb7aDSm5/haXNFBAgcwJ4UO2tTL2cEoN0s3F+rJY+caC+FADW/AbZDVipkut
	 i4k2nADYFc9LJu5W54rOMd3QxWAmICO7Ni0Cd9CI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389436AbfDRPNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:13:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32946 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388548AbfDRPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:13:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so1900696oii.0;
        Thu, 18 Apr 2019 08:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57cZv0GFINjsjL8/kTD208X0YWPfWCuS73Z4VQYZBu4=;
        b=Qj7J7eoOPZhydLLeR2JkHLHvLW9ChEpg+QVKIOQNFXH1hfg5Vpmh+kW0rloxhm3P2e
         RfRdK5EjntSGev7go/u3Twtdn7W7N1b99+pAQPcXMVOE7cEAYHzzS76EFG372FmwgCmw
         m3zHxww1VOHGVl3FjTxU8Tc6uP9/hb33SdvrB7kLekG1ErNg/JRM+Crf3RvgC9O0PkwY
         U7bNZVLnepBCW+o0ExcI5pxFGIaB1/Q7+2Q8ZKODfKmA4HlUrvtm+CoItwNwjasLQFck
         NFHrD+NIpUe2nFTSvyUlMgo8PmC+ZyQxGVx3A62whp+189KuOkt4I/eB4/Vw3qT76eEB
         gDpA==
X-Gm-Message-State: APjAAAXXrYWUphhU/BsoPRnuwtT7fJgFAkZbhF4UpfDrH93KB3/e1rA7
        ZPr77+jl1DOi7RkPfAqSMA==
X-Google-Smtp-Source: APXvYqzFZClK1vNKk4T6avmyuJPkz3DuMp8EXTHWML2zHX3a3oLa/rwYbPNetMtF9KCAwLIRuC8lFQ==
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr2119620oif.48.1555600431909;
        Thu, 18 Apr 2019 08:13:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 66sm1054406otc.25.2019.04.18.08.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 08:13:51 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:13:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, m.felsch@pengutronix.de,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 1/3] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
Message-ID: <20190418151350.GC32345@bogus>
References: <20190417165514.18689-1-angus@akkea.ca>
 <20190417165514.18689-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417165514.18689-2-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:55:12AM -0700, Angus Ainslie (Purism) wrote:
> This is the development kit board for the Librem 5. The current level of
> support yields a working console and is able to boot userspace from the
> Network or eMMC.
> 
> Additional subsystems that are active :
> 
> - Both USB ports
> - SD card socket
> - WiFi usdhc
> - WWAN modem
> - GNSS
> - GPIO keys
> - LEDs
> - gyro
> - magnetometer
> - touchscreen
> - pwm
> - backlight
> - haptic motor
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 833 ++++++++++++++++++
>  2 files changed, 834 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 0bd122f60549..c043aca66572 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> new file mode 100644
> index 000000000000..846a72dc7640
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts

> +&usb3_phy0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	port@0 {
> +		reg = <0>;
> +
> +		typec_hs: endpoint {
> +			remote-endpoint = <&usb_con_hs>;
> +		};
> +	};
> +
> +	port@1 {
> +		reg = <1>;
> +
> +		typec_ss: endpoint {
> +			remote-endpoint = <&usb_con_ss>;
> +		};
> +	};

This is wrong. The graph should be between the USB controller and the 
connector. The phy is not involved.

> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	extcon = <&typec_ptn5100>;

extcon is deprecated and you should only have the usb-connector binding. 
From the controller, you can walk the graph to the connector.

> +	dr_mode = "otg";
> +	status = "okay";
> +};
