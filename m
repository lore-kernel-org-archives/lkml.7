Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55FCC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E02206E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKMTkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfKMTkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:40:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E7E206DC;
        Wed, 13 Nov 2019 19:40:12 +0000 (UTC)
Date:   Wed, 13 Nov 2019 14:40:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yuming Han <yuming.han@unisoc.com>
Subject: Re: [PATCH] tracing: use kvcalloc for tgid_map array allocation
Message-ID: <20191113144010.0368a715@gandalf.local.home>
In-Reply-To: <CAAfSe-tQ2VB-OQ5-z6b6=KqiC4iaNCfAFouZ1Lo=-4O9pGbKkA@mail.gmail.com>
References: <1571884773-23990-1-git-send-email-chunyan.zhang@unisoc.com>
        <1571888070-24425-1-git-send-email-chunyan.zhang@unisoc.com>
        <CAAfSe-tQ2VB-OQ5-z6b6=KqiC4iaNCfAFouZ1Lo=-4O9pGbKkA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 11:21:11 +0800
Chunyan Zhang <zhang.lyra@gmail.com> wrote:

> gentle ping

Sorry, was traveling during this time, and my INBOX exploded :-p

> 
> On Thu, 24 Oct 2019 at 11:34, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
> >
> >
> > From: Yuming Han <yuming.han@unisoc.com>
> >
> > Fail to allocate memory for tgid_map, because it requires order-6 page.
> > detail as:
> >
> > c3 sh: page allocation failure: order:6,
> >    mode:0x140c0c0(GFP_KERNEL), nodemask=(null)
> > c3 sh cpuset=/ mems_allowed=0
> > c3 CPU: 3 PID: 5632 Comm: sh Tainted: G        W  O    4.14.133+ #10
> > c3 Hardware name: Generic DT based system
> > c3 Backtrace:
> > c3 [<c010bdbc>] (dump_backtrace) from [<c010c08c>](show_stack+0x18/0x1c)
> > c3 [<c010c074>] (show_stack) from [<c0993c54>](dump_stack+0x84/0xa4)
> > c3 [<c0993bd0>] (dump_stack) from [<c0229858>](warn_alloc+0xc4/0x19c)
> > c3 [<c0229798>] (warn_alloc) from [<c022a6e4>](__alloc_pages_nodemask+0xd18/0xf28)
> > c3 [<c02299cc>] (__alloc_pages_nodemask) from [<c0248344>](kmalloc_order+0x20/0x38)
> > c3 [<c0248324>] (kmalloc_order) from [<c0248380>](kmalloc_order_trace+0x24/0x108)
> > c3 [<c024835c>] (kmalloc_order_trace) from [<c01e6078>](set_tracer_flag+0xb0/0x158)
> > c3 [<c01e5fc8>] (set_tracer_flag) from [<c01e6404>](trace_options_core_write+0x7c/0xcc)
> > c3 [<c01e6388>] (trace_options_core_write) from [<c0278b1c>](__vfs_write+0x40/0x14c)
> > c3 [<c0278adc>] (__vfs_write) from [<c0278e10>](vfs_write+0xc4/0x198)
> > c3 [<c0278d4c>] (vfs_write) from [<c027906c>](SyS_write+0x6c/0xd0)
> > c3 [<c0279000>] (SyS_write) from [<c01079a0>](ret_fast_syscall+0x0/0x54)
> >
> > Switch to use kvcalloc to avoid unexpected allocation failures.
> >
> > Signed-off-by: Yuming Han <yuming.han@unisoc.com>

OK, I'll apply this.

-- Steve

> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  kernel/trace/trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 6a0ee9178365..2fa72419bbd7 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4609,7 +4609,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
> >
> >         if (mask == TRACE_ITER_RECORD_TGID) {
> >                 if (!tgid_map)
> > -                       tgid_map = kcalloc(PID_MAX_DEFAULT + 1,
> > +                       tgid_map = kvcalloc(PID_MAX_DEFAULT + 1,
> >                                            sizeof(*tgid_map),
> >                                            GFP_KERNEL);
> >                 if (!tgid_map) {
> > --
> > 2.20.1
> >
> >  

