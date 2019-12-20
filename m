Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F00C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01E2206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="VmdN32C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLTVUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:20:53 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45328 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTVUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:20:53 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so1319635oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9Qnmp0WI/wJPh5obkk1eDEi0Xc1HmFywljm1WZKRD54=;
        b=VmdN32C+3faE2DeglNJ2zDUowKjP03iZiRJy1BWyUMp2kNO7p0RHDaRvQQFqs/HURe
         ILXuVhylyKt7wb20SZYWfC9uGAHzFCq5WPih4QMncAEVOlk++e1Ypt7aQqxmsMT3yD4j
         36CxC4W0ALOHxaOxIqrEK2F1GZCnv+Zfqsrm13SAIG1OxWSDY7auUPDcsPijHW7xw/UZ
         R7KqAIbIBgBhNki4cidE5XxyU9Zg6mb1mBwv0shtQKxfGktY1nVym73u/k3c4HtjADcV
         Id1GIuy3gIGspl3G7KGMGkAwUni3RqIsC6Q4KRWVPeRLiHeLLOho5cSqpVOToQDU7KFN
         wTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9Qnmp0WI/wJPh5obkk1eDEi0Xc1HmFywljm1WZKRD54=;
        b=lTyT9jgRbjSYrIJE5KTZFvEGL7SRT5NbMz6afFI2tIHe/3ixj6gGCj33aTpRSU277z
         FWM2ebjGfZqlZP9X3lbKwmtBOce8/ls52G6DB9rCrh0hv/S+NXzYCX7lBupfq4y5Ie9q
         GKLNEmlDzveYefqGNsPi4SwyjvU3SB8bbgIRu03tlL6fGR7n8Ae1IlJ3BcVC/4Mvq7mG
         IgzpRNALmNn4vfNfzZB2TfonKb4kWStyFabWcehs2Sz58aDlvXX1t5HrtgTkv2/OdtJZ
         Lsd59KmFXmNUY+oxD4jw4VskcQ6J4dJq1irUQvMRV+W16PjZpIfhOI/dE3/z0lM9UfTm
         100A==
X-Gm-Message-State: APjAAAVL/IhEB8FGfnE8S04Vne+fDFkjtHPwNTYNWPxcuGJp7nXL+rgH
        uU62PB9F02H5DDqYxsnFSQa9uQ==
X-Google-Smtp-Source: APXvYqx5CXpDGFWd07MxIxOkmCrgSCU+qG1n8l8D1GpIN60/Wzmaj8zotokOH8zdfBTWDwFJfz79SA==
X-Received: by 2002:a05:6808:3d0:: with SMTP id o16mr1542733oie.79.1576876851262;
        Fri, 20 Dec 2019 13:20:51 -0800 (PST)
Received: from [26.82.234.166] ([172.58.110.182])
        by smtp.gmail.com with ESMTPSA id a15sm3951509otn.64.2019.12.20.13.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 13:20:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: Remove force_iret()
Date:   Sat, 21 Dec 2019 05:20:46 +0800
Message-Id: <A5CA1E6B-B755-4F5A-8813-10713C1C192C@amacapital.net>
References: <227c8442919d44a790370870aaba416c@AcuMS.aculab.com>
Cc:     Brian Gerst <brgerst@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
In-Reply-To: <227c8442919d44a790370870aaba416c@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 20, 2019, at 6:59 PM, David Laight <David.Laight@aculab.com> wrote:=

>=20
> =EF=BB=BFFrom: Andy Lutomirski
>> Sent: 20 December 2019 10:30
>>>> On Dec 20, 2019, at 6:10 PM, David Laight <David.Laight@aculab.com> wro=
te:
>>>=20
>>> =EF=BB=BFFrom: Brian Gerst
>>>> Sent: 20 December 2019 03:48
>>>>> On Thu, Dec 19, 2019 at 8:50 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
>>>>>=20
>>>>> On Thu, Dec 19, 2019 at 3:58 AM Brian Gerst <brgerst@gmail.com> wrote:=

>>>>>>=20
>>>>>> force_iret() was originally intended to prevent the return to user mo=
de with
>>>>>> the SYSRET or SYSEXIT instructions, in cases where the register state=
 could
>>>>>> have been changed to be incompatible with those instructions.
>>>>>=20
>>>>> It's more than that.  Before the big syscall rework, we didn't restore=

>>>>> the caller-saved regs.  See:
>>>>>=20
>>>>> commit 21d375b6b34ff511a507de27bf316b3dde6938d9
>>>>> Author: Andy Lutomirski <luto@kernel.org>
>>>>> Date:   Sun Jan 28 10:38:49 2018 -0800
>>>>>=20
>>>>>   x86/entry/64: Remove the SYSCALL64 fast path
>>>>>=20
>>>>> So if you changed r12, for example, the change would get lost.
>>>>=20
>>>> force_iret() specifically dealt with changes to CS, SS and EFLAGS.
>>>> Saving and restoring the extra registers was a different problem
>>>> although it affected the same functions like ptrace, signals, and
>>>> exec.
>>>=20
>>> Is it ever possible for any of the segment registers to refer to the LDT=

>>> and for another thread to invalidate the entries 'very late' ?
>>=20
>> Not in newer kernels, because the actual LDT is never modified.
>> Instead, LDT changes create a whole new LDT and propagate it with an IPI.=

>=20
> Can the IPI be disabled through the SYSRET path?

There=E2=80=99s a whole dance in prepare_exit_to_usermode().  We turn off in=
terrupts, then check for pending work (which does not include this IPI, but i=
ncludes plenty of other nasty things), and we keep interrupts off until we a=
re in user mode.

> Once in user space, the IPI will interrupt the process and, I presume, it w=
ill
> pick up the new LDT on 'return to user'.

The new LDT is picked up in the IPI callback.

> But if the IPI happens between the LDT being set and SYSRET it will (presu=
mably)
> remain 'pending' until the next system call?
> Which could be long enough for one thread to have passed a pointer across g=
iving
> an unexpected SEGV (or maybe worse, failing to give an expected one).

modify_ldt() won=E2=80=99t return until all threads have the new LDT.=
