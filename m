Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE42C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1C82067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556568884;
	bh=XmK3rO33RQXtAZO3dHIqc+UzwvUsR3IlkWUtANZAQGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sTE0x+Q1Afk7cRdN4NuEIDMg3xcJQoA/H0Q5Nt359QqLGTh/dE24Pfs3aRrryPApc
	 YgwPerEQEXEWs3PO01j/85Fp1sKl6axG5mvsXp/M/ZaTKP7OJEFkdciR3ThSSFfb8V
	 4anMZCWQS1Nfz8YEe+tflqShCpU4aiMUi1ZzHcQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfD2UOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:14:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33644 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbfD2UOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:14:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so9045857lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klpGGVlaux40qrg5TuBwipJksiZuTXXgkF+MhiSRIlA=;
        b=TcY9IXe9CfLqn42qUjL9P1ySMDeddDODCyvYowl1cSTLiBSIL5Qts+yxj2tJATyscS
         VuMBIQMZJ9FcZ/bxb46xlQLqbBowZnvy4pBLmtOnwzxLeSB2LeNEj9ycOUiKVGex0PQ0
         7w5rqat134L6eKheTJLzUXWSjYZJq/e/a7oNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klpGGVlaux40qrg5TuBwipJksiZuTXXgkF+MhiSRIlA=;
        b=Qj4ThQrYlI+bO+P2qQYfSlTAHe86PNACxUZQlVTZ8XbJak+Evj4Xn4g1PDtKfUZyIs
         OS62TohcqeLbuvZ1RHpbfQcCEOugaAXwsIVN/KpjnBpn6BV7+e71UGhX1gD1udW0puul
         VIJ9Ahkmt6KPyHhvmA3JRFIhEdgCWJy02auZOb7lAUcN0rcUjynv5cpAs60mWhvMEeT4
         uWitU/BLNSqkId3xubMEOWX5dKZ0ui3pXn+y/LzKF0fvyqUeijvcqQHuWL0IgvD2Umd7
         o/41veFnUEuu8KKWrYBSg0GSQWmUxF+cQj5JCEKgC/K0x2+gdthK/qXGtsHE5ZLaxmVM
         mzUQ==
X-Gm-Message-State: APjAAAVpWYi4YN1vqMn1f8eeE1Ke2dRchenSzEMgm6PvEBQCsb2Wkttb
        k2jVKO8qwWk/DWSugs4xhwnZOYDIYFE=
X-Google-Smtp-Source: APXvYqxZJabRhiXk1ogFTbSKBYxgV0HnrEU4V/dJv5eBbc8AJPLghjBgAmAuB5ctxg3ibqk5729iTw==
X-Received: by 2002:ac2:4566:: with SMTP id k6mr33823569lfm.22.1556568880556;
        Mon, 29 Apr 2019 13:14:40 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y20sm7597549lfe.8.2019.04.29.13.14.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:14:39 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id b12so9420414lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:14:39 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr33222307lji.94.1556568469873;
 Mon, 29 Apr 2019 13:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com> <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
In-Reply-To: <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:07:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
Message-ID: <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
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

On Mon, Apr 29, 2019 at 12:24 PM Andy Lutomirski <luto@kernel.org> wrote:
> > Side note: we *already* depend on sti shadow working in other parts of the kernel, namely sti->iret.
>
> Where?  STI; IRET would be nuts.

Sorry, not 'sti;iret' but 'sti;sysexit'

> before commit 4214a16b02971c60960afd675d03544e109e0d75
>     x86/asm/entry/64/compat: Use SYSRETL to return from compat mode SYSENTER
>
> we did sti; sysxit, but, when we discussed this, I don't recall anyone
> speaking up in favor of the safely of the old code.

We still have that sti sysexit in the 32-bit code.

                     Linus
