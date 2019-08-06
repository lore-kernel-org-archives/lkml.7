Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11479C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A02070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Uu4acLVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfHFDuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:50:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42020 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfHFDuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:50:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so61811245qkm.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qh2aacRT20BlQ9A973K75nHXL1wZp2XTv3/9UF2XGxc=;
        b=Uu4acLVsnqEsAeS985J39078bIOn28lBSHW2elLI3mXoit8aw1ClcoRmBNcUtD81ho
         LPSW0bG6GIyt7oll53uGJ1l6R9/c58LRGxC2Ilifkc+u4mITBuKyfOibxq3XgjNVvzBd
         FkFiNNToE4pC9mMNEsjyrkrl3byLqw4XUbepKmypUV0nC7dx1VcSB1+0P2iFtNVWrWGv
         WnmOC2u74ZkMr+VXKzcqF/x0MkSqkh0O4cHaj8eK/mnnB2jh0k3KXSLnHXWZmht2lzAj
         i8Omq1y/kguQZo8hhZjpFg7RnF8aTOTnkCiHxiFQyjqyOWsu9WFscNjFLhEjLLSfdjhS
         tX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qh2aacRT20BlQ9A973K75nHXL1wZp2XTv3/9UF2XGxc=;
        b=FkOh/LQqMgRU6IGjn0PpIpgcgzjc4tsSSH0g8glQ+5nZP008DK26SSbNEl8muVAzFN
         NXE/Qj8OSrQoGMGNKMd43LO0OCNkY7wRP21S4dnpWNKa49fjHhYzwe2e/Mz0BwQ7bkAR
         Q4ZDGl5eIwCU1GG7rOPHDTbT12w7BvypIRO2BALsHJQRQIcOsu1oDF9ONEhQmK7kntl5
         FOweoGWuVUc7oMuWqJWV7A6YA64pNXoSey0qTPZ2Xz081fmuZySEM1Vgk7nKEz9Vzmpb
         2xLteeTz8RRJIVZTnEnXi9Tab/ZH6a2n46NEou+ALYZF75h/Jm8qZmgQOBIE44EJqZ8Z
         lC/g==
X-Gm-Message-State: APjAAAXG30DIC6lUvIkqxFO3V0Lnk3me7igsvNGS+AA0n4zjHVblx7Ao
        pTgPVZwfaLPzYCq8A9FzsS2Lpg==
X-Google-Smtp-Source: APXvYqy1hF8A4G+N7jc/1OxNxVeXSi6P8h94UymN35VEWiNWqQmEFyxp9KQaMN/eaxJgjRZWUuNpHA==
X-Received: by 2002:ae9:eb4e:: with SMTP id b75mr1395985qkg.478.1565063405483;
        Mon, 05 Aug 2019 20:50:05 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h18sm35493471qkk.93.2019.08.05.20.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 20:50:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] arm64/cache: fix -Woverride-init compiler warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190805140118.fys437oor2b2rnq5@willie-the-truck>
Date:   Mon, 5 Aug 2019 23:50:03 -0400
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <06613F4A-3DA7-4FF9-8616-52CB4BB58C48@lca.pw>
References: <1564759944-2197-1-git-send-email-cai@lca.pw>
 <20190805095256.ocgdb2yfhnbdz6kw@willie-the-truck>
 <771C4B4C-6D79-419D-9778-5DE1BFC67FBE@lca.pw>
 <20190805140118.fys437oor2b2rnq5@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 5, 2019, at 10:01 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Mon, Aug 05, 2019 at 07:47:37AM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On Aug 5, 2019, at 5:52 AM, Will Deacon <will@kernel.org> wrote:
>>>=20
>>> On Fri, Aug 02, 2019 at 11:32:24AM -0400, Qian Cai wrote:
>>>> The commit 155433cb365e ("arm64: cache: Remove support for =
ASID-tagged
>>>> VIVT I-caches") introduced some compiation warnings from GCC,
>>>>=20
>>>> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
>>>> overwritten [-Woverride-init]
>>>> [ICACHE_POLICY_VIPT]  =3D "VIPT",
>>>>                         ^~~~~~
>>>> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
>>>> 'icache_policy_str[2]')
>>>> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
>>>> overwritten [-Woverride-init]
>>>> [ICACHE_POLICY_PIPT]  =3D "PIPT",
>>>>                         ^~~~~~
>>>> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
>>>> 'icache_policy_str[3]')
>>>> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
>>>> overwritten [-Woverride-init]
>>>> [ICACHE_POLICY_VPIPT]  =3D "VPIPT",
>>>>                          ^~~~~~~
>>>> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
>>>> 'icache_policy_str[0]')
>>>>=20
>>>> because it initializes icache_policy_str[0 ... 3] twice.
>>>>=20
>>>> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged =
VIVT I-caches")
>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>> ---
>>>> arch/arm64/kernel/cpuinfo.c | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/arch/arm64/kernel/cpuinfo.c =
b/arch/arm64/kernel/cpuinfo.c
>>>> index 876055e37352..193b38da8d96 100644
>>>> --- a/arch/arm64/kernel/cpuinfo.c
>>>> +++ b/arch/arm64/kernel/cpuinfo.c
>>>> @@ -34,10 +34,10 @@
>>>> static struct cpuinfo_arm64 boot_cpu_data;
>>>>=20
>>>> static char *icache_policy_str[] =3D {
>>>> -	[0 ... ICACHE_POLICY_PIPT]	=3D "RESERVED/UNKNOWN",
>>>> +	[ICACHE_POLICY_VPIPT]		=3D "VPIPT",
>>>> +	[ICACHE_POLICY_VPIPT + 1]	=3D "RESERVED/UNKNOWN",
>>>> 	[ICACHE_POLICY_VIPT]		=3D "VIPT",
>>>> 	[ICACHE_POLICY_PIPT]		=3D "PIPT",
>>>> -	[ICACHE_POLICY_VPIPT]		=3D "VPIPT",
>>>=20
>>> I really don't like this patch. Using "[0 ... MAXIDX] =3D <default>" =
is a
>>> useful idiom and I think the code is more error-prone the way you =
have
>>> restructured it.
>>>=20
>>> Why are you passing -Woverride-init to the compiler anyway? There's =
only
>>> one Makefile that references that option, and it's specific to a =
pinctrl
>>> driver.
>>=20
>> Those extra warnings can be enabled by =E2=80=9Cmake W=3D1=E2=80=9D. =
=E2=80=9C-Woverride-init =E2=80=9C seems to be useful
>> to catch potential developer mistakes with unintented =
double-initializations. It is normal to
>> start to fix the most of false-positives first before globally =
enabling the flag by default just like
>> =E2=80=9C-Wimplicit-fallthrough=E2=80=9D mentioned in,
>>=20
>> https://lwn.net/Articles/794944/
>=20
> I think this case is completely different to the implicit fallthrough =
stuff.
> The solution there was simply to add a comment without restructuring =
the
> surrounding code. What your patch does here is actively make the code =
harder
> to understand.
>=20
> Initialising a static array with a non-zero pattern is a useful idiom =
and I
> don't think we should throw that away just to appease a silly compiler
> warning that appears only with non-default build options. Have a look =
at
> the way we use PERF_MAP_ALL_UNSUPPORTED in the Arm PMU code, for =
example.

Well, both GCC and Clang would generate warnings for those. Clang even =
enable this by
default,

=
https://releases.llvm.org/8.0.0/tools/clang/docs/DiagnosticsReference.html=
#winitializer-overrides

Assume compiler people are sane, I probably not call those are =
=E2=80=9Csilly=E2=80=9D.

