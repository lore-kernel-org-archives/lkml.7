Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A357C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB69206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557181943;
	bh=1my7TI4YLDlOXSwz+gKvTqVkIqZ8eYEoExJtcJlJkD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t12Zc8mPMI33NQy5zLP1+HL73qrEMB1BL6ZzpWkdKqp+BHQVinu5z0jz+FUWzkxjn
	 h3uGhSRW8K/b1NgsKlQZbt5+PfKJrfUiHkonwhrRyL4Il6moMAYHxDMsaq1cBd2RDY
	 s1BuKPPGoC01uOcEUkmLuNReNPB0ILYr0drJwbHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEFWcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:32:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35464 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:32:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id m20so3280310lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dxftzvjm/ITflLxpaon8lNkVkwZKAv6W1SNUZkWADvU=;
        b=QpAj51Mi2Y8qwLgnhbcKf/qXqptSySRdePaWjhEzne8z6S13GHE8jO+Y+Tb25ZwGd3
         i5iKwHdDqjZwGz2dkYEWWbrQUc5rqB0zVWEJXtAV3RZHsD4AYRss4H5uvz/lIp09NGTU
         y1PP7SzMglvop+x+MQmaR/R6GmlqoGbadW9GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dxftzvjm/ITflLxpaon8lNkVkwZKAv6W1SNUZkWADvU=;
        b=luSSlwORFDDjhDZswtUMfW6/EmR2NI6W55Ytf/dJKVtymLoNiDZTCbTzJPiuNgGaf3
         t5hrZmq3pS4qJMzs1CpevttB3IXSVDQPiyZmIb1NoB05kSGgTv4SiDHixgjuPnXnRh36
         J42CmZ2eTKY7rzWlg1+QISNfvxFxrDMXye9Hp/RYoAnIGRmXIPd3FhM7x+BgUeyY3UzF
         PvTcAPt4J8Ii4VkSrcIoNZmG4pWcr3PhtunpTz9ZNJzg/SVknUXmTMSBw4ebLCWIkiOd
         dmOvDJuTgRD0mGKIAWirxvKfimhuxUtBGqMnfFght0Py2s+KVFj6IsHpO1Uu8mGQAwLo
         /m7Q==
X-Gm-Message-State: APjAAAU+91D2VxpUgonDKogyvMPlkM9kiuxU0NwOBrLk5Au/FFXhvufh
        yNuyd1/uwX1VucAkC3KLl4qIlwUPAcM=
X-Google-Smtp-Source: APXvYqyQxeVgZ3eLEuzYwVulRCRjA30A/VIiaM8m25nxoTzRVvj2yDD3NPbjXaUyzew5JMSTtzpUaA==
X-Received: by 2002:a2e:8850:: with SMTP id z16mr8640776ljj.84.1557181937735;
        Mon, 06 May 2019 15:32:17 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d23sm2442210ljj.38.2019.05.06.15.32.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:32:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u27so10046508lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:32:14 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr14261445lfg.88.1557181933876;
 Mon, 06 May 2019 15:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <20190502185225.0cdfc8bc@gandalf.local.home> <20190502193129.664c5b2e@gandalf.local.home>
 <20190502195052.0af473cf@gandalf.local.home> <20190503092959.GB2623@hirez.programming.kicks-ass.net>
 <20190503092247.20cc1ff0@gandalf.local.home> <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net>
 <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home> <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
 <20190506162915.380993f9@gandalf.local.home> <CAHk-=wi5KBWUOvM94aTOPnoJ5L_aQG=vgLQ4SxxZDeQD0pF2tQ@mail.gmail.com>
 <20190506174511.2f8b696b@gandalf.local.home> <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
In-Reply-To: <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 15:31:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wje38dbYFGNw0y==zd7Zo_4s2WOQjWaBDyr24RCdK2EPQ@mail.gmail.com>
Message-ID: <CAHk-=wje38dbYFGNw0y==zd7Zo_4s2WOQjWaBDyr24RCdK2EPQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 3:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why are you emulating something different than what you are rewriting?

Side note: I'm also finding another bug on the ftrace side, which is a
simple race condition.

In particular, the logic with 'modifying_ftrace_code' is fundamentally racy.

What can happen is that on one CPU we rewrite one instruction:

        ftrace_update_func = ip;
        /* Make sure the breakpoints see the ftrace_update_func update */
        smp_wmb();

        /* See comment above by declaration of modifying_ftrace_code */
        atomic_inc(&modifying_ftrace_code);

        ret = ftrace_modify_code(ip, old, new);

        atomic_dec(&modifying_ftrace_code);

   but then another CPU hits the 'int3' while the modification is
going on, and takes the fault.

The fault handler does that

        if (unlikely(atomic_read(&modifying_ftrace_code))..

and sees that "yes, it's in the middle of modifying the ftrace code",
and calls ftrace_int3_handler().  All good and "obviously correct" so
far, no?

HOWEVER. It's actually buggy. Because in the meantime, the CPU that
was rewriting instructions has finished, and decrements the
modifying_ftrace_code, which doesn't hurt us (because we already saw
that the int3 was due to the modification.

BUT! There are two different races here:

 (a) maybe the fault handling was slow, and we saw the 'int3' and took
the fault, but the modifying CPU had already finished, so that
atomic_read(&modifying_ftrace_code) didn't actually trigger at all.

 (b) maybe the int3-faulting CPU *did* see the proper value of
modifying_ftrace_code, but the modifying CPU went on and started
*another* modification, and has changed ftrace_update_func in the
meantime, so now the int3 handling is looking at the wrong values!

In the case of (a), we'll die with an oops due to the inexplicable
'int3' we hit. And in the case of (b) we'll be fixing up using the
wrong address.

Things like this is why I'm wondering how much of the problems are due
to the entry code, and how much of it is due to simply races and
timing differences?

Again, I don't actually know the ftrace code, and maybe I'm missing
something, but this really looks like _another_ fundamental bug.

The way to handle that modifying_ftrace_code thing is most likely by
using a sequence counter. For example, one way to actually do some
thing like this might be

        ftrace_update_func = ip;
        ftrace_update_target = func;
        smp_wmb();
        atomic_inc(&modifying_ftrace_head);

        ret = ftrace_modify_code(ip, old, new);

        atomic_inc(&modifying_ftrace_tail);
        smp_wmb();

and now the int3 code could do something like

        int head, tail;

        head = atomic_read(&modifying_ftrace_head);
        smp_rmb();
        tail = atomic_read(&modifying_ftrace_tail);

        /* Are we still in the process of modification? */
        if (unlikely(head != tail+1))
                return 0;

        ip = ftrace_update_func;
        func = ftrace_update_target;
        smp_rmb();
        /* Need to re-check that the above two values are consistent
and we didn't exit */
        if (atomic_read(&modifying_ftrace_tail) != tail)
                return 0;

        *pregs int3_emulate_call(regs, ip, func);
        return 1;

although it probably really would be better to use a seqcount instead
of writing it out like the above.

NOTE! The above only fixes the (b) race. The (a) race is probably best
handled by actually checking if the 'int3' instruction is still there
before dying.

Again, maybe there's something I'm missing, but having looked at that
patch now what feels like a million times, I'm finding more worrisome
things in the ftrace code than in the kernel entry code..

                 Linus
