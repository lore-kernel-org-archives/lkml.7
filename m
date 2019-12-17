Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE37C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA61A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lYhsZzkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t65XaHKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfLQOYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:24:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43155 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728973AbfLQOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:24:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F367421D28;
        Tue, 17 Dec 2019 09:24:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 17 Dec 2019 09:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/m0POol9wORRwVPgBQM/4iedMaG
        mXANv7x8kJeqUrb4=; b=lYhsZzkTGt9J32KZTTP7D0gYwAJwdXrwWpwuEHVOMxe
        SWWDqg4IneI3mTs1ggR8DkEKVXdmaZV0GG670hgbGHZVaJss5/ALy4gjm0EOdRaU
        WrVLKRq8AAOg1FZYck19/Pyxqap2mb/JCPcgVVAvqUiCTjCcp7khRI4vUAN3c3/Y
        EQMFb/SHc+XRlhtLNcyF7ViKu3FEqniIlv3TPA2sKMaRa9ZgRzPtk/B8jOmp1InQ
        L59N3FNesndPjbPJnGDTvfuCEC9YKhrp5bv6Ns76YIjJXdJMm03beYOxTBXWuTAk
        M57StqIX/yz6dGUkmyhRK6JOB0CsDMqdgF7K2BCYg+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/m0POo
        l9wORRwVPgBQM/4iedMaGmXANv7x8kJeqUrb4=; b=t65XaHKXhHF207bTgmCNCz
        NmByeuef5nFUMgAOpN6EaYnQXSQUqx/maAyDf+NTJvY6m6YGmxAlwdEvntXyABtT
        cWYzLzfzNdv/9Ct9PU2Fx2aAGcKDiaMU38r0USk5jv9Y6tUkoPKzv0lwZfKpvVH3
        rV+t18DtYXB7m56p2jAx7wFWZrDdoVpN66fT5fskONGywOJBM9B9olctEJs4P2FY
        WDt41qD5xv413RICFZvBraZYlT9aJ7fPKBlWJ4Ak19l8AhLcd6/tOxWAuPtiHWDq
        RQ+sMuVMGpwxbgtR3lLwqFuxzJ6LaxyDhvhoGFBCYcaL8nR/PruyecQmEveIrdOQ
        ==
X-ME-Sender: <xms:MOX4XWfubWKZ-q-s1fmqnhT6qHQPDCnENg0z9U9d2-IyAw1O6ikaJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekledrieekrdejieenucfr
    rghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthhenucevlh
    hushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:MOX4Xd2WqOL3rpTNmp6HnyIy7jueNOuRI6qOATiU6vjOHh00FEhO9A>
    <xmx:MOX4XdGPhQp5bK9koyvOyCy7EjKawU3kP6j9W8LaF6Yo1gfxPMabsQ>
    <xmx:MOX4XXkVnQPp612QOBYEvgkffg65b1ubIOy4vga7wpdJgBHCmMdnSw>
    <xmx:MuX4XTKI8GldbJ1wyvw4N2Q_C-JVnLc8xY4WUWRCg3S5LShgTkI1Gg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0AAD980068;
        Tue, 17 Dec 2019 09:24:47 -0500 (EST)
Date:   Tue, 17 Dec 2019 15:24:46 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, sam@ravnborg.org
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: Add binding document
 for Xinpeng XPP055C272
Message-ID: <20191217142446.yexcmh5ox4336qmd@gilmour.lan>
References: <20191217140703.23867-1-heiko@sntech.de>
 <20191217140703.23867-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217140703.23867-2-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 17, 2019 at 03:07:02PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>
> The XPP055C272 is a 5.5" 720x1280 DSI display.
>
> changes in v2:
> - add size info into binding title (Sam)
> - add more required properties (Sam)
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/xinpeng,xpp055c272.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> new file mode 100644
> index 000000000000..2d0fc97d735c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sony,acx424akp.yaml#

The ID doesn't match the file name.

Did you run dt_bindings_check?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xinpeng XPP055C272 5.5in 720x1280 DSI panel
> +
> +maintainers:
> +  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: xinpeng,xpp055c272
> +  reg: true
> +  backlight: true
> +  port: true

What is the port supposed to be doing?

> +  reset-gpios: true
> +  iovcc-supply:
> +     description: regulator that supplies the iovcc voltage
> +  vci-supply:
> +     description: regulator that supplies the vci voltage
> +
> +required:
> +  - compatible
> +  - reg
> +  - backlight
> +  - iovcc-supply
> +  - vci-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsi@ff450000 {
> +        panel@0 {
> +            compatible = "xinpeng,xpp055c272";
> +            reg = <0>;
> +            backlight = <&backlight>;
> +            iovcc-supply = <&vcc_1v8>;
> +            vci-supply = <&vcc3v3_lcd>;
> +        };
> +    };
> +
> +...

Thanks!
Maxime
