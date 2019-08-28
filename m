Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488BBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C63A22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yk5r26L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfH1PC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:02:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44321 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1PC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:02:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id e24so2881423ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTjWwBG2QA2lXypc42uG3Z6pGyVgR47XB6ptSoGkJFM=;
        b=yk5r26L9c/QzR9tj01N9IdBIG43zB4RiZmsmfhtTnVdHFbvyPsHXdep1s7IvILp/rS
         eaoVJSpwKLnOAqjuXlPpHCmQdIyXmIShAEjWHfa+MCC51u16xzdNAeA2AnyjRdWHxT3F
         hnR0dREKAUbsR7YubeCqQysFIyWb1il+4yISWC1RA9NTJxs5SBFM45vz8P9GYIQEnLfg
         4oWa8CUzjWJnl2yZQBIXeJcLguVTq8YAsI769/GnmuxJyiHICZCrwcg8NJyhN3VV09az
         yH8RqavfGuR7qD5lUzQGPyT52onqav2CZh/uaeRaDx0mWXk77mCESPWQ0w4Jkd+HC/UH
         mStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTjWwBG2QA2lXypc42uG3Z6pGyVgR47XB6ptSoGkJFM=;
        b=pOBdm+Ms5vUZnIUO0Qdb0jw4Mn09zrNIA++FXW6zSGqJJ4P5IjAT38PfjdqJYJVkrM
         TJI+cXJ6fFn10z6fUtO8fT+49diRPihZ+E0JO9HePvhuN88wjy0+1yQkeH7NV/qrZLGg
         NXaJPfIzsi7zUdtAf+OE8z3TazKVk0gI2jT0hTGSsR7e7OzHCtDivQK8MGrVPpxHAeW5
         aOrUqcQRnTNbl3P70bRz2xdakwxgCsCstGH/qSAIACE9VzUIgwrujMPvaVShmZ93xwHl
         RJSZlKcBcYpy7xO+VNeVx+oZNcHkKK35Ge8H9km8YetrNFdSmTbEtETWQgifk2YGBzD1
         RiFQ==
X-Gm-Message-State: APjAAAUiwaWcFctb5shTWxOcjFoOuGiRj9MnJEY/TJkM4X2Xj0bFYDzS
        Hm555TdXrVxXW60uBMZEb6GEUx4s2x5BODzTl+/GZg==
X-Google-Smtp-Source: APXvYqwEYAO7NbPymKQK0rkSbHtTeSUH3ggNYFBoMz9Oz7ETPNAyZOUBHPFUm1u3sf4IIl1YPk3ZLA2stqMe+ncO9WM=
X-Received: by 2002:a2e:864c:: with SMTP id i12mr2264752ljj.88.1567004575683;
 Wed, 28 Aug 2019 08:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190822021740.15554-1-riel@surriel.com> <20190822021740.15554-4-riel@surriel.com>
 <CAKfTPtAYBiYPQod4KTbk3dXL2zpkF3kOVG4oW6i-JCHO5sNNxQ@mail.gmail.com> <98dffa226df25fd0d3017605bc7343c330f79a7e.camel@surriel.com>
In-Reply-To: <98dffa226df25fd0d3017605bc7343c330f79a7e.camel@surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Aug 2019 17:02:44 +0200
Message-ID: <CAKfTPtBJb-f+LVLuQy4dbQrjGOiGzMe_3+wcwBiFgJttameCaQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 at 16:48, Rik van Riel <riel@surriel.com> wrote:
>
> On Wed, 2019-08-28 at 15:50 +0200, Vincent Guittot wrote:
> > Hi Rik,
> >
> > On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > > The runnable_load magic is used to quickly propagate information
> > > about
> > > runnable tasks up the hierarchy of runqueues. The runnable_load_avg
> > > is
> > > mostly used for the load balancing code, which only examines the
> > > value at
> > > the root cfs_rq.
> > >
> > > Redefine the root cfs_rq runnable_load_avg to be the sum of
> > > task_h_loads
> > > of the runnable tasks. This works because the hierarchical
> > > runnable_load of
> > > a task is already equal to the task_se_h_load today. This provides
> > > enough
> > > information to the load balancer.
> > >
> > > The runnable_load_avg of the cgroup cfs_rqs does not appear to be
> > > used for anything, so don't bother calculating those.
> > >
> > > This removes one of the things that the code currently traverses
> > > the
> > > cgroup hierarchy for, and getting rid of it brings us one step
> > > closer
> > > to a flat runqueue for the CPU controller.
> >
> > I like your proposal but just wanted to clarify one thing with this
> > patch.
> > Although you removed the computation of runnable_load_avg of the
> > cgroup cfs_rq, we are still traversing the hierarchy to update the
> > root cfs_rq runnable_load_avg because we are traversing the hierarchy
> > for computing the task_h_loads
>
> The task_h_load hierarchy traversal in update_cfs_rq_h_load
> is rate limited to once a jiffy, though.  Rate limiting the

Ah yes. I forgot that it was jiffies and not clock_task that is used
for limiting the update

> hierarchy traversal significantly reduces overhead.
>
> > That being said, if we manage to remove the need on using
> > runnable_load_avg we will completely skip this traversal. I have a
> > proposal to remove it from load balance and wake up path but i
> > haven't
> > look at numa stats which also use it
>
> --
> All Rights Reversed.
