Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C1AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4BD206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dMA1DpS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfFFTpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:45:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40254 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFFTpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:45:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so2463629oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvsZS4bOWzh/rxJ7Vbhm+IleDBXmUoCFx+NzSXIR57o=;
        b=dMA1DpS4lVQzF3ZNO1J8lBPXw7HRf3KPEBh1nnzkpwHzS+JnIlc6I1WhERrDHbG3n6
         ZZMXV2U73oxBby1z/sJfZS2dxWu0uSLZb5L1SaobDKr1D9R1EP2mnsAUNjBCpgTX9637
         PaI1fAwxsKymUjv0iwjOkUUzxkGrmTUFQTpo3IqVi2PRDDtcRWWIOzNeDSzyYApA/YIs
         Iz3P+UD24H7N3ATUYFD71EFh+UsU6bkXcXSU0/dkIV0Yq8MDvXAhEMSRdhbJoB3VOh/s
         n/R2RIS309HBRdorUaO9BWvnXZdtPYPQd0tb1ZTLKhJE7Gj3eTTzvVAjHU8P/KmrdiBd
         zD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvsZS4bOWzh/rxJ7Vbhm+IleDBXmUoCFx+NzSXIR57o=;
        b=pQKwxzhjFCjpexz/VigppHciGHSjogzwpPMuUccAlk8XKMPMpu/j6MxKdSjPfbmptQ
         /qcOq+JUUprP4QFrGwSdIOiqxaLd56P2NUQXWq6cFn39TgJhPC3luY9mAHVuskHwJS4x
         NMOraU5zx0IaLSNdxczQuYBHBtiw1r4Q1F6bFE53UBBxYgizkDKZpygjzxmUMmpc1u5g
         Fo5HyeKeRj9ikgVix3FNWlNQ+RRgIwDo9DZjRwk18KXLPF+8Y1uEdlBBnOHKQxk1VACo
         8hdcsFMHoZi1uc1ohfvZMDCvZBI9kGfvGblklHcH1PaBRNTFl7pUPYgyaVDvHJo/Rebk
         SUjg==
X-Gm-Message-State: APjAAAUj32C9yNy+YCOOHva8q2rKx3mTN3I7oxZ8TiLTx1HWCg/N2qWn
        r7tq2wwyOhnGNkCLbY9Mwxch1r0gzr3xWI5G4RKj6Bmm
X-Google-Smtp-Source: APXvYqzwNJzMn8BxHcmZMP8ExVHZkbQto4huDPJ4ia1CxvIjvKtYeqqbd10DSX8Ulxk42tGLcO6UqDoPI3VIjCXSj58=
X-Received: by 2002:aca:4341:: with SMTP id q62mr1300541oia.140.1559850341244;
 Thu, 06 Jun 2019 12:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190603100357.16799-1-narmstrong@baylibre.com> <20190603100357.16799-4-narmstrong@baylibre.com>
In-Reply-To: <20190603100357.16799-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:45:30 +0200
Message-ID: <CAFBinCD5y4rVO7AU7iDcrJXK7nj1uHowVnQOQT2wMSwL3EjuWw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: meson-g12a-x96-max: Enable Wifi SDIO Module
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Jun 3, 2019 at 12:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The X96 Max embeds an AP6398S SDIO module, let's add the
> corresponding SDIO, PWM clock and mmc-pwrseq nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the comment below addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> @@ -155,6 +169,12 @@
>         pinctrl-names = "default";
>  };
>
> +&pwm_ef {
> +       status = "okay";
> +       pinctrl-0 = <&pwm_e_pins>;
> +       pinctrl-names = "default";
on the other boards we list the input clock explicitly here (I assume
to avoid jitter due to a less precise parent which may be the chip
default or set by the bootloader)
