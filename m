Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E91BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D538C208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9pxyutt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfEMLOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:14:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46481 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfEMLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:14:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so16977176edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWmGYQkX5ziDlQEAMnWWXiWNixr8ETc6toa2bNjqovo=;
        b=p9pxyutt3nteInevAPKvPqzooCTEiAwiquO+LcBVrdiBLukNvM4nG5ZQTW8QtcyVsT
         jZu83ZbINTP8vZ1TSPWXxh5LjStyLFesGIRHR0+bfcipRebTmcyfmwuuq1535mJYI57o
         BQVkIel/2raqaE1U4wX0nqm+mfOXENzHoVhjZwIBa6g6xt0zCpSNOGuEVqYYPsX13Dpc
         KCwgP5qExQ7UQjKJV1L05mlKOZtObyxN6jEO1eU4V3cqqL+R2Mf19P3nkYLaz7Mq8NKd
         LzY9b+fdOOZ5sgFqb0W4J0L+kJbV8R09Q3kjrTXFIrCmycJoSB8gpMN17V5612EdGpaR
         /0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWmGYQkX5ziDlQEAMnWWXiWNixr8ETc6toa2bNjqovo=;
        b=cEI3YUVTOjRvBhFpGe9OivbEY28dSK8cMOBnvCY8ywX8z0p+IjoTHJwBoWb2uIbOqN
         0PZe6tS46Gb4x7SykEhei/NsTObuBzhy+K4nB1lPT6ODPhkazNMnRjS46DtORPP++0pB
         hxA6oonxjtWaxkp4Apz8vZPmi6Xon8zUX0YDKQTYnrjom91YuoAAgLZvt2IXSqv22lkD
         qZWnfCHkdhJlhvWyBvtXTJMhVb2qLl8l2gdWqxDIg8zwWHWa27TfWmVMtNNZIbfpAWaG
         vuTHDZp/ZxTlXulUiG1hqhtNN4+LrirtwUVnCeIpKeYo4QfP9guSA+3FzGHLPL2ImKax
         7kJg==
X-Gm-Message-State: APjAAAWJV2EOyHRwlVOItFt6WSDbFc42xsC1cfPlSoNn83kne+lDOKj2
        K1JxCxj7AxxmgeRhB5ChmNaqieK1MOcPVNnTZ8w=
X-Google-Smtp-Source: APXvYqxehO6qr0CVLbZ/ewnxhNOUYns80zBSSRxZ/Oe/UAEL7fk2757r5dLBz6+hh8X23yEasknD3OzQVXJ3eUtlp7s=
X-Received: by 2002:a50:9441:: with SMTP id q1mr28451354eda.101.1557746086425;
 Mon, 13 May 2019 04:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com> <1557741724-6859-3-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1557741724-6859-3-git-send-email-viorel.suman@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 13 May 2019 14:14:35 +0300
Message-ID: <CAEnQRZDqaXPaE_RiSRmKfqOkwORp5zPoigG2sDAt52zwVWwGow@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 2/2] ASoC: ak4458: add return value for ak4458_probe
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Colin Ian King <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 1:05 PM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> AK4458 is probed successfully even if AK4458 is not present - this
> is caused by probe function returning no error on i2c access failure.
> Return an error on probe if i2c access has failed.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/codecs/ak4458.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
> index baf990a..7156215 100644
> --- a/sound/soc/codecs/ak4458.c
> +++ b/sound/soc/codecs/ak4458.c
> @@ -539,9 +539,10 @@ static void ak4458_power_on(struct ak4458_priv *ak4458)
>         }
>  }
>
> -static void ak4458_init(struct snd_soc_component *component)
> +static int ak4458_init(struct snd_soc_component *component)
>  {
>         struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
> +       int ret;
>
>         /* External Mute ON */
>         if (ak4458->mute_gpiod)
> @@ -549,21 +550,21 @@ static void ak4458_init(struct snd_soc_component *component)
>
>         ak4458_power_on(ak4458);
>
> -       snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
> +       ret = snd_soc_component_update_bits(component, AK4458_00_CONTROL1,
>                             0x80, 0x80);   /* ACKS bit = 1; 10000000 */
> +       if (ret < 0)
> +               return ret;
>
> -       ak4458_rstn_control(component, 1);
> +       return ak4458_rstn_control(component, 1);
>  }
>
>  static int ak4458_probe(struct snd_soc_component *component)
>  {
>         struct ak4458_priv *ak4458 = snd_soc_component_get_drvdata(component);
>
> -       ak4458_init(component);
> -
>         ak4458->fs = 48000;
>
> -       return 0;
> +       return ak4458_init(component);
>  }
>
>  static void ak4458_remove(struct snd_soc_component *component)
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
