Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155ACC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C402173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kucOejN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390505AbfHHWSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:18:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44634 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390340AbfHHWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:18:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so70105035qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QLZzrW7ZdQW83kYujBZ//d/WvY4fqGhP4bcyYPW9Wjc=;
        b=kucOejN1r5TWtNxTNxQFaC04oKgS96Oev3tr4Te4PVP6k4yXz623fypMLZr3/X8yv8
         yYIZzly2I5mO16T9Xl4GiHeCWVocTvBvWrz0P/QIePxoblkfu0eX5Ws/NOPaIle6ZfaH
         4FvFr6jV8rB20loX4dga6EWpUnjbDEUZz7OkphtQYVl/GGHPa3AR7Hxg5pjGYAk67Udz
         KgjiRyeWagUouAiQE/Rsu/7DKT3msHJmkYywIa0hODPn31BQxsM4a9VHlwesc0BeIBsS
         uc7Jg2+dc08wTv03vOzZX3A+2Ev1F/TCQSd+hza4KTbN1Hp+6r2yylCI0vzoFr8E69Cn
         tGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QLZzrW7ZdQW83kYujBZ//d/WvY4fqGhP4bcyYPW9Wjc=;
        b=jyHVlY+WoNIdeRYepSCFW458FGIzq/8jQsJBCpMc5rl3PTveJIS2HWNebmZ2h9T2ej
         zpWgGw/cdQ+JPzszI/TtaUPUFo4HBii882mtKTAD6UKD3nljblsR7AuU0iV1XnBZ4NU7
         UZ4uUEvZKmC1CduCElsZW6vr1JvbL6e0O3HJ37emkOkfodp/vGCgBWPegWuhMJb02seh
         ZZOjnyfA/lsyRcM3t/wEnZkhTKCm9XvpF7k6Ey9iDMqqrjx34sWzRCKJfvgXAhtrq6cz
         laFXuEMjyF9eawPQH5/Bh3rwHmeir+cCXZx08wrmVZ5nwbjHNdoDXTUduiBwjAzl9h1m
         xY6g==
X-Gm-Message-State: APjAAAWpRpa5tV2ecOgbRcOhmEh+QWjLjDMtmK4vogOoxcoZNC2416fE
        i1cJuHsp1QGGZvw38rezdlu3CQ==
X-Google-Smtp-Source: APXvYqxVYTQ1ShONsiy0DCWLZh4ngafA6BDzAMkeTZxXGi0m+ojO6+oil5OC6CsuH6ZUxDOUw/zVsg==
X-Received: by 2002:a05:620a:70f:: with SMTP id 15mr15546578qkc.171.1565302721558;
        Thu, 08 Aug 2019 15:18:41 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u4sm41470668qkb.16.2019.08.08.15.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 15:18:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] arm64/cache: silence -Woverride-init warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190808103808.GC46901@lakrids.cambridge.arm.com>
Date:   Thu, 8 Aug 2019 18:18:39 -0400
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2A2F2B9-0563-4DF6-8E77-F191A768CE4E@lca.pw>
References: <20190808032916.879-1-cai@lca.pw>
 <20190808103808.GC46901@lakrids.cambridge.arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 8, 2019, at 6:38 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>=20
> On Wed, Aug 07, 2019 at 11:29:16PM -0400, Qian Cai wrote:
>> The commit 155433cb365e ("arm64: cache: Remove support for =
ASID-tagged
>> VIVT I-caches") introduced some compiation warnings from GCC (and
>> Clang) with -Winitializer-overrides),
>>=20
>> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
>> overwritten [-Woverride-init]
>> [ICACHE_POLICY_VIPT]  =3D "VIPT",
>>                        ^~~~~~
>> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
>> 'icache_policy_str[2]')
>> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
>> overwritten [-Woverride-init]
>> [ICACHE_POLICY_PIPT]  =3D "PIPT",
>>                        ^~~~~~
>> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
>> 'icache_policy_str[3]')
>> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
>> overwritten [-Woverride-init]
>> [ICACHE_POLICY_VPIPT]  =3D "VPIPT",
>>                         ^~~~~~~
>> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
>> 'icache_policy_str[0]')
>>=20
>> because it initializes icache_policy_str[0 ... 3] twice. Since
>> arm64 developers are keen to keep the style of initializing a static
>> array with a non-zero pattern first, just disable those warnings for
>> both GCC and Clang of this file.
>>=20
>> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged =
VIVT I-caches")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>=20
> This is _not_ a fix, and should not require backporting to stable =
trees.

