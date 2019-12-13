Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642F0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312E52253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WvoaLe+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nid8Tlyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLMJsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:48:17 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51435 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfLMJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:48:16 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CAF9B22624;
        Fri, 13 Dec 2019 04:48:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Dec 2019 04:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=3c/pNZbfVguiAfAJyfOP8e8RotX
        tqEiIuR+b/5Y50jQ=; b=WvoaLe+Mxsd7nenltVRefeH2nKbXSpJF7pVIo8WP4Dl
        2XBNlSB27AD290e0C/roc/lAOh89szpIYP48cYtmYq3Cpav5erWoWfgwIeXbIxzy
        M7hRlkg5Q8iMlFkuYnLGgD1jV/lbwD2rFJaeXtVAHjRheJLKHlgkf3I6b1CdSIcr
        3yEbdzwgtiaV5CVi2qfVyIjMF5dj0qt26so115fkyjmRghAS51E3W3PtB4DcAVFs
        OW0vmt6wjxgcAuCrEMsQxfjjW9KKqxH4jir9HjRi60G9a41qpTbrce9p4faWuG5p
        aouballAlMI0pMcQv6dTjdB/g7mn90FbS5btAHbh9+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3c/pNZ
        bfVguiAfAJyfOP8e8RotXtqEiIuR+b/5Y50jQ=; b=nid8TlyddIjZ8NewJc1KLl
        2crc+qEgO9RODbWnWNIzYKspb4XfnC7I/wWqJHYuWveNJMv9jPFIXU+sg0rmre27
        KYMZh5DIbihPek2E+dyMKVMfo5Bk24ahZowmS0zaqYyjXA+Q2BPI0au5DLW8OD8w
        CVEI0AQgqzmoLh5ms4wpFKdoRQlF2tbi7BY7hkeecDZM+iALfQCha3D9reYJBAmt
        NpHhuFRs8xus2dF1Dyet4W1UePggd1qMOkxEn/ytrEDTklu47TqpEAmsmm/V3UBx
        pT0MyzmfRhU1lTZ17zkKhLEW3NdzSgxwCivxU9595U/Phlk6cssskCpwBwi8Oa8w
        ==
X-ME-Sender: <xms:Xl7zXYa8e6oA7sBeBMNZV2TxXvr4vpQ0At_a5AdczBSR7O4RI3LM_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggv
    rhhnohdrthgvtghhnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Xl7zXdpG03vMNf0_89GHn7Gxgf9QdH0i6-25fmowA9-oj0JdXV8kMw>
    <xmx:Xl7zXUvVltReegJxcwYFRrz4jE6EVVwTEwClo6PZ1h-QKsZYNILdYw>
    <xmx:Xl7zXXN4JJ4uibtpwz5O4tqzVbT2f0UUJ0zRNGXxZvY3Jdx1rd4_Eg>
    <xmx:Xl7zXVmW1e40Jaxm9qyRFqaj8biZnWQvrMDrjs0V4C9llPhsI0W97A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5C4D80060;
        Fri, 13 Dec 2019 04:48:13 -0500 (EST)
Date:   Fri, 13 Dec 2019 10:48:11 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, orsonzhai@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Subject: Re: [PATCH RFC 7/8] dt-bindings: display: add Unisoc's generic mipi
 panel bindings
Message-ID: <20191213094811.4jl5d6jssuml5jov@gilmour.lan>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
 <1575966995-13757-8-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmaocqylhz7nomfh"
