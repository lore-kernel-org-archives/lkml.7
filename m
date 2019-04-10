Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0ECC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5702721741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDJAvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:51:07 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:59008 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfDJAvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:51:07 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 44f5F21qTDz172F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 20:51:01 -0400 (EDT)
Received: by mail-oi1-f180.google.com with SMTP id l203so287117oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 17:51:01 -0700 (PDT)
X-Gm-Message-State: APjAAAWl1n0ax183gRV+XopO7eGJitxtqyQEEnOs4b7BkN0fT823BSYh
        pzPXX8gC2PcQEYUkOw+P8kK1J7lSj4E0lqBlb8g=
X-Google-Smtp-Source: APXvYqxQnAHJCwJJUj73t79jcs5OzTF3jyGbgFXWMJVziSS45HTPnc59qqg3N/+WLhOrk+Qvc5EisUsjQ8TQgSDzxx4=
X-Received: by 2002:aca:5387:: with SMTP id h129mr831258oib.52.1554857461021;
 Tue, 09 Apr 2019 17:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com> <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com>
In-Reply-To: <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com>
From:   Zack Weinberg <zackw@panix.com>
Date:   Tue, 9 Apr 2019 20:50:49 -0400
X-Gmail-Original-Message-ID: <CAKCAbMi6ZM0ehUrjxNfjR+SV_Xv_x7JkMjvB9nEVH=31JHNEPg@mail.gmail.com>
Message-ID: <CAKCAbMi6ZM0ehUrjxNfjR+SV_Xv_x7JkMjvB9nEVH=31JHNEPg@mail.gmail.com>
Subject: Re: rseq/x86: choosing rseq code signature
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Tue, Apr 9, 2019 at 4:43 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- On Apr 9, 2019, at 3:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> >
> > We are about to include the code signature required prior to restartable
> > sequences abort handlers into glibc, which will make this ABI choice final.
> > We need architecture maintainer input on that signature value.
> >
> > That code signature is placed before each abort handler, so the kernel can
> > validate that it is indeed jumping to an abort handler (and not some
> > arbitrary attacker-chosen code). The signature is never executed.
> >
> > Currently, tools/testing/selftests/rseq/rseq-x86.h defines RSEQ_SIG
> > as 0x53053053, and uses it as an immediate operand to the following
> > instruction opcodes (as suggested by Andy Lutomirski):
> >
> > x86-32:
> > - .byte 0x0f, 0x1f, 0x05: nopl <sig>
> >
> > x86-64:
> > - .byte 0x0f, 0x1f, 0x05: nopl <sig>(%rip)
> >
> > The current discussion thread on the glibc mailing list leads us towards
> > using a trap with uncommon immediate operand, which simplifies integration
> > with disassemblers, emulators, makes it easier to debug if the control
> > flow gets redirected there by mistake, and is nicer for some architecture's
> > speculative execution.
...
> Peter Zijlstra suggested to use "invlpg" in user-space, which should generate
> a trap. The only concern would be emulators, but ideally they would not try to
> decode an instruction that is never executed. This would lead to the following
> patch. Any objections/ack ?
...
> +/*
> + * RSEQ_SIG is used with the following privileged instructions, which trap in user-space:
> + * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
> + * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
> + */
>  #define RSEQ_SIG       0x53053053

On x86, you have to worry about what happens if control flow gets
redirected to an arbitrary byte address.  The proposed sequence `0f 01
3d 53 30 05 53` is a trap instruction if control lands seven bytes
before the beginning of the abort handler, but if it lands anywhere
_else_ within the marker sequence, you get one of these instruction
sequences, none of which trap, all but one of which will corrupt the
process state, and three of which will consume three bytes from the
beginning of the abort handler's code, continuing execution with a
misaligned PC:

    01 3d 53 30 05 53        add %edi,0x53053053(%rip)
    3d 53 30 05 53           cmp $0x53053053,%eax
    53 30 05 53 XX XX XX     push %rbx; xor %al,0xXXXXXX78(%rip)
    30 05 53 XX XX XX        xor %al,0xXXXXXX78(%rip)
    05 53 XX XX XX           add $0xXXXXXX53,%eax
    53                       push %rbx

So I'm going to suggest instead the four-byte sequence CD CF CD CF.
That's INT $0xCF if control lands either two or four bytes before the
beginning of the abort handler, and IRET if it lands one or three
bytes before.  I believe both of these possibilities are currently
also forbidden in user mode.  It doesn't need to be longer, does it?

zw
