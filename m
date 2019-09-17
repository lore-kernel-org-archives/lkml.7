Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6ACC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562B721852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfIQNC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIQNC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:02:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65B7C2171F;
        Tue, 17 Sep 2019 13:02:55 +0000 (UTC)
Date:   Tue, 17 Sep 2019 09:02:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <20190917090254.46131564@gandalf.local.home>
In-Reply-To: <20190917075216.agzoy6cnol5eio6y@pathway.suse.cz>
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
        <20190917075216.agzoy6cnol5eio6y@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 09:52:16 +0200
Petr Mladek <pmladek@suse.com> wrote:

> Heh, I did some grepping and the return value is actually used on
> three locations:
> 
> $> git grep "= printk("  
> drivers/scsi/aic7xxx/aic79xx_core.c:	printed = printk("%s[0x%x]", name, value);
> drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(" ");
> drivers/scsi/aic7xxx/aic79xx_core.c:			printed += printk("%s%s",
> drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(") ");
> drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(" ");
> drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col = printk("\n%3d FIFO_USE[0x%x] ", SCB_GET_TAG(scb),
> drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col += printk("SHADDR = 0x%x%x, SHCNT = 0x%x ",
> drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col += printk("HADDR = 0x%x%x, HCNT = 0x%x ",
> drivers/scsi/aic7xxx/aic7xxx_core.c:	printed  = printk("%s[0x%x]", name, value);
> drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(" ");
> drivers/scsi/aic7xxx/aic7xxx_core.c:			printed += printk("%s%s",
> drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(") ");
> drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(" ");
> drivers/scsi/aic7xxx/aic7xxx_core.c:		cur_col  = printk("\n%3d ", i);
> drivers/scsi/aic7xxx/aic7xxx_core.c:		cur_col  = printk("\n%3d ", scb->hscb->tag);
> drivers/scsi/libsas/sas_ata.c:	r = printk("%s" SAS_FMT "ata%u: %s: %pV",
> kernel/locking/lockdep.c:			len += printk("%*s   %s", depth, "", usage_str[bit]);
> kernel/locking/lockdep.c:			len += printk(KERN_CONT " at:\n");
> 
> It is probably not a big deal. For example, lockdep uses the value
> just for formatting (extra spaces) when printing backtrace.
> 
> I agree that it does not make sense to return the value if it
> complicates the code too much. Well, we will need to count
> the string length also from another reason (reservation).

Well, it's being used. I was thinking of dropping it if it was not.
Let's keep it then.

Thanks for looking into this.

-- Steve
