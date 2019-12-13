Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708E12253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MilBJvex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Japy6OMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLMJqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:46:13 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42423 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfLMJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:46:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EC6912227E;
        Fri, 13 Dec 2019 04:46:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Dec 2019 04:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=9EWMZmsphQyg/+dC9Cq4JFD2u/5
        w4AH6ycvkMlNzRqs=; b=MilBJvexN+qXkJ2br9gsNvcl2GjH2hyiOE1MPIn1i5X
        v1RJesDk/0x1g6jx4Lhkz6O1fnXZTZdVE6SfTRIV6CVUkzvuhtrdm60esIXZ1sT+
        KAs0rymtujne2s6fInhxnh+yl5siIqHOuJSLG2Az9I0TAyf3mGse6DO9nVcjZ19X
        22nxK0guiBQ3nvPcs27EaGxEzJKUjSVh1F04YR7NknrPtyQUXjJjGZ3cv7TcWsOr
        FSdBBHmuc0SbY2hYq3qtYGWleZWiYeHgSi5D3BaMsKuyjkLAofVUTVc364cCzy1S
        /BV4e3UF6B/d/8g7jRschHk/xKf7bQ+jXGV+ThSov/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9EWMZm
        sphQyg/+dC9Cq4JFD2u/5w4AH6ycvkMlNzRqs=; b=Japy6OMw0fPVxppihyo5hf
        +SiecAg6VDNxj0NWEpiwHOAzg4oA9cKGZ8E+GFM9uKGdM2tGZpAYbC5RooqnaUd+
        k5gFx+/XvPK1mfcCgdN1vI4RHfFQR4VqZmVvMjSXHW55pDvblPLM1hGqfpL4MPBN
        8g8RA/OAn8YwNpZxCIJlUwfUor4ZmxazJZNyqosYw/YIDanPfh1fYvxxOslqllkw
        U3FCx6toSwN8jYoVchHBXphNYc5zCZuix0JZvEZl/wMJEDfSZJJzstm/+ICvwXB6
        HmBBEgbLBuinYaM1K0xwiWAwBMCKxJ5ybMpIDHSJqTzYAw/fZzlqnvQiVpCxbtfw
        ==
X-ME-Sender: <xms:413zXZiJwvWg-7O5J4s2uK4UWZ5wGDsxeQoh2pntt1KGiCD-XIg8Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggv
    rhhnohdrthgvtghhnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:413zXYWibQN9OLBc0XektkN4Lco_CY59k4tfjgwYZIM8p5BwhsrzQQ>
    <xmx:413zXTWbrdu7gENFwXK34yAGyAZZAEQtIwQv91hV_YccyxqbiPJuag>
    <xmx:413zXUio6nKZBpwogblpZ_v6MXS605j5Vu5xj8sFTVRyMbt3ltPGzQ>
    <xmx:413zXdn91Hp3FpsVQ3q9et2TggE6J7dJbYfpM6Dchnty_-Gm5pgAOg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB6F680063;
        Fri, 13 Dec 2019 04:46:10 -0500 (EST)
Date:   Fri, 13 Dec 2019 10:46:08 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, orsonzhai@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Subject: Re: [PATCH RFC 5/8] dt-bindings: display: add Unisoc's mipi dsi&dphy
 bindings
Message-ID: <20191213094608.awut27zbutuxhlsv@gilmour.lan>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
 <1575966995-13757-6-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6zgxd3we6mnaxudq"
Content-Disposition: inline
In-Reply-To: <1575966995-13757-6-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zgxd3we6mnaxudq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 04:36:32PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
>
> Adds MIPI DSI Master and MIPI DSI-PHY (D-PHY)
> support for Unisoc's display subsystem.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../devicetree/bindings/display/sprd/dphy.txt      | 49 ++++++++++++++++
>  .../devicetree/bindings/display/sprd/dsi.txt       | 68 ++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/dphy.txt
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/dsi.txt
>
> diff --git a/Documentation/devicetree/bindings/display/sprd/dphy.txt b/Documentation/devicetree/bindings/display/sprd/dphy.txt
> new file mode 100644
> index 0000000..474c2b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/dphy.txt
> @@ -0,0 +1,49 @@
> +Unisoc MIPI DSI-PHY (D-PHY)
> +============================================================================
> +
> +Required properties:
> +  - compatible: value should be "sprd,dsi-phy".
> +  - reg: must be the dsi controller base address.
> +  - #address-cells, #size-cells: should be set respectively to <1> and <0>
> +
> +Video interfaces:
> +  Device node can contain video interface port nodes according to [1].
> +  The following are properties specific to those nodes:
> +
> +  port node inbound:
> +    - reg: (required) must be 0.
> +  port node outbound:
> +    - reg: (required) must be 1.
> +
> +  endpoint node connected from DSI controller node (reg = 0):
> +    - remote-endpoint: specifies the endpoint in DSI node.
> +  endpoint node connected to panel node (reg = 1):
> +    - remote-endpoint: specifies the endpoint in panel node.
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +
> +Example:
> +
> +	dphy: dphy {
> +		compatible = "sprd,dsi-phy";
> +		reg = <0x0 0x63100000 0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* input port*/
> +		port@1 {
> +			reg = <1>;
> +			dphy_in: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +
> +		/* output port */
> +		port@0 {
> +			reg = <0>;
> +			dphy_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};

There's support for the MIPI D-PHY in the Linux PHY framework now, so
it would be a good fit for this (and that would mean using the generic
PHY bindings too.

> diff --git a/Documentation/devicetree/bindings/display/sprd/dsi.txt b/Documentation/devicetree/bindings/display/sprd/dsi.txt
> new file mode 100644
> index 0000000..1719ff5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/dsi.txt
> @@ -0,0 +1,68 @@
> +Unisoc MIPI DSI Master
> +=============================================================================
> +
> +Required properties:
> +  - compatible: value should be "sprd,dsi-host";
> +  - reg: physical base address and length of the registers set for the device
> +  - interrupts: should contain DSI interrupt
> +  - clocks: list of clock specifiers, must contain an entry for each required
> +	    entry in clock-names
> +  - clock-names: list of clock names sorted in the same order as the clocks
> +                 property.

Again, a list of the expected clock names and what they represent
would be great here.

Thanks!
Maxime

--6zgxd3we6mnaxudq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfNd4AAKCRDj7w1vZxhR
xSpSAQDTCGvPU8zMvz1OrUwV0y36VMtShiznWTC5hjK+GuJDLwD/Yt4yfhCETmY5
EKIzNfriYbWPRYY7BEN45tUr4SJrbQE=
=dwwy
-----END PGP SIGNATURE-----

--6zgxd3we6mnaxudq--
