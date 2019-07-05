Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E98C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D26320843
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfGEUSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:18:03 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:28118 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:18:02 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: iyBg88caDLISw+Jsz4crYchtylLUuqOz1SbOTMEvFVWAV+t4dfhmoqHoaPZZoQXk7P/XvFagr1
 guGLpKcwMbP4oXip0PTpGOWeD6Wu4mE8I1x0tqz6TRrhquh7R5fF+Lxmpm8vi6BqsYCRuQZfAq
 IscpyxsooZnPQ+aOTJl022Q/1B7vBxbYnJawzH+ZTDEbgXjLKMxjzBXLkH/GAoGtH1dihDayib
 XMeIUVJVekoJuDiUT0l3pb5a0UQLQnPQm4BtncVDSiOah9c9Z9+mBZRwpPimiMzs1oEjWRp3uJ
 q48=
X-SBRS: 2.7
X-MesageID: 2658662
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,456,1557201600"; 
   d="scan'208";a="2658662"
Subject: Re: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more
 robust
To:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
References: <20190704155145.617706117@linutronix.de>
 <20190704155608.636478018@linutronix.de>
 <958a67c2-4dc0-52e6-43b2-1ebd25a59232@citrix.com>
 <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Autocrypt: addr=andrew.cooper3@citrix.com; prefer-encrypt=mutual; keydata=
 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
 6+ahAA==
Message-ID: <40db3bec-6dbb-4957-f50f-b72b0920885f@citrix.com>
Date:   Fri, 5 Jul 2019 21:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CALCETrVomGF-OmWxdaX9axih1kz345rEFop=vZtcKwGR8U-gwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2019 20:06, Andy Lutomirski wrote:
> On Fri, Jul 5, 2019 at 8:47 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 04/07/2019 16:51, Thomas Gleixner wrote:
>>>   2) The loop termination logic is interesting at best.
>>>
>>>      If the machine has no TSC or cpu_khz is not known yet it tries 1
>>>      million times to ack stale IRR/ISR bits. What?
>>>
>>>      With TSC it uses the TSC to calculate the loop termination. It takes a
>>>      timestamp at entry and terminates the loop when:
>>>
>>>         (rdtsc() - start_timestamp) >= (cpu_hkz << 10)
>>>
>>>      That's roughly one second.
>>>
>>>      Both methods are problematic. The APIC has 256 vectors, which means
>>>      that in theory max. 256 IRR/ISR bits can be set. In practice this is
>>>      impossible as the first 32 vectors are reserved and not affected and
>>>      the chance that more than a few bits are set is close to zero.
>> [Disclaimer.  I talked to Thomas in private first, and he asked me to
>> post this publicly as the CVE is almost a decade old already.]
>>
>> I'm afraid that this isn't quite true.
>>
>> In terms of IDT vectors, the first 32 are reserved for exceptions, but
>> only the first 16 are reserved in the LAPIC.  Vectors 16-31 are fair
>> game for incoming IPIs (SDM Vol3, 10.5.2 Valid Interrupt Vectors).
>>
>> In practice, this makes Linux vulnerable to CVE-2011-1898 / XSA-3, which
>> I'm disappointed to see wasn't shared with other software vendors at the
>> time.
>>
>> Because TPR is 0, an incoming IPI can trigger #AC, #CP, #VC or #SX
>> without an error code on the stack, which results in a corrupt pt_regs
>> in the exception handler, and a stack underflow on the way back out,
>> most likely with a fault on IRET.
>>
>> These can be addressed by setting TPR to 0x10, which will inhibit
>> delivery of any errant IPIs in this range, but some extra sanity logic
>> may not go amiss.  An error code on a 64bit stack can be spotted with
>> `testb $8, %spl` due to %rsp being aligned before pushing the exception
>> frame.
> Several years ago, I remember having a discussion with someone (Jan
> Beulich, maybe?) about how to efficiently make the entry code figure
> out the error code situation automatically.  I suspect it was on IRC
> and I can't find the logs.

It was on IRC, but I don't remember exactly when, either.

> I'm thinking that maybe we should just
> make Linux's idtentry code do something like this.
>
> If nothing else, we could make idtentry do:
>
> testl $8, %esp   /* shorter than testb IIRC */

Sadly not.  test (unlike cmp and the basic mutative opcodes) doesn't
have a sign-extendable imm8 encoding.  The two options are:

f7 c4 08 00 00 00        test   $0x8,%esp
40 f6 c4 08              test   $0x8,%spl

> jz 1f  /* or jnz -- too lazy to figure it out */
> pushq $-1
> 1:

It is jz, and Xen does use this sequence for reserved/unimplemented
vectors, but we expect those codepaths never to be executed.

>
> instead of the current hardcoded push.  The cost of a mispredicted
> branch here will be smallish compared to the absurdly large cost of
> the entry itself.  But I thought I had something more clever than
> this.  This sequence works, but it still feels like it should be
> possible to do better:
>
> .macro PUSH_ERROR_IF_NEEDED
>     /*
>      * Before the IRET frame is pushed, RSP is aligned to a 16-byte
>      * boundary.  After SS .. RIP and the error code are pushed, RSP is
>      * once again aligned.  Pushing -1 will put -1 in the error code slot
>      * (regs->orig_ax) if there was no error code.
>     */
>
>     pushq    $-1                /* orig_ax = -1, maybe */
>     /* now RSP points to orig_ax (aligned) or di (misaligned) */
>     pushq    $0
>     /* now RSP points to di (misaligned) or si (aligned) */
>     orq    $8, %rsp
>     /* now RSP points to di */
>     addq    $8, %rsp
>     /* now RSP points to orig_ax, and we're in good shape */
> .endm
>
> Is there a better sequence for this?

The only aspect I can think of is whether mixing the push/pops with
explicit updates updates to %rsp is better or worse than a very well
predicted branch, given that various frontends have special tracking to
reduce instruction dependencies on %rsp.  I'll have to defer to the CPU
microachitects as to which of the two options is the lesser evil.

That said, both Intel and AMD's Optimisation guides have stack alignment
suggestions which mix push/sub/and on function prolog, so I expect this
is as optimised as it can reasonably be in the pipelines.

>> Another interesting problem is an IPI which its vector 0x80.  A cunning
>> attacker can use this to simulate system calls from unsuspecting
>> positions in userspace, or for interrupting kernel context.  At the very
>> least the int0x80 path does an unconditional swapgs, so will try to run
>> with the user gs, and I expect things will explode quickly from there.
> At least SMAP helps here on non-FSGSBASE systems.  With FSGSBASE, I
> suppose we could harden this by adding a special check to int $0x80 to
> validate GSBASE.
>
>> One option here is to look at ISR and complain if it is found to be set.
> Barring some real hackery, we're toast long before we get far enough to do that.

Even if the path moves to be like a regular idtentry?  How much more
expensive is that in reality?  Ultimately, it is that which needs to be
weighed against any extra wanted robustness.

~Andrew
