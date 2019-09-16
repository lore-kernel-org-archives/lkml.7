Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C3FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B620650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DmAolwHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfIPIoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:44:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39535 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfIPIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:44:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so1094439otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=am5fajrgYrh2eMM8UWTgzQSBhFr06neV3+14UIU2Y/w=;
        b=DmAolwHHTOeh/Hn9bUFgOquLAlhvY3oBWsAFq4a55qQ9t6ihl+/dXiaiEF0HGByKMd
         2sdOqTfFVC5P82zdXTJuoxPnbjG+gM1+nELbd23t0e8UKOA+uC1P8eN/oyTZ2nPYp7Jc
         tVHCA82w6bQBg3GyDg1Uyr4060MEG0SPEy/Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=am5fajrgYrh2eMM8UWTgzQSBhFr06neV3+14UIU2Y/w=;
        b=pAYP+cdwJ7IJTSeJODzrTrSd6Ia03x+Pc46rzURypoHyx+wNuCRVNMMBoxl8vh65mz
         0P2OTnvCYn0CkV1kg6sNa+kHuFll0ogPEiBAi5yKsJV8fAckhdZOs3GYdJB1KXmlBJvD
         7SnbqOb3SZDu7qCZ26nq8LSYti52thO8sLU/1QQn7gH7rEEAV2oYkp5eA3FmWT+nmbDW
         9mAa1CzVnI4PJ1GDVxU/decZyt4Wzx9cRO4K7NIunZozrNw3i81G9CpSDqrqRK0x4HIL
         AZNR5pZC3RdOjvv3xEckZjVBnsAP2uXOXWF4phBpTeOxznHtUsJ+93sZ2yvMV7WyUApH
         Puyw==
X-Gm-Message-State: APjAAAVGDv5BEOpjG6aPV4am6rovrL97pUaQKFOiPYRN2zdeiaz4jfiw
        4ApLs3q59RpN3NcYguc6Dc38spD4TJtP91ySLPlHkw==
X-Google-Smtp-Source: APXvYqw2VHQWbQNlXWcfCbo6X1xsUSi4YVc/jYjaoDA8FDbO/L/d+jj3uLaYrLOGf7HFNwQwxgBhxAwIxF41Tkrf/sI=
X-Received: by 2002:a9d:7006:: with SMTP id k6mr41697080otj.303.1568623458276;
 Mon, 16 Sep 2019 01:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net> <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home> <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de> <CAKMK7uHXTGKSyXgUOucNr4HSrcnBxVkkoqA=VzF4-=sZSq1MKw@mail.gmail.com>
 <87d0g18ydt.fsf@linutronix.de>
In-Reply-To: <87d0g18ydt.fsf@linutronix.de>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 16 Sep 2019 10:44:07 +0200
Message-ID: <CAKMK7uH-3PqezSBTX3Xh40xyZ0o9NQFBA5gnPq70HHBGLGp8-A@mail.gmail.com>
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

On Sun, Sep 15, 2019 at 3:48 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2019-09-13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >> 2. A kernel thread will be created for each registered console, each
> >> responsible for being the sole printers to their respective
> >> consoles. With this, console printing is _fully_ decoupled from
> >> printk() callers.
> >
> > Is the plan to split the console_lock up into a per-console thing? Or
> > postponed for later on?
>
> AFAICT, the only purpose for a console_lock would be to synchronize
> between the console printing kthread and some other component that wants
> to write to that same device. So a per-console console_lock should be
> the proper solution. However, I will look into the details. My main
> concerns about this are the suspend/resume logic and the code sitting
> behind /dev/console. I will share details once I've sorted it all out.
>
> >> 6. A new may-sleep function pr_flush() will be made available to wait
> >> for all previously printk'd messages to be output on all consoles
> >> before proceeding. For example:
> >>
> >>     pr_cont("Running test ABC... ");
> >>     pr_flush();
> >>
> >>     do_test();
> >>
> >>     pr_cont("PASSED\n");
> >>     pr_flush();
> >
> > Just crossed my mind: Could/should we lockdep-annotate pr_flush (take
> > a lockdep map in there that we also take around the calls down into
> > console drivers in each of the console printing kthreads or something
> > like that)? Just to avoid too many surprises when people call pr_flush
> > from within gpu drivers and wonder why it doesn't work so well.
>
> Why would it not work so well? Basically the task calling pr_flush()
> will monitor the lockless iterators of the various consoles until _all_
> have hit/passed the latest sequence number from the time of the call.

Classic deadlock like the below: Some thread:

mutex_lock(A);
pr_flush();
mutex_unlock(A);

And in the normal console write code also needs do to mutex_lock(A);
mutex_unlock(A); somewhere.

> > Although with this nice plan we'll take the modeset paths fully out of
> > the printk paths (even for normal outputs) I hope, so should be a lot
> > more reasonable.
>
> You will be running in your own preemptible kthread, so any paths you
> take should be safe.
>
> > From gpu perspective this all sounds extremely good and first
> > realistic plan that might lead us to an actually working bsod on
> > linux.
>
> Are you planning on basing the bsod stuff on write_atomic() (which is
> used after entering an emergency state) or on the kmsg_dump facility? I
> would expect kmsg_dump might be more appropriate, unless there are
> concerns that the machine will die before getting that far (i.e. there
> is a lot that happens between when an OOPS begins and when kmsg_dumpers
> are invoked).

Yeah I think kms_dump is what the current patches use. From the fbcon
pov the important bit here is the clearly split out write_atomic, so
that we can make sure we never try to do anything stupid from special
contexts. Aside from the printing itself we also have all kinds of fun
stuff like unblank_screen() and console_unblank() currently in the
panic path still.

-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
