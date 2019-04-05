Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C51C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468C421738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sQRvFXWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfDENuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:50:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46975 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfDENua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:50:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so3310848pfj.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IQHcKnKeKdkVOr4ZdokFjgAD0qFsrMe0GjJE2cNLqmc=;
        b=sQRvFXWJsLg8ToY6Cm/tmnaPd60dEpAthnHwvS16eAw6FSh9qpTOBD+CyBUMz4qleN
         sN9mAmlZGOYHbw8co9375XIZmHo/hQQCf4LDijeCxHDehwJRoJ8Zr8kkgRKtsSCvJKCX
         36tsDbsJ0yyJeluSGrZw+K8l8ppdWEKzGrvcqybBbpibPyNpeRD98uHG6dUXdJwE+fFX
         TSySgs7O5iqeWO6Dy4Vh+H/QmU2xbTtpX6MoC0DITBRIF3e4r7fwGj2Z8KufkkQ1F6Jw
         w9+ERbuGBhQ7PkbtQ4Syg0qHyqphcNBWiHeGoy9Illc0gARJU6fszIzrFkYbW0wjiuej
         FGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IQHcKnKeKdkVOr4ZdokFjgAD0qFsrMe0GjJE2cNLqmc=;
        b=NB3B6B9pERMmYil+eyeJmuM85YTPbFb4eFkjTccsKj1DC2yz9izFM8DiJaMpLH1Az+
         L+sOCVT1DWbORj94tg7WyOGgIRLd5wiYSW3IGzOsUX7kqcV4B6mhHP1QwWVqTZLfLSKQ
         3ReAdKq606uPSY6KABVKiy28OvJH0HU8T++Sy2hgJ2RTB9MN0Bcit0TOZ553yfJZNL6R
         PUG1Luz4/8khbstCzGy83v5598voh7wY7SUh0BQgIbctaeJbxo3cBYNbO5t4GJ4A8odC
         NxOJpgflwL3yPQJ+1/hfJ3xNKBx94zw3+A3IxbaDpmXwAau07UjelR5fFSF3jfLCYNQZ
         vdXA==
X-Gm-Message-State: APjAAAXtYHoDb+ppu2vc9CNlSUkuCHBVzI7ZeHVyMVSuKwYyf8s0JChp
        3fnAEMRBJvfyVKE8l33joKGJ1w==
X-Google-Smtp-Source: APXvYqyD7BjB/CjIBkCxiGWdlND5bxvcZ8oAaLrQoBOcbeKqj2p8nUbruIpRh1HvE7wimFaWjxsSzQ==
X-Received: by 2002:a63:7152:: with SMTP id b18mr12105327pgn.186.1554472228960;
        Fri, 05 Apr 2019 06:50:28 -0700 (PDT)
