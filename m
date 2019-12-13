Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AE7C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9472D2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="R6aL2F7S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8rW5bq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLMJoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:44:13 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36067 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfLMJoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:44:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 47CD1226B1;
        Fri, 13 Dec 2019 04:44:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 13 Dec 2019 04:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ImxQ1LR0DbrnqW0fDLZsDrM+ZJV
        DueyOIVlxP6rimw0=; b=R6aL2F7SIzNJEmcW5dOZSidpCrJ3FwPs86iRwbcSigB
        a5S62VzMREckC4wiya5jCQialz6B5X1qyeZENkFW9vmI8z3Vr23LHWXD25oPs/2p
        mZ75Fnzdr7l4tv2efMDUtwoih4Wddx+3kK4Q6nQa0YfMC8XXIeTO3tN79Cxc8Q/z
        NAKV93ESYh06MnOFp6NWzR4+2OhedVQFKOPesyYSQvGSwsjnd0CMpgZ2MilHrUQ+
        3HIKVAyhn1T2oRyf5Ie9JgNTYPdA/Qo38Bxw25FDOA63GdOU0hWgkoqGRiRn8b2w
        MftfuL+Fk5aWdqq1Y6szkYabDNzS/yVBNgdveteLR3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ImxQ1L
        R0DbrnqW0fDLZsDrM+ZJVDueyOIVlxP6rimw0=; b=X8rW5bq2/QlZe5HnCu6Wqd
        XdEh22uAjlsE61der+4K0xrXrN33Y4YkPoKCOVDqtVLpkZ9ZgU1LWaqwNQO0RiZP
        TMIDKA74pfOsL7ltj/CPKAcrms3yJ4RxUHHbzK56bekKghqCmbUUnBV/JkXpYcEn
        K99+UsgdU0jUZHFXo//6CcxWnJXUYMgzu2IBGlLM4H+BEfqpwoMJ5WdPkHn1iSf2
        6K16yTYfffC6JUt+VaPgpuCCwo4WSl2/GlDUWUm0ai/g3m1Y/MsuipVaaPxI+Yqr
        xPMuAGuv9Lac9W4BaaoPD1bJcUMpVOeHwFS6iPwqc32Jb3LT7zmjjQtvm7utWGFQ
        ==
X-ME-Sender: <xms:a13zXVtKS7zZ-oS4PYe9WbmxCrAsUwDpv1RhChf7KIpLSVfvGH9InQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggv
    rhhnohdrthgvtghhnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:a13zXTLucGaxFKNq4HGP_zV_KU9NH57MIXmQ70aV26qprNKa4ROdeA>
    <xmx:a13zXZC_HGnbG61LwuQA11xoZD_NxED-VduRfYs5RowNsnhNKrSKUw>
    <xmx:a13zXQUt2Rg9qZ6OXcVOhzqN9n7ID1XihVdPH5nltgZY8jC378WJug>
    <xmx:bF3zXV8fzlyXpYCNAhQpH3LvjgxTsw10aJg7eIhOdl9QkBdzvUhbRQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4985030602F1;
        Fri, 13 Dec 2019 04:44:11 -0500 (EST)
Date:   Fri, 13 Dec 2019 10:44:09 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, orsonzhai@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Subject: Re: [PATCH RFC 3/8] dt-bindings: display: add Unisoc's dpu bindings
Message-ID: <20191213094409.lvvhwtxl4vlkvi6b@gilmour.lan>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
 <1575966995-13757-4-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmgykvho46e6yds2"
Content-Disposition: inline
In-Reply-To: <1575966995-13757-4-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xmgykvho46e6yds2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Dec 10, 2019 at 04:36:30PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
>
> DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
> which transfers the image data from a video memory buffer to an internal
> LCD interface.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../devicetree/bindings/display/sprd/dpu.txt       | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.txt
>
> diff --git a/Documentation/devicetree/bindings/display/sprd/dpu.txt b/Documentation/devicetree/bindings/display/sprd/dpu.txt
> new file mode 100644
> index 0000000..25cbf8e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/dpu.txt
> @@ -0,0 +1,55 @@
> +Unisoc SoC Display Processor Unit (DPU)
> +============================================================================
> +
> +DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
> +which transfers the image data from a video memory buffer to an internal
> +LCD interface.
> +
> +Required properties:
> +  - compatible: value should be "sprd,display-processor";
> +  - reg: physical base address and length of the DPU registers set.
> +  - interrupts: the interrupt signal from DPU.
> +  - clocks: must include clock specifiers corresponding to entries in the
> +	    clock-names property.
> +  - clock-names: list of clock names sorted in the same order as the clocks
> +                 property.

Same story, this should be a YAML schemas, but here you should
describe what the expected clock-names are, and what clock they
represent.

> +  - dma-coherent: with this property, the dpu driver can allocate large and
> +		  continuous memorys.
> +  - port: a port node with endpoint definitions as defined in document [1].

So only one? Connected to what?

Maxime

--xmgykvho46e6yds2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfNdaQAKCRDj7w1vZxhR
xRZkAQDkkC17ANn/69CaZbSnHiWEbolmYloHcKTq/lk8Qtqd+wEAhPyfDMSoPcf5
jkGbaka5QNRk6dAHQtPx3hk7RtwlXQs=
=jNnp
-----END PGP SIGNATURE-----

--xmgykvho46e6yds2--
