Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7808C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8499120830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbfIPO3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:29:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbfIPO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:29:05 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1i9rzs-0000FQ-OA; Mon, 16 Sep 2019 16:28:56 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk meeting at LPC
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
        <20190905121101.60c78422@oasis.local.home>
        <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
        <87k1acz5rx.fsf@linutronix.de>
        <cfc7b1fa-e629-19a6-154b-0dd4f5604aa7@I-love.SAKURA.ne.jp>
        <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
        <20190916094314.6053f988@gandalf.local.home>
Date:   Mon, 16 Sep 2019 16:28:54 +0200
In-Reply-To: <20190916094314.6053f988@gandalf.local.home> (Steven Rostedt's
        message of "Mon, 16 Sep 2019 09:43:14 -0400")
Message-ID: <87r24giac9.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-16, Steven Rostedt <rostedt@goodmis.org> wrote:
>>>> 6. A new may-sleep function pr_flush() will be made available to
>>>> wait for all previously printk'd messages to be output on all
>>>> consoles before proceeding. For example:
>>>> 
>>>>     pr_cont("Running test ABC... ");
>>>>     pr_flush();
>>>> 
>>>>     do_test();
>>>> 
>>>>     pr_cont("PASSED\n");
>>>>     pr_flush();  
>>> 
>>> Don't we need to allow printk() callers to know the sequence number
>>> which the printk() has queued? Something like
>>> 
>>>   u64 seq;
>>>   pr_info(...);
>>>   pr_info(...);
>>>   pr_info(...);
>>>   seq = pr_current_seq();
>>>   pr_wait_seq(seq);
>>> 
>>> in case concurrently executed printk() flooding keeps adding a lot
>>> of pending output?
>> 
>> My expectation is that pr_flush() would wait only until the current
>> message appears on all consoles. It will not wait for messages that
>> would get added later.
>
> Right, I believe we agreed that pr_flush() would take care of all this.

Yes, this is what we agreed on.

>>>> 9. Support for printk dictionaries will be discontinued. I will
>>>> look into who is using this and why. If printk dictionaries are
>>>> important for you, speak up now!
>>> 
>>> I think that dev_printk() is using "const char *dict, size_t
>>> dictlen," part via create_syslog_header(). Some userspace programs
>>> might depend on availability of such information.
>> 
>> Yeah, but it seems to be the only dictionary writer. There were
>> doubts (during the meeting) whether anyone was actually using the
>> information.
>> 
>> Hmm, it seems that journalctl is able to filer device specific
>> information, for example, I get:
>> 
>> $> journalctl _KERNEL_DEVICE=+usb:2-1  
>> -- Logs begin at Tue 2019-08-13 09:00:03 CEST, end at Mon 2019-09-16 12:32:58 CEST. --
>> Aug 13 09:00:04 linux-qszd kernel: usb 2-1: new high-speed USB device number 2 using ehci-pci
>> 
>> One question is if anyone is using this filtering. Simple grep is
>> enough. Another question is whether it really needs to get passed
>> this way.
>> 
>
> If worse comes to worse, perhaps we let the console decide what to do
> with it. Where all consoles but the "kmsg" one ignores it?
>
> Then journalctl should work as normal.
>
> Or will this break one of our other changes?

The consoles will just iterate the ringbuffer. So if any console needs
dictionary information, that information needs to be stored in the
ringbuffer as well.

The dictionary text and message text could be stored as concatenated
strings. The descriptor would point separately to the beginning of
dictionary and message. So the data-buffer would still be a clean
collection of text. But AFAIK Linus didn't want to see that "extra" text
at all.

If we want to keep dictionary text out of the data-buffer, we could have
a 2nd data-buffer dedicated for dictionary text. I expect it would not
really complicate things. Especially if the dictionary part was "best
effort" (i.e. if the dictionary text does not fit in the free part of
its data-buffer, it is dropped).

John Ogness
