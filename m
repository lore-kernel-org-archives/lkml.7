Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72741C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D992178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfKFIPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:15:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729951AbfKFIPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:15:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE6FDB011;
        Wed,  6 Nov 2019 08:15:44 +0000 (UTC)
Date:   Wed, 6 Nov 2019 09:15:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH 43/50] xtensa: Add show_stack_loglvl()
Message-ID: <20191106081541.soxefwyvu3o72tqg@pathway.suse.cz>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-44-dima@arista.com>
 <CAMo8Bf+q0j81VZeUQdvCkXt131uzSBfJ0N7RTe7+NpjRkVpzdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8Bf+q0j81VZeUQdvCkXt131uzSBfJ0N7RTe7+NpjRkVpzdA@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-11-05 20:13:22, Max Filippov wrote:
> Hi Dmitry,
> 
> On Tue, Nov 5, 2019 at 7:08 PM Dmitry Safonov <dima@arista.com> wrote:
> >
> > Currently, the log-level of show_stack() depends on a platform
> > realization. It creates situations where the headers are printed with
> > lower log level or higher than the stacktrace (depending on
> > a platform or user).
> >
> > Furthermore, it forces the logic decision from user to an architecture
> > side. In result, some users as sysrq/kdb/etc are doing tricks with
> > temporary rising console_loglevel while printing their messages.
> > And in result it not only may print unwanted messages from other CPUs,
> > but also omit printing at all in the unlucky case where the printk()
> > was deferred.
> >
> > Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> > an easier approach than introducing more printk buffers.
> > Also, it will consolidate printings with headers.
> >
> > Introduce show_stack_loglvl(), that eventually will substitute
> > show_stack().
> >
> > Cc: Chris Zankel <chris@zankel.net>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: linux-xtensa@linux-xtensa.org
> > [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >  arch/xtensa/kernel/traps.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> > index cbc0d673f542..ba6c150095c6 100644
> > --- a/arch/xtensa/kernel/traps.c
> > +++ b/arch/xtensa/kernel/traps.c
> > @@ -502,7 +502,8 @@ static void show_trace(struct task_struct *task, unsigned long *sp,
> >
> >  static int kstack_depth_to_print = 24;
> >
> > -void show_stack(struct task_struct *task, unsigned long *sp)
> > +void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
> > +                      const char *loglvl)
> >  {
> >         int i = 0;
> >         unsigned long *stack;
> > @@ -511,16 +512,21 @@ void show_stack(struct task_struct *task, unsigned long *sp)
> >                 sp = stack_pointer(task);
> >         stack = sp;
> >
> > -       pr_info("Stack:\n");
> > +       printk("%sStack:\n", loglvl);
> >
> >         for (i = 0; i < kstack_depth_to_print; i++) {
> >                 if (kstack_end(sp))
> >                         break;
> > -               pr_cont(" %08lx", *sp++);
> > +               printk("%s %08lx", loglvl, *sp++);

KERN_CONT can be combined with any other loglevel.
So you could keep using pr_cont() together with explicit loglevel:

			pr_cont("%s %08lx", loglvl, *sp++);

It should fix the problems reported below.

Well, the preferred solution would be to snprintf() the continuous
line into a temporary buffer. And printk() it when it is complete.
pr_cont() is not reliable when more CPUs print at the same time.

Best Regards,
Petr

> This change doesn't work well with printk timestamps, it changes
> the following output on xtensa architecture
> 
> [    3.404675] Stack:
> [    3.404861]  a05773e2 00000018 bb03dc34 bb03dc30 a0008640 bb03dc70
> ba9ba410 37c3f000
> [    3.405414]  37c3f000 d7c3f000 00000800 bb03dc50 a02b97ed bb03dc90
> ba9ba400 ba9ba410
> [    3.405969]  a05fc1bc bbff28dc 00000000 bb03dc70 a02b7fb9 bb03dce0
> ba9ba410 a0579044
> 
> into this:
> [    3.056825] Stack:
> [    3.056963]  a04ebb20
> [    3.056995]  bb03dc10
> [    3.057138]  00000001
> [    3.057277]  bb03dc10
> [    3.057815]  a00083ca
> [    3.057965]  bb03dc50
> [    3.058107]  ba9ba410
> [    3.058247]  37c3f000
> [    3.058387]
> [    3.058584]  a05773e2
> [    3.058614]  00000001
> [    3.058755]  a05ca0bc
> [    3.058896]  bb03dc30
> [    3.059035]  a000865c
> [    3.059180]  bb03dc70
> [    3.059319]  ba9ba410
> [    3.059459]  37c3f000
> [    3.059598]
> [    3.059795]  37c3f000
> [    3.059824]  d7c3f000
> [    3.059964]  00000800
> [    3.060103]  bb03dc50
> [    3.060241]  a02b9809
> [    3.060379]  bb03dc90
> [    3.060519]  ba9ba400
> [    3.060658]  ba9ba410
> [    3.060796]
> 
> -- 
> Thanks.
> -- Max
