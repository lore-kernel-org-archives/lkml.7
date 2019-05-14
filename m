Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222CAC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1832084F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VSY8dXQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfENQrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:47:23 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39231 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:47:23 -0400
Received: by mail-ua1-f67.google.com with SMTP id v7so6455408ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7PwSEWga2/yPtBQUis8gBpGWAMpLLGBJz02yhRxW58=;
        b=VSY8dXQoBspa4RXRjnFzsXCE0X8Uk+FIr6PE+cYivABoT0y+YLVAE8RbSuXG99Z7Rf
         N25/9PQ9Ufr7OYaHSH7Oh1iMkAYcaMSPowqMKeVyfw80o2CRO7ieTWCoCIez+CTxr4Tl
         rSbsPE7YdyNeVFoFWWU48wHDTgvkSL8q1w8to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7PwSEWga2/yPtBQUis8gBpGWAMpLLGBJz02yhRxW58=;
        b=TFwqLgIx6g+w1Whp0SSSnc1Q28x/8RfP1Nl+OhBc2NzrlSTDNIg+lXUcIOFKPprerd
         JCDCMcIPpZbdDrq37Wl1nDib/G8BOPqZAyJBq6ntPOhVEzfVJZ+WyGQtI8fsRaOT2A3z
         pTzFh54Bcypx6XiGxwdhK3Erslo7+0oKkYyRgYejH4rMKp7D1WgwwuSnH6dVoaNWsCLY
         Dd5vBPvlD8uuwIKZGJScjUlcau2XySAS7U78CsKwPaUhCSjN/r5hQdgn0pkbRhsctGe0
         mSnXTUTLfo46tdmiVCGHMAE0zHk8m36AtDswo1QaZXI3mM3AnVO7yRN+cBX4O18tCJA+
         loTg==
X-Gm-Message-State: APjAAAURhM0r5bGkXIdb7To6PH4m7r6nwpkVWJ013nGCm7QvA5ifcRrj
        eGQr4MLWGSj62HqWklKaNhDtIhH1reU=
X-Google-Smtp-Source: APXvYqzarCVh4FvfCDlqwwh7HhzHjeBDqJblyShJ81QHLPXzQ7iWpVkXAo65WOU262MoHxTzI2eoOg==
X-Received: by 2002:ab0:806:: with SMTP id a6mr18119629uaf.10.1557852441897;
        Tue, 14 May 2019 09:47:21 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id o66sm3621844vke.17.2019.05.14.09.47.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 09:47:20 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id z17so6467448uar.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:47:20 -0700 (PDT)
X-Received: by 2002:ab0:2692:: with SMTP id t18mr1528737uao.106.1557852440345;
 Tue, 14 May 2019 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com>
 <20190513171519.GA26166@redhat.com>
