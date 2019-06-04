Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40CBC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 03:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60BB25F63
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 03:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcst1qx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDD0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 23:26:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38274 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFDD0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 23:26:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so12135728qtj.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 20:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAjnAQ0K1hwYMM9KoNoMU2lJGPs5nS56B44QDhx0hDo=;
        b=lcst1qx/GHdqNmKA5u4qCKjmdHycGvAGijuRlbh3ztn3J7LpyVsaugqFZCmbkCquOQ
         X2bn4P7pO4r9AsUbDUkhCCHmv/lu3RO5D4chblb12rGHWFNLJtQ+gP8e1QCcqpPZWmPW
         j5oSO+KtxAVIVj8LWjRBEdVyC5vGu1OPBoKOHnnFXAcZ8vvwIn6UG0DBiVKomyJG/Lz0
         5rBKGdHftFs88QBitexyae3k1ZoFAspekrRpU3lPJrTNr5oy9hxRVJSwg5FWTOfMGpHj
         6onv6LN/pvWrlKILtHdpE985wcuhAohzeTVe6a+OcBysWTffIjA3aMR5JT8kVjBYfRD4
         9N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAjnAQ0K1hwYMM9KoNoMU2lJGPs5nS56B44QDhx0hDo=;
        b=f27dF1OKODXuCVDCfsVkkSTEiGlBHl39atBbxbNcLtWVvVdOlcPebbvlTrAJ1L1FaA
         ceiSdAGtRdx1AWDvanfvP7IgZH2IgXBtDNuza+96jqjtV56S3u+iv4c2VTaR3QYr0I22
         +QGNMSU6kmfOh3qnhWqVK/WmrdQJ5JinbJfaOwUTikL2GiMVBTTVBa4zU6yfKphWk1cs
         ykKO8gVi/swqfZcH/aiTqnQhVJM2buPEJKqSm27F9l1KjkSDAGtYiFcdjz6+VtkJFKTN
         a9F5egEK22ICK1cmet+LEqovNpvgz5d3bIiIbI+PFzNOSiooHdy6UQv0FjR6hxI2Hc0a
         u1Ig==
X-Gm-Message-State: APjAAAXctqmbKcDFZhWq39eE7Yvvz3EUWkYzB+ReuJe0A7Rj9vfwEvW8
        GySiwreLOdEzPMAhj32dG4vjSltiYsX9AoiTd5dvBdA6RdNZzWPd
X-Google-Smtp-Source: APXvYqycQS+KYKe4U6PuulC0mMXA/LEo66BT5illnpNsgL+k2PBmNmm+RRTnCrdkDjZfwOlvyaBYJsnH6UTyj+sQ5Hc=
X-Received: by 2002:a0c:a066:: with SMTP id b93mr24420790qva.140.1559618801568;
 Mon, 03 Jun 2019 20:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205918.22251-1-longman@redhat.com> <20190520205918.22251-8-longman@redhat.com>
 <CAHttsrYx=pgen5yVpYfCKaymoCaA7iJ52B8t_ycD2UcDR2848Q@mail.gmail.com>
In-Reply-To: <CAHttsrYx=pgen5yVpYfCKaymoCaA7iJ52B8t_ycD2UcDR2848Q@mail.gmail.com>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Tue, 4 Jun 2019 11:26:30 +0800
Message-ID: <CAHttsrZCGMqBi4ifj7A1rO3G3nOz-0pbD8TXRtUQ1rGQRAGiUw@mail.gmail.com>
Subject: Re: [PATCH v8 07/19] locking/rwsem: Implement lock handoff to prevent
 lock starvation
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 at 11:03, Yuyang Du <duyuyang@gmail.com> wrote:
>
> Hi Waiman,
>
> On Tue, 21 May 2019 at 05:01, Waiman Long <longman@redhat.com> wrote:
> >
> > Because of writer lock stealing, it is possible that a constant
> > stream of incoming writers will cause a waiting writer or reader to
> > wait indefinitely leading to lock starvation.
> >
> > This patch implements a lock handoff mechanism to disable lock stealing
> > and force lock handoff to the first waiter or waiters (for readers)
> > in the queue after at least a 4ms waiting period unless it is a RT
> > writer task which doesn't need to wait. The waiting period is used to
> > avoid discouraging lock stealing too much to affect performance.
>
> I was working on a patchset to solve read-write lock deadlock
> detection problem (https://lkml.org/lkml/2019/5/16/93).
>
> One of the mistakes in that work is that I considered the following
> case as deadlock:

Sorry everyone, but let me rephrase:

One of the mistakes in that work is that I considered the following
case as no deadlock:

>
>   T1            T2
>   --            --
>
>   down_read1    down_write2
>
>   down_write2   down_read1
>
> So I was trying to understand what really went wrong and find the
> problem is that if I understand correctly the current rwsem design
> isn't showing real fairness but priority in favor of write locks, and
> thus one of the bad effects is that read locks can be starved if write
> locks keep coming.
>
> Luckily, I noticed you are revamping rwsem and seem to have thought
> about it already. I am not crystal sure what is your work's
> ramification on the above case, so hope that you can shed some light
> and perhaps share your thoughts on this.
>
> Thanks,
> Yuyang
