Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B4A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCgjYU7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCNA3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 20:29:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36611 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfCNA3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 20:29:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id g18so3962133wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bA6I4b+KNoyWDW/ol2Rzv/zK7atLFhqyLkmYsEnI5DE=;
        b=SCgjYU7iw0BdvgnDh/XKa4WtbEgtobbLXGjxDTMxfx8eeFZO41XJVgc1ZE3//MKWrs
         CrGOZKcf5uX1nRHBcBtp2/Dzdvp3Xs/Q5bn3ewEgny6YlgqX7aVZ5bKRBhAaSF9T5CJd
         YJ2HH4kjLrhNfw5mkntbf95kT+UgXmVR1wobcoTcf8F0hbTjsEUl0liPdliFG234NYe6
         hWzqCDEIHg13rd/F1NXcJSh5Mkw4wQ0q3uKHmTQfhFk95H1tpX3ohcCvD3bRaMYuA5vh
         fE0yVftU1a/lljcaOPbJMxGDr+OA9AnzTmN1jVXsUqehHeNr8y6glS4Rgw2DprJjT1bB
         /gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bA6I4b+KNoyWDW/ol2Rzv/zK7atLFhqyLkmYsEnI5DE=;
        b=uQ1wFY9gg73HaKqG8PO+IVey9mfxk5jJPjIczSD2ojXD+ZOM8FlhaCyzqgHuGx/K0z
         /M2YJKfwViMlazLltYAbfrWeAIk4c78+KHFxAZg0IY7/V7wJieuA+5YZ1lWpc4A04Xht
         VuHHP7j3eSavNYnyWzGIxbIdCSG3bno3TKEMjv2JYD39PaPPQUWG3lJxffMGCM1KofCi
         UHzJn2AEkd/wUdIHmLNPB/s3BGW2PPJ5QrSpHHQ2YL1lNHOJIqvGLxm4kGV1qOsMbH/p
         99Fi0aIrrOlEQJB9eUHgOdsgqAXqFJZYqgnKj4EmfrQ/XE8ivMDAFlkIOlqSDMwQcapn
         7lbA==
X-Gm-Message-State: APjAAAVuxQS9KvmMeel/FcM4T8JF9xDpxyK15sFODZPeBO8D4eZRqaZL
        hcxkVD1DtdFYVdsVX3EDbBC5yrRfUoNH9ZOpeceG/VZd76Q=
X-Google-Smtp-Source: APXvYqxWVWaViIQwckmG1+tZGzdfGGy4YoXIwfO7MEKWVHFkwvdQysiEo/ag+8IPFsBeykYDBEgpUaoz630zQAH2BSA=
X-Received: by 2002:a5d:40c5:: with SMTP id b5mr30091307wrq.107.1552523367691;
 Wed, 13 Mar 2019 17:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-3-patrick.bellasi@arm.com> <20190313141253.GG5922@hirez.programming.kicks-ass.net>
 <20190313161646.fp2gswuqgzi7z7ow@e110439-lin>
In-Reply-To: <20190313161646.fp2gswuqgzi7z7ow@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Mar 2019 17:29:02 -0700
Message-ID: <CAJuCfpH2QPgB3D+qsbF7gzDhrD4Y6oo3Q-b8iwtUxZe-dDWR7Q@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] sched/core: uclamp: Enforce last task UCLAMP_MAX
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 9:16 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 13-Mar 15:12, Peter Zijlstra wrote:
> > On Fri, Feb 08, 2019 at 10:05:41AM +0000, Patrick Bellasi wrote:
> > > +static inline void uclamp_idle_reset(struct rq *rq, unsigned int clamp_id,
> > > +                                unsigned int clamp_value)
> > > +{
> > > +   /* Reset max-clamp retention only on idle exit */
> > > +   if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> > > +           return;
> > > +
> > > +   WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> > > +
> > > +   /*
> > > +    * This function is called for both UCLAMP_MIN (before) and UCLAMP_MAX
> > > +    * (after). The idle flag is reset only the second time, when we know
> > > +    * that UCLAMP_MIN has been already updated.
> >
> > Why do we care? That is, what is this comment trying to tell us.
>
> Right, the code is clear enough, I'll remove this comment.

It would be probably even clearer if rq->uclamp_flags &=
~UCLAMP_FLAG_IDLE is done from inside uclamp_rq_inc after
uclamp_rq_inc_id for both clamps is called.

> >
> > > +    */
> > > +   if (clamp_id == UCLAMP_MAX)
> > > +           rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > > +}
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