Content-Disposition: inline
In-Reply-To: <1575966995-13757-8-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmaocqylhz7nomfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 04:36:34PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
>
> Adds generic MIPI panel support for Unisoc's display subsystem.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../devicetree/bindings/display/sprd/panel.txt     | 110 +++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/panel.txt
>
> diff --git a/Documentation/devicetree/bindings/display/sprd/panel.txt b/Documentation/devicetree/bindings/display/sprd/panel.txt
> new file mode 100644
> index 0000000..a4017af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/panel.txt
> @@ -0,0 +1,110 @@
> +Unisoc Generic MIPI Panel
> +================================================================
> +
> +Required properties:
> +  - compatible: must be "sprd,generic-mipi-panel"
> +  - reg: panel ID
> +  - #address-cells, #size-cells: should be set respectively to <1> and <0>
> +  - port: video port for DPI input
> +  - sprd,dsi-work-mode: the following dsi mode can be select:
> +	0: cmd mode,
> +	1: video burst mode,
> +	2: video non-burst mode with sync pulse,
> +	3: video non-burst mode with sync event
> +  - sprd,dsi-lane-number: number of dsi lanes to use, default is 4
> +  - sprd,dsi-color-format: data format for video stream transmission, currently
> +	supports "rgb888", "rgb666", "rgb666_packed", "rgb565" and "dsc", defaults rgb888
> +  - sprd,phy-bit-clock: the transmission rate of the clock lane for High-Speed,
> +	the unit is Kbps, and the default value is 500Mbps
> +  - sprd,phy-escape-clock: the transmission rate of the clock lane for Low-Power,
> +	the unit is Kbps, and the default value is 20Mbps
> +
> +
> +Optional properties:
> +  - width-mm: see [2] for details
> +  - height-mm: see [2] for details
> +  - sprd,esd-check-enable: esd check function enable switch
> +  - sprd,esd-check-mode: esd detection method, default is register
> +	0: register,
> +	1: TE signal
> +  - sprd,esd-check-period: esd detection cycle, unit ms, default 1000ms
> +  - sprd,esd-check-register: if register detection is used, this attribute must be configured
> +  - sprd,esd-check-value: if register detection is used, this attribute must be configured
> +  - sprd,reset-on-sequence: timing of the reset pin when the lcd power on
> +	<1 5>, <0 5> means first keep high for 5ms, then keep low for 5ms
> +  - sprd,reset-on-sequence: timing of the reset pin when the lcd power off
> +  - sprd,use-dcs-write: bool attribute, indicating whether to use the dcs to send inital & sleep cmds,
> +	default use generic
> +  - sprd,initial-command: lcd initialization command set
> +  - sprd,sleep-in-command: lcd suspend command set
> +  - sprd,sleep-out-command: lcd resume command set
> +  - display-timings: see [1] for details

I can't say for sure since I'm not the panel maintainer, but I'm not
sure it's something that we want.

Panels are much more complicated than that, and DT is usually to store
data, not code (unlike the initial-command property you have).

The best way to support this would be to use the panel infrastructure.

> +
> +	[1] Documentation/devicetree/bindings/display/panel/display-timing.txt
> +	[2] Documentation/devicetree/bindings/display/panel/panel-common.yaml
> +
> +Example
> +-------
> +
> +Panel specific DT entry:
> +
> +	&dsi {
> +		panel {
> +			compatible = "sprd,generic-mipi-panel";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			port {
> +				reg = <1>;
> +				panel_in: endpoint {
> +					remote-endpoint = <&dphy_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	/ { lcds {
> +        lcd_mipi_hd: lcd_mipi_hd {
> +                sprd,dsi-work-mode = <1>;
> +                sprd,dsi-lane-number = <4>;
> +                sprd,dsi-color-format = "rgb888";
> +                sprd,phy-bit-clock = <1100000>;
> +                sprd,phy-escape-clock = <20000>;
> +                width-mm = <68>;
> +                height-mm = <121>;
> +                sprd,esd-check-enable = <0>;
> +                sprd,esd-check-mode = <0>;
> +                sprd,esd-check-period = <1000>;
> +                sprd,esd-check-register = <0x0A>;
> +                sprd,esd-check-value = <0x9C>;
> +                sprd,reset-on-sequence = <1 5>, <0 5>, <1 20>;
> +                sprd,reset-off-sequence = <0 5>;
> +                sprd,use-dcs-write;
> +                sprd,initial-command = [
> +                        39 00 00 02 b0 00
> +                        39 00 00 04 B3 31 00 06
> +                        ];
> +                sprd,sleep-in-command = [
> +                        13 0A 00 01 28
> +                        13 78 00 01 10
> +                        ];
> +                sprd,sleep-out-command = [
> +                        13 78 00 01 11
> +                        13 32 00 01 29
> +                        ];
> +                display-timings {
> +                        timing0 {
> +                                clock-frequency = <64000000>;
> +                                hactive = <720>;
> +                                vactive = <1280>;
> +                                hback-porch = <31>;
> +                                hfront-porch = <31>;
> +                                vback-porch = <32>;
> +                                vfront-porch = <16>;
> +                                hsync-len = <20>;
> +                                vsync-len = <2>;
> +                        };
> +                };
> +        };

This example doesn't match the binding described above?

Thanks!
Maxime

--fmaocqylhz7nomfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfNeWwAKCRDj7w1vZxhR
xWhwAP98RU5C1Ov0gl/GgHDppoKt7VwSReifpN40/viytahdHwD/fGbWpG3U6F11
MeS6D92+LmJWx4TslLGBmRSI8BPqVwA=
=HpWR
-----END PGP SIGNATURE-----

--fmaocqylhz7nomfh--
