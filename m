Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD0C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D44206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IX6ZfmwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLFWN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:13:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36681 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLFWN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:13:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id s25so2883708qks.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWAFy/mhi8Rmp8q07EC5kiE1uUIRPU7vMiVGdCYXdOU=;
        b=IX6ZfmwLLMFWTPkNcUhH2lfYAiGeN5disemyiNXjVEyXD/gt87ZzdgUn8CmCrLnYCj
         fAhR+K/WNfxaLZGfmbUUifZYTE3Ch9PfqsAd4TBaEO/sCVjMN0il/rqO9f+exyAB7LYc
         fha0xsKJZkQ4qeijd7KWWjVslvyS7DlMnVpN+BpYiMFwW8qUzkLQpTsc7TXDMEtKIcms
         BdztEwYS1gfNMioRey0XM71bO7tw5D/v9cDPJBxStahN3He5BgiZpDhl9ZCamvHu/x8T
         UcMAst2iNFC91vkN4CTFOsTWxx9gFsRnZnTkyHIB7km+0B1sdV6+GOk+b7aKeAR7BY3q
         e0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWAFy/mhi8Rmp8q07EC5kiE1uUIRPU7vMiVGdCYXdOU=;
        b=aEr8XsksmlDSFFSR9LrVgkyY4hgPOBx6jTIY0KmT4eo69AbX1eQnzvKNGQDHu4bVsi
         0l9xXNDX0HQ5N0Wh6P4bI9rJm984oOCex07x84FvwUt9JJ0U8nCxVLz6eqkXiktb7H51
         tB8doZ+UjbWnvk/5fTK5ibFuxdKoaImeo731RRfHiekh5OjTgrGDx+gFqe19QqcKGsQE
         3Sb6oDmtM89JIrkddO70TwSS4dA15ao5mxluy90KYmZ3apm6vyKpqdl3RJZy9MccfX4q
         QEL3D7qtS2+hlwcGIu02Gohq1HiPMihDHra6whEzZpQvgUw98ArHIc6XwXEUWdcRIv/p
         AFlw==
X-Gm-Message-State: APjAAAWBBks99GCWPv9uqhJbCdzbboyAlDYFv2aWABP+baiMEPKZ8f/q
        cGwOarf1EMsSlLxWurH3OrqG5SCQpdYBVq0fBU8Esw==
X-Google-Smtp-Source: APXvYqzsSXY0deiIm7iWAyieMD4II6sDrkxUHRbHGI9gYSMumja6Omcn07Rz8c3uyZTYCjiGMEIbeKN6ZsVZKaUhDO8=
X-Received: by 2002:ae9:efc5:: with SMTP id d188mr16436211qkg.178.1575670406741;
 Fri, 06 Dec 2019 14:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20191204200623.198897-1-joshdon@google.com> <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
In-Reply-To: <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 6 Dec 2019 14:13:15 -0800
Message-ID: <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thanks for taking a look.

> There is a mismatch between the author Venkatesh Pallipadi and the
> signoff Josh Don
> If Venkatesh is the original author and you have then done some
> modifications, your both signed-off should be there

Venkatesh no longer works at Google, so I don't have a way to get in
touch with him.  Is my signed-off insufficient for this case?


On Thu, Dec 5, 2019 at 11:57 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Josh,
>
> On Wed, 4 Dec 2019 at 21:06, Josh Don <joshdon@google.com> wrote:
> >
> > From: Venkatesh Pallipadi <venki@google.com>
> >
> > Setting skip buddy all the way up the hierarchy does not play well
> > with intra-cgroup yield. One typical usecase of yield is when a
> > thread in a cgroup wants to yield CPU to another thread within the
> > same cgroup. For such a case, setting the skip buddy all the way up
> > the hierarchy is counter-productive, as that results in CPU being
> > yielded to a task in some other cgroup.
> >
> > So, limit the skip effect only to the task requesting it.
> >
> > Signed-off-by: Josh Don <joshdon@google.com>
>
> There is a mismatch between the author Venkatesh Pallipadi and the
> signoff Josh Don
> If Venkatesh is the original author and you have then done some
> modifications, your both signed-off should be there
>
> Apart from that, the change makes sense to me
>
> > ---
> > v2: Only clear skip buddy on the current cfs_rq
> >
> >  kernel/sched/fair.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 08a233e97a01..0b7a1958ad52 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4051,13 +4051,10 @@ static void __clear_buddies_next(struct sched_entity *se)
> >
> >  static void __clear_buddies_skip(struct sched_entity *se)
> >  {
> > -       for_each_sched_entity(se) {
> > -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > -               if (cfs_rq->skip != se)
> > -                       break;
> > +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >
> > +       if (cfs_rq->skip == se)
> >                 cfs_rq->skip = NULL;
> > -       }
> >  }
> >
> >  static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > @@ -6552,8 +6549,15 @@ static void set_next_buddy(struct sched_entity *se)
> >
> >  static void set_skip_buddy(struct sched_entity *se)
> >  {
> > -       for_each_sched_entity(se)
> > -               cfs_rq_of(se)->skip = se;
> > +       /*
> > +        * One typical usecase of yield is when a thread in a cgroup
> > +        * wants to yield CPU to another thread within the same cgroup.
> > +        * For such a case, setting the skip buddy all the way up the
> > +        * hierarchy is counter-productive, as that results in CPU being
> > +        * yielded to a task in some other cgroup. So, only set skip
> > +        * for the task requesting it.
> > +        */
> > +       cfs_rq_of(se)->skip = se;
> >  }
> >
> >  /*
> > --
> > 2.24.0.393.g34dc348eaf-goog
> >
