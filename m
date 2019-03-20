Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF86C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB8321873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jgf6sgY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfCTUiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:38:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44420 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:38:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so3416359otl.11;
        Wed, 20 Mar 2019 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS28IOdb+N4OpJMYZwvSYBGAUmBgN2n51QXH6hhVFhw=;
        b=jgf6sgY5sBRNZVxPBkWf1m/XKBgEaqmQ48DjGNpRGX+vdmFXwJBj9akSYV+EplRRxe
         ysPz1XDDmPxcoN9CAcXJeRkbx1Q0Mwmh+Lkajs6TU1Qdd6aLQ9Dyz4QSh+SWgc36n+VV
         h/gQdgL1JNEW36icXHx/EdCTfxdJDajq9Ar/TfcTvfvrGrzRyOZAmxxU7CBROlvO3JoW
         HgZonX0ipUfG+mWtZuR7YVQtaSSs5bBs5BC1TUZfVOMKoURrL1iY6X8Qaf1FEEZXugm6
         1baueBQppbmVdPxWosUm41g1mq/m1Q9r9hpBtkfogGK70zAiIsWkaWm++yo4jKNUtpSq
         V9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS28IOdb+N4OpJMYZwvSYBGAUmBgN2n51QXH6hhVFhw=;
        b=UgitLO8eE1HDO+rDyRlHdceae8Nz1QyFP1VOif1/LPPGcUwYufvMFdRIzpALN6Pirj
         zqG7CYBoNxgiJLMlEaOQ+hghlwdTMFxSRVPHMtce41R0TJxXWu50FeUheNvQDnBK5Mxe
         7zqTIpzO64fgar+kMfQD5/H3W86fGhnjDOh/3Q4EYesa40B76TjuaJMphzvc79gKd5cp
         EoEmi6vZoK9Cc9KjMVkk3mT9E51G1d2i3uBtx8T6W6mZsoe0L411vXgtjSf641x6h2m4
         SvA1Vxdy3dl5NdwQDRg5J1ZhQEhE4/mwknB1kaXIRUFRD26D1mnkLwJaNx14VjG/F/Md
         hQ4A==
X-Gm-Message-State: APjAAAVGIm5wCUKIvV9BQyC1UblMdhRHLSekgBAdxC0KH8XqkwqTvtTr
        CHZnQkHcc6uUgwZhkY4HtZ6FxrZ3sfdkRQaYmtw=
X-Google-Smtp-Source: APXvYqwFxNQQS7bEDrTe9ECfwBUC0mZ+RR/Anzw/RLbwocF5qZ/7UmpTy8kZB+aaUb8YldwOu1GPgoMAnhbMr3JoOjM=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr17150otk.86.1553114324569;
 Wed, 20 Mar 2019 13:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
 <20190319215121.29340-3-martin.blumenstingl@googlemail.com> <1d52f584-1a5d-8b0d-ecd0-8c041f2b9c18@baylibre.com>
In-Reply-To: <1d52f584-1a5d-8b0d-ecd0-8c041f2b9c18@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 20 Mar 2019 21:38:33 +0100
Message-ID: <CAFBinCC61EgCS2djT2NZdYnGsHM1VS3_zOzaxSDyHGdguLCFyg@mail.gmail.com>
Subject: Re: [PATCH 2/4] clk: meson: meson8b: use a sparate clock table for Meson8m2
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Mar 20, 2019 at 9:15 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> There is a typo in the subject "s/sparate/separate/" !
good catch - I'll wait until the weekend and send a fixed version then!

> On 19/03/2019 22:51, Martin Blumenstingl wrote:
> > Meson8, Meson8b and Meson8m2 implement a similar clock controller.
> > However, there are a few differences between the three actual IP blocks.
> >
> > One example where Meson8m2 differs from Meson8b is the VPU clock setup:
> > - the VPU input mux can choose between "fclk_div4", "fclk_div3",
> >   "fclk_div5" and "fclk_div7" on Meson8b
> > - however, on Meson8m2 it can choose between "fclk_div4", "fclk_div3",
> >   "fclk_div5" and "gp_pll" (GP_PLL only exists on Meson8m2, it's the
> >   predecessor of the GP0_PLL clock on GXBB/GXL/GXM))
>
> By curiosity, what is the default (maximum) setup ? On GX & G12A, fclk_div3 is the default/max setup.
u-boot on my Meson8m2 board uses GP_PLL as input (364MHz)
u-boot on my Meson8b (Odroid-C1) uses fclk_div7 as input (approx. 364MHz)
if you want I can look up the divider (I don't remember it from the
top of my head)

[...]
> Apart the typo in the subject,
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
thank you!


Regards
Martin
