Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EFEC4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9635621881
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 02:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfIRCIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfIRCIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 22:08:52 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974BF214AF;
        Wed, 18 Sep 2019 02:08:50 +0000 (UTC)
Date:   Tue, 17 Sep 2019 22:08:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
Message-ID: <20190917220849.17a1226a@oasis.local.home>
In-Reply-To: <20190918012546.GA12090@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        <87k1acz5rx.fsf@linutronix.de>
        <20190918012546.GA12090@jagdpanzerIV>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 10:25:46 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (09/13/19 15:26), John Ogness wrote:
> > 2. A kernel thread will be created for each registered console, each
> > responsible for being the sole printers to their respective
> > consoles. With this, console printing is _fully_ decoupled from printk()
> > callers.  
> 
> sysrq over serial?
> 
> What we currently have is hacky, but, as usual, is a "best effort":
> 
> 	>> serial driver IRQ  
> 
> 	serial_handle_irq()		[console driver]
> 	 uart_handle_sysrq_char()
> 	  handle_sysrq()
> 	   printk()
> 	    call_console_drivers()
> 	     serial_write()		[re-enter console driver]
> 
> offloading this to kthread may be unreliable.

But we also talked about an "emergency flush" which will not wait for
the kthreads to finish and just output everything it can find in the
printk buffers (expecting that the consoles have an "emergency"
handler. We can add a sysrq to do an emergency flush.

-- Steve

