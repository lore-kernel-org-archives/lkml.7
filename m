Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE54C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1229215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556562568;
	bh=YhLvJQMwP9dTUJ6EKowj9rAtpZqsG1brQtu+b1PS7JY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mu4yDSjUfDv31yp2EEw2xrgtBjh7lltRL8T5XpGAYc/yknAkF0+7vWCiK0vzlCjeZ
	 330k8wzhUK4TlaNsy85xBs9Kh6VqclYwfwv7FEmL3Z8s0mzrTraVMu+sIJPq7gPPbF
	 kiUcsLiJwdd6abcT2koZ/GWeo1kni0G9+4iDqOgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfD2S30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:29:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35221 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfD2S30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:29:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so10335649ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liktUAQ84meAwYxARrOaB57hFmqHknre6y7TLap/pyw=;
        b=TlX1vlaNRutHcVL0zAHMii8+n9hCbC2fIKsPMUSq4g7TknK8mmi/6eY9keIz02Ws6a
         0sxXLjiXKqUe5nVD8Hq9h6XVk1mWLMo7lAqkO0QgXrp0M7JguoB/2YMziFqvFKujU3CI
         Oo2bSTLegqzhOQTgHMmIMbR2g7S9IuZHsXaQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liktUAQ84meAwYxARrOaB57hFmqHknre6y7TLap/pyw=;
        b=BKQkHtlkRw/m6jtICj4m9ajZl3TSKIhkm1sEFoMCuE1g0P+3t7+qJMPW9+Qpy/hpzm
         DLl5z20xYrH+gNX56GwCwC4KPPmZzktzARRPltdTha1Mp0A8Fe/hX6tq4ebXjTCzoVZc
         nCLPTcw1x1xmPNdsXHb6OUKqH+Nd7W308cRezm0dY9lHWsc28jIXO8415qkvXkqnCDb/
         s+12GgxuAF3u/2O9LkHsgr9oKd9b1pr64T2/Pir4Vx+KLfrWyXF7z0XqtJV1Rpd2COsi
         N/rid6QKkHNNvcdcrG1v6ReWNkLa5vGRfHdeNspGjP0tVDud1/s7trFK0LAUZ+0VDRhW
         hPGw==
X-Gm-Message-State: APjAAAV1AGpJYoYrrtAasfJz+R1HEVpnp/Q3DY7figdxZ2q1GDq8pPMx
        x/V6qaZfcboud7w0iEstA/jYHbKVfdE=
X-Google-Smtp-Source: APXvYqwBLABNWG6bCbfi6iWIT6ywCZdwik8iQN4+FgMnTod0yTZOpIOZzaTVc+DP9N9JtL+iDoizwQ==
X-Received: by 2002:a2e:8693:: with SMTP id l19mr32985699lji.47.1556562563537;
        Mon, 29 Apr 2019 11:29:23 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h6sm7368659lfp.1.2019.04.29.11.29.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:29:23 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m18so5688225lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 11:29:23 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr30224042ljj.79.1556562187132;
 Mon, 29 Apr 2019 11:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
In-Reply-To: <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 11:22:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
Message-ID: <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> It does *not* emulate the "call" in the BP handler itself, instead if
> replace the %ip (the same way all the other BP handlers replace the
> %ip) with a code sequence that just does
>
>         push %gs:bp_call_return
>         jmp *%gs:bp_call_target
>
> after having filled in those per-cpu things.

Note that if you read the patch, you'll see that my explanation
glossed over the "what if an interrupt happens" part. Which is handled
by having two handlers, one for "interrupts were already disabled" and
one for "interrupts were enabled, so I disabled them before entering
the handler".

The second handler does the same push/jmp sequence, but has a "sti"
before the jmp. Because of the one-instruction sti shadow, interrupts
won't actually be enabled until after the jmp instruction has
completed, and thus the "push/jmp" is atomic wrt regular interrupts.

It's not safe wrt NMI, of course, but since NMI won't be rescheduling,
and since any SMP IPI won't be punching through that sequence anyway,
it's still atomic wrt _another_ text_poke() attempt coming in and
re-using the bp_call_return/tyarget slots.

So yeah, it's not "one-liner" trivial, but it's not like it's
complicated either, and it actually matches the existing "call this
code to emulate the replaced instruction". So I'd much rather have a
couple of tens of lines of code here that still acts pretty much
exactly like all the other rewriting does, rather than play subtle
games with the entry stack frame.

Finally: there might be other situations where you want to have this
kind of "pseudo-atomic" replacement sequence, so I think while it's a
hack specific to emulating a "call" instruction, I don't think it is
conceptually limited to just that case.

                 Linus
