Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70C7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C620020640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbfIMN1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:27:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391567AbfIMN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:37 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i8lam-0000Ir-Cw; Fri, 13 Sep 2019 15:26:28 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
Date:   Fri, 13 Sep 2019 15:26:26 +0200
In-Reply-To: <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Mon, 9 Sep 2019 15:11:52 +0100 (WEST)")
Message-ID: <87k1acz5rx.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-09, Thomas Gleixner <tglx@linutronix.de> wrote:
> printk meeting at LPC Meeting Room - SAFIRA on Tuesday Sept 10. from
> 2PM to 3PM.

The meeting was very effective in letting us come to decisions on the
direction to take. Thanks for the outstanding attendance! It certainly
saved hundreds of hours of reading/writing emails!

The slides[0] from my printk talk served as a _rough_ basis for the
discussion. Here is a summary of the decisions:

1. As a new ringbuffer, the lockless state-based proof of concept
posted[1] by Petr Mladek will be used. Since it has far fewer memory
barriers in the code, it will be simpler to review. I posted[2] a patch
to hack my RFCv4 into a fully functional version of Petr's PoC. So we
know it will work. With this, printk() can be called from any context
and the message will be put directly into the ringbuffer.

2. A kernel thread will be created for each registered console, each
responsible for being the sole printers to their respective
consoles. With this, console printing is _fully_ decoupled from printk()
callers.

3. Rather than defining emergency _messages_, we define an emergency
_state_ where the kernel wants to flush the messages immediately before
dying. Unlike oops_in_progress, this state will not be visible to
anything outside of the printk infrastructure.

4. When in emergency state, the kernel will use a new console callback
write_atomic() to flush the messages in whatever context the CPU is in
at that moment. Only consoles that implement the NMI-safe write_atomic()
will be able to flush in this state.

5. LOG_CONT message pieces will be stored as individual records in the
ringbuffer. They will be "assembled" by the ringbuffer reader (in
kernel) before being copied to userspace or printed on the
console. Since each record in the ringbuffer has its own sequence
number, this has the effect for userspace that sequence numbers will
appear to be skipped. (i.e. if there were LOG_CONT pieces with sequence
numbers 4, 5, 6, the fully assembled message will appear only as
sequence number 6 (and will have the timestamp from the first piece)).

6. A new may-sleep function pr_flush() will be made available to wait
for all previously printk'd messages to be output on all consoles before
proceeding. For example:

    pr_cont("Running test ABC... ");
    pr_flush();

    do_test();

    pr_cont("PASSED\n");
    pr_flush();

7. The ringbuffer raw data (log_buf) will be simplified to only consist
of alignment-padded strings separated by a single unsigned long. All
record meta-data (timestamp, loglevel, caller_id, etc.) will move into
the record descriptors, which are located in an extra array. The
appropriate crash tools will need to be adjusted for this. (FYI: The
unsigned long in the string data is the descriptor ID.)

8. A CPU-reentrant spinlock (the so-called cpu-lock) will be used to
synchronize/stop the kthreads during emergency state.

9. Support for printk dictionaries will be discontinued. I will look
into who is using this and why. If printk dictionaries are important for
you, speak up now!

(There was also some talk about possibly discontinuing kdb, but that is
not directly related to printk. I'm mentioning it here in case anyone
wants to pursue that.)

If I missed (or misunderstood) anything, please let me know!

John Ogness

[0] https://www.linuxplumbersconf.org/event/4/contributions/290/attachments/276/463/lpc2019_jogness_printk.pdf
[1] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com
[2] https://lkml.kernel.org/r/87lfvwcssu.fsf@linutronix.de
