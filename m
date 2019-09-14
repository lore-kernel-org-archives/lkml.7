Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA41C49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 08:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E852081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 08:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SbUR5RPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfINIeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 04:34:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50929 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfINIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 04:34:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so4970902wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XR6myC8ho3Zej/eH269mFAfC2Y8Rr1vm2wEQ0SW3QIM=;
        b=SbUR5RPOuUNyQeNzfYfeB6OeQLcLvmimHMbQ0lfCgI9OkPbhxzuW48hZRnG0VMKekZ
         NoZASYUY0uodnwMYgczuvv8Tae/KJ5HdAtwKSk/FNJTCgbaMZ0qAF+pC8cQR+mO/yImw
         QSIfR22Q7QzuliXF3Ek2+SSJRhF1Y2R8U3Ff0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XR6myC8ho3Zej/eH269mFAfC2Y8Rr1vm2wEQ0SW3QIM=;
        b=O6jDgbLp3KZ3McWKy2oonz1xihXkVWJniGNpNUFPr4/L94csGcVIJltOstdfYFoZB4
         8pC1cQ1fn1lHxNdgMOE0nUNPGk++KHtroSesq7/iclDX2ZsJDW3d00M2J6/6GPLlEq4w
         Q8BDiQ+12nrj+ik3xItzI5oGUlXoTFtgGVkISDWbopjNYLGG1mngiQ8VQIuylvyBOcQa
         z3/UiMdFMhf8RZwG27mq40Lirq2BQqu0mHOSyJP3oO8c8kr5GKjp8XNekxAQFEoIL3+X
         BO/4y4jGTqyBgSzFH2RNxhO2Fg0MgDn2NVk+266kFo0zoHLe1Qtmpa6y3fJYG6j0t3GT
         Ev3A==
X-Gm-Message-State: APjAAAWoAEzsZreRiS3bP58NI4ND0A19+7ojB2rUjz/UvFb5or2XyjQB
        W1M4OCRhBPz2/zk7NPBsvwDXEpk0g2pQkrA5JZMvDw==
X-Google-Smtp-Source: APXvYqyFGOghYBtS/OOI3emUQG5Xe6OdZI24dVnaEB1q2J6IBDsVyIBIPl1/zYZxsBLy5kLeU4e51R7yO0A8vLtaNrI=
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr5975406wmg.30.1568450055796;
 Sat, 14 Sep 2019 01:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190912022740.161798-1-yuhsuan@chromium.org> <f2d9e339-ef96-8bb4-7360-422d317a470f@linux.intel.com>
 <CAGvk5PpCOG0Jii_vksrewZ_Dfmc+OVM9C6pkCYLY=n+ac-wVaA@mail.gmail.com> <bd442561-8fd9-0814-66c6-e08a21bb1a97@linux.intel.com>
In-Reply-To: <bd442561-8fd9-0814-66c6-e08a21bb1a97@linux.intel.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Sat, 14 Sep 2019 16:34:04 +0800
Message-ID: <CAGvk5Ppg-dnfO-hHWps+MeWEYhqZmehEUXNn3MvL5VJwKmM5JQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add
 dmic format constraint
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
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

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> =E6=96=BC
2019=E5=B9=B49=E6=9C=8814=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:2=
8=E5=AF=AB=E9=81=93=EF=BC=9A
>
> please don't top-post on public mailing lists, thanks.
>
> On 9/13/19 9:45 AM, Yu-Hsuan Hsu wrote:
> > Thanks for the review! If I'm not mistaken, the microphone is attached
> > to external codec(rt5514) instead of PCH on Kabylake platform. So there
> > should be a TDM between DMICs and PCH. We can see in the
> > kabylake_ssp0_hw_params function, there are some operations about
> > setting tdm slot_width to 16 bits. Therefore, I think it only supports
> > S16_LE format for DMICs. Is it correct?
>
> Ah yes, ok. we have other machine drivers where dmic refers to the PCH
> attached case, thanks for the precision.
>
> I am still not clear on the problem, you are adding this constraint to a
> front-end, so in theory the copier element in the firmware should take
> care of converting from 16-bits recorded on the TDM link to the 24 bits
> used by the application. Is this not the case? is this patch based on an
> actual error and if yes can you share more information to help check
> where the problem happens, topology maybe?

If we use 24 bits format on that device to record, the audio samples
it returns are still in 16 bits. So the rate we measured is only the
half of the expected rate. It's a real problem. Apart from the rate,
the audio samples are also wrong if we still decode them with 24 bits
format. Therefore, the better fix is to add a constraint to remove
24bits support.

By the way, we found this issue by "ALSA conformance test", which is a
new tool to verify audio drivers.
(https://chromium.googlesource.com/chromiumos/platform/audiotest/+/master/a=
lsa_conformance_test.md)

>
> >
> > Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
> > <mailto:pierre-louis.bossart@linux.intel.com>> =E6=96=BC 2019=E5=B9=B49=
=E6=9C=8812=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B
> > =E5=8D=889:02=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> >     On 9/11/19 9:27 PM, Yu-Hsuan Hsu wrote:
> >      > 24 bits recording from DMIC is not supported for KBL platform be=
cause
> >      > the TDM slot between PCH and codec is 16 bits only. We should ad=
d a
> >      > constraint to remove that unsupported format.
> >
> >     Humm, when you use DMICs they are directly connected to the PCH wit=
h a
> >     standard 1-bit PDM. There is no notion of TDM or slot.
> >
> >     It could very well be that the firmware/topology only support 16 bi=
t (I
> >     vaguely recall another case where 24 bits was added), but the
> >     description in the commit message would need to be modified to make=
 the
> >     reason for this change clearer.
> >
> >      >
> >      > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org
> >     <mailto:yuhsuan@chromium.org>>
> >      > ---
> >      >   sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
> >      >   1 file changed, 3 insertions(+)
> >      >
> >      > diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> >     b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> >      > index 74dda8784f1a01..67b276a65a8d2d 100644
> >      > --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> >      > +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> >      > @@ -400,6 +400,9 @@ static int kabylake_dmic_startup(struct
> >     snd_pcm_substream *substream)
> >      >       snd_pcm_hw_constraint_list(runtime, 0,
> >     SNDRV_PCM_HW_PARAM_CHANNELS,
> >      >                       dmic_constraints);
> >      >
> >      > +     runtime->hw.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
> >      > +     snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
> >      > +
> >      >       return snd_pcm_hw_constraint_list(substream->runtime, 0,
> >      >                       SNDRV_PCM_HW_PARAM_RATE, &constraints_rate=
s);
> >      >   }
> >      >
> >
>
