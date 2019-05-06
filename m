Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE574206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557172413;
	bh=djI1GV58DDCHF1i6e2Z0HOk5VV/FcXxwDMT4Uwh/6tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZYaSta3dXbI3w0M12CeUkssOGSsqd5VWk6/3G6fAkK5CKye86noFw0+Y8XAk6k9ui
	 ABRY2ZTgHY/HrCvXMu639p0+ZhrlRcv46WTpukkpqMQD2fdggFnfEWLDFOH8FdgbP0
	 dYybaoMTaR856A6cgbamKEGRTT4KYSDEd12JKpJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfEFTxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:53:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43604 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:53:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id u27so9785420lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4kkKa3SRWQVadtU9idY39CCQftkxcpIoOM0XAJqBTM=;
        b=cdF+EPKS6Ge2/s30X7OzfVs/i8EBdXNa487B1p2vGBTd+n7CgEMvurpKHpXcLVem3u
         rzevt8MxZIrbBVHT/2blPyzn4vnzFxGcHXwbP4Rlh59f3LBxbz5pPdNbdmV6lS7efsQa
         93j00k6IAskp5TeuRRIvJP0yqXdlZxHNFN5Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4kkKa3SRWQVadtU9idY39CCQftkxcpIoOM0XAJqBTM=;
        b=JwP7q6Pg/DIPEfmu88PbWaP7YujOaH7+8Bpr1/zm16YW5f7cHOjPzAIdmqmEb0C80p
         +6BcxxZz6Dej1poQ66mhsuzvOha0T/miDNJHv2b2Fz/RB1CPzWw4Hwuz9GhJOMvkyOlP
         N0d3UXimIExDZHuLQymk91Q3AAHgqvhInG3VBBeHfx4wjJSXrMd8X1+AeVRNFX/d8lGa
         ME3Pl4kEN/nOUnNUO4Zkf0gnIpjH1lSXVO5wxleHK3vUR8hJtW8hGXO7+wFhUcCFgwHq
         nEE2Ch6e9yhvgYd6zd95AFn1RVyXdhu6Yhh8e0uO+NyKpc0RsesGP5cQHb4nPEqQozHs
         WJbA==
X-Gm-Message-State: APjAAAWIiUeREOLLqDo3stcIenu2OUyZrEgEGlarveYP0DYd4jZH5xhK
        AaLcpe2HbHYzvti3zjEZiFff/dKtIzE=
X-Google-Smtp-Source: APXvYqzOwmfAQosv4tDUNBYwplFBpgMx9W0YrszkfkGZwH2JnPpAniNM8cYhbz/YbLgNcIQ3ZyxBPA==
X-Received: by 2002:ac2:55b5:: with SMTP id y21mr8391971lfg.84.1557172409666;
        Mon, 06 May 2019 12:53:29 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k8sm1090668ljc.91.2019.05.06.12.53.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 12:53:29 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id v18so7849770lfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:53:29 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr13815824lfl.67.1557171988295;
 Mon, 06 May 2019 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com>
 <20190506130643.62c35eeb@gandalf.local.home> <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
 <20190506145745.17c59596@gandalf.local.home>
In-Reply-To: <20190506145745.17c59596@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 12:46:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
Message-ID: <CAHk-=witfFBW2O5v6g--FmqnAFsMkKNLosTFfWyaoJ7euQF8kQ@mail.gmail.com>
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
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 11:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> You should have waited another week to open that merge window ;-)

Hmm. I'm looking at it while the test builds happen, and since I don't
see what's wrong in the low-level entry code, I'm looking at the
ftrace code instead.

What's going on here?

               *pregs = int3_emulate_call(regs, (unsigned
long)ftrace_regs_caller);

that line makes no sense. Why would we emulate a call to
ftrace_regs_caller()? That function sets up a pt_regs, and then calls
ftrace_stub().

But we *have* pt_regs here already with the right values. Why isn't
this just a direct call to ftrace_stub() from within the int3 handler?

And the thing is, calling ftrace_regs_caller() looks wrong, because
that's not what happens for *real* mcount handling, which uses that
"create_trampoline()" to create the thing we're supposed to really
use?

Anyway, I simply don't understand the code, so I'm confused. But why
is the int3 emulation creating a call that doesn't seem to match what
the instruction that we're actually rewriting is supposed to do?

IOW, it looks to me like ftrace_int3_handler() is actually emulating
something different than what ftrace_modify_code() is actually
modifying the code to do!

Since the only caller of ftrace_modify_code() is update_ftrace_func(),
why is that function not just saving the target and we'd emulate the
call to that? Using anything else looks crazy?

But as mentioned, I just don't understand the ftrace logic. It looks
insane to me, and much more likely to be buggy than the very simple
entry code.

             Linus
