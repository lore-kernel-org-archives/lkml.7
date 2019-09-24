Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721FDC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5118C2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441245AbfIXOCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:02:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2441223AbfIXOCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:02:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42592ABF4;
        Tue, 24 Sep 2019 14:02:43 +0000 (UTC)
Date:   Tue, 24 Sep 2019 16:02:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, paulmck@kernel.org,
        Christian Brauner <christian@brauner.io>,
        prsood@codeaurora.org, avagin@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, dbueso@suse.de,
        syzbot <syzbot+18379f2a19bc62c12565@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: INFO: rcu detected stall in sys_exit_group
Message-ID: <20190924140241.be77u2jne3melzte@pathway.suse.cz>
References: <000000000000674b3d0592d2015b@google.com>
 <CACT4Y+YX3yNz7Fc8wUKsVR-rzusqmTnzP6ysZx+=3CzhVHk36w@mail.gmail.com>
 <20190919170750.GO30224@paulmck-ThinkPad-P72>
 <CACT4Y+bHcy1ZOstVvSGezs+3Q=jccdWTeikm6mnZiXYCBi+Nyw@mail.gmail.com>
 <20190919201200.GP30224@paulmck-ThinkPad-P72>
 <CACT4Y+YdodVKL2h-Z4Svjyd6kug2ORmfiP4jripSC9PpYw4RiA@mail.gmail.com>
 <46269171-ff57-8afd-f36b-40e6519b6557@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46269171-ff57-8afd-f36b-40e6519b6557@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-09-20 19:22:10, Tetsuo Handa wrote:
> Calling printk() people.
> 
> On 2019/09/20 16:50, Dmitry Vyukov wrote:
> >>>                                   How it runs on top of an interrupt?
> >>
> >> It is not running on top of an interrupt.  Its stack was dumped
> >> separately.
> > 
> > I see. Usually the first stack is the traceback of the current stack.
> > So I was confused.
> > 
> >>> And why one cpu tracebacks another one?
> >>
> >> The usual reason is because neither CPU's quiescent state was reported
> >> to the RCU core, so the stall-warning code dumped both stacks.
> > 
> > But should the other CPU traceback _itself_? Rather than being traced
> > back by another CPU?
> > E.g. see this report:
> > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L61-L83
> > Here the overall problem was detected by C2, but then C1 traces back itself.
> > 
> > ... however even in that case C0 and C3 are traced by C2:
> > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L84-L149
> > I can't understand this...
> > This makes understanding what happened harder because it's not easy to
> > exclude things on other CPUs.
> 
> I think this should be
> https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/350#L84-L172
> than #L84-L149 .
> 
> Is the reason these lines have "[    C2]" is that these lines were flushed (printk_caller_id()
> was called) from log_output() from vprintk_store() from vprintk_emit() from vprintk_deferred()
>  from printk_deferred() from printk_safe_flush_line() from __printk_safe_flush() from
> printk_safe_flush() from printk_safe_flush_on_panic() from panic() ?

It seems to be the case. CPU2 is clearly flushing per-CPU buffers
from NMI context, for example:

[ 1098.703114][    C2] NMI backtrace for cpu 0
[...]
[ 1098.703295][    C2] NMI backtrace for cpu 3

A solution would be to store all these metadata (timestamp, caller
info) already into the per-CPU buffers. I think that it would be
doable.

But much better solution is a lockless ring buffer. John Ogness is
working hard on it. The plan is to have it ready for 5.5 or 5.6.
I would prefer to concentrate on this solution for the moment.

Best Regards,
Petr
