Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A793CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7751F20867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409736AbfJYRGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:06:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51516 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfJYRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:05:32 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iO31i-0000jf-BS; Fri, 25 Oct 2019 17:05:26 +0000
Date:   Fri, 25 Oct 2019 19:05:25 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     dvyukov@google.com, ebiederm@xmission.com, elver@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191025170523.u43rkulrui22ynix@wittgenstein>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
 <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
 <20191025141325.GB6020@redhat.com>
 <20191025143224.wtwkkimqq4644iqq@wittgenstein>
 <20191025155224.GC6020@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025155224.GC6020@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Removing a few people from Cc to avoid spamming the whole world]

On Fri, Oct 25, 2019 at 05:52:25PM +0200, Oleg Nesterov wrote:
> On 10/25, Christian Brauner wrote:
> >
> > On Fri, Oct 25, 2019 at 04:13:25PM +0200, Oleg Nesterov wrote:
> > > Almost every usage of task->flags (load or sore) can be reported as "data race".
> > > 
> > > Say, you do
> > > 
> > > 	if (task->flags & PF_KTHREAD)
> > > 
> > > while this task does
> > > 
> > > 	current->flags |= PF_FREEZER_SKIP;
> > > 	schedule().
> > > 
> > > this is data race.
> > 
> > Right, but I thought we agreed on WONTFIX in those scenarios?
> > The alternative is to READ_ONCE()/WRITE_ONCE() all of these.
> 
> Well, in my opinion this is WONTFIX, but I won't argue if someone
> adds _ONCE to all of these. Same for task->state, exit_state, and
> more.

Well, I honestly think that state and exit_state would make sense.
There already were issues that got fixed for example in 3245d6acab98
("exit: fix race between wait_consider_task() and wait_task_zombie()")
and as far as I understand this would also help kcsan to better detect
races.

Christian
