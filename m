Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48007C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FD8214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfHGGg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:36:27 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:44940 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfHGGg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:36:27 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x776aPfp060234
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 02:36:26 -0400
Received: by mail-lf1-f43.google.com with SMTP id x3so63264847lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 23:36:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUCAfC/ne2th2s4qQ0AnSsdS7sDdz8IJUlgsNULd+Spic5YtDN8
        cA/JNHKtSo38vByC4P4csSMKa1TOQyP2h0vDJ5M=
X-Google-Smtp-Source: APXvYqxi4dKptE+0uRVH3LQnwgbIkzKfmoRHAjVF058miJuQSfE8z+Z7mv+uM58P9AeypODBnMZmdkM1bad3jfBXvB8=
X-Received: by 2002:a19:4aca:: with SMTP id x193mr4878607lfa.146.1565159785183;
 Tue, 06 Aug 2019 23:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAAa=b7ffFNc4zuQfXEwsS363=kX_ZOx0+jhg4WM3JQ-d7n-LMA@mail.gmail.com>
 <s5h8ss5o569.wl-tiwai@suse.de>
In-Reply-To: <s5h8ss5o569.wl-tiwai@suse.de>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Wed, 7 Aug 2019 02:35:49 -0400
X-Gmail-Original-Message-ID: <CAAa=b7fRWjusR8y8DZze7NOW+P4w0O-HLK+5fcpZV8mcTeV37w@mail.gmail.com>
Message-ID: <CAAa=b7fRWjusR8y8DZze7NOW+P4w0O-HLK+5fcpZV8mcTeV37w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: pcm: fix a memory leak bug
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

On Wed, Aug 7, 2019 at 2:33 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 07 Aug 2019 08:15:17 +0200,
> Wenwen Wang wrote:
> >
> > In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
> > on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'.
> > However, if the initialization fails, 'rt' is not deallocated, leading to a
> > memory leak bug.
> >
> > To fix the above issue, free 'rt' before returning the error.
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  sound/usb/hiface/pcm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
> > index 14fc1e1..5dbcd0d 100644
> > --- a/sound/usb/hiface/pcm.c
> > +++ b/sound/usb/hiface/pcm.c
> > @@ -599,8 +599,10 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
> > extra_freq)
> >         for (i = 0; i < PCM_N_URBS; i++) {
> >                 ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
> >                                     hiface_pcm_out_urb_handler);
> > -               if (ret < 0)
> > +               if (ret < 0) {
> > +                       kfree(rt);
> >                         return ret;
> > +               }
>
> Unfortunately this still leaves some memory.  We need to release
> rt->out_urbs[], too.  The relevant code is already in
> hiface_pcm_destroy(), so factor out the looped kfree() there and call
> it from both places.
>
> Care to resubmit with more fixes?

Thanks for your comments! I also found this issue, and am working on
another patch to fix it.

Wenwen
