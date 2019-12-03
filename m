Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C207C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D870C2073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfLCOSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLCOSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:18:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE35420684;
        Tue,  3 Dec 2019 14:18:44 +0000 (UTC)
Date:   Tue, 3 Dec 2019 09:18:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191203091843.678461e4@gandalf.local.home>
In-Reply-To: <20191203011721.GH93017@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-2-john.ogness@linutronix.de>
        <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
        <20191202155955.meawljmduiciw5t2@pathway.suse.cz>
        <87sgm2fzuh.fsf@linutronix.de>
        <20191203011721.GH93017@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 10:17:21 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > > BTW: If I am counting correctly. The ABA problem would happen when
> > > exactly 2^30 (1G) messages is written in the mean time.  
> > 
> > All the ringbuffer code assumes that the use of index numbers handles
> > the ABA problem (i.e. there must not be 1 billion printk's within an
> > NMI). If we want to support 1 billion+ printk's within an NMI, then
> > perhaps the index number should be increased. For 64-bit systems it
> > would be no problem to go to 62 bits. For 32-bit systems, I don't know
> > how well the 64-bit atomic operations are supported.  
> 
> ftrace dumps from NMI (DUMP_ALL type ftrace_dump_on_oops on a $BIG
> machine)? 1G seems large enough, but who knows.

ftrace dump from NMI is the most likely case to hit this, but when that
happens, you are in debugging mode, and the system usually becomes
unreliable at this moment. I agree with Petr, that we should not
complicate the code more to handle this theoretical condition.

-- Steve