In-Reply-To: <20190513171519.GA26166@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 May 2019 09:47:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7GDNoJVvRgBTDoVkf9UYA69B-rTY2G3888w=9iS=RtQ@mail.gmail.com>
Message-ID: <CAD=FV=X7GDNoJVvRgBTDoVkf9UYA69B-rTY2G3888w=9iS=RtQ@mail.gmail.com>
Subject: Re: Problems caused by dm crypt: use WQ_HIGHPRI for the IO and crypt workqueues
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Tim Murray <timmurray@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 13, 2019 at 10:15 AM Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, May 13 2019 at 12:18pm -0400,
> Doug Anderson <dianders@chromium.org> wrote:
>
> > Hi,
> >
> > I wanted to jump on the bandwagon of people reporting problems with
> > commit a1b89132dc4f ("dm crypt: use WQ_HIGHPRI for the IO and crypt
> > workqueues").
> >
> > Specifically I've been tracking down communication errors when talking
> > to our Embedded Controller (EC) over SPI.  I found that communication
> > errors happened _much_ more frequently on newer kernels than older
> > ones.  Using ftrace I managed to track the problem down to the dm
> > crypt patch.  ...and, indeed, reverting that patch gets rid of the
> > vast majority of my errors.
> >
> > If you want to see the ftrace of my high priority worker getting
> > blocked for 7.5 ms, you can see:
> >
> > https://bugs.chromium.org/p/chromium/issues/attachmentText?aid=392715
> >
> >
> > In my case I'm looking at solving my problems by bumping the CrOS EC
> > transfers fully up to real time priority.  ...but given that there are
> > other reports of problems with the dm-crypt priority (notably I found
> > https://bugzilla.kernel.org/show_bug.cgi?id=199857) maybe we should
> > also come up with a different solution for dm-crypt?
> >
>
> And chance you can test how behaviour changes if you remove
> WQ_CPU_INTENSIVE? e.g.:
>
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 692cddf3fe2a..c97d5d807311 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -2827,8 +2827,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>
>         ret = -ENOMEM;
>         cc->io_queue = alloc_workqueue("kcryptd_io/%s",
> -                                      WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
> -                                      1, devname);
> +                                      WQ_HIGHPRI | WQ_MEM_RECLAIM, 1, devname);
>         if (!cc->io_queue) {
>                 ti->error = "Couldn't create kcryptd io queue";
>                 goto bad;
> @@ -2836,11 +2835,10 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>
>         if (test_bit(DM_CRYPT_SAME_CPU, &cc->flags))
>                 cc->crypt_queue = alloc_workqueue("kcryptd/%s",
> -                                                 WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
> -                                                 1, devname);
> +                                                 WQ_HIGHPRI | WQ_MEM_RECLAIM, 1, devname);
>         else
>                 cc->crypt_queue = alloc_workqueue("kcryptd/%s",
> -                                                 WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND,
> +                                                 WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND,
>                                                   num_online_cpus(), devname);
>         if (!cc->crypt_queue) {
>                 ti->error = "Couldn't create kcryptd queue";

It's not totally trivially easy for me to test.  My previous failure
cases were leaving a few devices "idle" over a long period of time.  I
did that on 3 machines last night and didn't see any failures.  Thus
removing "WQ_CPU_INTENSIVE" may have made things better.  Before I say
for sure I'd want to test for longer / redo the test a few times,
since I've seen the problem go away on its own before (just by
timing/luck) and then re-appear.

Do you have a theory about why removing WQ_CPU_INTENSIVE would help?

---

NOTE: in trying to reproduce problems more quickly I actually came up
with a better test case for the problem I was seeing.  I found that I
can reproduce my own problems much better with this test:

  dd if=/dev/zero of=/var/log/foo.txt bs=4M count=512&
  while true; do
    ectool version > /dev/null;
  done

It should be noted that "/var" is on encrypted stateful on my system
so throwing data at it stresses dm-crypt.  It should also be noted
that somehow "/var" also ends up traversing through a loopback device
(this becomes relevant below):


With the above test:

1. With a mainline kernel that has commit 37a186225a0c
("platform/chrome: cros_ec_spi: Transfer messages at high priority"):
I see failures.

2. With a mainline kernel that has commit 37a186225a0c plus removing
WQ_CPU_INTENSIVE in dm-crypt: I still see failures.

3. With a mainline kernel that has commit 37a186225a0c plus removing
high priority (but keeping CPU intensive) in dm-crypt: I still see
failures.

4. With a mainline kernel that has commit 37a186225a0c plus removing
high priority (but keeping CPU intensive) in dm-crypt plus removing
set_user_nice() in loop_prepare_queue(): I get a pass!

5. With a mainline kernel that has commit 37a186225a0c plus removing
set_user_nice() in loop_prepare_queue() plus leaving dm-crypt alone: I
see failures.

6. With a mainline kernel that has commit 37a186225a0c plus removing
set_user_nice() in loop_prepare_queue() plus removing WQ_CPU_INTENSIVE
in dm-crypt: I still see failures

7. With my new "cros_ec at realtime" series and no other patches, I get a pass!


tl;dr: High priority (even without CPU_INTENSIVE) definitely causes
interference with my high priority work starving it for > 8 ms, but
dm-crypt isn't unique here--loopback devices also have problems.


-Doug
