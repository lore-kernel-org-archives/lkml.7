Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF04C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89EF20828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FkxCn4Rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCRUN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:13:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37596 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:13:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so7805477oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JX7zqHaIu/f/4WJ+moXDPr6XWTpIHVkf/YKVmDEyBQE=;
        b=FkxCn4Rci7k/IG1yg+mVFwx3nbStmUAu7To1o6ypuvQhJOTj92rQ/P8aj1HxNcQv5n
         B4XJB1jKVcvs0OKe87146WNXH5iew/LbN6t3aFsyBLIjRNLStkYrREzIaZcIaxjsNgJD
         UnPBfYfqYougvtcZl1/D/hJXwohtFGxubsL0/9r05ob9H23MwFE7hDzFv/iJ/Zba3ozn
         edmcPTMjStHtOX5nR2BywAFHxgu+KpGFYPESzbyVy/+TgV63CwfotaF4XPMgdqhsb3O4
         6DtPnZU3t0zzuF50kffrb98/ujzgaeVC/CLHK7F3AZqydOixi5b7aefk7r4pJEfApzTN
         Kjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JX7zqHaIu/f/4WJ+moXDPr6XWTpIHVkf/YKVmDEyBQE=;
        b=bQFVHw3y4SPyPHGKdfU8ke3VRvIe7MBGa2ZsIyhdOGHYEq2HHs2uet/kdH2KpPuVXp
         ou3L+ZsVQ/cphPW6TCLzPMpVbS8Khjls2I8h3YRKekSM8gRjHczXN176A+H/TAjUnenX
         TRfJ+JjEYW55jFCYmMSsMnwfEQGjjsmHR1if0tdA6cDZFvYAg3146tm3VmFddqPf1GQ7
         9VJNi3rZX2WiR9y36dGMr3HTtgBLKxQQtivYEhMWowBGOIQnSRRgmyki1WAM13/2DIhy
         VtekrmS5UD8F+5oJ8XbqV0uxCjm8cE/jFQvIjJIzAW1B08/UUhfFV6fJGY/zaCYVaQB2
         b36g==
X-Gm-Message-State: APjAAAUCOm3+GUytFNe3VzoaiFED1C/UlUGVX7foSSQng9DsATgq+52p
        POg7wgVkQQ2cpJ9bCbKYiAv9xvRzmYO23b7xQ9dFEKt8
X-Google-Smtp-Source: APXvYqxK+mqOGTY75gVcQ00WrMF7FJmWZKnkJnEyR3CkSIhW78B4iNPZdaUyWb8dTm0JNUkx/QsUX8/7amy4g4tgpIU=
X-Received: by 2002:a54:4e02:: with SMTP id a2mr469676oiy.140.1552940007949;
 Mon, 18 Mar 2019 13:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100458.5619-1-narmstrong@baylibre.com> <20190318100458.5619-7-narmstrong@baylibre.com>
In-Reply-To: <20190318100458.5619-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 21:13:17 +0100
Message-ID: <CAFBinCCSKh145--5EAPQyJjbuefRgWm57G+05so28-WiZjqNYg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] arm64: dts: meson-g12a-x96-max: add regulators
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 18, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Guillaume La Roque <glaroque@baylibre.com>
>
> Add system regulators for the X96 Max Set-Top-Box.
>
> Still missing
> * VDD_EE (0.8V - PWM controlled)
> * VDD_CPU (PWM controlled)
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> index 0edbd00b358f..5c37930b09e2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
[...]
> +       vcc_5v: regulator-vcc_5v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VCC_5V";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               vin-supply = <&dc_in>;
> +
> +               gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
> +               enable-active-high;
is there any way to test whether this GPIO is the right one?
I couldn't find a reference to a GPIOH_8 regulator in
buildroot_openlinux_kernel_4.9_fbdev_20180706


Regards
Martin
