Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4430C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0B2206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404542AbfIQHwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:52:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbfIQHwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:52:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B8BAB048;
        Tue, 17 Sep 2019 07:52:18 +0000 (UTC)
Date:   Tue, 17 Sep 2019 09:52:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        AndreaParri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LinusTorvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        PraritBhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk meeting at LPC
Message-ID: <20190917075216.agzoy6cnol5eio6y@pathway.suse.cz>
References: <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <cfc7b1fa-e629-19a6-154b-0dd4f5604aa7@I-love.SAKURA.ne.jp>
 <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
 <20190916094314.6053f988@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916094314.6053f988@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-16 09:43:14, Steven Rostedt wrote:
> On Mon, 16 Sep 2019 12:46:24 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> > > By the way, do we need to keep printk() return bytes like printf() ?
> > > Maybe we can make printk() return "void", for almost nobody can do
> > > meaningful things with the return value.  
> > 
> > It is true that I have never seen anyone checking the return value.
> > On the other hand, it is a minor detail. And I would prefer to stay
> > compatible with the userland printf() as much as possible.
> 
> I understand your wanting to keep compatibility with printf(), but I
> would suggest that we only do so if it doesn't complicate any of the
> design. I'm actually leaning on recommending that we remove the return
> value, to prevent there becoming a dependency on it. I don't see any
> reason to have the "number of bytes processed" as the return value
> being useful within the kernel.

Heh, I did some grepping and the return value is actually used on
three locations:

$> git grep "= printk("
drivers/scsi/aic7xxx/aic79xx_core.c:	printed = printk("%s[0x%x]", name, value);
drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(" ");
drivers/scsi/aic7xxx/aic79xx_core.c:			printed += printk("%s%s",
drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(") ");
drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(" ");
drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col = printk("\n%3d FIFO_USE[0x%x] ", SCB_GET_TAG(scb),
drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col += printk("SHADDR = 0x%x%x, SHCNT = 0x%x ",
drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col += printk("HADDR = 0x%x%x, HCNT = 0x%x ",
drivers/scsi/aic7xxx/aic7xxx_core.c:	printed  = printk("%s[0x%x]", name, value);
drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(" ");
drivers/scsi/aic7xxx/aic7xxx_core.c:			printed += printk("%s%s",
drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(") ");
drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(" ");
drivers/scsi/aic7xxx/aic7xxx_core.c:		cur_col  = printk("\n%3d ", i);
drivers/scsi/aic7xxx/aic7xxx_core.c:		cur_col  = printk("\n%3d ", scb->hscb->tag);
drivers/scsi/libsas/sas_ata.c:	r = printk("%s" SAS_FMT "ata%u: %s: %pV",
kernel/locking/lockdep.c:			len += printk("%*s   %s", depth, "", usage_str[bit]);
kernel/locking/lockdep.c:			len += printk(KERN_CONT " at:\n");

It is probably not a big deal. For example, lockdep uses the value
just for formatting (extra spaces) when printing backtrace.

I agree that it does not make sense to return the value if it
complicates the code too much. Well, we will need to count
the string length also from another reason (reservation).

Best Regards,
Petr
