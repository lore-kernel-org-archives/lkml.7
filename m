Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C240C20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eQXzutDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCOVso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:48:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34406 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfCOVsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:48:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id r19so9694359otn.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gE4sBOVkRwRnt8KIIAcvowjB6I4HM0nW8hKSb5lf5DU=;
        b=eQXzutDlvr7xTHtW6R+w8KuikHPoW0oUJ4rQMOFNPrqyLynLfBswC+K1KNZdfwrOw/
         iS6wzkzs+uv8wxhbp1BNMKzXpZie6+UZ2j4EZhbMsHXbXmrIBsJPaT0LVKrF9ejYHjR+
         ewNGJBpv1CrdnQFpTVOBvvGLv5aFKuk78xOjsNU1Aw3nRhc2Ed4zyEgbzNrWlVV4ibKC
         H53yIk9SSRkcBGaqR62F8T77I1bWeDj3+zfBuH7AmaKt+GCZEC7qMUj0DA1+1XDIHvh+
         KudmRbIHOb8LavePHiIIEFJDprs26ucocKxlGHOEhb6mkM8KHjLAsj17sMbtEFk6gUb0
         bpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gE4sBOVkRwRnt8KIIAcvowjB6I4HM0nW8hKSb5lf5DU=;
        b=EGh9oYT54NqHKEJsPH8Id8OcMR9vC4pNs2A780Fg0dc4hhs022fROkWmbZrTQXS6xy
         8CmjL6c+4sGTC2qM9OQ/3LRUdw00kL3EpU20g8Vxyv76G+uy1KS1QZEvezt7wrjC9esy
         r4rRBEM5YsAF65gmKxOjZQ47NgGbzXCDbOgxcfLuFpeTcCWhowrjIPC+eD7aQInERa5o
         EbTUgoHb8DzGZBFHtH/aiKtMLdWUq3rNFlm75lFdo9gLfFZF9pYmBmoR+sOBIAx29Krv
         CbNSNhGrUb4olQkXL3A7hNYMpMS+AVWs3d/xjv7uQO2gd4+Y4jHBGyV4ZTgNy25IfavS
         IfNQ==
X-Gm-Message-State: APjAAAVlMd1p//SSS5FA+zVP29kAm/sRsxGEHULjx1oY0hcmoS4vObrX
        R5ybWSaMjrK+3oAZpHIIsWaafWoVD7P9mhRh+21dCVvq
X-Google-Smtp-Source: APXvYqwJU5fFUUCeC1Q34gt1I0LOCxQIcWmubuzTwMKrFVJwJ6mHYDyi/nGZl89cdYG0+TxwXEvFQmZpugajwijf/kg=
X-Received: by 2002:a9d:7441:: with SMTP id p1mr3678653otk.148.1552686522929;
 Fri, 15 Mar 2019 14:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-8-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:48:32 +0100
Message-ID: <CAFBinCCbu54hvATKpQ+DxZ6g-FCJ_7Gty2v3HMWJWNFDbwwKwQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] arm64: dts: meson-g12a-x96-max: Enable BT Module
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 11, 2019 at 10:57 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Enable the Bluetooth Module on the X96 Max Set-Top-Box.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I didn't have time to test this yet but it looks sane to me, so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> index 21e5de48613e..61606601fb4f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> @@ -88,6 +88,18 @@
>         };
>  };
>
> +&uart_A {
> +       status = "okay";
> +       pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
> +       pinctrl-names = "default";
> +       uart-has-rtscts;
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
> +               shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
you could add:
  host-wakeup-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
(at least according to the output of /sys/kernel/debug/gpio and the
.dtb on my X96 Max)


Regards
Martin
