Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDF5206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCsRLqNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfCFXiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:38:00 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36125 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCFXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:38:00 -0500
Received: by mail-ua1-f66.google.com with SMTP id e15so9599206uam.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyIXuMAw3n37zrTrlY9c88XciPug8WFdBmEA+CderNw=;
        b=uCsRLqNtWhXUtsEEK6bPI72H5cWAHlNq//Ib9KikhKPTZRnMNQxED80+ibu/t97NY2
         LkLgIFWgDhX6DMwjPx/EbwLNcrBbw/Y/CRPOWOMmyVbotRXh15Q5sZC701Q6vP0FS+NS
         Re/+nkiMwwwyRkhI+NjU8XCEWVZWRSkTe+m1c1xTue9ndjt8sJSEs5Ylr/71YLZGqTpf
         YP540IdupWVW1TwCvBbRq9HWRQpkBzCU1twYdBsT1HrE+NXcyHHMM8ZDbnzLa3tculaV
         Ch2WTW2A15tjaTnC3l92+lrCCD9j+s/DEiwr0kMAMt0ppv4D6FRWptNNPUZwZU40RtM2
         uIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyIXuMAw3n37zrTrlY9c88XciPug8WFdBmEA+CderNw=;
        b=hCVtek187j2jW7eb46RT8nx/D+1Q/P+f95h7FnI4U11wIhBVspmUX+dAk7b6/HQg4R
         5DVLRJFzlcxavZpe7dCUdwV7aPWGDA/h9pF6/hlsJ/5ItXWnaFf0rKff/97M+k1INrUx
         8RMFHPjgY7nTZ3s4lIqjmVdX3VySrXoxduMmY/3hO9b3y7d0C8FUERPFvQrr+aaS7NHj
         qT2gWBnxJ9K/9rnmhB5yx/1j2eX2+gFMYSn2p5cTnp5bXq+pURPWJSaW3rO3F+sek7DL
         dfxgTFvQ6fGXgwqAjKLkmCkgq7UuvlHPbX3bHd/mq1wfaFJLlT3FRbf/r/EljsZgFR8e
         1czQ==
X-Gm-Message-State: APjAAAXyuANsYPNZt9udHe8VSrDWwbI2b6e0vadWNeC9xa32ZVUXVvxn
        eiEJeSv4UyAW0TcuSqrWZvmoAY6EJF9lBJfQgeVamQ==
X-Google-Smtp-Source: APXvYqxl2vnDcH06eYQoG5A8az88PWIvkNvB1YKVYdVfgq1P6vYd7Kp1BYV0v6NiBvp46uFi0bMjQv3gIF44bPYLx74=
X-Received: by 2002:a9f:3591:: with SMTP id t17mr5511602uad.11.1551915478236;
 Wed, 06 Mar 2019 15:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com> <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
In-Reply-To: <20190306230944.GB7915@amd>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 6 Mar 2019 15:37:46 -0800
Message-ID: <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com>
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:09 PM Pavel Machek <pavel@ucw.cz> wrote:
>
>
> > > >Ok, I'll look into LZMA. Thanks for checking the compression sizes.
> > > >
> > > >- Joel
> > >
> > > Don't use lzma, use xz if you are going to do something.
> >
> > Ok, sounds good.

XZ is a file format for LZMA2. Everyone's right. :-)

> >
> > > However, it seems unlikely to me that someone not willing to spend the space in the filesystem will spend unswappable kernel memory.
> > >
> > > It would seem that a far saner way to do this is to use inittmpfs or perhaps an auxiliary "ktmpfs" so it can at least be swapped out if you have swap.
> >
> > But this is already possible with the proposed solution, you would load the
> > module, extract it into a tmpfs, and unload the module. TMPFS pages can
> > already be swapped.
>
> So your licensing requirements prevent you from having headers in the
> filesystem, but allow module with the headers hidden inside on the
> filesystem?
>
> Looks like you should just tar xvzf
> this-is-a-kernel-module-I-promise.ko /usr/src/linux/include :-).

I just don't get the opposition to Joel's work. The rest of the thread
already goes into detail about the problems with pure-filesystem
solutions, and you and others are just totally ignoring those
well-thought-out rationales for the module approach and doing
inflooping on "lol just use a tarball". That's not productive.

Look; here's the bottom line: without this work, doing certain kinds
of system tracing is a nightmare, and with this patch, it Just Works.
You're arguing that various tools should do a better job of keeping
the filesystem in sync with the kernel. Maybe you're right. But we
don't live in a world where they will, because if this coherence were
going to happen, it'd work already. But this work solves the problem:
by necessity, anything that changes a kernel image *must* update
modules coherently, whether the kernel image and module come from the
filesystem, network boot, some kind of SQL database, or carrier
pigeon. There's nothing wrong with work that very cheaply makes the
kernel self-describing (introspection is elegant) and that takes
advantage of *existing* kernel tooling infrastructure to transparently
do a new thing.

You don't have to use this patch if you don't want to. Please stop
trying to block it.
