Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF270C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8936D206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGzoYy+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfLLWTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:19:40 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45905 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbfLLWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:19:40 -0500
Received: by mail-qv1-f66.google.com with SMTP id c2so41071qvp.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqtUQa/7zK+Ip9tOn0jDtk5XmThJo8EhWPjq+zQojr8=;
        b=QGzoYy+EGt7vzIzIKh7bl4ChMUPBF90xUvCPRGPFWHoh4ip2ABntAekCFeSwkNlzpx
         4jhor/SnKt8Q0HMxEEyiTY9eQdGA9Y2QsfYEMBo2vfUbYXQMvgg9h1f9AVpPW6bhAWKe
         gULQ9sStRV6lncbIJe55H6dnBqAiUIOGYK/UTBjubxEkwUmNQ9Kash70Gx+Q0KmlZcOQ
         ucTG1RzKQgzsipVwuSl/0YYb5HmyIZ7VVMrWL8/+iRMwET2hjHog45aNBt9zRZOXF1uZ
         wAD3GqUsZNBEQ+88j1q+XzwJCghEzR8abe04wrXFaHQIi0UV/Hm1czJ8NpZm2QxW+ELR
         Zemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqtUQa/7zK+Ip9tOn0jDtk5XmThJo8EhWPjq+zQojr8=;
        b=QY2QzHjkEy97EIc+/j8RK7434X77ALTJ+CYXgOUU9ko/Hpm+EwbNErZmJwL+6dJVf1
         2sSWP70+3t2n/OYsmNR2aP+CK0iscfmmt9SoyvDAZAJLROh5rIOd7ybyawScaXO8hwzZ
         1zZ7I7/yntw0SvP249p9PpCRJOKodptpEyMBKIsBA9LS0rdmncmZshA+BbsbWHZ9TQgJ
         M34o3s09R/W83EAFDI94eQt0Fwg2q4mWPAvN6WHy0pao/7OJYaRDNtFWse5X3WOT56aR
         +79Zn+DMXc5U2Hu5aqWEnn86Ck2AMJ7nUee5b4auFPPArVNIanOlzabSj/DPTpOF173x
         jZnQ==
X-Gm-Message-State: APjAAAX4KuUhTVM3n2hh+LCVJ9cj/lPma3TyL17IbZSnim0FrrceSLf2
        5tsiBUDduaDj8gVog7qM32Jor8D1YmDZM8Nq+VW6Sw==
X-Google-Smtp-Source: APXvYqzEV428R/DLTcddJ/jGN8hXRnyb86u/LdameAN+mMUU6/9cjl357okvLixPad36LqBJsa/lZXxZnH+1he1gSmM=
X-Received: by 2002:a0c:9476:: with SMTP id i51mr10429690qvi.75.1576189178536;
 Thu, 12 Dec 2019 14:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20191204200623.198897-1-joshdon@google.com> <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com> <edc9f4aa-a6ab-3bab-0a9e-73a155b8a48a@arm.com>
In-Reply-To: <edc9f4aa-a6ab-3bab-0a9e-73a155b8a48a@arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 12 Dec 2019 14:19:27 -0800
Message-ID: <CABk29Ns3v3KqAo89oEOqQjRQxWN4Wgc+YtweWbS13MtmsUJeyw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 1:19 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 06.12.19 23:13, Josh Don wrote:
>
> [...]
>
> > On Thu, Dec 5, 2019 at 11:57 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> Hi Josh,
> >>
> >> On Wed, 4 Dec 2019 at 21:06, Josh Don <joshdon@google.com> wrote:
> >>>
> >>> From: Venkatesh Pallipadi <venki@google.com>
> >>>
> >>> Setting skip buddy all the way up the hierarchy does not play well
> >>> with intra-cgroup yield. One typical usecase of yield is when a
> >>> thread in a cgroup wants to yield CPU to another thread within the
> >>> same cgroup. For such a case, setting the skip buddy all the way up
>
> But with yield_task{_fair}() you have no way to control which other task
> gets accelerated. The other task in the taskgroup (cgroup) could be even
> on another CPU.
>
> It's not like yield_to_task_fair() which uses next buddy to accelerate
> another task p.
>
> What's this typical usecase?

The semantics for yield_task under CFS are not well-defined.  With our
CFS hierarchy, we cannot easily just push a yielded task to the end of
a runqueue.  And, we don't want to play games with artificially
increasing vruntime, as this results in potentially high latency for a
yielded task to get back on CPU.

I'd interpret a task that calls yield as saying "I can run, but try to
run something else."  I'd agree that this patch is imperfect in
achieving this, but I think it is better than the current
implementation (or at least, less broken).  Currently, a side-effect
of calling yield is that all other tasks in the same hierarchy get
skipped as well.  This is almost certainly not what the user
expects/wants.  It is true that if a yielded task has no other tasks
in its cgroup on the same CPU, we will potentially end up just picking
the yielded task again.  But this should be OK; a yielded task should
be able to continue making forward progress.  Any yielded task that
calls yield again is likely implementing a busy loop, which is an
improper use of yield anyway.

I also played around with the idea of setting the skip buddy up the
hierarchy up to the point where cfs_rq->nr_running > 1, but this is
racy with enqueue, and in general raises questions about whether an
enqueued task should try to clear skip buddies.
