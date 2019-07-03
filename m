Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686FAC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A72189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfGCIep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:34:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43813 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:34:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so1199581edr.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J82z1LlQmnxvq8BGCR47A7grHNbwxVExo4k//gkAz/g=;
        b=dcIDfcbYD2wHUppZ4g0+hI1k6e5Cl0ldZjOJmyCHFjIYRGOvI2I97wYL3V4Bij96TX
         Sf4a1ccMUZ+lKD/sSkrovt+an96BwmyzP/58ftyva5J0unUYUdZ4hqb2lN1n9ixrw+YH
         4P2aa8UKdxrJoeMUXE2nJ1xZGFPIPfMIkxN+4l4pS6j63h954pPdfAOua6Z7tpFu+5N8
         /FshuFzJ0CUQ8TWFzX1c6yVWGrHRCwG2Jpz/xaBhSNVKDLuoCY0GlwHX3NLtY5s6fsna
         mgSCjFjxJY0oUq7JmXFzS5Y/U6J4SY/BN66j7qxjYlJcPFv/80qeCwLA8f9bU6qG1kbu
         6KDQ==
X-Gm-Message-State: APjAAAWBZocRk0dqcA7x6is/zuioNsmHMdKanGvo3epzO9yNWrh+zds0
        l7nOQRPtCLx4IHkTJaQ+3gCpE6We5oM=
X-Google-Smtp-Source: APXvYqzF2UfidSwyyUx5ARMiahBg5ZrorXqb1TqrEdvL44cz8m6yOeQU5PG5zADZ6zklqXLoa+fXeQ==
X-Received: by 2002:a17:906:4e42:: with SMTP id g2mr27947356ejw.304.1562142883275;
        Wed, 03 Jul 2019 01:34:43 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id c49sm471083eda.74.2019.07.03.01.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 01:34:41 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id p11so1733529wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:34:40 -0700 (PDT)
X-Received: by 2002:a5d:5009:: with SMTP id e9mr23708360wrt.279.1562142880511;
 Wed, 03 Jul 2019 01:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190702191613.11084-1-luca@z3ntu.xyz>
In-Reply-To: <20190702191613.11084-1-luca@z3ntu.xyz>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 3 Jul 2019 16:34:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v66gX83sR-aWgFKBX+BH7Mud_PaAMvw4eNctQZFMkBYo=g@mail.gmail.com>
Message-ID: <CAGb2v66gX83sR-aWgFKBX+BH7Mud_PaAMvw4eNctQZFMkBYo=g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sunxi: sun50i-codec-analog: Add earpiece
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 3:17 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> This adds the necessary registers and audio routes to play audio using
> the Earpiece, that's supported on the A64.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> So, first of all: This is my first audio patch and I hope I didn't make
> too many mistakes :) , especially with the routes at the bottom of
> the patch.
>
> What I'm really unsure about, is how the enable & mute registers should
> be handled. Should I put both registers into a SOC_DOUBLE("Earpiece
> Playback Switch",...)?

What we normally have with sunxi is the "Enable" switches typically
control whether a given function is active or not. With the earpiece
output, it controls the amplifier for the output. This should be modeled
as a separate DAPM widget, without a control, and let the framework
deal with it.

The mute controls the signal, so you can just keep as a control.

>  sound/soc/sunxi/sun50i-codec-analog.c | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
> index d105c90c3706..6c19fea992c5 100644
> --- a/sound/soc/sunxi/sun50i-codec-analog.c
> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
> @@ -49,6 +49,15 @@
>  #define SUN50I_ADDA_OR_MIX_CTRL_DACR           1
>  #define SUN50I_ADDA_OR_MIX_CTRL_DACL           0
>
> +#define SUN50I_ADDA_EARPIECE_CTRL0     0x03
> +#define SUN50I_ADDA_EARPIECE_CTRL0_EAR_RAMP_TIME       4
> +#define SUN50I_ADDA_EARPIECE_CTRL0_ESPSR               0
> +
> +#define SUN50I_ADDA_EARPIECE_CTRL1     0x04
> +#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN    7
> +#define SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE  6
> +#define SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL     0
> +
>  #define SUN50I_ADDA_LINEOUT_CTRL0      0x05
>  #define SUN50I_ADDA_LINEOUT_CTRL0_LEN          7
>  #define SUN50I_ADDA_LINEOUT_CTRL0_REN          6
> @@ -172,6 +181,10 @@ static const DECLARE_TLV_DB_RANGE(sun50i_codec_lineout_vol_scale,
>         2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
>  );
>
> +static const DECLARE_TLV_DB_RANGE(sun50i_codec_earpiece_vol_scale,
> +       0, 1, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
> +       2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
> +);
>
>  /* volume / mute controls */
>  static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
> @@ -225,6 +238,19 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
>                    SUN50I_ADDA_LINEOUT_CTRL0_LEN,
>                    SUN50I_ADDA_LINEOUT_CTRL0_REN, 1, 0),
>
> +       SOC_SINGLE_TLV("Earpiece Playback Volume",
> +                      SUN50I_ADDA_EARPIECE_CTRL1,
> +                      SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
> +                      sun50i_codec_earpiece_vol_scale),
> +
> +       SOC_SINGLE("Earpiece Playback Switch (enable)",
> +                  SUN50I_ADDA_EARPIECE_CTRL1,
> +                  SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_EN, 1, 0),

