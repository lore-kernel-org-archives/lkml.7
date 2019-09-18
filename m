Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738B1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6BD20640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfIRHmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:42:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45116 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfIRHmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:42:42 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1iAUbk-00008R-D2; Wed, 18 Sep 2019 09:42:36 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
References: <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        <87k1acz5rx.fsf@linutronix.de> <20190918012546.GA12090@jagdpanzerIV>
        <20190917220849.17a1226a@oasis.local.home>
        <20190918023654.GB15380@jagdpanzerIV>
        <20190918051933.GA220683@jagdpanzerIV>
Date:   Wed, 18 Sep 2019 09:42:34 +0200
In-Reply-To: <20190918051933.GA220683@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 18 Sep 2019 14:19:33 +0900")
Message-ID: <87h85anj85.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> For instance, tty/sysrq must be able to switch printk emergency
>> on/off.
>
> How did we come up to that _sync() printk() emergency mode (when we
> make sure that there is no active printing kthread)? We had a number
> of cases (complaints) of lost kernel messages. There are scenarios in
> which we cannot offload to async preemptible printing kthread, because
> current control path is, for instance, going to reboot the kernel. In
> sync printk() mode we have some sort (!) of guarantees that when we do
>
> 		pr_emerg("Restarting system\n");
> 		kmsg_dump(KMSG_DUMP_RESTART);
> 		machine_restart(cmd);
>
> pr_emerg("Restarting system\n") is going to flush logbuf before the
> system will machine_restart().

Yes, this was why I asked Daniel how the bsod stuff will be
implemented. We don't want a bsod just because we are
restarting. Perhaps write_atomic() should also have a "reason" argument
like kmsg_dump does. I will keep in touch with Daniel to make sure we
are sync on this.

> It's going to be a bit harder when we have per-console kthread.

Each console has its own iterator. This iterators will need to advance,
regardless if the message was printed via write() or write_atomic().

John Ogness
