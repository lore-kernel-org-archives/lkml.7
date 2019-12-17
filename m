Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B0C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F452176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="hzl3RxcC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pj8zWa8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfLQO2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:28:25 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47027 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728801AbfLQO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:28:25 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 07CD61EAE;
        Tue, 17 Dec 2019 09:28:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 17 Dec 2019 09:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=o7MJ2oxooSAZLrE4IgKBFIHl/Fq
        uvlsScI7dDq2S0Lo=; b=hzl3RxcCTOf/6vakmast5z/ssSN6fGEGQslELZEROQ3
        Frk7iXOG9tka5Q9WYrFjC/s8fkuSuROpKxvkLx9TkuD5AA15EFHmVBNUFH4nC7KO
        czKIYqDJ2IfAm2CD5mEzM2hw0F9A35p63gDQUDV7MC+ms9U9Ja13sXsvttjKpy0G
        mpcZ/WgegUv4YSjDtIcpHYFwCUyqWvprtkA/bOCzwqx4fh0VGv3Dwdir50dq2ScV
        kvntqKv26XwNpqLNCm+TJ+ZsfdrKqv2ZJd3q7B4+vFXuBRb3jsgzFbuQdJFmv5je
        +dCwtpPwEmYgBLmiRxUZemO1gqL1JcREZyFU8/Kevrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=o7MJ2o
        xooSAZLrE4IgKBFIHl/FquvlsScI7dDq2S0Lo=; b=Pj8zWa8SuQBOs6JWhrGdUr
        w5dAZH6vBwr25rTvG16U+YHnDjv6UhrVdGT7wvlHKzLbuZHb41bwqZMlxBw1sbQO
        KqIZrUUfSJC53mtKc85UqL3vw3YLIP9qFEFMgTHiTJKgCtbu+guYOiTyKBMUq3PE
        Tpo4ZrxZ1YwrbTomSpOx+jfMJ9slBwWc3nfl+OQdar6R8ZdqgMsbxkry+rLjNTer
        1Iax9QpBMSlGZq/KKF6cUC81qSIrvlWH4nQKjMkiSEZTqe9N15FjvQ7LJAp+nwyL
        CxZYQZZnLzGVRQh8VE/3P431BVGieKHdTEfT08sdqmJPtxLbWecRYPuNU6YklynQ
        ==
X-ME-Sender: <xms:B-b4XaxYogkGZ-VkhbmZAG8ZW-NeQdkGcAS8s1TZJWAEIkLrLEMZrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtjedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggv
    rhhnohdrthgvtghhnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:B-b4XXUAC8RJFDB70axFrRUjezaNbOEDUp4OeYRUgBeVlokkhlNd3g>
    <xmx:B-b4XfQkfHMZglJ4EjBq084hYFss1JXRAvMRoQ_r3bCpqSiYZXp04w>
    <xmx:B-b4XeM52bBJz35B3keMx4xLX-ahcscnJRrJlGeUlMda_qbJwUo1Qw>
    <xmx:COb4XYoVYHxDAt4SzjQwApM83lGLo5BlzAgc4Dj9NSlurRM0FrE-Nw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 922EA80066;
        Tue, 17 Dec 2019 09:28:22 -0500 (EST)
Date:   Tue, 17 Dec 2019 15:28:21 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        drinkcat@chromium.org, Jitao Shi <jitao.shi@mediatek.com>,
        Ulrich Hecht <uli@fpond.eu>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        matthias.bgg@gmail.com, Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v21 1/2] Documentation: bridge: Add documentation for
 ps8640 DT properties
Message-ID: <20191217142821.xitumpvfg52heb4t@gilmour.lan>
References: <20191216135834.27775-1-enric.balletbo@collabora.com>
 <20191216135834.27775-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216135834.27775-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 02:58:33PM +0100, Enric Balletbo i Serra wrote:
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> Add documentation for DT properties supported by
> ps8640 DSI-eDP converter.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Ulrich Hecht <uli@fpond.eu>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v21: None
> Changes in v19: None
> Changes in v18: None
> Changes in v17: None
> Changes in v16: None
> Changes in v15: None
> Changes in v14: None
> Changes in v13: None
> Changes in v12: None
> Changes in v11: None
>
>  .../bindings/display/bridge/ps8640.txt        | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ps8640.txt
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.txt b/Documentation/devicetree/bindings/display/bridge/ps8640.txt
> new file mode 100644
> index 000000000000..7b13f92f7359
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ps8640.txt
> @@ -0,0 +1,44 @@
> +ps8640-bridge bindings
> +
> +Required properties:
> +	- compatible: "parade,ps8640"
> +	- reg: first page address of the bridge.
> +	- sleep-gpios: OF device-tree gpio specification for PD pin.
> +	- reset-gpios: OF device-tree gpio specification for reset pin.
> +	- vdd12-supply: OF device-tree regulator specification for 1.2V power.
> +	- vdd33-supply: OF device-tree regulator specification for 3.3V power.
> +	- ports: The device node can contain video interface port nodes per
> +		 the video-interfaces bind[1]. For port@0,set the reg = <0> as
> +		 ps8640 dsi in and port@1,set the reg = <1> as ps8640 eDP out.
> +
> +Optional properties:
> +	- mode-sel-gpios: OF device-tree gpio specification for mode-sel pin.
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +	edp-bridge@18 {
> +		compatible = "parade,ps8640";
> +		reg = <0x18>;
> +		sleep-gpios = <&pio 116 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&pio 115 GPIO_ACTIVE_LOW>;
> +		mode-sel-gpios = <&pio 92 GPIO_ACTIVE_HIGH>;
> +		vdd12-supply = <&ps8640_fixed_1v2>;
> +		vdd33-supply = <&mt6397_vgp2_reg>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
> +				reg = <0>;
> +				ps8640_in: endpoint {
> +					remote-endpoint = <&dsi0_out>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				ps8640_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
> +	};

It's not really fair to ask this after the rough history of this
patchset apparently, but bindings should be submitted in the YAML
format now.

This wouldn't be nice to stop it from going in just because of this,
so can you send a subsequent patch fixing this?

Thanks!
Maxime
