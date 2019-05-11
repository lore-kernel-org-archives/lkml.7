Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1281C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0A6216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 19:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXrknFiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfEKTKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 15:10:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKTKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 15:10:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id m20so8569396wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 12:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MfGrmqC7D7F6enHrfpsTmPEIqWHqv5G2uRwI3xddp6M=;
        b=bXrknFiQeIOVGskqrvgOsC/geKwFDC3Yo86/CAKighwYpuQInu6FECJYMiJ76alKI2
         9+cYwRqcty0U7gjzes8v6xzXtlf2rqgAceyauoeyxTg+cGfw/OxFdprUhEq2tIVVHTAa
         Ikq0AIW3DgOCxm28Q+hkoypNLPpeb6/0lASFeXqCqvQ7gMEF5xVVm0AUA8e8b7UQkVNu
         NEhvuHdkepU9XvAdzgNYwClqwi3MYzkGvX4ZwzRsJzKcfyFklb2QSV4KOkmjG6CvuCI0
         x9eU12fG3MJd+rowd9vID23WJIADTi8QPi/vLC0mneWR+4+SVWROSVdrPtZtUJAzYDJJ
         68Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MfGrmqC7D7F6enHrfpsTmPEIqWHqv5G2uRwI3xddp6M=;
        b=p8Gl5OJ2730HWPWNbkLXyw3pV1XMMidSkszyr9ctgD+NYPwI3/19N76dnwUbLuutGk
         bVZkjbS3l7UTVFeuJ+YuKNwNM0W1yS5DSFlDsqhEjF/4jKKUp24Wa0IkDioelytJMo1I
         1E6Vt6zb9o5tH7Zu7yPLKmNkcXeI2rbUpeZSrstiTJJIw2O537WvSlMxabiyzZlYhUvA
         jFB1qk9a7AOKe31C+R2V7s/YUAcCcaTtIMSEFvIy9w5DZkCMqxDA2NxSD2PUqCPO9TRT
         1jx9uvvCxpFZGYreYZs6HF053qXqqeDtUJHvDsfYLeH+FaUrphE9VlC+CBNqewNYcOkr
         rBgA==
X-Gm-Message-State: APjAAAWFCIuMe9XaY3eXloC5S2Y1rhLl6cZ8bzWAprv74oJcIo2mugIA
        UFI/saKpikXI1F0jlXQju4EKhM1ppvOKmwJeCvU=
X-Google-Smtp-Source: APXvYqxtrXHmxuXeZG5+dLztGl2XzuGjN6KcXSqF9ibg83JTKY98Ld6NJtsvolWaVnE4iN/5T1rlOR0y5jo1Pys9oMU=
X-Received: by 2002:a1c:5f02:: with SMTP id t2mr10697632wmb.19.1557601808429;
 Sat, 11 May 2019 12:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190511151149.28823-1-sravanhome@gmail.com>
In-Reply-To: <20190511151149.28823-1-sravanhome@gmail.com>
From:   =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= 
        <benoit.thebaudeau.dev@gmail.com>
Date:   Sat, 11 May 2019 21:10:32 +0200
Message-ID: <CA+sos7-KyuCmfuxby4ta46ypK6H-DmEA7RgoL3cyrghQa8i+zA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4] ASoC: tlv320aic3x: Add support for high
 power analog output
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, Alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Saravanan Sekar,

On Sat, May 11, 2019 at 5:13 PM Saravanan Sekar <sravanhome@gmail.com> wrot=
e:
>
> Add support to output level control for the analog high power output
> drivers HPOUT and HPCOM.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>
> Notes:
>     Notes:
>         Changes in V4:
>         -Added separate mono playback volume control
>         -grouped volume controls with corresponding switch
>
>         Changes in V3:
>         -Fixed compilation error
>
>         Changes in V2:
>         - Removed power control as it is handled by DAPM
>         - Added level control for left channel
>
>  sound/soc/codecs/tlv320aic3x.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3=
x.c
> index 516d17cb2182..599e4ed3850b 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
>   */
>  static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
>
> +/* Output volumes. From 0 to 9 dB in 1 dB steps */
> +static const DECLARE_TLV_DB_SCALE(out_tlv, 0, 100, 0);
> +
>  static const struct snd_kcontrol_new aic3x_snd_controls[] =3D {
>         /* Output */
>         SOC_DOUBLE_R_TLV("PCM Playback Volume",
> @@ -386,11 +389,17 @@ static const struct snd_kcontrol_new aic3x_snd_cont=
rols[] =3D {
>                          DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
>                          0, 118, 1, output_stage_tlv),
>
> -       /* Output pin mute controls */
> +       /* Output pin controls */
> +       SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, =
4,
> +                        9, 0, out_tlv),
>         SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
>                      0x01, 0),
> +       SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, =
4,
> +                        9, 0, out_tlv),
>         SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
>                      0x01, 0),
> +       SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTR=
L,
> +                        4, 9, 0, out_tlv),
>         SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3=
,
>                      0x01, 0),
>
> @@ -472,6 +481,9 @@ static const struct snd_kcontrol_new aic3x_mono_contr=
ols[] =3D {
>                          0, 118, 1, output_stage_tlv),
>
>         SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
> +       SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0,
> +                       out_tlv),
> +
>  };
>
>  /*
> --
> 2.17.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Reviewed-by: Beno=C3=AEt Th=C3=A9baudeau <benoit.thebaudeau.dev@gmail.com>

Best regards,
Beno=C3=AEt
