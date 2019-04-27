Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9573C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717BB20645
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DUEXK7Q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfD0U0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:26:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46999 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0U0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:26:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so5489712otk.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htGG/QDITTjzI/SpL8tXuy05dilvstyb85gN9ZixiaM=;
        b=DUEXK7Q1EaNC1WOySNY36v2tkh4NaIc6y5v06HAKPUIrT0i60BJTQwEANyDsDBNZ/D
         0uYytnFZywbCHcB8zoPk4F02v2VVoyyjd/6Et6dLFP5/CytPJsWhL30rbQ9yjWCx3+US
         6Uop/c97LkIF6Hnng42NP78Vl7xXYmBy1x5TJU15obE03d0Odl84XocrDDyEuGlf+W/D
         s7be9A4shhvdcd77Lph1LMf/ee6Qt4DHvUZXiGznxOOpmWXfuNM7Ig8ppp8zOpzamJPn
         EPkIt1LjLaNQK1hBHqfmXEGVzgzQsun32VM5UhriL9RBENJMGD2ku0jY5g3kAbrPQW3S
         UMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htGG/QDITTjzI/SpL8tXuy05dilvstyb85gN9ZixiaM=;
        b=UjwzMw57TIOEygUQ1jUT8v/QaWGZl96IrM101tofaPFi7AB+W3NTFIteq4k+98vOP+
         kXMULIGFgy4e8baiqNJkMecHiiLvO7aPXzWXRtgs9UBYPNlolapMSRLKLtAP2s0hCpuq
         QGhkrhDC61/ZdTnfR1eaLzGhlVTwFxllrsXdgzYVN1zCpvT2ukovQzdaa8qguW5U9/48
         9Aj3Eui3hDRiy7wRuXUEswbfbFmHF6e/8ZDxdIOlAP83PABlf7nfutjBmDn2DMtMFxou
         jLz4Rdxc9xSynPuI2azv9C+7vHuphDXrS/v0TRNoJ7a/aXgyaftg/AOzba2511SdV14z
         iIuQ==
X-Gm-Message-State: APjAAAW8TzhHd70qIfLQh2mI2h0yEQ0gLxIOt8pnQ9744MoIrUByx3re
        1ZZ7kuGhHKbm/TLiv/CU93qemCSpLvx/E3l286Y=
X-Google-Smtp-Source: APXvYqxmZcAARJYmMBlSpzioTQi4gzrDkaGUC1GBOoR5pfyicYYBOKt8NRkZbxw9KIJJSVZ+KbPlUYWCLTDkToss26A=
X-Received: by 2002:a9d:76d5:: with SMTP id p21mr31514726otl.308.1556396775956;
 Sat, 27 Apr 2019 13:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190423091503.10847-1-narmstrong@baylibre.com> <20190423091503.10847-7-narmstrong@baylibre.com>
In-Reply-To: <20190423091503.10847-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:26:05 +0200
Message-ID: <CAFBinCDOGyP5pwcmV_4ZjhY4hiBaTesrgfEMyQ6yfx+T0Uo1hg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: meson: Add minimal support for Odroid-N2
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Apr 23, 2019 at 11:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This patch adds basic support for :
> - Amlogic G12B, which is very similar to G12A
> - The HardKernel Odroid-N2 based on the S922X SoC
>
> The Amlogic G12B SoC is very similar with the G12A SoC, sharing
> most of the features and architecture, but with these differences :
> - The first CPU cluster only has 2xCortex-A53 instead of 4
> - G12B has a second cluster of 4xCortex-A73
> - Both cluster can achieve 2GHz instead of 1,8GHz for G12A
> - CPU Clock architecture is difference, thus needing a different
>   compatible to handle this slight difference
> - Supports a MIPI CSI input
> - Embeds a Mali-G52 instead of a Mali-G31, but integration is the same
>
> Actual support is done in the same way as for the GXM support, including
> the G12A dtsi and redefining the CPU clusters.
> Unlike GXM, the first cluster is different, thus needing to remove
> the last 2 cpu nodes of the first cluster.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
I don't have the board myself so I can't test it. However, apart from
one comment below this is looking good so:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +&usb {
> +       status = "okay";
> +};
> +
> +&usb2_phy0 {
> +       phy-supply = <&usb_pwr_en>;
> +};
is usb_pwr_en really the phy-supply or is it the vbus-supply of the
USB top control block (&usb node)?


Martin
