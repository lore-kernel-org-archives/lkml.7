Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C03AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8BE218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XWSSCotf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfC2TkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:40:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42513 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2TkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:40:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so2587473oie.9;
        Fri, 29 Mar 2019 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aM9EKbz+7/aPftkItrnYnE5lqNxYBNnVwmeQcd9Kol4=;
        b=XWSSCotf/SUOGGDvpsm0X47JUHungm3R8BL9EMv5wa07skyS3+dCtJVq4UCloshw3r
         tCOzlMx2D8Ud45cz7xpFGXFlkgy5vKZypantTNwbdsKQYa9PAMEwwIgx8nk9OX/748ao
         wW7YWWqSYkW1mQbCNCoPUZyr3WkSRX59QbiUUosDYBCNKjPd0Z2Nhtfm37O2ZNThL0Ex
         OhpVIAStg5NyOLBWVyQ2+Y7HgnLtsY246fsp+D9zZvgLDFZvutnvUNXtrgy8raXM4SU9
         oLd2gIrVnngCumwnG/ZupTCdcy+wx3GlZGu9f60IgfXpAOyVptXaoqv2B78QLGnouL4C
         2JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aM9EKbz+7/aPftkItrnYnE5lqNxYBNnVwmeQcd9Kol4=;
        b=DRKKvdQAEDHebg8wAqV4MtUlFdUYNJyFWjBwAhp0YqLFADJU6sH2bjQIuGrvDYNciP
         EvCdl5UqpkxLY6d0GVBPJlh1kvfQMnrR4JTzemjYdAiU9RQtpzv/ocyuMEHgwH+K0nW+
         CBfcoI7Xb4sWv+liV7KkiKntOb4dzSEVqYwJNduxQyoY7PXig9HCQPLVQ3AZKnhg4R6z
         jc/tfOFnKBd4YxMjB0gCQQh352HfaAxQB/mNlCZleKgIanfA56nSrz5VdVTFUHgEixPY
         /M0NILR5VJ23uAXIvuOIT2e6Z804ELOelYpowbRTu6v0VEHCjBoWirh066uC1C7lGs/A
         IsUg==
X-Gm-Message-State: APjAAAWA8Y+ZMUW9uviMkssAeApbUQT5qetyLMFWXb7c5bkb0nQ4zqJL
        O/8OCWYuUWUcCjxPUZLcIkKkTWQL7FDkIqaWfrXfPOVM
X-Google-Smtp-Source: APXvYqx+0UvqGXfA1c84cS+UB+xOob5koPFek2j1iN3hUhQkOpzkkZ1VnzC/KCsVWVhLAkiY9aLtijKDly7m8gjhGPY=
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr4966052oif.140.1553888410427;
 Fri, 29 Mar 2019 12:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190329153325.23869-1-jbrunet@baylibre.com> <20190329153325.23869-2-jbrunet@baylibre.com>
In-Reply-To: <20190329153325.23869-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 29 Mar 2019 20:39:59 +0100
Message-ID: <CAFBinCDnoY41ZcoHqsngR4WTeczkmOu93R=2G_JOXbdUmHSjMw@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: meson: mpll: properly handle spread spectrum
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, Mar 29, 2019 at 4:34 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The bit 'SSEN' available on some MPLL DSS outputs is not related to the
> fractional part of the divider but to the function called
> 'Spread Spectrum'.
>
> This function might be used to solve EM issues by adding a jitter on
> clock signal. This widens the signal spectrum and weakens the peaks in it.
>
> While spread spectrum might be useful for some application, it is
> problematic for others, such as audio.
>
> This patch introduce a new flag to the MPLL driver to enable (or not) the
> spread spectrum function.
>
> Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/clk-mpll.c | 9 ++++++---
>  drivers/clk/meson/clk-mpll.h | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
> index 64d31c8ba3d0..2d39a8bc367c 100644
> --- a/drivers/clk/meson/clk-mpll.c
> +++ b/drivers/clk/meson/clk-mpll.c
> @@ -141,9 +141,12 @@ static void mpll_init(struct clk_hw *hw)
>         /* Enable the fractional part */
>         meson_parm_write(clk->map, &mpll->sdm_en, 1);
>
> -       /* Set additional fractional part enable if required */
> -       if (MESON_PARM_APPLICABLE(&mpll->ssen))
> -               meson_parm_write(clk->map, &mpll->ssen, 1);
> +       /* Set spread spectrum if possible */
> +       if (MESON_PARM_APPLICABLE(&mpll->ssen)) {
> +               unsigned int ss =
> +                       mpll->flags & CLK_MESON_MPLL_SPREAD_SPECTRUM ? 1 : 0;
> +               meson_parm_write(clk->map, &mpll->ssen, ss);
> +       }
this changes the "ssen" flag on all supported clocks from 1 (before
this patch) to 0 (after this patch).
is this on purpose and how does it affect existing clocks?

based on the original commit 1f737ffa13ef ("clk: meson: mpll: fix
mpll0 fractional part ignored") it seems that
CLK_MESON_MPLL_SPREAD_SPECTRUM should be set for mpll0 (at least on
GXBB and Meson8b)


Martin