Received: from [172.20.4.37] ([66.111.127.100])
        by smtp.gmail.com with ESMTPSA id p189sm13931506pfg.184.2019.04.05.06.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 06:50:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base as GSBASE at the paranoid_entry
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <alpine.DEB.2.21.1904050007050.1802@nanos.tec.linutronix.de>
Date:   Fri, 5 Apr 2019 07:50:26 -0600
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DCF2089-98EC-42D3-96C3-6ECCDA0B18E2@amacapital.net>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-9-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de> <alpine.DEB.2.21.1904050007050.1802@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 5, 2019, at 2:35 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Mon, 25 Mar 2019, Thomas Gleixner wrote:
>>> On Fri, 15 Mar 2019, Chang S. Bae wrote:
>>> ENTRY(paranoid_exit)
>>>    UNWIND_HINT_REGS
>>>    DISABLE_INTERRUPTS(CLBR_ANY)
>>>    TRACE_IRQS_OFF_DEBUG
>>> +    ALTERNATIVE "jmp .Lparanoid_exit_no_fsgsbase",    "nop",\
>>> +        X86_FEATURE_FSGSBASE
>>> +    wrgsbase    %rbx
>>> +    jmp    .Lparanoid_exit_no_swapgs;
>>=20
>> Again. A few newlines would make it more readable.
>>=20
>> This modifies the semantics of paranoid_entry and paranoid_exit. Looking a=
t
>> the usage sites there is the following code in the nmi maze:
>>=20
>>    /*
>>     * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_ex=
it
>>     * as we should not be calling schedule in NMI context.
>>     * Even with normal interrupts enabled. An NMI should not be
>>     * setting NEED_RESCHED or anything that normal interrupts and
>>     * exceptions might do.
>>     */
>>    call    paranoid_entry
>>    UNWIND_HINT_REGS
>>=20
>>    /* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
>>    movq    %rsp, %rdi
>>    movq    $-1, %rsi
>>    call    do_nmi
>>=20
>>    /* Always restore stashed CR3 value (see paranoid_entry) */
>>    RESTORE_CR3 scratch_reg=3D%r15 save_reg=3D%r14
>>=20
>>    testl    %ebx, %ebx            /* swapgs needed? */
>>    jnz    nmi_restore
>> nmi_swapgs:
>>    SWAPGS_UNSAFE_STACK
>> nmi_restore:
>>    POP_REGS
>>=20
>> I might be missing something, but how is that supposed to work when
>> paranoid_entry uses FSGSBASE? I think it's broken, but if it's not then
>> there is a big fat comment missing explaining why.
>=20
> So this _is_ broken.
>=20
>   On entry:
>=20
>      rbx =3D rdgsbase()
>      wrgsbase(KERNEL_GS)
>=20
>   On exit:
>=20
>      if (ebx =3D=3D 0)
>           swapgs
>=20
> The resulting matrix:
>=20
>   |  ENTRY GS    | RBX        | EXIT        | GS on IRET    | RESULT
>   |        |        |        |        |
> 1 |  KERNEL_GS    | KERNEL_GS    | EBX =3D=3D 0    | USER_GS    | FAIL
>   |        |        |        |        |
> 2 |  KERNEL_GS    | KERNEL_GS    | EBX !=3D 0    | KERNEL_GS    | ok
>   |        |        |        |        |
> 3 |  USER_GS    | USER_GS    | EBX =3D=3D 0    | USER_GS    | ok
>   |        |        |        |        |
> 4 |  USER_GS    | USER_GS    | EBX !=3D 0    | KERNEL_GS    | FAIL
>=20
>=20
> #1 Just works by chance because it's unlikely that the lower 32bits of a
>   per CPU kernel GS are all 0.
>=20
>   But it's just a question of probability that this turns into a
>   non-debuggable once per year crash (think KASLR).
>=20
> #4 This can happen when the NMI hits the kernel in some other entry code
>   _BEFORE_ or _AFTER_ swapgs.
>=20
>   User space using GS addressing with GS[31:0] !=3D 0 will crash and burn.=

>=20
>  =20

Hi all-

In a previous incarnation of these patches, I complained about the use of SW=
APGS in the paranoid path. Now I=E2=80=99m putting my maintainer foot down. =
 On a non-FSGSBASE system, the paranoid path known, definitively, which GS i=
s where, so SWAPGS is annoying. With FSGSBASE, unless you start looking at t=
he RIP that you interrupted, you cannot know whether you have user or kernel=
 GSBASE live, since they can have literally the same value.  One of the nume=
rous versions of this patch compared the values and just said =E2=80=9Cwell,=
 it=E2=80=99s harmless to SWAPGS if user code happens to use the same value a=
s the kernel=E2=80=9D.  I complained that it was far too fragile.

So I=E2=80=99m putting my foot down. If you all want my ack, you=E2=80=99re g=
oing to save the old GS, load the new one with WRGSBASE, and, on return, you=
=E2=80=99re going to restore the old one with WRGSBASE. You will not use SWA=
PGS in the paranoid path.

Obviously, for the non-paranoid path, it all keeps working exactly like it d=
oes now.

Furthermore, if you folks even want me to review this series, the ptrace tes=
ts need to be in place.  On inspection of the current code (after the debacl=
e a few releases back), it appears the SETREGSET=E2=80=99s effect depends on=
 the current values in the registers =E2=80=94 it does not actually seem to r=
eliably load the whole state. So my confidence will be greatly increased if y=
our series first adds a test that detects that bug (and fails!), then fixes t=
he bug in a tiny little patch, then adds FSGSBASE, and keeps the test workin=
g.

=E2=80=94Andy=
