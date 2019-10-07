Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE03FC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBD7206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLIJFSTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfJGOSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:18:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32821 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:18:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so19412994qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0aGd5iGzy7oTR3viDB2jBKpSZXW/T11Qmx88FocAp0=;
        b=BLIJFSTB/G0hTxSyuUcChHQTUG4TktVTAMCyTFc/UM7op4sD0B69rpMXeOIiGf6kRI
         Z1zzsxjlfbahk/UR802rSVa+3rdsfua1CFa44/pN48dPKOoNoEx8PZVnmS4QBu1yA53o
         4HvslXk7uZ8b75qpxBOGtgVZLEuVRfY1ZoBu/2z3PxABOv3H3/r0ZIqoMMaJr85jAPxI
         al7Mm3ECcO+MVagXddXp6mQFUludyxrKGHF6IqEhA5qe8VwsK5a/NOOUtYcl+Hv6KVAl
         6gvDtZsTbtfIH7ZBl5+HUZtwiwVEjYu6kSq9BRnUvKZzNcRksoDGCvQBYI/dJkAulJjV
         6z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0aGd5iGzy7oTR3viDB2jBKpSZXW/T11Qmx88FocAp0=;
        b=qjZl+wDd4gVTW5Xs0DEe+6eNl0YelRVEhZgLWXu1WY23m62zt165Yum75xuVBG+W1D
         cmzSL3Lczi2jSpVqBKJJgYRa4ZPS8D4iVE4OrAVj7+Tr88pIb01P12j+IJDW8vp+1yVI
         G0XG7YzEuVd369M7qrEYOWf104sSXBmUnkzToD7T4dBMmMthJgNeECtLCgVQF19GvDvW
         ebQGer8ko5Nqk9HG7nPDZXwOlVK+Tx5ubosiSpHDhCHlwcvDJcVYNKnzRD0WqpoIF7fY
         EL7ua1zwrq1E2jDXDrGNKHzTet2FfvMoz5/sHPXHiDAFS7pLVc2cXU/KgiFSV3npI1Ar
         TXcQ==
X-Gm-Message-State: APjAAAX6+SaU9/X1nkwcXCRsAUG5BW23aBp22zaGDezj7yuJsYUmc303
        uVoL8rUxNwwywDmvkim71dsJU9Ka4vAGyeL0wlvAcw==
X-Google-Smtp-Source: APXvYqyCkMof+lfWuP5KA6qlI2H3Fjv46/wLvsY4rIyhiAcrcHG0FOMjuLe5Y/7mZugp/EJEMPLLjieK3rPinWTysy4=
X-Received: by 2002:ac8:7646:: with SMTP id i6mr30548962qtr.50.1570457917819;
 Mon, 07 Oct 2019 07:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191007104039.GA16085@andrea.guest.corp.microsoft.com>
 <20191007110117.1096-1-christian.brauner@ubuntu.com> <20191007131804.GA19242@andrea.guest.corp.microsoft.com>
 <CACT4Y+YG23qbL16MYH3GTK4hOPsM9tDfbLzrTZ7k_ocR2ABa6A@mail.gmail.com> <20191007141432.GA22083@andrea.guest.corp.microsoft.com>
In-Reply-To: <20191007141432.GA22083@andrea.guest.corp.microsoft.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Oct 2019 16:18:26 +0200
Message-ID: <CACT4Y+avbYvtF9mHiX=R8Y2=YsP1_QsN6i_FpjLM7UxCKv6vxA@mail.gmail.com>
Subject: Re: [PATCH v2] taskstats: fix data-race
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 4:14 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> > > >  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> > > >  {
> > > >       struct signal_struct *sig = tsk->signal;
> > > > -     struct taskstats *stats;
> > > > +     struct taskstats *stats_new, *stats;
> > > >
> > > > -     if (sig->stats || thread_group_empty(tsk))
> > > > -             goto ret;
> > > > +     /* Pairs with smp_store_release() below. */
> > > > +     stats = READ_ONCE(sig->stats);
> > >
> > > This pairing suggests that the READ_ONCE() is heading an address
> > > dependency, but I fail to identify it: what is the target memory
> > > access of such a (putative) dependency?
> >
> > I would assume callers of this function access *stats. So the
> > dependency is between loading stats and accessing *stats.
>
> AFAICT, the only caller of the function in 5.4-rc2 is taskstats_exit(),
> which 'casts' the return value to a boolean (so I really don't see how
> any address dependency could be carried over/relied upon here).

This does not make sense.

But later taskstats_exit does:

memcpy(stats, tsk->signal->stats, sizeof(*stats));

Perhaps it's supposed to use stats returned by taskstats_tgid_alloc?
