Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8946EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F48D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="QHDINjIr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asgqDt7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLMKjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:39:01 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59759 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbfLMKjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:39:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C1DEE61CD;
        Fri, 13 Dec 2019 05:38:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Dec 2019 05:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=OFLMYUJQRntH92DcW9hNVdTnxB5
        r5T3CVZUfgI5FQn4=; b=QHDINjIrZXXk5J6lmOgGbzCh2IXf4nTciC6rBLRgz3S
        xcO6T9oDfo1sYHp67eyywjFsZ5WfvjxlGpmDdYK5DC2KAis1UXcaMtH39Qp+tcuN
        5NS8cCQ/njpLfm9Cxu+Krc51Gh/wS44nLWYgP1kODjWFOy4+MxAwFgEwbThTR9pk
        mAl7eclxSC6p7DGQnLFuf5oFthQwN6ReZ7kRu12NpOmkxyzPBYWRCQuqQw5j3cva
        jmmKUjA3cQzrmHUhHga2m5BQT6/fmISIq2kiE8fBMboi+yV6X7GOP4N016Y2sEew
        ehjnFRFDYkLE4aFm8fU8Rz1aK3yvYSLXF4maTcw0Ueg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OFLMYU
        JQRntH92DcW9hNVdTnxB5r5T3CVZUfgI5FQn4=; b=asgqDt7uZu8BOxSsEa2v7T
        JowPq8yCUHb/3S8UgYd2Jc7Z/VYlcZH+4UXCrZ5646cbBVlwchr+LFC2cklJ/58f
        XXjE+V22ypLhcIpAa9LueqzwyGka/+Ylp1SwQC9R3R7pIEUhEZa8nTLCFEryGM50
        od7QCkHqXHS1YrRHcUlH0BZIVihD9DImQS9KJz6AIx/BrrKnVTfwdXR0ocPIPE7V
        BKkkFIihbG18jsq6ZWk9jTv2t2rWryXQhT1zDsFMDV74FPWvJtVs4jvdQylxFvYL
        5QSKfriPmwzRICBLm8PaNLg/Bu2/AfC1wO907I3cBpUitatuCaSveEfzWmdWTxQw
        ==
X-ME-Sender: <xms:Q2rzXUhVUy5YAlSnFzgpAIJZKG_2lcDSc05oMDouc_VRV-p5Zk89mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghdphhhurdgtohhmnecukfhppeeltddrkeelrdei
    kedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrth
    gvtghhnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Q2rzXYYyZ0O9FoCwc8xMG2PhFHXIQTsSc1zcS9_eW6Fvu_SFYC4L1Q>
    <xmx:Q2rzXZ3pREFwehwkkWoV3OETw1uU9rouuYPqx_P7wJa18et7p-ABMw>
    <xmx:Q2rzXby8JQWmjYqMaOeEleqCSHWVVYW1BDkrQVMc0NOLhptBofYI8w>
    <xmx:Q2rzXaAOsx9D7wRCdl2gz9FaiP_phsSCYkneQd3QJHWsKDlEsA3wZw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D794780063;
        Fri, 13 Dec 2019 05:38:58 -0500 (EST)
Date:   Fri, 13 Dec 2019 11:38:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <20191213103856.qo7vlnuk4ajz3vq5@gilmour.lan>
References: <20191206074052.15557-1-jian.hu@amlogic.com>
 <20191206074052.15557-2-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rosr3cxhl5siv7sy"
Content-Disposition: inline
In-Reply-To: <20191206074052.15557-2-jian.hu@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rosr3cxhl5siv7sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Dec 06, 2019 at 03:40:47PM +0800, Jian Hu wrote:
> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 59 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 +++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> new file mode 100644
> index 000000000000..7feeef5abf1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +
> +properties:
> +  compatible:
> +    - enum:
> +        - amlogic,a1-pll-clkc

I'm not sure this works, compatible shouldn't contain a list.

You can write this like:
compatible:
  const: amlogic,a1-pll-clkc

> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +clocks:
> +  minItems: 2
> +  maxItems: 2

This is redundant, it will be added automatically by the tools ...

> +  items:
> +   - description: Input xtal_fixpll
> +   - description: Input xtal_hifipll

... When you have a list of items :)

> +
> +clock-names:
> +  minItems: 2
> +  maxItems: 2
> +  items:
> +     - const: xtal_fixpll
> +     - const: xtal_hifipll

Same story here

Maxime

--rosr3cxhl5siv7sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfNqQAAKCRDj7w1vZxhR
xd/wAQDsoznX44ibe0uCLaFPCOdrFkUP48DCrvyPmdP3KkeSoAEAqcgJwk/1XeqC
famgLadEPF6JXGccjcYncc1mLjCARA0=
=lykG
-----END PGP SIGNATURE-----

--rosr3cxhl5siv7sy--
