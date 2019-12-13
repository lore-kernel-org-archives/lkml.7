Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25966C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52D82253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="dmSZQE7l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELxQvu6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfLMJmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:42:18 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53635 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLMJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:42:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 50400226F2;
        Fri, 13 Dec 2019 04:42:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Dec 2019 04:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=efSLo1ioRmF/f6oNEX/AdyV5w6C
        Kaeb925GBxZ1IFkE=; b=dmSZQE7luPBV3T7VSXXb4VEZoSLHWXls6egM7ESgcq4
        R1Q5pNYJ/SK4j3F8HUwDDHyKazoaDFWneUyZtz4BPWuRrFo2KyS0/NdtXKbrBdAd
        y9aXJav/zNMX7o1vKy+bwzsWIUHCPQdZihxOXoGazho/gX5+Oh9+ryZcsgjlbfE8
        cDzOcupNU6s9sekP2HDNZ1xKGpAvAABxBa/9GE0aEXmbpWS5Hif8LfMDxc0Tb+zf
        ilhdOljkMTcW33NCtycbh+OiJ5zp7n1XeARcSI2SP5q1B66SzenF/M3BzO0cjLG0
        oMUcPjTHMbQdtkxgtus7JMJUY1wmsgHe7RZQxfYU98w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=efSLo1
        ioRmF/f6oNEX/AdyV5w6CKaeb925GBxZ1IFkE=; b=ELxQvu6l1AeghcqfTvEk72
        saYoo8e8zPVBAALuB5ARkzxQaT6c2BPeAw7UkDH+bwfYPnyh4tNTFH7ZGfL5z8Xz
        qrEiaPc91At5JFL4eGEg7E7u2G/uvmhcxAqIsuk0K8C2gJ6M6cdq40+RJgdaIaVq
        CmyeU1SqzHxGOgxo8k4Bs/S3DwhUYBgQbYGVuhM8aVgSXAnD6RU1sHH0WqsVZX61
        HI5yPzqV2UZFTMtbZrs1hTMSFWwSztO5d3OHaLT/v3/HyGUqL5lFwlRn4HFT4RmQ
        G5b8bVBqwYElYIpw3ihUnqRH8Pm6NgaPso1XdAi5fb4HFMummAWBfj7lUJAsVlRw
        ==
X-ME-Sender: <xms:91zzXUaI_NeYL298GYbyRLDqAYP2KQFySu2uEaYDYbURyXfyN5ANdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggv
    rhhnohdrthgvtghhnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:91zzXZHMCQseKT_xL8Ewy-P6nBT8l1khzgScL6DZN58ri4bCu9Q9Qw>
    <xmx:91zzXeSgA9RFN6DuAbCCrt0RhE1A7MLpjZt6lKENV8gLjv4ZbjRKrg>
    <xmx:91zzXWt3SaK8MaKhFqQKlSpBuZMPxkG04lmWcLbjsSx9xqFdo0NwKA>
    <xmx:-FzzXYmgIn-xsojpoeIrvAsfB4YQe96vyKBY1ruii52lnRTdSYnHdg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3256F8005C;
        Fri, 13 Dec 2019 04:42:15 -0500 (EST)
Date:   Fri, 13 Dec 2019 10:42:13 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, orsonzhai@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Subject: Re: [PATCH RFC 1/8] dt-bindings: display: add Unisoc's drm master
 bindings
Message-ID: <20191213094213.5eetnprhwolssdbp@gilmour.lan>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
 <1575966995-13757-2-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ydjubsryd27sfjsx"
Content-Disposition: inline
In-Reply-To: <1575966995-13757-2-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydjubsryd27sfjsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Dec 10, 2019 at 04:36:28PM +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
>
> The Unisoc DRM master device is a virtual device needed to list all
> DPU devices or other display interface nodes that comprise the
> graphics subsystem
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/display/sprd/drm.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.txt
>
> diff --git a/Documentation/devicetree/bindings/display/sprd/drm.txt b/Documentation/devicetree/bindings/display/sprd/drm.txt
> new file mode 100644
> index 0000000..7327b9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sprd/drm.txt
> @@ -0,0 +1,18 @@
> +Unisoc DRM master device
> +================================
> +
> +The Unisoc DRM master device is a virtual device needed to list all
> +DPU devices or other display interface nodes that comprise the
> +graphics subsystem.
> +
> +Required properties:
> +- compatible: Should be "sprd,display-subsystem"
> +- ports: Should contain a list of phandles pointing to display interface port
> +  of DPU devices.
> +
> +example:
> +
> +display-subsystem {
> +	compatible = "sprd,display-subsystem";
> +	ports = <&dpu_out>;
> +};

You should be using YAML schemas to describe your bindings nowadays.

Also, I'm not sure about how the display engine (and its component) is
going to be integrated into the SoCs, but usually have the name of the
first SoC to use it is a good practice in the case where there's a
second generation of display engine coming up in the future.

Maxime

--ydjubsryd27sfjsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfNc9QAKCRDj7w1vZxhR
xWjCAP9+RHPQU7IQY7UgNoGRVTC9xxrprwGFIvhh+jpm/mA2CwD/a/yUzjPw2Pim
8CJuodPMEdclpB4AlTUXTO2caVatRQ8=
=8l90
-----END PGP SIGNATURE-----

--ydjubsryd27sfjsx--
