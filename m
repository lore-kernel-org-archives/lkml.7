Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AA3C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDE72166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 00:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565310092;
	bh=O9zfb1q71B46LyQ9oiadBCxh5Q/9rCNFQdwvVIFsouo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fR5aO9kbwCEB42++Nyab5SkiUwEzQe45V10pdP46iqn5GEIFhjDfd+tp9MZOsJ412
	 UegPpa4hYfonoxoyT5rDsPfPrRxfvuQFn/uzIJ3na5r1xo3Q+sOlwbEgS7PTz3teeu
	 wIVZ8gkSKRrLYv++/zl0AEKc2hdDfnPh57zHOmts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405064AbfHIAVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 20:21:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36794 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404422AbfHIAVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:21:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so14155696lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 17:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3bTco2Lcs48f6Fyl9zkTa3/P3Hh2NXOsrEemToyYjg=;
        b=aOINADnKxCA9kwIJmqoq8aBUnMQy+sOjelyY9NBDQJ3FdmwzVkFlhI0vwcHTn5mvmT
         LZxxwDhcx5yqZeGlwSOSFjRFdo52rH/8KGBdjS3uid9qTjV0OHKuHRBA4CrAwaOQWOXK
         jbBD6KH1/H+P7ApfwfZ4djM1nazxtmS5eAD+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3bTco2Lcs48f6Fyl9zkTa3/P3Hh2NXOsrEemToyYjg=;
        b=Wqnt4xfap4jOeCZxnmsodSEO4qDOGZB+xEwvcyxKzwj64/47wgbWpGK0Dz0WSgDWLF
         vLKzxeO3fhoS4B9es+EgHFhhKUoxb5/hsMoluGlNnu4EJLPFwDclXf2AML/k7ry0A55s
         JyUfTGEnAAZrTxljFDq4RdnYOSCxpqDzLsaQ15Prl1O2RAavBh0WghYQf/a665iPSPE4
         Zwq+YF/aHC9KfqSbO4VNftNgwfsRkygfZpovWgjTARbrii0jnWxNaFI4BAwjDylxclNQ
         Lf0GtTCMcQ8yR9sNOUJTqAkvh45A2QdzJhsp5cyWh1Hk7WToLsHXJA1JOaRCNbncW4dP
         u3tQ==
X-Gm-Message-State: APjAAAVzQ6kG6FAZlptAodUFnUZZxnLvKTU2g7v3kB4mGS6p7kc5WHDu
        uQu6a7T6u1jWih/lb+EFB1eTvBrdmuU=
X-Google-Smtp-Source: APXvYqwRcTP80v+fwz3YBVvuMLnUY++9h0ftO0007HatEGRwyLPfdeX1PH02yyxqf0wSuWU55vogbw==
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr10691848lfq.119.1565310087363;
        Thu, 08 Aug 2019 17:21:27 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f22sm58101ljh.22.2019.08.08.17.21.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 17:21:26 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id i21so11277127ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 17:21:25 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr9356279lji.84.1565310085639;
 Thu, 08 Aug 2019 17:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de> <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
 <874l2rclmw.fsf@linutronix.de> <CAHk-=wiRN9v7UmhbTZgskh-MLyY2f0-8Zi3fUziy+GpZnj2i3w@mail.gmail.com>
 <20190808194523.6f83e087@gandalf.local.home>
In-Reply-To: <20190808194523.6f83e087@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Aug 2019 17:21:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com>
Message-ID: <CAHk-=wiRpvRg6dpEWqaB20QUFRq8or0-AGgkjvisygptRE64UA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 4:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Could we possibly have a magic value in some location that if it is
> set, we know right away that the buffer here has data from the last
> reboot, and we read it out into a safe location before we start using
> it again?

Right now I don't know how reliable RAM ends up being.

But with a small enough buffer I guess we could just do it
unconditionally and then let some debug tool in user space try to make
sense of it later.

More background for what I'm looking for: my hope for this is that we
can finally get the case of "undebuggable laptop hangs" logged with
something like this.

But laptops don't have reset buttons. They have "press the power
button for ten seconds, power turns off. Press it again, and power
comes on" reset sequences.

So DRAM power off for maybe 5 seconds? I've tried to find papers on
how well DRAM retention works (not very common: usually they happen
because you have some security researcher that wants to move a DIMM
and read it on another system, and some of them talk about using
freezing techniques to increase retention), and from what I've seen,
retention *should* be possible even for that kind of timeframe,
despite the usual "DRAM wants 60ms refresh". As in "maybe 90% of bits
might still be legible". And newer DRAM with smaller capacitors isn't
apparently a downside, because they have much less leakage too.

But some of those papers were for old DRAM. Maybe somebody knows
better. I don't have any real data myself, because my cold-boot tests
all seemed to show the BIOS reinitializing it to garbage. For all I
know, the DRAM training will guarantee garbage and it's all a pipe
dream.

Anyway, from some wild handwaving of "maybe  we can get 90% bit
retention" means that a human can read garbled data and guess
(particularly if you can see "ok, it's an oops, I know what the
overall pattern is, I can ignore a lot of bits that don't matter").
But I wouldn't want to necessarily automte it all that much.

But the retention pattern might be very random too, and honestly, I'm
mostly guessing to begin with (if that wasn't clear already ;).

But the "random user didn't have any other choice but to just
powercycle the machine" is one of the nastiest debug problems we have
right now, and if we were to get "next boot automatically sends a
report to the distro or whatever after a non-clean shutdown" that
might be *very* useful.

Or it might not be. Right now we simply don't have that kind of data
at all. Sure, we have a ton of virtual machines and servers that have
"reliable IO" (either thanks to the VM or thanks to serial lines etc),
but it's literally the "normal random consumer who runs
Fedora/Ubuntu/Suse workstation" that currently basically has no data
at all if it's the kind of crash that doesn't get you a saved log.

And the people running VM's and servers with serial lines are simply
not doing the same things as real people on real hardware are, so I
don't think it's an argument that "hey, we get reports from those nice
datacenter guys".

We likely don't even have any idea of how common it is, because while
I know "hangs on resume with no logs" used to be a fairly common
problem case, it by definition never gets _logged_. Maybe people
complain, but more likely they just curse and reboot.

And no, I don't think this is actually common at all. But the problem
with those unloggable problems is that _if_ they happen - even if it's
very very rare indeed - they are really nasty to debug.

They are nasty to debug when they happen on a developer machine (I
should know, I've definitely had them), but when they happen in the
wild they are basically "user just rebooted the machine". End of
story, and no stats or anything like that.

               Linus
