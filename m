Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3264AC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8A62087F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViH32LHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEBWoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:44:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37359 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfEBWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:44:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id k23so5482640wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SuUpfHu3jsyrHNGkijE3t4kxZS81qdHPL95LsioUnGs=;
        b=ViH32LHWXkf+gwRwBFv9arWh1x/EQk3jp2GPbg9ZDbhOQGKi18HcFZ2a2WhvUdi0E2
         hLvmZB7C0IFgBg2Wt5nPCV3wA+dJCEcrgd8xjJ5KKdM2aS0VsIPysO9DPqo1Y5f9lYLo
         qaAhnsjBl9hDzPhHjUXmIAW3wvTicKFLDFu7kZq52ny7jUEI//hYwQuWSMS3chSvHm+Z
         VO0Wdt5xL/wnXtyjcztI2b0wSpaSa5bw4RaFt5QAqXPbUY35WUbALfrrAL/ZYAb1oMdX
         OltRwihVxtM4GvvA+QkJh+Xvo+IGoR8HSfpyGf6+K0hBJW1uT5Suj0QV35es4Q/JcWMf
         9MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SuUpfHu3jsyrHNGkijE3t4kxZS81qdHPL95LsioUnGs=;
        b=mxcy5KXY8xzb7OnVobvFap6coEKDIs8kU1Q3GaeVAz9d4Tj8xCrUX4KvRUie6i20vh
         bxxgcuirIs/xyniFvbbPoxEtHL+Z6flDEyaB19wdZ7kAYw6ZXLy8oqNKLuY17MfS+hIS
         tUJMTybHs3zTnRqiB1jG90C98S4qPgzOR1gjD0JHWHOB8W+8qJ+pwB1ozR+Si037V50O
         rApWLQZJNdTx3OYFTaZNNp62dyW6NCMVHIyG6IyaKbRgmxIMqjdAVZQtyNMxBMJFTu1N
         Ux38B1dpXz6RdVGHcZvM7NfJpfEi+EA1qOCDkd18pFkLDGlPh6qnKJHQC7+W7sMwvFrF
         M0eQ==
X-Gm-Message-State: APjAAAXG8M5uzLlfvA7y7bqAwZrV1hJ3XD+SIHdwr1fUolPJAy0YvO++
        vzLHU6wQvNDIrevekCnOZjD4rIWPSLKZ+uWI50Y=
X-Google-Smtp-Source: APXvYqwNoLYrunH147NNmfIlbuaw02XNIikLKmKRNPweSoKWE52cBbTEMFCd6StVQmgpG2uMD74V9CWt37ZivUZ4L9I=
X-Received: by 2002:a5d:6101:: with SMTP id v1mr4479676wrt.222.1556837059885;
 Thu, 02 May 2019 15:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181332.5503-1-sravanhome@gmail.com>
In-Reply-To: <20190502181332.5503-1-sravanhome@gmail.com>
From:   =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= 
        <benoit.thebaudeau.dev@gmail.com>
Date:   Fri, 3 May 2019 00:44:31 +0200
Message-ID: <CA+sos7-U49b7DyQ76h-RohhGqPSPqsV-u-r+oaZnB5=DAkbm6w@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: tlv320aic3x: Add support for high
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

On Thu, May 2, 2019 at 8:14 PM Saravanan Sekar <sravanhome@gmail.com> wrote=
:
>
> Add support to output level control for the analog high power output
> drivers HPOUT and HPCOM.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>
> Notes:
>     Changes in V3:
>     -Fixed compilation error
>
>     Changes in V2:
>     - Removed power control as it is handled by DAPM
>     - Added level control for left channel
>
>  sound/soc/codecs/tlv320aic3x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3=
x.c
> index 516d17cb2182..489a6d89d63d 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
>   */
>  static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
>
> +/* HP/HPCOM volumes. From 0 to 9 dB in 1 dB steps */
> +static DECLARE_TLV_DB_SCALE(hp_tlv, 0, 100, 0);

This could be made "const" (as well as the other instances of
DECLARE_TLV_DB_SCALE()).

The hp_tlv naming is fine for the change here, but something not
HP-specific, such as out_tlv would be better if you consider the
further changes that could use this definition:
static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
+/* Output volumes. From 0 to 9 dB in 1 dB steps */
+static const DECLARE_TLV_DB_SCALE(out_tlv, 0, 100, 0);

E.g., the following control could be added to aic3x_snd_controls[]:
+SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, 4,
9, 0, out_tlv),

And this control could be added to aic3x_mono_controls[]:
+SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0, out_tlv),

The MONOLOPM_CTRL register exists for the 33 and 3106, but not for the
31, 32, 3007, and 3104 (it should not be written to for these CODECs).
However, the driver uses this register for the 31 and 32 too, which
should be fixed rather than disabling the corresponding pin as
suggested in the file top comment.

> +
>  static const struct snd_kcontrol_new aic3x_snd_controls[] =3D {
>         /* Output */
>         SOC_DOUBLE_R_TLV("PCM Playback Volume",
> @@ -419,6 +422,12 @@ static const struct snd_kcontrol_new aic3x_snd_contr=
ols[] =3D {
>         /* Pop reduction */
>         SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
>         SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
> +
> +       /* Analog HPOUT, HPCOM output level controls */
> +       SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL,
> +                       4, 9, 0, hp_tlv),

Correct for all the supported CODECs.

> +       SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTR=
L,
> +                       4, 9, 0, hp_tlv),

Correct for all the supported CODECs but the TLV320AIC3007. The latter
has no HPRCOM output, but only HPCOM (=3D HPLCOM). The HPRCOM_CTRL
register of this CODEC is reserved and should not be written to. All
the references to this register for this CODEC are actually broken in
this driver. You could still add this control, and the 3007 issue
could be fixed separately by you or someone else.

You could keep the volumes grouped with the corresponding switches,
just like all the AGC or PGA Capture controls are grouped together:
-/* Output pin mute controls */
+/* Output pin controls */
+SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, 4,
9, 0, out_tlv),
SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3, 0x01, 0),
+SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, 4,
9, 0, out_tlv),
SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3, 0x01, 0),
+SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
4, 9, 0, out_tlv),
SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3, 0x01, 0)=
,

And:
+SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0, out_tlv),
SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),

>  };
>
>  /* For other than tlv320aic3104 */

Best regards
Beno=C3=AEt
