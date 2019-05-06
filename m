Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A05C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CDD2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557180765;
	bh=LwAM7B0wwb6eYyfn9rjdsqRz3Hc/ODD9bamBJh9kTKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aohwU7i50IeqkPntiRKokVuY2Ne0vLJtkTaD1cnOMKUN1/fw8PKnZy7IoorbGe4jk
	 Sm15POaA2KPPLrdrxOTFv+WugAL0yWDSKTApplrMtSs7d+fiUMdC2yn5tVwanFnC8H
	 FtlJiYSH2vOc6gI5u5xmzohYhG3vItwtSzVa6hqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEFWMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:12:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44062 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:12:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id n134so8461494lfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnC6sHzJKQT/H/efllpurOKq1DqCgmhhrIn+ALVg0f8=;
        b=UuWTDsQLlvb0PtcfEid4ABezWzyagSu44050e/2j488U+99fI3xCIqtuQS8vXMHPrQ
         xvVSucwGErlEAEYFFWNYIWMj4gj1EPGneYgBBhuklMQ9H4OeRQjj1yrsseBu+AGIqRuC
         1DBfQJo9MbI0m5IyIe848iiX0VPuZXVlACZoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnC6sHzJKQT/H/efllpurOKq1DqCgmhhrIn+ALVg0f8=;
        b=Cxf46DZ+LkAoMAiAz7WOlunyjDdzo+a2padbOUCvcukWunsraMO76vBKTYFuvDCAKx
         zHUJNFl23FKAZyZdqkv/0jwF9lX9gO8stx3dTa6jQY+n0zmTPw41rVgTce/X3FLaM6i3
         RLKtGNLcgA/nxrKWd3yHYmjDC1Gh1FNYjlWFy/kjYmSR2vc9Zx8zzJqmuV5ptSyXsVjq
         qmxgf2CxqBd9lafbiz8UVtroG3ZgC2cnVRpk+zzXIb5sXaMbinzZRuI5c5BrI75+LHIu
         ZvC6DpkRNazMhvjTAUMahUBJ97AcdVias2UwVUs4S7p1S5gljsoElcSO2IvN2TPb0U8C
         W2iw==
X-Gm-Message-State: APjAAAVpCB9v1EetZ4bxiguZLROU9GUdDcRNm6VdR3ZSzoMumps+JoDC
        shdo0PZdzzD5eldZdZRXwNeWIr/s0GM=
X-Google-Smtp-Source: APXvYqySHJ8Qn5uH5jGw/15hLzUbLs4/i0W6/CJYPFyLcFlTTEFiLVWUbrpAm/Fwr/OY0uN2ycjwaw==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr3828674lfm.31.1557180757696;
        Mon, 06 May 2019 15:12:37 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g66sm1864346lje.88.2019.05.06.15.12.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:12:37 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u27so10019156lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:12:37 -0700 (PDT)
X-Received: by 2002:a19:4f54:: with SMTP id a20mr14066761lfk.136.1557180433906;
 Mon, 06 May 2019 15:07:13 -0700 (PDT)
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
 <20190506174511.2f8b696b@gandalf.local.home>
In-Reply-To: <20190506174511.2f8b696b@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 15:06:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
Message-ID: <CAHk-=wj3R_s0RTJOmTBNaUPhu4fz2shNBUr4M6Ej65UYSNCs-g@mail.gmail.com>
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

On Mon, May 6, 2019 at 2:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> To do that we would need to rewrite the logic to update each of those
> 40,000 calls one at a time, or group them together to what gets
> changed.

Stephen, YOU ARE NOT LISTENING.

You are already fixing the value of the call in the instruction as
part of the instruction rewriting.

When you do things like this:

        unsigned long ip = (unsigned long)(&ftrace_call);
        unsigned char *new;
        int ret;

        new = ftrace_call_replace(ip, (unsigned long)func);
        ret = update_ftrace_func(ip, new);

you have already decided to rewrite the instruction with one single
fixed call target: "func".

I'm just saying that you should ALWAYS use the same call target in the
int3 emulation.

Instead, you hardcode something else than what you are AT THE SAME
TIME rewriting the instruction with.

See what I'm saying?

You already save off the "ip" of the instruction you modify in
update_ftrace_func(). I'm just saying that you should *also* save off
the actual target of the call, and use *THAT*.

So that the int3 emulation and the instruction rewriting *match*.

What you do now makes no sense. You're modifing the code with one
thing (the "func" argument in update_ftrace_func), so if your
modification completed, that's what you'll actually *run*. But you're
then _emulating_ doing somethiing completely different, not using
"func" at all there.

So let me say one more time: how can it *possibly* make sense to
emulate something else than you are changing the instruction to read?

Are you finally understanding what craziness I'm talking about?

Stop with the "there could be thousands of targets" arguyment. The
"call" instruction THAT YOU ARE REWRITING has exactly one target.
There aren't 40,000 of them. x86 does not have that kind of "call"
instruction that randomly calls 40k different functions. You are
replacing FIVE BYTES of memory, and the emulation you do should
emulate those FIVE BYTES.

See?

Why are you emulating something different than what you are rewriting?

                    Linus
