Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA08C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F2B20850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557291081;
	bh=pTyxrwECxa2pgGzrgPk/KLF+bllzOOCxIk3tiZXY+d0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GDJ2oMdQTYyMVWporvG+YGG0/vwONbco6QbHCoF3lJ7S5A64raqmMvxIE/SS3zFO9
	 Fd3QXv1tRdnreM2UGnt2kqQbUlOWeOZhVs3WdNObOyDmb+VHuzLlFV9MRNRVcqEwQ2
	 FAVaa9tjWgu4GBc65WGOJW3pQDmFJ0unUql07L/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfEHEvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:51:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34861 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHEvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:51:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id j20so13521215lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 21:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5e/UfOxO1ET3GG/v6CYadKGMC4a8arhmGhydGAJn8s=;
        b=fCVBMlCqXFaNG3/T7joMRaQg4ceXtuYdPorGYMf1oXOX02JSfkDNtMBZ392mp3Xa+w
         XzLxNjp4lFJG4QNeeBTaE98AcmNY9mHk/ZS6OieHVwaCDyObPW9cGux/hc2VnbzcJFR6
         4ExSRI8O2Vzt05xYgeQ6pkrUST7OnP3nm4W/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5e/UfOxO1ET3GG/v6CYadKGMC4a8arhmGhydGAJn8s=;
        b=m6R0SsysZ+qkGkv7H0dBzwhCeCn6W+0yaF1cZYpS62uMvW+Cp0uAPHPWE2Y3nDLJEr
         5v1v03qj+YGk5JMLrMAm7hWJ0+9JRvT0vZrh9KbkVlsxPCmvR0rm5dpEgUens6WX3YkC
         IgJPGnXtoDP6VkVmLooCBAnRluuMSwYow3oyV6vjJOHWYLRwXApk4HUCuHjVUKAargLS
         wAZwruGKHcP8wE52m/YK9lC9zvZpGnX5G+Z9XE52olEPFwOefMmxU+k2VUksdnWLXkDR
         ngoI4nZSHbtE6hFl5zXSv4c8Dn63GHU5yXQnOwhGwAXumw0IJGRk6U7mTK42VwIBk/Na
         pmNw==
X-Gm-Message-State: APjAAAWy9dm6OV5lh75b3wbpI/CKdmDjo67J3SWmwptdAWelerPKstvH
        qUQbKauHIKy2+Qc6LKrwq3Z2eQxgeiY=
X-Google-Smtp-Source: APXvYqyjxqn8KynGWaSRI5KdQm0PkOloiJi+wxLT9l8CGgq0EFp2vPfh257HitNLloKnRIhJWbbx+A==
X-Received: by 2002:a19:c194:: with SMTP id r142mr17227167lff.41.1557291073473;
        Tue, 07 May 2019 21:51:13 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k8sm2110654ljc.91.2019.05.07.21.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 21:51:09 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s7so10843974ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 21:51:08 -0700 (PDT)
X-Received: by 2002:a2e:9d86:: with SMTP id c6mr17393609ljj.135.1557291068666;
 Tue, 07 May 2019 21:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
 <20190506225819.11756974@oasis.local.home> <CAHk-=wh4FCNBLe8OyDZt2Tr+k9JhhTsg3H8R4b55peKcf0b6eQ@mail.gmail.com>
 <20190506232158.13c9123b@oasis.local.home> <CAHk-=wi4vPg4pu6RvxQrUuBL4Vgwd2G2iaEJVVumny+cBOWMZw@mail.gmail.com>
 <CAHk-=wg2_okyU8mpkGCUrudgfg8YmNetSD8=scNbOkN+imqZdQ@mail.gmail.com>
 <20190507111227.1d4268d7@gandalf.local.home> <CAHk-=wjYdj+vvV8uUA8eaUSxOhu=xuQxdo-dtM927j0-3hSkEw@mail.gmail.com>
 <20190507163440.GV2606@hirez.programming.kicks-ass.net> <CAHk-=wiuue37opWK5QaQ9f6twqDZuSratdP-1bK6kD9-Az5WnA@mail.gmail.com>
 <20190507172159.5t3bm3mjkwagvite@treble> <20190507172418.67ef6fc3@gandalf.local.home>
In-Reply-To: <20190507172418.67ef6fc3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 21:50:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5_fwx_-ybD9TLQE4rAUqtYzO2CAmpciWTkDn3dtKMOw@mail.gmail.com>
Message-ID: <CAHk-=wg5_fwx_-ybD9TLQE4rAUqtYzO2CAmpciWTkDn3dtKMOw@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, May 7, 2019 at 2:24 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> And there's been several times I forget that regs->sp can not be read
> directly. Especially most of my bug reports are for x86_64 these days.
> But when I had that seldom x86_32 one, and go debugging, I would print
> out "regs->sp" and then the system would crash. And I spend some time
> wondering why?
>
> It's been a bane of mine for some time.

Guys, I have basically a one-liner patch for your hangups.

It's called "rename 'sp' to 'user_sp' on x86-32".

Then we make the 'sp' field on x86-64 be a union, so that you can call
it user_sp or sp as you wish.

Yeah, it's really more than one line, because obviously the users will
need chaning, but honestly, that would be a _real_ cleanup. Make the
register match what it actually is.

And it doesn't mess up the stack frame, and it doesn't change the
entry code. It just reminds people that the entry is the USER stack
pointer.

Problem solved.

               Linus
