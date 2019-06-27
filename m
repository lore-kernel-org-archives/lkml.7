Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE91DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD2F217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGPWXI3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfF0CyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:54:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34345 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfF0CyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:54:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so497027lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VizROXl0zyqycl7jiCmhGuemYyIUikxy4LZZGg5Y3a8=;
        b=JGPWXI3lnuCRASQSzrLLEawzeB5M1kF4HL4Lb/KP7oIk97JYVlKJvo7sRkir62tZqa
         CPrQNtes/klFW7opcnJOoxyBmpkqKp2i5ZV07DdDInxFEGj1c2i0mBfWJKbodFE5+lpf
         eLbCZDun2vGMBXKmPCODDeG4byT8nfPPO14WFccuO+SHARjR8lytpNr3grIaikvFNX4t
         CvF818YCES9SxMk1CDdHLzrGX0GDZJ3sQ5KTJ1dSFijzca5thXQUMwJLTbpOIB5j91AU
         fulBxKpYYJerTnneReMOJ2fop+9auryZzB0hoGKg5AifGfILIL33n/1Oa6on9gRBwGQM
         4xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VizROXl0zyqycl7jiCmhGuemYyIUikxy4LZZGg5Y3a8=;
        b=B0VK2djnpve3pPiS+QFiL8QrFSSL/mIKYt/s7GD8ClHoQhpeptalfGwiJWVbO7Rc6C
         wxjf4319qFi3UsDCnjzxJJw8aBbIg+BRTjlRhIqJaaR0fAxS3py0OVBuZXgc4duNktkz
         XmdHV4SmIFBIfwng2nmUJiV1KhK5kzB0ITXMYTWKy2+/s3aahRJmdk9NtIb5B33BCGtE
         SkfdA3N/SsHl997/m64nhjF5Gtu6O78ZI3D4N1vPx5wXnoV2Fn6XGFFbourskFGVlDUH
         WBsGOHhQN069EZZ09Tlmr14C4qX3xKDwDlCmpqa/k/y57wxA7tLn2fZC/VyRvvG+ISMR
         x86Q==
X-Gm-Message-State: APjAAAWrTbJ1tzoOQ/f8vu5EESKoyXqV9W97jvWbQ7SyrrX5aSUqtIhD
        BIIcGEnGlBY9toSQCdfPR4p3fE96PKvlm8DpNac=
X-Google-Smtp-Source: APXvYqy1ChP+sYi3/jBaQtwatxnj7wQ2qhQHCkddUtoM7hRp5eGfJvrT1XIZp+9ywffYJpVqez7pF96LX0c6ZTEUuXo=
X-Received: by 2002:ac2:5337:: with SMTP id f23mr694532lfh.15.1561604060440;
 Wed, 26 Jun 2019 19:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561595111.git.jpoimboe@redhat.com> <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
 <CAADnVQ+veayfD70Xsu8UnNrLdRW6rh9jxPb=OGoiYT-O=_zW=A@mail.gmail.com> <20190627024700.q4rkcbhmrna6ev4y@treble>
In-Reply-To: <20190627024700.q4rkcbhmrna6ev4y@treble>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 26 Jun 2019 19:54:08 -0700
Message-ID: <CAADnVQJRs9NdHgGiAZfzCLb=eWAPD03-+uf3fisLZrKZUSSoyg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] objtool: Add support for C jump tables
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 7:47 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Jun 26, 2019 at 06:42:40PM -0700, Alexei Starovoitov wrote:
> > > @@ -1035,9 +1038,18 @@ static struct rela *find_switch_table(struct objtool_file *file,
> > >
> > >                 /*
> > >                  * Make sure the .rodata address isn't associated with a
> > > -                * symbol.  gcc jump tables are anonymous data.
> > > +                * symbol.  GCC jump tables are anonymous data.
> > > +                *
> > > +                * Also support C jump tables which are in the same format as
> > > +                * switch jump tables.  Each jump table should be a static
> > > +                * local const array named "jump_table" for objtool to
> > > +                * recognize it.
> >
> > Nacked-by: Alexei Starovoitov <ast@kernel.org>
> >
> > It's not acceptable for objtool to dictate kernel naming convention.
>
> Abrasive nack notwithstanding, I agree it's not ideal.
>
> How about the following approach instead?  This is the only other way I
> can think of to annotate a jump table so that objtool can distinguish
> it:
>
> #define __annotate_jump_table __section(".jump_table.rodata")
>
> Then bpf would just need the following:
>
> -       static const void *jumptable[256] = {
> +       static const void __annotate_jump_table *jumptable[256] = {
>
> This would be less magical and fragile than my original approach.
>
> I think the jump table would still be placed with all the other rodata,
> like before, because the vmlinux linker script recognizes the section
> ".rodata" suffix and bundles them all together.

I like it if that works :)
Definitely cleaner.
May be a bit more linker script magic would be necessary,
but hopefully not.
And no need to rely on gcc style of mangling static vars.
