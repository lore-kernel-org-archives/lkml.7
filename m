Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181C02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="N3P9uzwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfDJETO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:19:14 -0400
Received: from mail.efficios.com ([167.114.142.138]:46880 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfDJETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:19:14 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6E0B71D5DB9;
        Wed, 10 Apr 2019 00:19:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Y4MK6Qss9iHY; Wed, 10 Apr 2019 00:19:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EC03F1D5DB2;
        Wed, 10 Apr 2019 00:19:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EC03F1D5DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554869952;
        bh=P1be2QuHcXmSKkEp0bnHwLJ0vWLY2Q+AcekntuqYb+k=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=N3P9uzwS+8Ok9LpfIED3YyJbPJBaahMcGd1mhH3KfC3ypZltLvFUy7f758xHSKnW6
         3e7CKP0cHTTcdb98r1IhW5dUQetTcm/+cOW3w9plbO8pIGSpwggV5dldZ4TYIknyB5
         yfhUcy4cpNPyHRrw3Dd6LNzjo2nalnC7I/qXYLZ+NFpFdlepWR7DwhBWZYZ7QMQiXb
         BXksirjCe1mU9oPjOc5mKfFDJQIOJTU5sGMiS+357a9PMcVoTya2MywnJHKxmR9rmF
         +nb4INXuiWbELVon3nN+DerY34ys/HCflQ1hqWpn+q1muJtDuxwFcyBl+MQaMCFxkP
         7fGZyXhjhzN9g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id xG3RtqsBRQLD; Wed, 10 Apr 2019 00:19:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C844D1D5DAB;
        Wed, 10 Apr 2019 00:19:11 -0400 (EDT)
Date:   Wed, 10 Apr 2019 00:19:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Zack Weinberg <zackw@panix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>, x86 <x86@kernel.org>
Message-ID: <611494911.2833.1554869951745.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrUScoGHPP9avQDSWhfJtxrSxFYy0z=AQNM-61ECLUK+PA@mail.gmail.com>
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com> <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com> <CAKCAbMi6ZM0ehUrjxNfjR+SV_Xv_x7JkMjvB9nEVH=31JHNEPg@mail.gmail.com> <CALCETrUScoGHPP9avQDSWhfJtxrSxFYy0z=AQNM-61ECLUK+PA@mail.gmail.com>
Subject: Re: rseq/x86: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/x86: choosing rseq code signature
Thread-Index: pRP9qI+xDgT7AqIPE0pOUiK7D/NL0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 9, 2019, at 9:57 PM, Andy Lutomirski luto@kernel.org wrote:

> On Tue, Apr 9, 2019 at 5:51 PM Zack Weinberg <zackw@panix.com> wrote:
>>
>> On Tue, Apr 9, 2019 at 4:43 PM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>> > ----- On Apr 9, 2019, at 3:32 PM, Mathieu Desnoyers
>> > mathieu.desnoyers@efficios.com wrote:
>> > >
>> > > We are about to include the code signature required prior to restartable
>> > > sequences abort handlers into glibc, which will make this ABI choice final.
>> > > We need architecture maintainer input on that signature value.
>> > >
>> > > That code signature is placed before each abort handler, so the kernel can
>> > > validate that it is indeed jumping to an abort handler (and not some
>> > > arbitrary attacker-chosen code). The signature is never executed.
>> > >
>> > > Currently, tools/testing/selftests/rseq/rseq-x86.h defines RSEQ_SIG
>> > > as 0x53053053, and uses it as an immediate operand to the following
>> > > instruction opcodes (as suggested by Andy Lutomirski):
>> > >
>> > > x86-32:
>> > > - .byte 0x0f, 0x1f, 0x05: nopl <sig>
>> > >
>> > > x86-64:
>> > > - .byte 0x0f, 0x1f, 0x05: nopl <sig>(%rip)
>> > >
>> > > The current discussion thread on the glibc mailing list leads us towards
>> > > using a trap with uncommon immediate operand, which simplifies integration
>> > > with disassemblers, emulators, makes it easier to debug if the control
>> > > flow gets redirected there by mistake, and is nicer for some architecture's
>> > > speculative execution.
>> ...
>> > Peter Zijlstra suggested to use "invlpg" in user-space, which should generate
>> > a trap. The only concern would be emulators, but ideally they would not try to
>> > decode an instruction that is never executed. This would lead to the following
>> > patch. Any objections/ack ?
>> ...
>> > +/*
>> > + * RSEQ_SIG is used with the following privileged instructions, which trap in
>> > user-space:
>> > + * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
>> > + * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
>> > + */
>> >  #define RSEQ_SIG       0x53053053
>>
>> On x86, you have to worry about what happens if control flow gets
>> redirected to an arbitrary byte address.  The proposed sequence `0f 01
>> 3d 53 30 05 53` is a trap instruction if control lands seven bytes
>> before the beginning of the abort handler, but if it lands anywhere
>> _else_ within the marker sequence, you get one of these instruction
>> sequences, none of which trap, all but one of which will corrupt the
>> process state, and three of which will consume three bytes from the
>> beginning of the abort handler's code, continuing execution with a
>> misaligned PC:
>>
>>     01 3d 53 30 05 53        add %edi,0x53053053(%rip)
>>     3d 53 30 05 53           cmp $0x53053053,%eax
>>     53 30 05 53 XX XX XX     push %rbx; xor %al,0xXXXXXX78(%rip)
>>     30 05 53 XX XX XX        xor %al,0xXXXXXX78(%rip)
>>     05 53 XX XX XX           add $0xXXXXXX53,%eax
>>     53                       push %rbx
>>
>> So I'm going to suggest instead the four-byte sequence CD CF CD CF.
>> That's INT $0xCF if control lands either two or four bytes before the
>> beginning of the abort handler, and IRET if it lands one or three
>> bytes before.  I believe both of these possibilities are currently
>> also forbidden in user mode.  It doesn't need to be longer, does it?
>>
> 
> IRET works in user mode just fine.  Why are you concerned about
> landing in the middle of the signature?  A misaligned jump into code
> is screwy pretty much no matter what.  It does seem genuinely useful
> to trap if you accidentally fall through to the beginning of the
> signature, but I don't see the point of worrying about jumping to the
> middle.
> 
> There's some argument that, for consistency with CET, the last couple
> bytes of the signature should match ENDBR.
> 
> Mathieu, how many bytes do we have for the signature?

The signature is 4 bytes. Those 4 bytes need to be uncommon.
You can have a longer instruction than that, but then the
additional bytes at the beginning of the instruction will
not be part of the signature per se.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
