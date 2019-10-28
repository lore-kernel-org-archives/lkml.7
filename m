Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A88ACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC2F21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390697AbfJ1RsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:48:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41553 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730715AbfJ1RsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:48:07 -0400
Received: from [91.217.168.176] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iP8qe-0005p2-OR; Mon, 28 Oct 2019 17:30:32 +0000
Date:   Mon, 28 Oct 2019 18:30:32 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     dvyukov@google.com, ebiederm@xmission.com, elver@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191028173031.m32p5e3ek764hnre@wittgenstein>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
 <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
 <20191025141325.GB6020@redhat.com>
 <20191025143224.wtwkkimqq4644iqq@wittgenstein>
 <20191025155224.GC6020@redhat.com>
 <20191025170523.u43rkulrui22ynix@wittgenstein>
 <20191028164852.GA17900@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028164852.GA17900@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:48:52PM +0100, Oleg Nesterov wrote:
> On 10/25, Christian Brauner wrote:
> >
> > On Fri, Oct 25, 2019 at 05:52:25PM +0200, Oleg Nesterov wrote:
> > > On 10/25, Christian Brauner wrote:
> > > >
> > > > On Fri, Oct 25, 2019 at 04:13:25PM +0200, Oleg Nesterov wrote:
> > > > > Almost every usage of task->flags (load or sore) can be reported as "data race".
> > > > >
> > > > > Say, you do
> > > > >
> > > > > 	if (task->flags & PF_KTHREAD)
> > > > >
> > > > > while this task does
> > > > >
> > > > > 	current->flags |= PF_FREEZER_SKIP;
> > > > > 	schedule().
> > > > >
> > > > > this is data race.
> > > >
> > > > Right, but I thought we agreed on WONTFIX in those scenarios?
> > > > The alternative is to READ_ONCE()/WRITE_ONCE() all of these.
> > >
> > > Well, in my opinion this is WONTFIX, but I won't argue if someone
> > > adds _ONCE to all of these. Same for task->state, exit_state, and
> > > more.
> >
> > Well, I honestly think that state and exit_state would make sense.
> 
> Heh. Again, I am not arguing, but...
> 
> OK, lets suppose we blindly add READ_ONCE() to every access of
> task->state/exit_state.
> 
> Yes, this won't hurt and possibly can fix some bugs we are not aware of.

I wasn't planning or working on adding *_ONCE everywhere. ;)
I just think it makes sense as a preemptive strike since they are shared
(though mostly protected by locks anyway).

> 
> However,
> 
> > There already were issues that got fixed for example in 3245d6acab98
> > ("exit: fix race between wait_consider_task() and wait_task_zombie()")
> 
> The change above can't fix the problem like this.

No argument about the code we discussed right here, for sure!

> 
> It is not that this code lacked READ_ONCE(). I am sure me and others
> understood that this code can read ->exit_state more than once, just
> nobody noticed that in this case this is really wrong.
> 
> IOW, if we simply change the code before 3245d6acab98 to use READ_ONCE()
> the code will be equally wrong, and
> 
> > and as far as I understand this would also help kcsan to better detect
> > races.
> 
> this change will simply hide the problem from kcsan.

I can't speak to that since the claim that read_once() helps them even
if it's not really doing anything. But maybe I misunderstood the
k{c,t}san manpage.

Christian
