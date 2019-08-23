Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC16E21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUnOqF6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404272AbfHWNTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:19:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38029 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbfHWNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:19:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so8636163wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZPOX0INdRlOUvoefxV/HDc1vutqvPxYj4fWM1wy0rw=;
        b=mUnOqF6uNCM6LcdyehIFjzjsqAEof9B3kEFEJZUVN62H3iSJhkiiVCYHQ96YMhS7pg
         WWQxX7Zi4CQ/Hh3F8NxgU/YpVIdxTlD8WDG2Qtaq/ydXMvpj3C8idH/Ml46oVakYSRxD
         6W3Tj1DIeuKn/rRGwr3eC0wJZCyMqsBKqGFmTNSeBrrr23oJNlbCIcaHm6u6FFoocaC/
         nmyGYShss+ThniPimc4+KAPMoD9enuctPgOIRGG+NrkXuYMVi7TBln7NIqhMZxoyR75g
         wPyvuX4jjMhc9QpsgJzCdI02ckNVcKlWZfPj2tL4KCFYZJviAwZuhb6IEUrGk3yGizqd
         /Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZPOX0INdRlOUvoefxV/HDc1vutqvPxYj4fWM1wy0rw=;
        b=WUj5FFGtDlhqELbJNr0gNzoMhh5io4Ho1UjozFoz58Cy22Sf3+UEIz9tWlh2f+S4L0
         G4xBuvGAhf8BdwGT5imj61WIoXndcpjaeXTv8wLzMSOEobYmuDi4j9PmWna4B5umEVEH
         eVXensCby5G4CLBAMZzbgA5lYBEv0rX9u4zRqSeTqFO+qnohPROJ37iMdbMwXjjfouuw
         pw17kj4VwZMc7Gm0cxFHEkT6Fadj0Ctutb8kouUV11HGJ1ME/paW/eDeius1mgykqX+2
         btkwfB4bY8SAYivC/kPnFDhBJP9r75ZaPLS/A5D6XEYyg1Tq5j0oBGCb4kz+ncCfnLqA
         yWuA==
X-Gm-Message-State: APjAAAX6Qqb/o5+rQga3gNSzBDN2CEXbhPSs+hFBc8Qfg4wznULfFuzj
        e9Id81Zi37MMQ8/9ErHS4tHpH+ZOliOlmCUI3VQ=
X-Google-Smtp-Source: APXvYqwyGM+XjqB1+xj7Yj+k9wbVw5I8l/PwOau11tLzSRWm/a4VmG0taIHdQ+qFDPb+UCQEGmlZKo4bD9c+QGFI4wc=
X-Received: by 2002:a5d:5408:: with SMTP id g8mr5348355wrv.201.1566566369129;
 Fri, 23 Aug 2019 06:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190823125939.30012-1-yuehaibing@huawei.com>
In-Reply-To: <20190823125939.30012-1-yuehaibing@huawei.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 23 Aug 2019 16:19:17 +0300
Message-ID: <CAEnQRZA3reBF=H58596-e1xRLHLz5pVHZVhVgiXEmbV-wwOctg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Make some functions static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 4:12 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> sound/soc/sof/imx/imx8.c:104:6: warning: symbol 'imx8_dsp_handle_reply' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:115:6: warning: symbol 'imx8_dsp_handle_request' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:336:5: warning: symbol 'imx8_get_bar_index' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:341:6: warning: symbol 'imx8_ipc_msg_data' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:348:5: warning: symbol 'imx8_ipc_pcm_params' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/sof/imx/imx8.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index e502f58..6404724 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -101,7 +101,7 @@ static int imx8_get_window_offset(struct snd_sof_dev *sdev, u32 id)
>         return MBOX_OFFSET;
>  }
>
> -void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
> +static void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
>  {
>         struct imx8_priv *priv = imx_dsp_get_data(ipc);
>         unsigned long flags;
> @@ -112,7 +112,7 @@ void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
>         spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
>  }
>
> -void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
> +static void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
>  {
>         struct imx8_priv *priv = imx_dsp_get_data(ipc);
>
> @@ -333,21 +333,21 @@ static int imx8_remove(struct snd_sof_dev *sdev)
>  }
>
>  /* on i.MX8 there is 1 to 1 match between type and BAR idx */
> -int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
> +static int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
>  {
>         return type;
>  }
>
> -void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
> -                      struct snd_pcm_substream *substream,
> -                      void *p, size_t sz)
> +static void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
> +                             struct snd_pcm_substream *substream,
> +                             void *p, size_t sz)
>  {
>         sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
>  }
>
> -int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
> -                       struct snd_pcm_substream *substream,
> -                       const struct sof_ipc_pcm_params_reply *reply)
> +static int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
> +                              struct snd_pcm_substream *substream,
> +                              const struct sof_ipc_pcm_params_reply *reply)
>  {
>         return 0;
>  }
> --
> 2.7.4
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
