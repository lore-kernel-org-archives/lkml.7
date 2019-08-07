Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2657BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055A421BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfHGHYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:24:48 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:45480 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfHGHYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:24:48 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x777OjeM061253
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 03:24:46 -0400
Received: by mail-lj1-f177.google.com with SMTP id p17so84514406ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 00:24:46 -0700 (PDT)
X-Gm-Message-State: APjAAAVrxdTJLwEk/u2oDEQhAYPrFk1cLOrpvBY2j9hLEVoOlZk6OC/1
        Og+v2Mhh/6r1qB8hYlh5IGXALKtrecldZkHha98=
X-Google-Smtp-Source: APXvYqw7AV1qOIRFM5iroGqqZTGmVstTMrMRgRdOkFFNBa3998VR/3ohCw6xMvC1v7NGHLy2SsiLweoN5rphQWModk4=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr3962559lji.169.1565162685345;
 Wed, 07 Aug 2019 00:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAAa=b7dkPm4JqF4_cPwJo_6_aoobr6OyezCb2A9-aAFHNWffeQ@mail.gmail.com>
 <s5hv9v9moir.wl-tiwai@suse.de>
In-Reply-To: <s5hv9v9moir.wl-tiwai@suse.de>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Wed, 7 Aug 2019 03:24:08 -0400
X-Gmail-Original-Message-ID: <CAAa=b7d-vxsrzk=B+Qcg1Fp6JgUJ1FOAXbJLU-SL_v-+nKVzaQ@mail.gmail.com>
Message-ID: <CAAa=b7d-vxsrzk=B+Qcg1Fp6JgUJ1FOAXbJLU-SL_v-+nKVzaQ@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: pcm: fix multiple memory leak bugs
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 3:18 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 07 Aug 2019 09:09:59 +0200,
> Wenwen Wang wrote:
> >
> > In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
> > on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'. In
> > hiface_pcm_init_urb(), 'rt->out_urbs[i].buffer' is allocated through
> > kzalloc().  However, if hiface_pcm_init_urb() fails, both 'rt' and
> > 'rt->out_urbs[i].buffer' are not deallocated, leading to memory leak bugs.
> > Also, 'rt->out_urbs[i].buffer' is not deallocated if snd_pcm_new() fails.
> >
> > To fix the above issues, free 'rt' and 'rt->out_urbs[i].buffer'.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  sound/usb/hiface/pcm.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
> > index 14fc1e1..9b132aa 100644
> > --- a/sound/usb/hiface/pcm.c
> > +++ b/sound/usb/hiface/pcm.c
> > @@ -599,12 +599,18 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
> > extra_freq)
> >         for (i = 0; i < PCM_N_URBS; i++) {
> >                 ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
> >                                     hiface_pcm_out_urb_handler);
> > -               if (ret < 0)
> > +               if (ret < 0) {
> > +                       for (; i >= 0; i--)
> > +                               kfree(rt->out_urbs[i].buffer);
> > +                       kfree(rt);
> >                         return ret;
> > +               }
> >         }
> >
> >         ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
> >         if (ret < 0) {
> > +               for (i = 0; i < PCM_N_URBS; i++)
> > +                       kfree(rt->out_urbs[i].buffer);
> >                 kfree(rt);
> >                 dev_err(&chip->dev->dev, "Cannot create pcm instance\n");
> >                 return ret;
>
> The fixes look correct, but since we can unconditionally call kfree()
> for NULL, both error paths can be unified as:
>
>         for (i = 0; i < PCM_N_URBS; i++)
>                 kfree(rt->out_urbs[i].buffer);
>         kfree(rt);
>
> and this would be better to be put in the common path at the end and
> do "goto error" or such from both places.

I will rework the patch and revise the subject line.

> BTW, your patch doesn't seem cleanly applicable in anyway because the
> tabs are converted to spaces.  Please check the mail setup.
>
> Also, please try to make the subject line more unique.  This is about
> hiface driver, so "ALSA: hiface: xxx" should be more appropriate.

I will also check my mail setup. Thanks!

Wenwen
