Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45675C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BC12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbfG2Pky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:40:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55975 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388095AbfG2Pkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:40:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so54298233wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URFGNdCuc17w2MBn3hDVUpGm+HQA2LH5HoY9qPXf7MA=;
        b=HsarULrvPIVMn7c1QyfPwjOsy1zs5UPCaPoKu0honm5MVFId+ZT9qkJ+moGP2LGl04
         IPa8eYtMSgIgar8u1XqKFpWmwNTz6U/WI621BoNULiqR7nVy41um6bt1uImFsY0qt6HL
         8EnVFrNEl++fEWJYa4UC1vZpcEazwCrUhsSx7KSGheueCNjhnoiUjA3aZTUS6E6iVbol
         AQRmeqoCRKV2wvurHwxRHZaGVdke59V4yE6g6oUTCG/YrwzZsAq/x1uv5T6ejTTCsTpI
         dZE6/S3iJ14iVtYMDoZRUH4ufuPFe+BiqDO7sCiSw180okF91HDbGOb/F7B0S//DHNTJ
         3wIA==
X-Gm-Message-State: APjAAAUh73eLxMFogf5ta+3fKUE1GytQICoWhUCVq39Tijm5I/teXqwV
        OoDXCZpDjffPbmRJcwdSptMV/QDskfZZyVHq8sY=
X-Google-Smtp-Source: APXvYqw7qmwWisTaRdLSAWkSTuob8FAbalj1bCbmoQk6YVPW+oWh9x4EXQXccBLfkn/tUQWVE662tyJJHi/aThNuUV8=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr101660403wme.146.1564414528469;
 Mon, 29 Jul 2019 08:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729143320.GA8212@embeddedor>
In-Reply-To: <20190729143320.GA8212@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 17:35:16 +0200
Message-ID: <CAMuHMdWAboq1YxVVJUop0woJTcantfpftVoR8T5qm3KsAMyCPg@mail.gmail.com>
Subject: Re: [PATCH] sound: dmasound_atari: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Thanks for your patch!

On Mon, Jul 29, 2019 at 4:33 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 1449:24
>
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.

Have you compile-tested this?

This doesn't work with gcc version 8.2.0 (Ubuntu 8.2.0-1ubuntu2~18.04).
Turns out the warning only goes away when converting the indentation
of the switch() statement to match kernel style... Silly gcc...

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  sound/oss/dmasound/dmasound_atari.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/oss/dmasound/dmasound_atari.c b/sound/oss/dmasound/dmasound_atari.c
> index 83653683fd68..b5845e904ba1 100644
> --- a/sound/oss/dmasound/dmasound_atari.c
> +++ b/sound/oss/dmasound/dmasound_atari.c
> @@ -1449,7 +1449,7 @@ static int FalconMixerIoctl(u_int cmd, u_long arg)
>                 tt_dmasnd.input_gain =
>                         RECLEVEL_VOXWARE_TO_GAIN(data & 0xff) << 4 |
>                         RECLEVEL_VOXWARE_TO_GAIN(data >> 8 & 0xff);
> -               /* fall thru, return set value */
> +               /* fall through - return set value */
>             case SOUND_MIXER_READ_MIC:
>                 return IOCTL_OUT(arg,
>                         RECLEVEL_GAIN_TO_VOXWARE(tt_dmasnd.input_gain >> 4 & 0xf) |

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
