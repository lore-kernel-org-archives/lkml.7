Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D78C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466B24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HbNZO5uW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLTKaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:30:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36689 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:30:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id w1so11339669otg.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 02:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=znR2t9WVo02TVin3awRFyHfwvu+IfsYJ4HHatPXnQoY=;
        b=HbNZO5uWnC5A/WT4OxFlbs6v/a8KH8diI2a1vMPsjYdIA/S7KQmlChM7PwjI4yZ3kG
         JGHapqlmP7V2Pf/6ev6WHXXeMVLrc2qhRJ06vRWZrsgpXuvx6lJZ3YIgguB4BXrT3Lh5
         3WEMSttW0nVXIbSskMDksAt2K5AII93Io4Rs1p2CVcaQYXmdUwPdBVz5zPdwaw4YraS2
         /qejyLNmyiKnJJHgTMoVX9xMU8Cad2r5KJsYMF7OjNWifSnH2L59jfyGHdsnOs1I+28Y
         Ev/I//RX2NwRQSkSed/UR2UO6aN7pDIvctkE1IY5m4L/NXPdCNsMP7letzZjUOFxvam8
         FoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=znR2t9WVo02TVin3awRFyHfwvu+IfsYJ4HHatPXnQoY=;
        b=BM+gCzBUI0WwKNKRm3hUU4bZgUXozUlF861v2EZ4nCpdoxKeyf8A7glgb4E8lbwVwm
         y/UY3lJ4eIQgkgFSZ9pjhEKsqmbabQ9+I5257A8krjda1DrEf+oV4vmU+lUhU1jbxc7c
         7z+1yuQxd9pDJf2xgQ6RrOALu0AYAUeFXgXydvcxatI+gXY7xx0lwmPypNt+7Hp41BcY
         f+49dCfIgh2M/DvgZHc7enCaB8HAGtso9Fzl5iLIKV8CafWNdnNqR/BGNdnh1LMsOhzV
         9QPPX/xTdRjD+xj/iRz+wOBjs+ETN2pnQ+MxtLkjPeaSO2sdG+/4NARbgFRlOdgf6PuY
         Nohw==
X-Gm-Message-State: APjAAAVo96tYB+L3NIRFKrNyBCtY8yRoupCamfMNt+PplsNTix9CjWmo
        2Xh2pl8N8p2r1sHC2x7KyHKwtQ==
X-Google-Smtp-Source: APXvYqxGkNxo0M404i0Sl5XKzBYh6f6QDUgxzqIhk3CjY7dpCpJR3mzYIgJ2j3g2arJAlG7MVZU2Iw==
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr14560766otd.266.1576837823374;
        Fri, 20 Dec 2019 02:30:23 -0800 (PST)
Received: from [26.82.234.166] ([172.58.110.182])
        by smtp.gmail.com with ESMTPSA id b206sm3010027oif.30.2019.12.20.02.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 02:30:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: Remove force_iret()
Date:   Fri, 20 Dec 2019 18:30:19 +0800
Message-Id: <D890A7DA-542B-42A7-8F82-CDBA6EBCA958@amacapital.net>
References: <431a146f6461402da61d09fff155f35b@AcuMS.aculab.com>
Cc:     Brian Gerst <brgerst@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
In-Reply-To: <431a146f6461402da61d09fff155f35b@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2019, at 6:10 PM, David Laight <David.Laight@aculab.com> wrote:=

>=20
> =EF=BB=BFFrom: Brian Gerst
>> Sent: 20 December 2019 03:48
>>> On Thu, Dec 19, 2019 at 8:50 PM Andy Lutomirski <luto@kernel.org> wrote:=

>>>=20
>>> On Thu, Dec 19, 2019 at 3:58 AM Brian Gerst <brgerst@gmail.com> wrote:
>>>>=20
>>>> force_iret() was originally intended to prevent the return to user mode=
 with
>>>> the SYSRET or SYSEXIT instructions, in cases where the register state c=
ould
>>>> have been changed to be incompatible with those instructions.
>>>=20
>>> It's more than that.  Before the big syscall rework, we didn't restore
>>> the caller-saved regs.  See:
>>>=20
>>> commit 21d375b6b34ff511a507de27bf316b3dde6938d9
>>> Author: Andy Lutomirski <luto@kernel.org>
>>> Date:   Sun Jan 28 10:38:49 2018 -0800
>>>=20
>>>    x86/entry/64: Remove the SYSCALL64 fast path
>>>=20
>>> So if you changed r12, for example, the change would get lost.
>>=20
>> force_iret() specifically dealt with changes to CS, SS and EFLAGS.
>> Saving and restoring the extra registers was a different problem
>> although it affected the same functions like ptrace, signals, and
>> exec.
>=20
> Is it ever possible for any of the segment registers to refer to the LDT
> and for another thread to invalidate the entries 'very late' ?

Not in newer kernels, because the actual LDT is never modified.  Instead, LD=
T changes create a whole new LDT and propagate it with an IPI.

But the IRET path can fail due to changes to the selectors while in the kern=
el, due to sigreturn or ptrace.  We have delightful selftests for this.

>=20
> So even though the values were valid when changed, they are
> invalid during the 'return to user' sequence.
>=20
> I remember writing a signal handler that 'corrupted' all the
> segment registers (etc) and fixing the NetBSD kernel to handle
> all the faults restoring the segment registers and IRET faulting
> in kernel (IIRC invalid user %SS or %CS).
> (IRET can also fault in user space, but that is a normal fault.)

Did you remember to test the #NP case?  Many kernels forgot that this was po=
ssible :)

>=20
> Is it actually cheaper to properly validate the segment registers,
> or take the 'hit' of the slightly slower IRET path and get the cpu
> to do it for you?
>=20
>=20

The validation we=E2=80=99re talking about is for SYSRET, not IRET.  It has i=
ts own set of nasty conditions involving EFLAGS, R11, RIP, and RCX.  Fortuna=
tely no segments are involved. The algorithm is, roughly:

if (okay for SYSRET) {
  SYSRET (and assume it can=E2=80=99t fail)
} else {
  if (need ESPFIX)
   Horrible hacks;
  IRET;
}

And we handle #GP, #SS, #NP and #DF from IRET. And we have selftests for all=
 of this. And no one runs the bloody selftests on 32-bit kernels, resulting i=
n truly awful bugs.

We can=E2=80=99t handle #GP from SYSRET. Thanks, Intel.

(AMD gets this more right. SYSRET is still a turd, but it can=E2=80=99t faul=
t. Intel handles RIP canonical checks differently from AMD, and SYSRET will #=
GP if RCX is noncanonical.  The result was privilege escalation on basically=
 every OS when this was noticed.)=
