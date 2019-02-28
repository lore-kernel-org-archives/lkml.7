Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C07C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC00214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551313827;
	bh=LOqqCQ7NKkR3oxRK57vodNSABl9xELGeja6ILnAf8bE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UmNYdZYmSEZP1gNeR0doisH9H+W5COmU68+KHQz2xYGn9TCnw/KWko2zNlfpGbDX6
	 GybyWqFczWumBS4Zh4P5M+Ko4/UnStdsg5JU1i56PEMnGGYgswEampowGfk42T18KP
	 HTqkLgECp29Sz17CQPOmSf4JYkTHLo6tCDNJ7/mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfB1Aa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbfB1AaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:30:25 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35307218D8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551313824;
        bh=LOqqCQ7NKkR3oxRK57vodNSABl9xELGeja6ILnAf8bE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W6HqekqK+rGnoSSLZlSrV/K3JYDu6pgp1cyVpBKH7Sbk5svNXZIXzCxULCUktda86
         33u+Udm1wtvIp8L+ykVrSrDQxcnLUYQROIb+SuahUjH+buZscO2oZ/U8a6E56Uv1V2
         CnO+wBgcS7C6BDugn7y+sPI/VYm7D4UW7gm+R5js=
Received: by mail-wm1-f49.google.com with SMTP id y15so7283161wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 16:30:24 -0800 (PST)
X-Gm-Message-State: AHQUAuafMS5kMlgvaC8uXXDwVeQRw6+s7cGPcAoxT3eOCnR2AqEGgmJJ
        T6RopelSy4tqr6cLrFWw+eVb81d1vVpOk/7IWjqg4A==
X-Google-Smtp-Source: AHgI3IY5cd78I+SyqI4VOhGOiobZIXmqbv8GUC8Lp5UW7PTUd+emReFpC57e8ZxuEogfdEWs8QqVbkYeLR4tSVhRqk8=
X-Received: by 2002:a1c:a885:: with SMTP id r127mr1153544wme.74.1551313822592;
 Wed, 27 Feb 2019 16:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.107098740@infradead.org>
 <20190225161124.cq6c45r3wlwktyuz@treble> <20190227122059.GO32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190227122059.GO32494@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 27 Feb 2019 16:30:08 -0800
X-Gmail-Original-Message-ID: <CALCETrUHyUA=1BOK=pL1O6M2B4E9JZv7F3eP7rHbeEysvgZPEQ@mail.gmail.com>
Message-ID: <CALCETrUHyUA=1BOK=pL1O6M2B4E9JZv7F3eP7rHbeEysvgZPEQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] objtool: Replace STACK_FRAME_NON_STANDARD annotation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 4:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 25, 2019 at 10:11:24AM -0600, Josh Poimboeuf wrote:
> > On Mon, Feb 25, 2019 at 01:43:34PM +0100, Peter Zijlstra wrote:
>
> > > -#define STACK_FRAME_NON_STANDARD(func) \
> > > -   static void __used __section(.discard.func_stack_frame_non_standard) \
> > > -           *__func_stack_frame_non_standard_##func = func
> > > +#define STACK_FRAME_NON_STANDARD(func)                                     \
> > > +   asm (".pushsection .discard.nonstd_frame_strtab, \"S\", @3\n\t" \
> > > +        "999: .ascii \"" #func "\"\n\t"                            \
> > > +        "     .byte 0\n\t"                                         \
> > > +        ".popsection\n\t"                                          \
> > > +        ".pushsection .discard.nonstd_frame\n\t"                   \
> > > +        ".long 999b - .\n\t"                                       \
> > > +        ".popsection\n\t")
> > > +
> >
> > I don't think this will work in the case where GCC does an IPA
> > optimization and renames the function (e.g., renames func to
> > func.isra.1234), right?  That might be a deal breaker...
>
> Or; as has been found by 0day; the whole function gets inlined and
> the symbol no longer exists at all.
>
> That's curable with a noinline, but all things considered, I think we
> should go back to the old horrible scheme. Andy?

Ugh, I guess.  I'm wondering just how atrocious the generated code is.

Just as a thought experiment, here are some other options:

1. Make a tiny GCC plugin that parses a special attribute on function
declarations and emits a record that describes that attribute into the
object file for each referenced symbol that comes from that
declaration.  (I know nothing about GCC internals, so I don't know how
hard this would be.)

2. Fiddle with the function names.  Turn a function called foo() into
__uaccess_safe_foo() and also emit a weak alias from that to foo.
This is probably every bit as bad as taking the address.

3. Take advantage of the fact that only static functions are (for now)
subject to this IPA stuff.  So take the address of a static function
or just declare that calling a static function is uaccess safe.

--Andy