=46rom my experience, the stable AI will pick up whatever they want to =
backport
not matter if there Is a =E2=80=9CFixes=E2=80=9D tag or not unless it is =
one of those subsystems like
Networking that exclusively manually flag for. backporting by the =
maintainer. =20

>=20
> What about all the other instances that we have in mainline?

I have not had a chance to review all instances yet. It is not unusually =
to fix one
warning at a time, and then go on fixing some more if time permit.

>=20
> I really don't think that we need to go down this road; we're just =
going
> to end up adding this to every file that happens to include a header
> using this scheme=E2=80=A6

How about disable them this way in a top level like arch/arm64/Makefile =
or
arch/arm64/kernel/Makefile? Therefore, there is no need to add this to
every file, but with a drawback that it could miss a few real issues =
there
in the future which probably not many people are checking for them of
the arm64 subsystem nowadays.

>=20
> Please just turn this off by default for clang.

As mentioned before, it is very valuable to run =E2=80=9Cmake W=3D1=E2=80=9D=
 given it found
many real developer mistakes which will enable =E2=80=9C-Woverride-init=E2=
=80=9D for both
compilers. Even =E2=80=9C-Woverride-init=E2=80=9D itself is useful find =
real issues as in,

ae5e033d65a (=E2=80=9Cmfd: rk808: Fix RK818_IRQ_DISCHG_ILIM =
initializer=E2=80=9D)
32df34d875bb (=E2=80=9C[media] rc: img-ir: jvc: Remove unused no-leader =
timings=E2=80=9D)

Especially, to find redundant initializations in large structures. e.g.,

e6ea0b917875 (=E2=80=9C[media] dvb_frontend: Don't declare values twice =
at a table=E2=80=9D)

It is important to keep the noise-level as low as possible by keeping =
the
amount of false positives under control to be truly benefit from those
valuable compiler warnings.=20

>=20
> If we want to enable this, we need a mechanism to permit overridable
> assignments as we use range initializers for.

I am not sure that it is worth filling a RFE for compilers of that =
feature.
I feel like the range initializers just another way to initialize an =
array, and
 it is just easier to make mistakes with unintended =
double-initializations.
The compiler developers probably recommend to enforce more of
=E2=80=9C-Woverride-init=E2=80=9D for  the range initializers rather =
than permitting it.

>=20
> Thanks,
> Mark.
>=20
>> ---
>> arch/arm64/kernel/Makefile | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 478491f07b4f..397ed5f7be1e 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -11,6 +11,9 @@ CFLAGS_REMOVE_ftrace.o =3D $(CC_FLAGS_FTRACE)
>> CFLAGS_REMOVE_insn.o =3D $(CC_FLAGS_FTRACE)
>> CFLAGS_REMOVE_return_address.o =3D $(CC_FLAGS_FTRACE)
>>=20
>> +CFLAGS_cpuinfo.o +=3D $(call cc-disable-warning, override-init)
>> +CFLAGS_cpuinfo.o +=3D $(call cc-disable-warning, =
initializer-overrides)
>> +
>> # Object file lists.
>> obj-y			:=3D debug-monitors.o entry.o irq.o =
fpsimd.o		\
>> 			   entry-fpsimd.o process.o ptrace.o setup.o =
signal.o	\
>> --=20
>> 2.20.1 (Apple Git-117)

