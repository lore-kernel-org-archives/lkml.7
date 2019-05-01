Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3094C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B958D2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556737867;
	bh=C9EnFKY57NczbApqVzFSazo6ZyPEshxOgeGwi70OPVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RY045+XMDNiJiWFEqNUH3yEJLmmH9uApGsYb+UZfsWwjPQ9WmLsoWdQhQf8U1+q/B
	 awZMlt12an1SOfpcONZ2ysBQqUKwGNI6+FvFawepJgAk35RTZhFfNUBQnkv6lTUD3z
	 VBlRzykaog2wriCOSelJlNSz7anyB+s7xNznL7rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfEATLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:11:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45957 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEATLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:11:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id w12so4526094ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiBsTWgzzAF+KdkEXxajDMuwYJJBRVV+mYkYOCtAGk0=;
        b=XhXhYve5yp/7i7ghcjSgqe8Ah4/jDyKSdA4S4qrEgBU4LVdnD257Ifh54gJv84NAiR
         JZoS2qQKQRUzHFnqFyLTaaVMOqgJnwidqknuDV//VcmEILwJrVqHQ7CVkyI5GbnNHtsk
         xTszDTRHy7x7pFIaZAu5kKKzR6BGVz7v+AD6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiBsTWgzzAF+KdkEXxajDMuwYJJBRVV+mYkYOCtAGk0=;
        b=nFJmbmhBjoZA9u0pkImR/996Tl1kWYebKBEZSPM2liBVvxHI4kyX+WVIA9jxHRBvkT
         3WhKUBJT7CrJwCKrr5HPo5Ejr8Xo2QNzBORY4qVRKnF1cWR/xMUB8gK8AU3bnPWSizBd
         6u1kjYezRAUrCaFHYdwRcau+e6MtD09ITRAVknIE3Vtxc/b0DmONXwySUNdw7oDO/G3z
         glATaXtPThdebtSIXlQzJFzyrswq4ypYFQK9xz7E9ngAzeFDQHg/zOxg87k9741qiuev
         oXqwja+5dJQlb75Ojs0NnveJoh6XCrsQnVAjLMwRXWEQ2SNGk6MeDLvCd8vlK6bqnGqm
         YZ2w==
X-Gm-Message-State: APjAAAXVs6JsDqyXg14DgR+ggCeXg5rmmoH1vdmqM/0/OpkQ9qY/23vx
        YYOnqm3Le2vHg5bd9PqII01F2FTK5rA=
X-Google-Smtp-Source: APXvYqy/+W7vp7HLvGpT/rwH/5B6Syox+A2UsiW726cYXunESgZfLFiuKPHMwyCkJpExWQyiDDKeHQ==
X-Received: by 2002:a2e:99d5:: with SMTP id l21mr8664551ljj.113.1556737863807;
        Wed, 01 May 2019 12:11:03 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g5sm5626963ljk.59.2019.05.01.12.11.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:11:03 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id o16so61161lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:11:03 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr18587346lfn.148.1556737448492;
 Wed, 01 May 2019 12:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net> <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home> <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home> <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
 <20190501131117.GW2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190501131117.GW2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 12:03:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCoycqdVjvWkkFnVRQS9fHEzdmiAG4uUV8B04xv7ZVwA@mail.gmail.com>
Message-ID: <CAHk-=wjCoycqdVjvWkkFnVRQS9fHEzdmiAG4uUV8B04xv7ZVwA@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating in
 breakpoint handler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Here goes, compile tested only...

Ugh, two different threads. This has the same bug (same source) as the
one Steven posted:

> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1479,6 +1479,13 @@ ENTRY(int3)
>         ASM_CLAC
>         pushl   $-1                             # mark this as an int
>
> +       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
> +       jnz     .Lfrom_usermode_no_gap
> +       .rept 6
> +       pushl   5*4(%esp)
> +       .endr
> +.Lfrom_usermode_no_gap:

This will corrupt things horribly if you still use vm86 mode. Checking
CS RPL is simply not correct.

                 Linus
