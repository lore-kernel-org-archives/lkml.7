Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E28C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB6E2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rEHaxjW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfEKRGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:06:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38616 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfEKRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:06:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id s19so8306263otq.5;
        Sat, 11 May 2019 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3sN8SO1ZSQjsuFAqVVsec48xDvFtRvQ6c9q1xtJ3w4=;
        b=rEHaxjW1gsnurbIixV75NzP95YB4oTvSj6gpP1HDzvw5m9LZrZxTo1YcpCJXzcaRXl
         ePHkkMw/28s6RNqEC3Uxb42UoKpS5vySUCGOZZv69/wVjxIWOzu6e5kRx+EMs16OFK3s
         8TA7z6zHVI4fnfWGb3Y3YiAxI7wt6IToEeOXLeJWvJj6IaZuy88pBjbJbvczSm1xLQyW
         Ld8pREXzqeIGyLNQKpQHBZ+NOAyFvdEPCZrZ8lUzXVObn2HNKjCT5hu5viMk1TLrBWZR
         stZX1A+H0fr8HT3fwr0XSVFSMAc60i5/VWeb90w6M/C/1WvH88UqEkkESZKUapc1zaIh
         l4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3sN8SO1ZSQjsuFAqVVsec48xDvFtRvQ6c9q1xtJ3w4=;
        b=Uhx61XsTWkQRSWDKGQfClNv8AJFlW2G3ltbRti5aobXjlUNuiGGolGDhJ7VuqXudwW
         8rbQ4yINiyTn9/kgShJ9h4pSUNIcTZkd+nLU8C+jQnY6IcWRTApEUoUVRx28KNylxL4t
         7XgrNMN8mRBn87R/KaFrHP/quFbpmWQwOGos/gQQi5qLUKYfC+9tbHUJi23NXuaBtElC
         R7yrdSrwGkCvS3c/wVdYiyjFH1Yc4CcYZ5upgeE4TdhLKY1LpkkTLCZ1iIOJ05cM9xnc
         5BIoRWQ6khh+bVbaszZoo0wSNTnQBWpTFubekkx7fyCmMTpkRWsF1tYL2MSZU4jBPkfv
         BDMQ==
X-Gm-Message-State: APjAAAXWZYGJMh79kbW6NfkJ9+a67iprTslifoCoibU8WX7F4Od4VtVB
        GGS1EMata/N77x8x2VyMJVwE3SMyWydoqLKPNhY=
X-Google-Smtp-Source: APXvYqy40tI6CvvJ9asRzi0J3aqGJnWcjTMCkhuG9+1jRIWgNreuoQSJwZ9k2J7IVuWIgjwmnWP5fdhI9nrccQxCYFo=
X-Received: by 2002:a9d:6759:: with SMTP id w25mr10864829otm.348.1557594403820;
 Sat, 11 May 2019 10:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190510164940.13496-1-jbrunet@baylibre.com> <20190510164940.13496-3-jbrunet@baylibre.com>
In-Reply-To: <20190510164940.13496-3-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 May 2019 19:06:32 +0200
Message-ID: <CAFBinCAmGRHDU5QX2VEsV8vLBXD6fJtcRHbjdW8=p9Yti0V4qA@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: meson: g12a: add ethernet pinctrl definitions
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, May 10, 2019 at 6:49 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the ethernet pinctrl settings for RMII, RGMII and internal phy leds
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index a32db09809f7..fe0f73730525 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -206,6 +206,43 @@
>                                                 };
>                                         };
>
> +                                       eth_leds_pins: eth-leds {
> +                                               mux {
> +                                                       groups = "eth_link_led",
> +                                                                "eth_act_led";
> +                                                       function = "eth";
> +                                                       bias-disable;
> +                                               };
> +                                       };
> +
> +                                       eth_rmii_pins: eth-rmii {
> +                                               mux {
> +                                                       groups = "eth_mdio",
> +                                                                "eth_mdc",
> +                                                                "eth_rgmii_rx_clk",
> +                                                                "eth_rx_dv",
> +                                                                "eth_rxd0",
> +                                                                "eth_rxd1",
> +                                                                "eth_txen",
> +                                                                "eth_txd0",
> +                                                                "eth_txd1";
> +                                                       function = "eth";
> +                                                       bias-disable;
> +                                               };
> +                                       };
> +
> +                                       eth_rgmii_pins: eth-rgmii {
> +                                               mux {
> +                                                       groups = "eth_rxd2_rgmii",
> +                                                                "eth_rxd3_rgmii",
> +                                                                "eth_rgmii_tx_clk",
> +                                                                "eth_txd2_rgmii",
> +                                                                "eth_txd3_rgmii";
> +                                                       function = "eth";
> +                                                       bias-disable;
> +                                               };
> +                                       };
it seems that the group definition is incomplete (missing things like
eth_mdc, eth_rx_dv, ...)

we could also mix the eth_rmii_pins and eth_rgmii_pins in a board.dts
(maybe that was your idea in the first place?):
  phy-mode = "rgmii";
  pinctrl-0 = <&eth_rmii_pins>, <&eth_rgmii_pins>;
  pinctrl-names = "default";
however, in this case I would prefer if "eth_rmii_pins" was named only
"eth_pins" (following mostly what Amlogic does with the pin group
naming: eth_* for pins that are valid in both, rmii and rgmii mode and
eth*rgmii* for pins that are only valid in rgmii mode)


Regards
Martin
