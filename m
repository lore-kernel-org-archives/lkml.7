Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33987C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C3F2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dUIzRZQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfKKCEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:04:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKKCEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:04:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so11609660wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 18:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hoNRr8vMAuZwu+YxnjVHz8DQL1f8vFbQxE/Xx5h1Uag=;
        b=dUIzRZQPn/lsKAoYuwHMdjBxwYwlKCfZbPdvnE4IpNnhKzkriar+VAq1Cc9xTIzWdt
         HB2Sr4iA0F3xg9/qMg7xZlnfZSaBiAszS1bLOReMnGIFeKzbQdab+nDkP6yZFPgW4rEI
         IIipkRJi3XMWnuDGFEV7tN8RD2wtZmehkqtmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hoNRr8vMAuZwu+YxnjVHz8DQL1f8vFbQxE/Xx5h1Uag=;
        b=ZBIT/bntAOsqu9IF21r+Z0HJo53voBxjQtqr7y+8GoxxUbTvhIEfH8kMWjPGAk7iHO
         l+JaB7WpsReJRSUsGhrhtoelIIOu7ibcwvcB44kJQBki9MnnJEy7Hp0L7BRtMRkEOkVZ
         dUJlIk8W+4xe1JGvQHfJouOK78sMwxnq/NRoeWV4Wiz8vngL0pA65Pfu5yA8kji7jisL
         rZk4tOeof4ewwg2CIbs9XvNjXqmm21Z+U5AxiO9wO9+sutSjjoN2knVO10UvR4B4NlnE
         9ZyLQ3IM1tQNRcP6QlzpxNs1xfL+kA/I0Lm6SyWienpDYe798UP/K9aktriRxCCMdA+d
         5JGg==
X-Gm-Message-State: APjAAAWTML5bXoYxaDV3HZ0w3SWyPEq1L6Ih7ByKkfgPLccYnt2BaozN
        XY6WCD1PHHGOKy6ZDHkQT5fXzTMGyf+586wXLBVHDgEc
X-Google-Smtp-Source: APXvYqz4nE5Jey3AtmxapRoFeQip25ILCpYY1Y44sryEjEoj5y9aOXdidpoAfaXB7e4B2t2fTyDBijMmi+ugy+XBkBg=
X-Received: by 2002:a1c:e157:: with SMTP id y84mr17186005wmg.59.1573437877833;
 Sun, 10 Nov 2019 18:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20190923162940.199580-1-yuhsuan@chromium.org>
In-Reply-To: <20190923162940.199580-1-yuhsuan@chromium.org>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Mon, 11 Nov 2019 10:04:26 +0800
Message-ID: <CAGvk5PqdnJ61XZMw3e4ja8YZ5_LAwJP3n=fYyKHQRwv_A+Kdwg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add dmic
 format constraint
To:     linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Does anyone have time to review this patch? It should be easy to
review because it just a format constraint.

Thanks,
Yu-Hsuan

Yu-Hsuan Hsu <yuhsuan@chromium.org> =E6=96=BC 2019=E5=B9=B49=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On KBL platform, the microphone is attached to external codec(rt5514)
> instead of PCH. However, TDM slot between PCH and codec is 16 bits only.
> In order to avoid setting wrong format, we should add a constraint to
> force to use 16 bits format forever.
>
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
> I have updated the commit message. Please see whether it is clear
> enough. Thanks.
>  sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/=
soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 74dda8784f1a01..67b276a65a8d2d 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -400,6 +400,9 @@ static int kabylake_dmic_startup(struct snd_pcm_subst=
ream *substream)
>         snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNEL=
S,
>                         dmic_constraints);
>
> +       runtime->hw.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
> +       snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
> +
>         return snd_pcm_hw_constraint_list(substream->runtime, 0,
>                         SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
>  }
> --
> 2.23.0.351.gc4317032e6-goog
>
