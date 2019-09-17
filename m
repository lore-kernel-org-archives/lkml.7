Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28DCC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C3A2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568725928;
	bh=r2S4lynJJ6O9qN2X1R+bVDf3htiFuzgHM7G+DZQKv/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fFrgqSEoJLDWm7KJamPlRdKJ68os84gk+UUu3VH/wWwtP6EnyUPLh0VgvCv3bL3Ee
	 0l6vOj3tTh6pk6UyqToimTaS65g5NIoEuH0/k0TVMY6w5J5dnIisLrYfpwdT2d16NV
	 VGaZ1iES8UUCnHIr8D6ZMCUX2DKrN9iuNSjRIevQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfIQNMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfIQNMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:12:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48C9214AF;
        Tue, 17 Sep 2019 13:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568725926;
        bh=r2S4lynJJ6O9qN2X1R+bVDf3htiFuzgHM7G+DZQKv/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4UliqZKz9k7SLXGwzNEniFLuQ3+KXOTy+qv8CrijzV76bU/dsAQuGB+JBEBZdEat
         V4Gl1yDuf+gkoCpLGRAa6dDIlNSJ4sRbaX7sunAMRj8FFLSyq3h0BjtRzT2ICxRpSv
         NvqlYtfwYtFIs1z0R6y7P5layOyBRNGianGurRxU=
Date:   Tue, 17 Sep 2019 15:12:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        AndreaParri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LinusTorvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        PraritBhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk meeting at LPC
Message-ID: <20190917131204.GA745680@kroah.com>
References: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <cfc7b1fa-e629-19a6-154b-0dd4f5604aa7@I-love.SAKURA.ne.jp>
 <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
 <20190916094314.6053f988@gandalf.local.home>
 <20190917075216.agzoy6cnol5eio6y@pathway.suse.cz>
 <20190917090254.46131564@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917090254.46131564@gandalf.local.home>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:02:54AM -0400, Steven Rostedt wrote:
> On Tue, 17 Sep 2019 09:52:16 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > Heh, I did some grepping and the return value is actually used on
> > three locations:
> > 
> > $> git grep "= printk("  
> > drivers/scsi/aic7xxx/aic79xx_core.c:	printed = printk("%s[0x%x]", name, value);
> > drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(" ");
> > drivers/scsi/aic7xxx/aic79xx_core.c:			printed += printk("%s%s",
> > drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(") ");
> > drivers/scsi/aic7xxx/aic79xx_core.c:		printed += printk(" ");
> > drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col = printk("\n%3d FIFO_USE[0x%x] ", SCB_GET_TAG(scb),
> > drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col += printk("SHADDR = 0x%x%x, SHCNT = 0x%x ",
> > drivers/scsi/aic7xxx/aic79xx_core.c:		cur_col += printk("HADDR = 0x%x%x, HCNT = 0x%x ",
> > drivers/scsi/aic7xxx/aic7xxx_core.c:	printed  = printk("%s[0x%x]", name, value);
> > drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(" ");
> > drivers/scsi/aic7xxx/aic7xxx_core.c:			printed += printk("%s%s",
> > drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(") ");
> > drivers/scsi/aic7xxx/aic7xxx_core.c:		printed += printk(" ");
> > drivers/scsi/aic7xxx/aic7xxx_core.c:		cur_col  = printk("\n%3d ", i);
> > drivers/scsi/aic7xxx/aic7xxx_core.c:		cur_col  = printk("\n%3d ", scb->hscb->tag);

All of those can be removed as none of the returned values are used.
What a mess.

> > drivers/scsi/libsas/sas_ata.c:	r = printk("%s" SAS_FMT "ata%u: %s: %pV",

return value is also ignored, this can be fixed.

> > kernel/locking/lockdep.c:			len += printk("%*s   %s", depth, "", usage_str[bit]);
> > kernel/locking/lockdep.c:			len += printk(KERN_CONT " at:\n");

That seems to be the only semi-legitimate use, but if it _really_ needs
it, it can just create the string ahead of time, and use the length then
after it printks it out.

> > It is probably not a big deal. For example, lockdep uses the value
> > just for formatting (extra spaces) when printing backtrace.
> > 
> > I agree that it does not make sense to return the value if it
> > complicates the code too much. Well, we will need to count
> > the string length also from another reason (reservation).
> 
> Well, it's being used. I was thinking of dropping it if it was not.
> Let's keep it then.

I think it should be dropped, only one user of the kernel is using it in
a legitimate way, which kind of implies it isn't needed.

thanks,

greg k-h
