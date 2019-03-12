Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3468C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78827217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfCLJQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:16:13 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43040 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfCLJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:15:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id u6so1114269vso.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4y4IIchfSlftSLeDhqfNO0q4NZ6JqSj1praIFBKDj0=;
        b=ZCtMNsCGKtIJrvgPVju4NnfxJ8lAmw4zfPGuhNwu6QA/tfCblzlkeZ6/InZCsoplj5
         PgtStwcZ9zt5WVwjoaiwWCDiDmTb91kWjoC6tZVR2uSbTsCCOH+xTtQiKDtrh9/R3YgY
         x59NGysINbpmVXGsUaBsAksgQjSc8qLYQ1T3oqwU5rlMlGuUUNWPXZnj4Z70NNTSPHvt
         n3dHkGx/GDRpy1ntYYRzTu/Mv6bN+baKWG5s3Ox3LgLkDfh3i8wdkYlXvfeAcT/uEL10
         0H6/0YFoUct1u+IvBjwwpmmZUb6XsytfdDtTEv1nGlO1FByw/r8wL9292JqcX0n2UyDL
         6vqg==
X-Gm-Message-State: APjAAAWzdDxDi2tN4t+cbogJCBfcFoVN88EfzW7QDixTSZQwCUO6pSyc
        j8tMxniwc1P16ONUI7cQHsmGTviwPAWRx7Zj+IU=
X-Google-Smtp-Source: APXvYqyJJJyMeDpfut0x4bw8ANYM8hduvuns1mqAtUuaDQYMa8CW7p8dEZ7d/MkA27CMGrrFmmOj69uKv6AmJqs2l7E=
X-Received: by 2002:a67:ead0:: with SMTP id s16mr18686682vso.63.1552382157678;
 Tue, 12 Mar 2019 02:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190307061554.26486-1-jiada_wang@mentor.com> <20190307061554.26486-2-jiada_wang@mentor.com>
In-Reply-To: <20190307061554.26486-2-jiada_wang@mentor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Mar 2019 10:15:46 +0100
Message-ID: <CAMuHMdU+1Ntz6uvk-VYsSdWJgBfzHu99SztqyfLX7z2FRxPdNg@mail.gmail.com>
Subject: Re: [PATCH linux-next v2 1/2] ASoC: rsnd: src: Avoid a potential deadlock
To:     Jiada Wang <jiada_wang@mentor.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada, Fabrizio,

On Thu, Mar 7, 2019 at 7:17 AM Jiada Wang <jiada_wang@mentor.com> wrote:
> lockdep warns us that priv->lock and k->k_lock can cause a
> deadlock when after acquire of k->k_lock, process is interrupted
> by src, while in another routine of src .init, k->k_lock is
> acquired with priv->lock held.
>
> This patch avoids a potential deadlock by not calling soc_device_match()
> in SRC .init callback, instead it adds new soc fields in priv->flags to
> differentiate SoCs.
>
> Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  sound/soc/sh/rcar/core.c | 2 ++
>  sound/soc/sh/rcar/rsnd.h | 5 +++++
>  sound/soc/sh/rcar/src.c  | 9 +--------
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
> index 022996d2db13..4fe83e611c01 100644
> --- a/sound/soc/sh/rcar/core.c
> +++ b/sound/soc/sh/rcar/core.c
> @@ -110,6 +110,8 @@ static const struct of_device_id rsnd_of_match[] = {
>         { .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
>         { .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
>         { .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN3 },
> +       /* Special Handling */
> +       { .compatible = "renesas,rcar_sound-r8a77990", .data = (void *)(RSND_GEN3 | RSND_SOC_E) },

I guess we need an entry for RZ/G2E, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
