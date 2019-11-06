Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97356C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656082173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp3zwyxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfKFLgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:36:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35083 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfKFLgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:36:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id p2so112363wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 03:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCw5fZ9l2RrOi3SE8aqoJuN0UEZysLXdrRoRB/SxvBQ=;
        b=cp3zwyxxGArn6yB7UddfdzaHFMsp10QWEUHJUO0vPDt8WXjEKvzzCwG8xusRCA+PJS
         XkIAfXXJcOPnfFo39YKbHA1s4qQcxejVHSqrhFIfmpSZQqvkLx90rBW+OCy0c68xJGWI
         4+FUYZgWb15MxOtMawwLF7fnoW69g0OtktE26iIljd7V9AeTipZcWWcswuWycY31CsOh
         8/bnNr7wHEcZwGZbIYr5rL8GBPBBn9QeI2eEy76QjH6XzZzcMHLM52q6j/VD7asOqnXJ
         G12h0bezxKBl2VGTO95uzQyU2QcDUxxe2YtPboFfK9DItm5As9C6GaTRrSJHC87Eilqs
         KdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCw5fZ9l2RrOi3SE8aqoJuN0UEZysLXdrRoRB/SxvBQ=;
        b=dxFTa+aYj7dnK5fCvAh71KbdZPOyJZDDqKF9XBjAx4vWNGff0ta6wcEMuX5zca6hIF
         Nx5ZLB/eXoyoZrEcURjjS0nfJeXpMjXdtBhT8bVzZyEOA4MQe3dEfXGhU7dynL+Eurmt
         GdrDGKaNuOXi6lnsIuCwqP/3aqdktuCIq4VsiZCbW6LdXb+uW1RRlPQmkghdsZN/UA1j
         eybwkZMg4+BKtOmFLWHtQ/XHHpK/0p32W7rIiml5Q5nrMLZ0Blad47Fc71/eiIvO2hkm
         mpMz+oKCJj+XuLXgAxn8NA/zE8/6HbOmRZH9VdBwHvQTFXM9u0p/bH/bcyTjTjiU/bzw
         tN+A==
X-Gm-Message-State: APjAAAXiS290tDBAv0hEnfhsqLNrtR/VbQsV1MVyIRwMz4JUID4THxZg
        NcOJUp7s/VDZl4t3Uku0b8NOlT+dioGIYzDNXut3FxM2
X-Google-Smtp-Source: APXvYqwq2zOaSIHLbR6lNDivoEFIR2AaMIjiv6C+GRRxG2Vqs1g+sI7nHw0I9kP2JTsFUuxglZfMQIhWMhS7fqWQcnc=
X-Received: by 2002:a5d:5306:: with SMTP id e6mr2160142wrv.187.1573040198673;
 Wed, 06 Nov 2019 03:36:38 -0800 (PST)
MIME-Version: 1.0
References: <1573025265-31852-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1573025265-31852-1-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 6 Nov 2019 13:36:26 +0200
Message-ID: <CAEnQRZB0tXZvArgxL+u7x1RAWGyw8bDbGRF9u6tKiPjJbMpGkw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_audmix: Add spin lock to protect tdms
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

Comments inline.

On Wed, Nov 6, 2019 at 9:30 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Audmix support two substream, When two substream start
> to run, the trigger function may be called by two substream
> in same time, that the priv->tdms may be updated wrongly.
>
> The expected priv->tdms is 0x3, but sometimes the
> result is 0x2, or 0x1.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_audmix.c | 6 ++++++
>  sound/soc/fsl/fsl_audmix.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
> index c7e4e9757dce..a1db1bce330f 100644
> --- a/sound/soc/fsl/fsl_audmix.c
> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -286,6 +286,7 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>                                   struct snd_soc_dai *dai)
>  {
>         struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
> +       unsigned long lock_flags;
>
>         /* Capture stream shall not be handled */
>         if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> @@ -295,12 +296,16 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
>         case SNDRV_PCM_TRIGGER_START:
>         case SNDRV_PCM_TRIGGER_RESUME:
>         case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +               spin_lock_irqsave(&priv->lock, lock_flags);

Why do we need to disable interrupts here? I assume that lock is only
used in process context.

thanks,
Daniel.
