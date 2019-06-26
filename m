Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE92C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110B02085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kyg5STNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFZUfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:35:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33545 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfFZUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:35:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so43397lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTRf588K19VR3uE4xJO4Ojwc8tEPausRnAboL2Ui+lU=;
        b=kyg5STNuNn7xfncn6wo2Yv/G5ZEt6xObU+gLxf5bai1e0LwHH3HnqqpmBIDfCmVxlS
         qz+z5g81bjwQWPsYzAdU9I4U77GW33GYOGebiIVAVbGpBrcTkwORPHT2q7vcucoNZwg8
         ePNS9c2+vF0OyA0BDj2kyQSCfD65z6LrU8Zzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTRf588K19VR3uE4xJO4Ojwc8tEPausRnAboL2Ui+lU=;
        b=NMBp8ZC9F+uN2Vtiuw6DG8g5vzjzmKah7984ZHYfqZApL7CwCAfGmDvi66NQNOrGb+
         E+CVYpyYVscbwnA4bY8fULE5xdUPL27IEnlSWMi6yi8GBrjU1mZscmMxBNwOdup5UsvS
         3wuwlXS7x7d8il15Ht69Is0Q4aNM/GYVnSyk/5Q9t44zwOFAEB9YLZrZOojaqX/BCNKg
         41TFcKLyBvAlOC7kAOAHf4A3N8g+h3+ZUYhFIT7/ZZr5qWasXrztXWbjt9szmf3yn1Sx
         gRVOGGfr5P/LQd7iC6zXLNj3jALVW59C9fBsq/Z2b51JU8DgG8DMttTuNif2WNKBEpqI
         Sdjw==
X-Gm-Message-State: APjAAAViIVsmQRdUQjjbNZJI9jg2rfwzip4RI/jgX5nQ5dGus2J2aIzq
        FRdjCwoJeXvf/xhcYDSRbDQyVFsoIRI=
X-Google-Smtp-Source: APXvYqyV9uWgTXc/6cEaRtmaba7SakBnEkJ+SOmrssfPjkeFetA92ABrO0y/Cv1ryjfLb3QT6phy4A==
X-Received: by 2002:ac2:4904:: with SMTP id n4mr38847lfi.53.1561581306421;
        Wed, 26 Jun 2019 13:35:06 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 80sm12449lfz.56.2019.06.26.13.35.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 13:35:05 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 131so3587852ljf.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:35:05 -0700 (PDT)
X-Received: by 2002:a2e:9c41:: with SMTP id t1mr142105ljj.6.1561581304868;
 Wed, 26 Jun 2019 13:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190625215418.17548-1-evgreen@chromium.org> <s5himsssqe8.wl-tiwai@suse.de>
In-Reply-To: <s5himsssqe8.wl-tiwai@suse.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 26 Jun 2019 13:34:28 -0700
X-Gmail-Original-Message-ID: <CAE=gft62iv=V=auOhocRRfPV2Tuc2WiRYJOH5_M+HkM0qH-Jhw@mail.gmail.com>
Message-ID: <CAE=gft62iv=V=auOhocRRfPV2Tuc2WiRYJOH5_M+HkM0qH-Jhw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Use correct start/count for sysfs init
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Thomas Gleixner <tglx@linutronix.de>,
        "Amadeusz S*awi*ski" <amadeuszx.slawinski@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 1:27 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 25 Jun 2019 23:54:18 +0200,
> Evan Green wrote:
> >
> > The normal flow through the widget sysfs codepath is that
> > snd_hdac_refresh_widgets() is called once without the sysfs bool set
> > to set up codec->num_nodes and friends, then another time with the
> > bool set to actually allocate all the sysfs widgets. However, during
> > the first time allocation, hda_widget_sysfs_reinit() ignores the new
> > num_nodes passed in via parameter and just calls hda_widget_sysfs_init(),
> > using whatever was in codec->num_nodes before the update. This is not
> > correct in cases where num_nodes changes. Here's an example:
> >
> > Sometime earlier:
> > snd_hdac_refresh_widgets(hdac, false)
> >   sets codec->num_nodes to 2, widgets is still not allocated
> >
> > Now:
> > snd_hdac_refresh_widgets(hdac, true)
> >   hda_widget_sysfs_reinit(num_nodes=7)
> >     hda_widget_sysfs_init()
> >       widget_tree_create()
> >         alloc(codec->num_nodes) // this is still 2
> >   codec->num_nodes = 7
> >
> > Pass num_nodes and start_nid down into widget_tree_create() so that
> > the right number of nodes are allocated in all cases.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Thanks for the patch.  That's indeed a problem, but I guess a simpler
> approach is just to return if sysfs didn't exist.  If the sysfs
> entries aren't present at the second call with sysfs=true, it implies
> that the codec object will be exposed anyway later, and the sysfs will
> be created there.  So, something like below would work instead?

Hi Takashi,
Thanks for taking a look. I'm not sure you'd want to do that because
then you end up returning from sysfs_reinit without having allocated
any of the sysfs widgets. You'd be relying on the implicit behavior
that another call to init is coming later (despite having updated
num_nodes and start node), which is difficult to follow and easy to
break. In my opinion the slight bit of extra diffs is well worth the
clarity of having widget_tree_create always allocate the correct
start/count.

Actually, in looking at the widget lock patch, I don't think it's
sufficient either. It adds a lock around sysfs_reinit, but the setting
of codec->num_nodes and codec->start_nid is unprotected by the lock.
So you could have the two threads politely serialize through
sysfs_reinit, but then get reordered before setting codec->num_nodes,
landing you with an array whose length doesn't match num_nodes.

Let me craft up an additional patch to fix the locking.
-Evan

>
>
> thanks,
>
> Takashi
>
> --- a/sound/hda/hdac_sysfs.c
> +++ b/sound/hda/hdac_sysfs.c
> @@ -428,7 +428,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
>         int i;
>
>         if (!codec->widgets)
> -               return hda_widget_sysfs_init(codec);
> +               return 0;
>
>         tree = kmemdup(codec->widgets, sizeof(*tree), GFP_KERNEL);
>         if (!tree)
