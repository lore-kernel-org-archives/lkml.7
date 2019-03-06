Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAB02064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2NIIM9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfCFLuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:50:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56194 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfCFLuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:50:13 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so9008448itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 03:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9P/2SFRC3TrjajfsV+8z3b3N6V9YVQ6E2tP7peiRKtA=;
        b=O2NIIM9IQuyvSmLOjrzGHnz2hOP5IWosgnRmuU07f0QiW1+fuHNpzt0mFYPx3hojws
         Yf5mYpx3Y6qyxX56vWLq62ek+ZROmH1LOAucHlKToEZc22VAgJlLtJ1tMZe900AsrpE7
         sg0BDeIEHw6tnmK6rirEYZpfX1Wf2AkKnBkTXdA8R9SjsPIXUZoSO+bDMdqPWI6PAQVt
         uQ99AaJqQo7GltaLpWn06agQyOqyfYpzz/vZgT9m94TNL0LlM/z8Ll2SuBltyuvgZI7h
         I1wiKs5L9Ni1UvzYdMm5tylrsaXpc3nGReBtyOvVSTYkFyx/lgw4wz9jF7sCtk/+ifoJ
         5CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9P/2SFRC3TrjajfsV+8z3b3N6V9YVQ6E2tP7peiRKtA=;
        b=seZSP40zeeUqTvUvyhP0ssF4iUR01UYmI4nSNb9qr4wpRHowLFiHFQEAulbsPg7Dr9
         a88r+0P5isT1foU6xkkNAJBlSvlr3mARadcKO7Pyoc8M64g9pSSgTbhWLBoUrQXLDF7g
         LF/PzLkHgPPmr9tjIU3g1a/dA3gwPurHYxOAwoQNYixCX0mMI1HuLIffwVY9tjAM11uH
         62HTpctQwDx3pmj4m3IXLikty6FnaFD8WZVmEDFBC0Um5peJIqczjjKS/VzHzv6sslii
         /7rhM36cZJXX+VlkeQf7FwbpJvcCIQYqOkEkGzZLsAziNPZOVXQntek1O7OBg9Lqk9W5
         uDug==
X-Gm-Message-State: APjAAAVXOUJC8WLFzuxX23WxvHROqPai+hVzOQKvinFkoztjxf+XpwDs
        9Dib2lDyPRKKSg14uc44+AJG9DApfosR59JwLg4=
X-Google-Smtp-Source: APXvYqwiPIqg1IayGKaXBZp7yZvDLYTE7LaS3N6gwsD7xq6ZFRG5j/xEZNtqKoRx9UmWBz/9OSttllY/XEursGz8Dnw=
X-Received: by 2002:a02:13ca:: with SMTP id 193mr3988614jaz.117.1551873012358;
 Wed, 06 Mar 2019 03:50:12 -0800 (PST)
MIME-Version: 1.0
References: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
 <20190306100907.GT32477@hirez.programming.kicks-ass.net> <CALOAHbC1zqzU8-ikcLOUMKY5cbyuW_B6MK5rz7G6rTK-SoyMTQ@mail.gmail.com>
 <20190306112707.GU32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306112707.GU32477@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Mar 2019 19:49:36 +0800
Message-ID: <CALOAHbB7EZ83R3gHcGa9oZWq=7CEgBkL2cXav_7N13u4U44+uA@mail.gmail.com>
Subject: Re: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 7:27 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 06, 2019 at 06:15:39PM +0800, Yafang Shao wrote:
> > On Wed, Mar 6, 2019 at 6:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Mar 06, 2019 at 04:43:46PM +0800, Yafang Shao wrote:
> > > > When I'm using trace_sched_stat_{iowait, blocked, wait, sleep} to
> > > > measure how long the processes are stalled, there's always no output from
> > > > trace_pipe while there're really some tasks in uninterruptible sleep
> > > > state. That makes me confused, so I try to investigate why.
> > > > Finally I find the reason is that CONFIG_SCHEDSTATS is not set.
> > > >
> > > > To avoid such kind of confusion, we should not expose these tracepoints
> > > > if CONFIG_SCHEDSTATS is not set.
> > >
> > > Yeah, lets not sprinkle #ifdef. Big fat NAK.
> > >
> > > Also, the below seem to indicate your compiler is stupid. Without
> > > CONFIG_SCHEDSTAT, schedstat_enabled() should be a constant 0 and DCE
> > > should delete all code.
> > >
> >
> > My compiler is GCC-7.3.0.
> > I don't know which comipler could be smart enough to remove the
> > definition of these tracepoints.
> > Could you pls. tell me what compiler you are using ?
>
> Just look at the generated code...

When CONFIG_SCHEDSTATS  is not set,
I have objdumped the vmlinux, and the perf_trace_sched_stat_template
is still there withou my patch.

$ objdump -D vmlinux > vmlinux.asm
$ cat vmlinux.asm | grep trace_sched_stat
ffffffff810b3b40 <perf_trace_sched_stat_template>:
...

So I can't get your point really.
Forgive me if I missed something.

Thanks
Yafang
