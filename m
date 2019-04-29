Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4EAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A302075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556575945;
	bh=jRT4+7dbuZ3essP+qoyKVZdhFfyIkM0445dXX3KClBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CmgZJNKV+TGDw6BaLGj6cAWoXt5cFoXqYksuDxG+ec+zZxl4W2tftnrupZVYPS1ZK
	 oeX/8YPmHq3Qv/n9XUPhR6glJmXcQYBVpdHBMRXew7BwfQOXaZcYf7WF61OUJyirMq
	 59NLVSg+/gbG3YVBVNBIJAYEc4ii2FTynd0Ehf4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfD2WMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:12:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38553 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2WMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:12:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id e18so4962906lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTkJ5qHxsD8SYnb8NRVfGGysKDzTffkMwFGKzHjAIes=;
        b=P/hvsAFBYFuVdRyxHJQqYZPAHZlzO7DpELqDJ8wtqrIzcq7eThvNjt852fIlr3+1hp
         vVyLfbe/O0jvxqP511QI0JfPRN9J+m8BMRz0pKGIgZRo0Qiu2YusRGP2+ndwrIJZA81T
         qOBt9kqSGLrhz0pQMSTGYNPFKlQsei2x7M0lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTkJ5qHxsD8SYnb8NRVfGGysKDzTffkMwFGKzHjAIes=;
        b=BzE8y/jmEyN9QWh2Y//j/BU/pJiCDIMvticXldbenBP7bQniBTzIPN7bDkgyKdocOO
         1IobUywfQ2rNLO7gSkjeJsIvfGXSL7rXoG62wyyJFrR0Q9I5rCRrJbLeaWJsphQmjMah
         bwek9H8lS8gzH0FAALfNnGYUgkVomq5OH9g7pqtS+4lVuPgyF6upNNlmj3ONZntMJS4e
         D/GuPjOsMxomLsP+OewNyomoNsBTElHiO926F9DQF0njmDk3+nfI/Hyvh+Ftw/HtDlmI
         SoRWg2Ns9jM/U5oF8kcsX4gpoROt/mQZz0R5TA19jeDTn7Jkw/ySMLjfgAe0xcUDEm2q
         tpNQ==
X-Gm-Message-State: APjAAAWN5vl1RX+ez0Q2uz7iN1x2FJTfNDiLFZUwVFIhPbNfjwjqxxi3
        ykMlJiMHyizELtrUfOGbQyaQNWmgBz0=
X-Google-Smtp-Source: APXvYqz7RVtkjPOIWYxL1rIcAXe1uxDPNdT8nmg9dpNzDu5Xc6a/fguh10XtFrsMgLaxrY4XY/vkOg==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr24408117ljj.21.1556575939386;
        Mon, 29 Apr 2019 15:12:19 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id k10sm7162481ljh.86.2019.04.29.15.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:12:18 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id i68so9083061lfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 15:12:18 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr32975252lfa.136.1556575607339;
 Mon, 29 Apr 2019 15:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com> <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
In-Reply-To: <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 15:06:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAQaowLHBrXs1M5K-Nr-eVQMt0K8oyCuWxKTvP9k=qqA@mail.gmail.com>
Message-ID: <CAHk-=wjAQaowLHBrXs1M5K-Nr-eVQMt0K8oyCuWxKTvP9k=qqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Mon, Apr 29, 2019 at 11:57 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Otherwise you could never trust the whole sti shadow thing - and it very much is part of the architecture.
>
> Is this documented somewhere?

Btw, if you really don't trust the sti shadow despite it going all the
way back to the 8086, then you could instead make the irqoff code do

        push %gs:bp_call_return
        push %gs:bp_call_target
        sti
        ret

which just keeps interrupts explicitly disabled over the whole use of
the percpu data.

The actual "ret" instruction doesn't matter, it's not going to change
in this model (where the code isn't dynamically generated or changed).
So I claim that it will still be protected by the sti shadow, but when
written that way it doesn't actually matter, and you could reschedule
immediately after the sti (getting an interrupt there might make the
stack frame look odd, but it doesn't really affect anything else)

                  Linus
