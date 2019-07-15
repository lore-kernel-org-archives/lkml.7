Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E885C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F4A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfGOHyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:54:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfGOHyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:54:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49953AD78;
        Mon, 15 Jul 2019 07:54:45 +0000 (UTC)
Date:   Mon, 15 Jul 2019 09:54:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump
 from NMI context
Message-ID: <20190715075444.fzxnf3iduqj6dkgp@pathway.suse.cz>
References: <156294329676.1745.2620297516210526183.stgit@buzz>
 <20190713060929.GB1038@tigerII.localdomain>
 <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
 <20190713131947.GA4464@tigerII.localdomain>
 <CALYGNiPp8546yGcC-TYSVq5X9tnPmrQsDecZxZ2smex9zKB5wg@mail.gmail.com>
 <20190715023338.GB3653@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715023338.GB3653@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-15 11:33:38, Sergey Senozhatsky wrote:
> On (07/13/19 17:03), Konstantin Khlebnikov wrote:
> > > We call kmsg_dump(KMSG_DUMP_PANIC) after smp_send_stop()
> > 
> > Indeed, panic is especially handled and looks fine.

Just to get a picture. What other situations are we talking about,
please?

oops_exit() is one candidate. The other callers seem to be working
in normal context.


> > Sanity check in my patch could be relaxed:
> > 
> >        if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
> >                return;
> 
> How critical kmsg_dump() is? We deadlock only if NMI->kmsg_dump()
> happens on the CPU which already holds the logbuf_lock; in any
> other case logbuf_lock is owned by another CPU which is expected
> to unlock it eventually. So it doesn't look like disabling all
> NMI->kmsg_dump() is the only way to fix it.
>
> When we lock logbuf_lock we increment per-CPU printk_context
> (PRINTK_SAFE_CONTEXT_MASK bits); when we unlock logbuf_lock
> we decrement printk_context. Thus we always can tell if the
> logbuf_lock was locked on the very same CPU - this_cpu printk_context
> has PRINTK_SAFE_CONTEXT_MASK bits sets - and we are about to deadlock
> in a nested context (NMI), or the lock was locked on another CPU and
> it's "safe" to spin on logbuf_lock and wait for logbuf_lock to become
> available.

This sounds familiar. I think that we did not consider it safe in the
end, see the commit 03fc7f9c99c1e7ae29 ("printk/nmi: Prevent deadlock
when accessing the main log buffer in NMI").

If the problem is only with Oops then the 2nd propose might be
acceptable. The system will either try to continue or it will end
up in panic() anyway.

Well, WARN() looks like an overkill, especially if there is only
one possible caller that prints the stack anyway. I would personally
do not print any message and do just:

	/*
	 * Prevent deadlock on logbuf_lock. It is safe only
	 * in panic() after smp_send_stop() and resetting
	 * the lock.
	 */
	if (in_nmi() && reason != KMSG_DUMP_PANIC)
		return;

Best Regards,
Petr
