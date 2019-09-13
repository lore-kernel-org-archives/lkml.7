Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5857BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A08220678
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RtVOQl6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfIMQBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:01:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:01:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so32049066wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xK3P/MTBGgvM9inB0b/+0BFfc7AXQxejr+yyElk4fOo=;
        b=RtVOQl6S0qDe3qqqZfOn+HYcBwzwBHLscsskaaMW8gjHeRO1yNBIApe4AbJfwm/AhP
         Xy3Tly5958IZh4IzKxBy9rwkgCC7L/Zq5br8ZM7FUakg25OAfV+d7+Oief38xPlT+L5+
         7STiYilmvmSxjFst7uVDgmNORsKFwriLEL/Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xK3P/MTBGgvM9inB0b/+0BFfc7AXQxejr+yyElk4fOo=;
        b=Deah+szyOV9yMjXNnJd+nwZ7Q8lokjE+WdCs2aZ7fqE5+qB8ZlLCy1MdvP8nycjn3+
         6h0mv/4bTbnFbiq+YdRW/2ij1K3L2pYwgtH1ILBjygmJ1x+FRu1IDEvVufR2ZeOiF/C7
         JdAd/Ej84xghmhiedrIi12s8SSbBJ6Hdqmu0TBJK7sJS52AC5yjyt+rGB/sY6QJbDxYj
         PCnmxFBP+0danbR1oJ0h9ML9+LMds1rvuwZKsbfKT88Pj37T8ovMcCT1F2uYYVvb/KXR
         fJgi/l8pZVQkarGBB3RAoZtllTumBDsnEp2uL5gCpXRBuqInX1ZfJmheb7XzIjR2DDcy
         lFKQ==
X-Gm-Message-State: APjAAAVVyd1OCk6iwtouhfnIKXxGjtHleTC7YaFcg4hXFsKtS6+Mo/vN
        Znm/H8Ud6hmtlJw15dxnRQeA+wnz6x7zA49hqD4/9Q==
X-Google-Smtp-Source: APXvYqyEhc02o1CZzKDqnsA5N4VH62NZw/ZCFduDfVoTeL7AGFM1k8EQtzNWkOsjRFuc0dUlkz4Yo0uSyn3TKbVCo6k=
X-Received: by 2002:a5d:62c6:: with SMTP id o6mr6921750wrv.243.1568390511848;
 Fri, 13 Sep 2019 09:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190912022740.161798-1-yuhsuan@chromium.org> <f2d9e339-ef96-8bb4-7360-422d317a470f@linux.intel.com>
In-Reply-To: <f2d9e339-ef96-8bb4-7360-422d317a470f@linux.intel.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Sat, 14 Sep 2019 00:01:40 +0800
Message-ID: <CAGvk5PoWOQKYT4T18_xTzz=85k3_W_0hnSS3EJCEk4ukkaSzcw@mail.gmail.com>
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
2019=E5=B9=B49=E6=9C=8812=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:0=
2=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 9/11/19 9:27 PM, Yu-Hsuan Hsu wrote:
> > 24 bits recording from DMIC is not supported for KBL platform because
> > the TDM slot between PCH and codec is 16 bits only. We should add a
> > constraint to remove that unsupported format.
>
> Humm, when you use DMICs they are directly connected to the PCH with a
> standard 1-bit PDM. There is no notion of TDM or slot.
>
> It could very well be that the firmware/topology only support 16 bit (I
> vaguely recall another case where 24 bits was added), but the
> description in the commit message would need to be modified to make the
> reason for this change clearer.

(I sent it again because the previous email contains HTML subpart.
Sorry for the inconvenience.)

Thanks for the review! If I'm not mistaken, the microphone is attached
to external codec(rt5514) instead of PCH on Kabylake platform. So
there should be a TDM between DMICs and PCH. We can see in the
kabylake_ssp0_hw_params function, there are some operations about
setting tdm slot_width to 16 bits. Therefore, I think it only supports
S16_LE format for DMICs. Is it correct?
>
>
>
> >
> > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > ---
> >   sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/soun=
d/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > index 74dda8784f1a01..67b276a65a8d2d 100644
> > --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > @@ -400,6 +400,9 @@ static int kabylake_dmic_startup(struct snd_pcm_sub=
stream *substream)
> >       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNEL=
S,
> >                       dmic_constraints);
> >
> > +     runtime->hw.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
> > +     snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
> > +
> >       return snd_pcm_hw_constraint_list(substream->runtime, 0,
> >                       SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
> >   }
> >
>
