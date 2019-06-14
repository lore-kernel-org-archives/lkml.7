Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E28EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E8208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM9PZfbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfFNM7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:59:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36735 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfFNM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:59:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so2324813ljj.3;
        Fri, 14 Jun 2019 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxN8IMeJHVXnP1b6nJkOyvD5/EuemFZLofVhpm8EbR8=;
        b=HM9PZfbMeFKhbiqGJ8k7ChriLFbLkvmVVj2iyulEvchIEz8/+TjMU383RbCZ51pYIY
         iWfrjlAiZwOGWcLcvHI9tDh/4Y8DOFsyxWrW9KskJtoJ/XvLna/Y0LviTgz0q1mnM21k
         cD+Ri3bnDrggF+7wdTbiHkxxZ4MHBymFnUmPp6ChkbD4YwjqWBplnh2SD5AXK/hpkWzU
         vRISa1Kjnt2u32lJ9buRRkD5KScwAxjyCEZSYp13JNgP/0VN7r/6m08wa17fGE99B1i2
         dZH2pgKYn+JWiQA0mcYs3/AIRxuVs970lPq2jIhJm3oQ4Glg36mZiTVQu648uhunD+2H
         aP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxN8IMeJHVXnP1b6nJkOyvD5/EuemFZLofVhpm8EbR8=;
        b=Udz4ZBS7DdfJk3K8dLzuG2c9GnGf44ZwxbfI7MFOaAVM9++RhXscT9bwBHYpI7l0HL
         LJrFJiz1qeI4+zfqzf/8XCaaFuR70ug5ItXcFQFmoN/mDNuI18VbojXV0Wodw5tmW/s/
         70vAcio8Hw2x1t8j1jNiHZlSq9OEiHrWO5GzLtRO6x2V4EFMb9zZs8m0usS04CLXo8qj
         DMMOzqkKHnrqEauDcB4Da36hqKOUlYwBp8hCo/V10OOHyfthpRqjcsZJOz9Fu9ydx3vR
         kNu6Dmps2aMxfSoHt5oxU8TalyOvyG9raLtxxMnUwHr5FGdtbtTpcyEZt5bbTRIOD1uD
         qHgg==
X-Gm-Message-State: APjAAAXAU9r86MeSZECVPFFfB2uuJlpU+mFcJM8k9U5gnn9MWnQBLAIW
        nvLOxmc3chbZIx2MLdbGuTilNeema0PT92Q/8Ew=
X-Google-Smtp-Source: APXvYqw8lXq0F0+4IJ+bpSdJl/2U6LvUGkEuFr8uiUorBszvcRCgkPzY9gUJlHkQLLz12pREmb/LM7DQwkvuRWZqP34=
X-Received: by 2002:a2e:63c4:: with SMTP id s65mr40905213lje.211.1560517191687;
 Fri, 14 Jun 2019 05:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com> <1560513063-24995-2-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1560513063-24995-2-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 14 Jun 2019 09:59:54 -0300
Message-ID: <CAOMZO5AMBr0TZip_PRBRPkMZ-d-kVeEOB4-rMTtcfcYtjLrLqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add support for Raydium
 RM67191 panel
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 8:53 AM Robert Chiras <robert.chiras@nxp.com> wrote:
>
> Add dt-bindings documentation for Raydium RM67191 DSI panel.
>
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  .../bindings/display/panel/raydium,rm67191.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
>
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> new file mode 100644
> index 0000000..5a6268d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
> @@ -0,0 +1,42 @@
> +Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
> +
> +Required properties:
> +- compatible:          "raydium,rm67191"
> +- reg:                 virtual channel for MIPI-DSI protocol
> +                       must be <0>
> +- dsi-lanes:           number of DSI lanes to be used
> +                       must be <3> or <4>
> +- port:                input port node with endpoint definition as
> +                       defined in Documentation/devicetree/bindings/graph.txt;
> +                       the input port should be connected to a MIPI-DSI device
> +                       driver
> +
> +Optional properties:
> +- reset-gpio:          a GPIO spec for the RST_B GPIO pin

reset-gpios (with the s in the end) is the recommendation.

> +- display-timings:     timings for the connected panel according to [1]

This is not needed.

> +- video-mode:          0 - burst-mode
> +                       1 - non-burst with sync event
> +                       2 - non-burst with sync pulse
> +
> +[1]: Documentation/devicetree/bindings/display/display-timing.txt

This path does not exist.

Also, could you try to align these bindings with the one from raydium,rm68200?

There are power-supply and backlight optional properties there, which
seem useful.

> +
> +Example:
> +
> +       panel@0 {
> +               compatible = "raydium,rm67191";
> +               reg = <0>;
> +               pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;

You should also pass pinctrl-names = "default"; if you use pinctrl-0.

> +               reset-gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;

Should be active low.
