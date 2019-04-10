Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E609C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6702133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554861446;
	bh=gfUIgnIg/DHbb+LXfQC2ld5G3sGfQ2zlEpyNZs+QkPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DUvwMsfhzbh/f/PlMXVSEjuPH8JbZfjfFtBJGXcEDRNDNarZ349zJ8IQNwzfGlJdA
	 KU86C30uw3DsTkn0zYTTMaHtDJx9Q25qM86vUDhZnWXxW6vpSulox4kGjSc9oBDwLU
	 NW6AGbbhFrxVEIHRhsr9LsE6/mB4VLm/GXBFkwmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfDJB5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDJB5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:57:24 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5380221906
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554861442;
        bh=gfUIgnIg/DHbb+LXfQC2ld5G3sGfQ2zlEpyNZs+QkPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qbkRJvZadStHyhvBxN2bQbWJHa65/wJ9QQEkZCzqUpiiZk2dRQjWOa92Jom5ItCWv
         TbqJDm+nRBbTZemkLO1cY7YYMp8kN3IB81EJa/KZkHfXxzzca5jkpCmJB6mQ4ApDJQ
         WJAkbt35vbeDz/7gPqbIBtvu3N8Qxdc5O11mB8jA=
Received: by mail-wm1-f42.google.com with SMTP id a184so744996wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 18:57:22 -0700 (PDT)
X-Gm-Message-State: APjAAAXU+NnOhRMXZty5LTwGpmmz3ER7A3j7m+txCbSf+g8VDczGlFAw
        5uMFkd7VO1oGYktHsYc/VPKTJ7dR3krcN7WPO8mzWA==
X-Google-Smtp-Source: APXvYqy8mLS7kzCqEylDkldQ+x0gjOdQfq8SxRihVVph8iN0kVVAPxRDKXQPUs96f7qtM+C026H4/4vrWcKXr1B0yFc=
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr847752wmh.9.1554861440757;
 Tue, 09 Apr 2019 18:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com>
 <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com> <CAKCAbMi6ZM0ehUrjxNfjR+SV_Xv_x7JkMjvB9nEVH=31JHNEPg@mail.gmail.com>
In-Reply-To: <CAKCAbMi6ZM0ehUrjxNfjR+SV_Xv_x7JkMjvB9nEVH=31JHNEPg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 9 Apr 2019 18:57:09 -0700
X-Gmail-Original-Message-ID: <CALCETrUScoGHPP9avQDSWhfJtxrSxFYy0z=AQNM-61ECLUK+PA@mail.gmail.com>
Message-ID: <CALCETrUScoGHPP9avQDSWhfJtxrSxFYy0z=AQNM-61ECLUK+PA@mail.gmail.com>
Subject: Re: rseq/x86: choosing rseq code signature
To:     Zack Weinberg <zackw@panix.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Carlos O'Donell" <carlos@redhat.com>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 5:51 PM Zack Weinberg <zackw@panix.com> wrote:
>
> On Tue, Apr 9, 2019 at 4:43 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > ----- On Apr 9, 2019, at 3:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> > >
> > > We are about to include the code signature required prior to restartable
> > > sequences abort handlers into glibc, which will make this ABI choice final.
> > > We need architecture maintainer input on that signature value.
> > >
> > > That code signature is placed before each abort handler, so the kernel can
> > > validate that it is indeed jumping to an abort handler (and not some
> > > arbitrary attacker-chosen code). The signature is never executed.
> > >
> > > Currently, tools/testing/selftests/rseq/rseq-x86.h defines RSEQ_SIG
> > > as 0x53053053, and uses it as an immediate operand to the following
> > > instruction opcodes (as suggested by Andy Lutomirski):
> > >
> > > x86-32:
> > > - .byte 0x0f, 0x1f, 0x05: nopl <sig>
> > >
> > > x86-64:
> > > - .byte 0x0f, 0x1f, 0x05: nopl <sig>(%rip)
> > >
> > > The current discussion thread on the glibc mailing list leads us towards
> > > using a trap with uncommon immediate operand, which simplifies integration
> > > with disassemblers, emulators, makes it easier to debug if the control
> > > flow gets redirected there by mistake, and is nicer for some architecture's
> > > speculative execution.
> ...
> > Peter Zijlstra suggested to use "invlpg" in user-space, which should generate
> > a trap. The only concern would be emulators, but ideally they would not try to
> > decode an instruction that is never executed. This would lead to the following
> > patch. Any objections/ack ?
> ...
> > +/*
> > + * RSEQ_SIG is used with the following privileged instructions, which trap in user-space:
> > + * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
> > + * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
> > + */
> >  #define RSEQ_SIG       0x53053053
>
> On x86, you have to worry about what happens if control flow gets
> redirected to an arbitrary byte address.  The proposed sequence `0f 01
> 3d 53 30 05 53` is a trap instruction if control lands seven bytes
> before the beginning of the abort handler, but if it lands anywhere
> _else_ within the marker sequence, you get one of these instruction
> sequences, none of which trap, all but one of which will corrupt the
> process state, and three of which will consume three bytes from the
> beginning of the abort handler's code, continuing execution with a
> misaligned PC:
>
>     01 3d 53 30 05 53        add %edi,0x53053053(%rip)
>     3d 53 30 05 53           cmp $0x53053053,%eax
>     53 30 05 53 XX XX XX     push %rbx; xor %al,0xXXXXXX78(%rip)
>     30 05 53 XX XX XX        xor %al,0xXXXXXX78(%rip)
>     05 53 XX XX XX           add $0xXXXXXX53,%eax
>     53                       push %rbx
>
> So I'm going to suggest instead the four-byte sequence CD CF CD CF.
> That's INT $0xCF if control lands either two or four bytes before the
> beginning of the abort handler, and IRET if it lands one or three
> bytes before.  I believe both of these possibilities are currently
> also forbidden in user mode.  It doesn't need to be longer, does it?
>

IRET works in user mode just fine.  Why are you concerned about
landing in the middle of the signature?  A misaligned jump into code
is screwy pretty much no matter what.  It does seem genuinely useful
to trap if you accidentally fall through to the beginning of the
signature, but I don't see the point of worrying about jumping to the
middle.

There's some argument that, for consistency with CET, the last couple
bytes of the signature should match ENDBR.

Mathieu, how many bytes do we have for the signature?
