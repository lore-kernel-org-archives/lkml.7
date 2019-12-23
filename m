Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA51C2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A993B207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MiE4tafp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMG9kPX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLWRUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:20:52 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50139 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726907AbfLWRUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:20:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D264366B0;
        Mon, 23 Dec 2019 12:20:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Dec 2019 12:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=3uY4HFDkgTih8k9wjqYyEaZq6ao
        EBWq7EA6Fi+wvbDE=; b=MiE4tafpYSn8TrvHNqOO0UYGazX/xNFKAEQtP4Jqhu6
        2JP7nC+l4y5UJOzOTRgdCs//Ae3JcEnSTipDP8L1NyUyB1Vz2Gf5KNfxtY8W/PpT
        7kWmMRSN9DxtPIzwKg9ghAl2JZE0DaSfP6lVQNjlZH3QbDCe6M+EoWBTo4hWCZAC
        WL6Bgcdpi6fpj9PVckrx3TDyIjv9kBLJwUIV3O5TECIQmhm8QXbiPaOTsXkK/gXE
        6opLg2RT8VHV8xFw2F0YuCDsgPvY9YZ9Fg9hWEFshqxSTW4i4KTsnr4DSVdSoq7U
        QJt57qTD6ajPcehtzgeCh0dDrJbxMeZQyMp5K7rd/6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3uY4HF
        DkgTih8k9wjqYyEaZq6aoEBWq7EA6Fi+wvbDE=; b=ZMG9kPX/G5Vi/XyYblME8o
        xVcBEvBTqsGF+R6OX5xvdNAzRsqS7tlw0QEb+xtauxUoPgUosMH5G4PvmAr8kS9S
        W+iECVrttSrSWiSY59t1Pb7E5hz4MjbdVopz1DOaBfSuWR2uYtxq0A42/mIS3crZ
        4z7/NrCOtsqtXNq5zFDvGtqCSBy9xm0GRPCRwEVL4RC1PMYew7hgJgXsnMQMRWgd
        GNrtj7PJ3FTrKklMurlAbwOPbMkwifnsx31biZFBw8TahJ8Gj/X35GAcFtnUAZpZ
        ecUzZEcOCOoPrMl2qAaIFKpzQ82xVtXWmwkz1tAgdMyO+Dn8+fSysk9yAhZh3oSw
        ==
X-ME-Sender: <xms:cPcAXi7TaXAKw_ipbQdcKqRzGBamyoYrmDDHN9VOtvBiiB9RjnL7XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddvtddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdduudelrddvtdeirddvtdeg
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghhne
    cuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:cPcAXry9FKRbXT7tTej4r1oyo-TsQ8E7fM1p0cjjltWwOrVCd8PWHQ>
    <xmx:cPcAXuy3c8eTxCKOFG_Hka-RvW_Ki4iGfNHYdr8DAumyKi9YfZOW9w>
    <xmx:cPcAXrUOxADV--HhJoTBcCN0kP_bz3fEpwdoLimZHUHYAk1SK_c9wA>
    <xmx:cvcAXkkLgfxOWLJM5sXM42Va5gjJjTAxthvV2LMiweM5NLwaIpnXPw>
Received: from localhost (lfbn-lyo-1-633-204.w90-119.abo.wanadoo.fr [90.119.206.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id A453B3060845;
        Mon, 23 Dec 2019 12:20:48 -0500 (EST)
Date:   Mon, 23 Dec 2019 18:22:06 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mark.rutland@arm.com, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, praneeth@ti.com,
        jsarha@ti.com, tomi.valkeinen@ti.com, mparab@cadence.com,
        sjakhade@cadence.com
Subject: Re: [PATCH v2 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings in yaml format
Message-ID: <20191223172206.ojnka2exmcld4nrl@hendrix.home>
References: <1577114202-15970-1-git-send-email-yamonkar@cadence.com>
 <1577114202-15970-2-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="krgpiy72sujxxp5c"
Content-Disposition: inline
In-Reply-To: <1577114202-15970-2-git-send-email-yamonkar@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--krgpiy72sujxxp5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 23, 2019 at 04:16:40PM +0100, Yuti Amonkar wrote:
> Document the bindings used for the Cadence MHDP DPI/DP bridge in
> yaml format.
>
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.yaml         | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> new file mode 100644
> index 0000000..aed6224
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> @@ -0,0 +1,109 @@
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence MHDP bridge
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp8546
> +      - ti,j721e-mhdp8546
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      DP bridge clock, it's used by the IP to know how to translate a number of
> +      clock cycles into a time (which is used to comply with DP standard timings
> +      and delays).
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of mhdptx apb registers upto PHY mapped area(AUX_CONFIG_P).
> +          The AUX and PMA registers are mapped to associated phy driver.
> +      - description:
> +          Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: mhdptx
> +      - const: j721e-intg

You should have an if / then clause to validate that the length is the
proper one based on the value of the compatible.

> +  phys:
> +    description: see the Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml

phys is a generic property, so we shouldn't tie it to one particular
phy. Especially since there's nothing in it that really explain what
this property is supposed to be.

> +  phy-names:
> +    const: dpphy
> +
> +  ports:
> +    type: object
> +    description:
> +      Ports as described in Documentation/devicetree/bindings/graph.txt
> +    properties:
> +       '#address-cells':
> +         const: 1
> +       '#size-cells':
> +         const: 0
> +       port@0:
> +         description:
> +           input port representing the DP bridge input
> +
> +       port@1:
> +         description:
> +           output port representing the DP bridge output
> +    required:
> +      - port@0
> +      - port@1
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - phys
> +  - phy-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mhdp: dp-bridge@f0fb000000 {
> +        compatible = "cdns,mhdp8546";
> +        reg = <0xf0 0xfb000000 0x0 0x1000000>,
> +              <0xf0 0xfc000000 0x0 0x2000000>;

There's two items here, yet you're not using the TI compatible?

Maxime

--krgpiy72sujxxp5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXgD3vgAKCRDj7w1vZxhR
xUA3AQC/pwICe4jhx/goC8w+guLB6HWSeSv/mRuIIFbcIefZzQD8D32DLBlk6UIv
LES2rZiDFShdS1q7KraOF8zI89VOlwc=
=y/zJ
-----END PGP SIGNATURE-----

--krgpiy72sujxxp5c--
