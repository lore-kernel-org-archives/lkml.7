Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB88C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CF2208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNkFCUXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfEMLMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:12:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41822 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfEMLMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:12:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so16998442edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSJpKKtOaPRaJ2njSlc0Hr8McxaKKWYBOWZ1jc3Lolo=;
        b=KNkFCUXmd4nRtY/OXamhwSMyjSblY9iYDyLW/7Dy9vStTfXSe1MiQu4nVAVGxVnyNh
         o3xuFcsFU+7MrHEZAln5yws3QmSAFEb4Rr5S/2BCeT4mRaQjnATCqPXOPNUZbl8hXFCO
         UpiSW+cuVrPtEdWEk4bnI6Rg35MKFUza0Dw1q2/qnlpgaGseLDJw+fVsXiU3Y40oRcIS
         pZaysV/0qluCZjFbYVDXukpcbAv+lTuZEjkIUFhI4GzG51W3kgQ+j9nvLxiDnz0IAH1a
         cWu2GslHRjZUMppjyy1CUwpYBBNopAkD01I44d3iXRojuUnSwF4chMeoib80pZYcodzx
         w1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSJpKKtOaPRaJ2njSlc0Hr8McxaKKWYBOWZ1jc3Lolo=;
        b=l4GMeO+vWv0MYeCHD1GLIbSeaZ2YBsimr0GkHv87vNB8jhJe67O4H4LF1pxRy/wX7N
         t1LbErAUYIuBlun7KL2WEOkBSooYl21Pznii/dUKXccJnOOqDDK4FaqnnLj9mBq1KRj1
         OyWskfDsNQfgX35rFi2CnmlX2mYL6pFGMJazmDyteu1QxDgRKTS/5aV19RIHS/9Xnpi6
         mu+xSseyc1b2kfwl/Q5JZZebDbSWk3PUX8H+ozBQ0tfp8fEH2aNLqmFGM0PWOniN8RoS
         02VnTKhGRC9r2R85iu+T3urbKDqy0ih8dg881WMtkf7G8NHDIr38TP5Qvq2RusGcYnEC
         9tgA==
X-Gm-Message-State: APjAAAUWYyT4NO9Sn/eXhrowAVQoO2s77XFsENoUfciWiAMT3gn1+1eD
        gmvlDOkeXt8UYm6Ie2J0BAsI6ZBV0onxEmksx0A=
X-Google-Smtp-Source: APXvYqy9j1/ftxSAlDMn4oGTpMjDHKVh5q+Hw/bOLNMBvJm+ijQLv8tZllu5OB7gwwVri8ii3X5j4owklvzmd4VPaJk=
X-Received: by 2002:a17:906:6857:: with SMTP id a23mr14655557ejs.280.1557745954760;
 Mon, 13 May 2019 04:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com> <1557741724-6859-2-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1557741724-6859-2-git-send-email-viorel.suman@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 13 May 2019 14:12:22 +0300
Message-ID: <CAEnQRZAwz+g_-xKwhECYz=Zc6phFrfj0PE22qXJa2sfAAci7JQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 1/2] ASoC: ak4458: rstn_control - return a
 non-zero on error only
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

On Mon, May 13, 2019 at 1:04 PM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> snd_soc_component_update_bits() may return 1 if operation
> was successful and the value of the register changed.
> Return a non-zero in ak4458_rstn_control for an error only.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/codecs/ak4458.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
> index eab7c76..baf990a 100644
> --- a/sound/soc/codecs/ak4458.c
> +++ b/sound/soc/codecs/ak4458.c
> @@ -304,7 +304,10 @@ static int ak4458_rstn_control(struct snd_soc_component *component, int bit)
>                                           AK4458_00_CONTROL1,
>                                           AK4458_RSTN_MASK,
>                                           0x0);
> -       return ret;
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
>  }
>
>  static int ak4458_hw_params(struct snd_pcm_substream *substream,
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
