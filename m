Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB48C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E88720693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kYGV7X+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfIMOtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:49:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45998 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbfIMOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:49:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so2815455oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YAF9dnbR9sCIpJIXRK0pmpPitasN8nMOoNNHDMHMvhQ=;
        b=kYGV7X+tE5+MSI8dIpKWs8fcF7tBPvItISQbPxCRGSJEHoq1xqi5Cu2uf1ODCu3xUw
         d2eOlP90pSFyl2/5PAvWxw4VL9L/Eiax5nQ1qbMjPk6e7uUg56BTzBvLqgqqnWYGryao
         A1Z5XjhhnjSxWDyQ5ovLyyLcH/dRglL1SyJys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAF9dnbR9sCIpJIXRK0pmpPitasN8nMOoNNHDMHMvhQ=;
        b=DHa3VlmA9x0qx8NydMTK+eAtzcS8rhWOs4C7wMImj5F63mCc6qzZK2IcB60RI417/H
         IJliXSkvvD9xxZCab4R78JgdIjbjYuzCgXn8yzWxEZX+ucSOJF9z3sGT7mE/R8Ha9kfk
         uXvfuGVoZF2769qkMI/DsXEvrfXYXqbFPHbJsxl1DgmNFMRIAdQDS0JZi83SDT9RJqv9
         epAl8dJLFut6E+2daDy9EIZoIcef39fEBFjT6lTPt/48U3MJtMzm4lg628y+9Ub0PwwP
         O7C3z6OVzIJyvPeGMl7y32UmShvUiV/xVIstG3PZfK7YToeGqkv8OCjhp/PFbTM4+C2L
         UMvg==
X-Gm-Message-State: APjAAAWLvzlRQN1jNj7iJtOhi0aq7dUgYrR/f1jiGr37vdHr4PSVlQkX
        ETgniOxn4cuNbwZTh/uxwzoi5zdtNw/ujFIUI14QgA==
X-Google-Smtp-Source: APXvYqzh1333JxFI2e5jkRedNcAIT6/auZg6+iNdIIzSlER1Er4Q3cTELD8VRdTDbd8PZlvUVZqiNGAc+v1QtBEHseY=
X-Received: by 2002:aca:eac5:: with SMTP id i188mr2372375oih.110.1568386139568;
 Fri, 13 Sep 2019 07:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net> <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home> <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
In-Reply-To: <87k1acz5rx.fsf@linutronix.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 13 Sep 2019 16:48:48 +0200
Message-ID: <CAKMK7uHXTGKSyXgUOucNr4HSrcnBxVkkoqA=VzF4-=sZSq1MKw@mail.gmail.com>
Subject: Re: printk meeting at LPC
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 3:26 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2019-09-09, Thomas Gleixner <tglx@linutronix.de> wrote:
> > printk meeting at LPC Meeting Room - SAFIRA on Tuesday Sept 10. from
> > 2PM to 3PM.
>
> The meeting was very effective in letting us come to decisions on the
> direction to take. Thanks for the outstanding attendance! It certainly
> saved hundreds of hours of reading/writing emails!
>
> The slides[0] from my printk talk served as a _rough_ basis for the
> discussion. Here is a summary of the decisions:
>
> 1. As a new ringbuffer, the lockless state-based proof of concept
> posted[1] by Petr Mladek will be used. Since it has far fewer memory
> barriers in the code, it will be simpler to review. I posted[2] a patch
> to hack my RFCv4 into a fully functional version of Petr's PoC. So we
> know it will work. With this, printk() can be called from any context
> and the message will be put directly into the ringbuffer.
>
> 2. A kernel thread will be created for each registered console, each
> responsible for being the sole printers to their respective
> consoles. With this, console printing is _fully_ decoupled from printk()
> callers.

Is the plan to split the console_lock up into a per-console thing? Or
postponed for later on?

> 3. Rather than defining emergency _messages_, we define an emergency
> _state_ where the kernel wants to flush the messages immediately before
> dying. Unlike oops_in_progress, this state will not be visible to
> anything outside of the printk infrastructure.
>
> 4. When in emergency state, the kernel will use a new console callback
> write_atomic() to flush the messages in whatever context the CPU is in
> at that moment. Only consoles that implement the NMI-safe write_atomic()
> will be able to flush in this state.
>
> 5. LOG_CONT message pieces will be stored as individual records in the
> ringbuffer. They will be "assembled" by the ringbuffer reader (in
> kernel) before being copied to userspace or printed on the
> console. Since each record in the ringbuffer has its own sequence
> number, this has the effect for userspace that sequence numbers will
> appear to be skipped. (i.e. if there were LOG_CONT pieces with sequence
> numbers 4, 5, 6, the fully assembled message will appear only as
> sequence number 6 (and will have the timestamp from the first piece)).
>
> 6. A new may-sleep function pr_flush() will be made available to wait
> for all previously printk'd messages to be output on all consoles before
> proceeding. For example:
>
>     pr_cont("Running test ABC... ");
>     pr_flush();
>
>     do_test();
>
>     pr_cont("PASSED\n");
>     pr_flush();

Just crossed my mind: Could/should we lockdep-annotate pr_flush (take
a lockdep map in there that we also take around the calls down into
console drivers in each of the console printing kthreads or something
like that)? Just to avoid too many surprises when people call pr_flush
from within gpu drivers and wonder why it doesn't work so well.
Although with this nice plan we'll take the modeset paths fully out of
the printk paths (even for normal outputs) I hope, so should be a lot
more reasonable.

> 7. The ringbuffer raw data (log_buf) will be simplified to only consist
> of alignment-padded strings separated by a single unsigned long. All
> record meta-data (timestamp, loglevel, caller_id, etc.) will move into
> the record descriptors, which are located in an extra array. The
> appropriate crash tools will need to be adjusted for this. (FYI: The
> unsigned long in the string data is the descriptor ID.)
>
> 8. A CPU-reentrant spinlock (the so-called cpu-lock) will be used to
> synchronize/stop the kthreads during emergency state.
>
> 9. Support for printk dictionaries will be discontinued. I will look
> into who is using this and why. If printk dictionaries are important for
> you, speak up now!
>
> (There was also some talk about possibly discontinuing kdb, but that is
> not directly related to printk. I'm mentioning it here in case anyone
> wants to pursue that.)
>
> If I missed (or misunderstood) anything, please let me know!

From gpu perspective this all sounds extremely good and first
realistic plan that might lead us to an actually working bsod on
linux. But we'll make it pink w/ yellow text or something like that
ofc :-)

Thanks, Daniel

>
> John Ogness
>
> [0] https://www.linuxplumbersconf.org/event/4/contributions/290/attachments/276/463/lpc2019_jogness_printk.pdf
> [1] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com
> [2] https://lkml.kernel.org/r/87lfvwcssu.fsf@linutronix.de



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
