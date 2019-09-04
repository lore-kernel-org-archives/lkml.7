Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D09C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0658E233A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cYDDozEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfIDJRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:17:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43553 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:17:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id b2so524059otq.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I+40/DNJALKIe+OMVW8OgiHh+XHMcISNZJPOwiVqxnU=;
        b=cYDDozExkHIYV0pS+OcdHOKXedZNtxAxjOpsZcONpkTyA8pgj4s1jdjMsXnH8mhLDC
         lDf2dknEmAB60L/jL10s1PKhx7qA2gKxoqKLETCab4H5uEjw4oezOXciviC4p5xwdh16
         pGqjdLTuvmSU3juIdrEi7KSXZ/oxKU4MhGRdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I+40/DNJALKIe+OMVW8OgiHh+XHMcISNZJPOwiVqxnU=;
        b=U4zdd8sS6uO/pR+iWCBsoareIDQ5UaG26MEjjU4x/LBCsC+s0qMQN9n8riHj07kFlR
         ecYAhr+pCMWQkQUbYfeDkMy2KeQMvYyPNuizOXKL3DSRnS5VsKWsv4Ydud8x8jM0AV/0
         qd3CFoJ3NtXl6kO+KDh8hViKcUhUIaNrsShTcp54PaW23bPjFtwhHC6q0ZQGONbssvV+
         yba4y5/LDWormW/+XoLPFjWlOMcguZImzrD75WC2jYAmaVKhXnA0sLpdkbp8EBQ/p9Jb
         a4Stb4DNf8CdRWu/D9QPm1x6uu4vQrG2zA7KPnCMnoiS+fhE3xT8OLBh5I/2xGJ/6nnm
         xjIQ==
X-Gm-Message-State: APjAAAWTq8UZbyKES8sBqW/Q3A0sfcfQ5b/B9RgJWyOVhoMxKYhUy2o7
        /mmFD+Ap1fwC2ylLTPrf3fLEwwBoBMKzxB/ZPbQXxjAQ
X-Google-Smtp-Source: APXvYqypz16YSXjW5oJ6bb2cXAUGXtifVRimiEm9apJ8tKa6ha99Mr+osX57GrV2Fd54XeC3XqZMn8kT4Nvrd+lcVA0=
X-Received: by 2002:a05:6830:10d8:: with SMTP id z24mr11682099oto.281.1567588657125;
 Wed, 04 Sep 2019 02:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de> <20190824051605.GA63850@shbuild999.sh.intel.com>
 <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de> <d114b0b6-6b64-406e-6c3f-a8b8d5502413@intel.com>
 <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de> <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
 <2e1b4d65-d477-f571-845d-fa0a670859af@suse.de> <20190904062716.GC5541@shbuild999.sh.intel.com>
 <72c33bf1-9184-e24a-c084-26d9c8b6f9b7@suse.de> <CAKMK7uGdOtyDHZMSzY8J45bX57EFKo=DWNUi+WL+GVOzoBpUhw@mail.gmail.com>
 <20190904083558.GD5541@shbuild999.sh.intel.com>
In-Reply-To: <20190904083558.GD5541@shbuild999.sh.intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 4 Sep 2019 11:17:25 +0200
Message-ID: <CAKMK7uGVKEN=pi4Erc_gtbL3ZFN-b6pm-nXSznjd_rH4H2yn4w@mail.gmail.com>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rong Chen <rong.a.chen@intel.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 10:35 AM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Daniel,
>
> On Wed, Sep 04, 2019 at 10:11:11AM +0200, Daniel Vetter wrote:
> > On Wed, Sep 4, 2019 at 8:53 AM Thomas Zimmermann <tzimmermann@suse.de> =
wrote:
> > >
> > > Hi
> > >
> > > Am 04.09.19 um 08:27 schrieb Feng Tang:
> > > >> Thank you for testing. But don't get too excited, because the patc=
h
> > > >> simulates a bug that was present in the original mgag200 code. A
> > > >> significant number of frames are simply skipped. That is apparentl=
y the
> > > >> reason why it's faster.
> > > >
> > > > Thanks for the detailed info, so the original code skips time-consu=
ming
> > > > work inside atomic context on purpose. Is there any space to optmis=
e it?
> > > > If 2 scheduled update worker are handled at almost same time, can o=
ne be
> > > > skipped?
> > >
> > > To my knowledge, there's only one instance of the worker. Re-scheduli=
ng
> > > the worker before a previous instance started, will not create a seco=
nd
> > > instance. The worker's instance will complete all pending updates. So=
 in
> > > some way, skipping workers already happens.
> >
> > So I think that the most often fbcon update from atomic context is the
> > blinking cursor. If you disable that one you should be back to the old
> > performance level I think, since just writing to dmesg is from process
> > context, so shouldn't change.
>
> Hmm, then for the old driver, it should also do the most update in
> non-atomic context?
>
> One other thing is, I profiled that updating a 3MB shadow buffer needs
> 20 ms, which transfer to 150 MB/s bandwidth. Could it be related with
> the cache setting of DRM shadow buffer? say the orginal code use a
> cachable buffer?

Hm, that would indicate the write-combining got broken somewhere. This
should definitely be faster. Also we shouldn't transfer the hole
thing, except when scrolling ...


> > https://unix.stackexchange.com/questions/3759/how-to-stop-cursor-from-b=
linking
> >
> > Bunch of tricks, but tbh I haven't tested them.
>
> Thomas has suggested to disable curson by
>         echo 0 > /sys/devices/virtual/graphics/fbcon/cursor_blink
>
> We tried that way, and no change for the performance data.

Huh, if there's other atomic contexts for fbcon update then I'm not
aware ... and if it's all the updates, then you wouldn't see a hole
lot on your screen, neither with the old or new fbdev support in
mgag200. I'm a bit confused ...
-Daniel

>
> Thanks,
> Feng
>
> >
> > In any case, I still strongly advice you don't print anything to dmesg
> > or fbcon while benchmarking, because dmesg/printf are anything but
> > fast, especially if a gpu driver is involved. There's some efforts to
> > make the dmesg/printk side less painful (untangling the console_lock
> > from printk), but fundamentally printing to the gpu from the kernel
> > through dmesg/fbcon won't be cheap. It's just not something we
> > optimize beyond "make sure it works for emergencies".
> > -Daniel
> >
> > >
> > > Best regards
> > > Thomas
> > >
> > > >
> > > > Thanks,
> > > > Feng
> > > >
> > > >>
> > > >> Best regards
> > > >> Thomas
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > >
> > > --
> > > Thomas Zimmermann
> > > Graphics Driver Developer
> > > SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> > > GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
> > > HRB 21284 (AG N=C3=BCrnberg)
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