As mentioned above, this should be a DAPM widget instead.

> +
> +       SOC_SINGLE("Earpiece Playback Switch",
> +                  SUN50I_ADDA_EARPIECE_CTRL1,
> +                  SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
> +
>  };
>
>  static const char * const sun50i_codec_hp_src_enum_text[] = {
> @@ -257,6 +283,20 @@ static const struct snd_kcontrol_new sun50i_codec_lineout_src[] = {
>                       sun50i_codec_lineout_src_enum),
>  };
>
> +static const char * const sun50i_codec_earpiece_src_enum_text[] = {
> +       "DACR", "DACL", "Right Analog Mixer", "Left Analog Mixer",

I suggest dropping "Analog" to match what other controls, such as the
Headphone Source" control, uses.

ChenYu

> +};
> +
> +static SOC_ENUM_SINGLE_DECL(sun50i_codec_earpiece_src_enum,
> +                           SUN50I_ADDA_EARPIECE_CTRL0,
> +                           SUN50I_ADDA_EARPIECE_CTRL0_ESPSR,
> +                           sun50i_codec_earpiece_src_enum_text);
> +
> +static const struct snd_kcontrol_new sun50i_codec_earpiece_src[] = {
> +       SOC_DAPM_ENUM("Earpiece Source Playback Route",
> +                     sun50i_codec_earpiece_src_enum),
> +};
> +
>  static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>         /* DAC */
>         SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
> @@ -285,6 +325,10 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
>                          SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
>         SND_SOC_DAPM_OUTPUT("LINEOUT"),
>
> +       SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
> +                        SND_SOC_NOPM, 0, 0, sun50i_codec_earpiece_src),
> +       SND_SOC_DAPM_OUTPUT("EARPIECE"),
> +
>         /* Microphone inputs */
>         SND_SOC_DAPM_INPUT("MIC1"),
>
> @@ -388,6 +432,13 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
>         { "Line Out Source Playback Route", "Mono Differential",
>                 "Right Mixer" },
>         { "LINEOUT", NULL, "Line Out Source Playback Route" },
> +
> +       /* Earpiece Routes */
> +       { "Earpiece Source Playback Route", "DACL", "Left DAC" },
> +       { "Earpiece Source Playback Route", "DACR", "Right DAC" },
> +       { "Earpiece Source Playback Route", "Left Analog Mixer", "Left Mixer" },
> +       { "Earpiece Source Playback Route", "Right Analog Mixer", "Right Mixer" },
> +       { "EARPIECE", NULL, "Earpiece Source Playback Route" },
>  };
>
>  static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
> --
> 2.22.0
>
