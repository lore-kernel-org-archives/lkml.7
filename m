Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C82C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C5E20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob84DQ66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfD3WxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:53:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40666 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfD3WxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:53:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so7413415plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=bDztD/ujVpn8NFHqaBmoePCgiisBaSiTIMPziP0Fi7o=;
        b=ob84DQ66+PN+jmJEe9bawx9ajfBeBS0ZwkSg7XsXrPpkdyMWZl4lpCjjUf1uV5Pxqn
         +xYGWWQ9erdpom1KVqwLHl4RiBHrswQkt3IEXggZbG3agcWQ8Fn+kboeIt1d3+vi6W4D
         5rAPZozZ2fQf9FtDSws0CO3LzI61WA9ZdDm+rsFT7FrAj7wmdFe/fFzSFq84cGNoHH6M
         M2E0NXgbGMdBtedJeVBzQJtzIBQF9Yo7HKibYQdpqhchkTDhfbTZ6NSOGn+biBIBS5cS
         7D2CiAkqpDOuiOkxaERjtolAay5m+zQIN5zRr8EMvOAqITAcd+GeCTEBK/aWijVLqGU6
         tG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=bDztD/ujVpn8NFHqaBmoePCgiisBaSiTIMPziP0Fi7o=;
        b=gb4Db7ydf5wowcEckPjKfWegpuyBA8UgNoK4d8I9n89F1xXMpOIce8SvbqCq/riZJQ
         y9IDiUJ4ZbmycmieGXJ+JGDYuBtQj6J70mN2NGT9ELYdT08s4sh7Sxj16ui2EEFUhdF3
         56wxT2Ds+PE4JnseUWt3NY5VsucCdXEvESnRchIctL9+ScER1wQdJUwFdFkgYonE7Z2Y
         Od0b95P7T82zaA+seff6elf92Sl/yWzrTRHjx7Ku/ld7Mn2qZSbzkIa/GHA3+A4sRABT
         s/9i1R/XOh/Pji6Hjqf0zMyaab1MNqmNOMEAg3UUKY4OD4s8wGOkRjII6mZrrU8xFWlw
         11uA==
X-Gm-Message-State: APjAAAVQylFfMjEERFJPwq3fsKS71QIOLom60+7P5L6MtKhZC7oomOhg
        cTsjngJCoA4R1ob4MGH7PfY=
X-Google-Smtp-Source: APXvYqzxfVaCacRpduoD2Xwazbs85NCmpezPFY44gKLxahC3sY2HvIa6YLQ6tX0Wk4DmgXr6SlZm2g==
X-Received: by 2002:a17:902:a3:: with SMTP id a32mr1820708pla.111.1556664783054;
        Tue, 30 Apr 2019 15:53:03 -0700 (PDT)
Received: from localhost ([61.68.7.233])
        by smtp.gmail.com with ESMTPSA id i3sm52883816pfa.90.2019.04.30.15.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:53:01 -0700 (PDT)
Date:   Wed, 01 May 2019 08:52:55 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: vdso: drop unnecessary cc-ldoption
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <paulus@samba.org>
Cc:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190423211116.261111-1-ndesaulniers@google.com>
        <CAKwvOd=dBLXQUzv8R3-JqF=pUTH0-5O3v+_ceekT3W23VxtDbg@mail.gmail.com>
In-Reply-To: <CAKwvOd=dBLXQUzv8R3-JqF=pUTH0-5O3v+_ceekT3W23VxtDbg@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556664541.74fhfupxpn.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers's on May 1, 2019 6:25 am:
> On Tue, Apr 23, 2019 at 2:11 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> Towards the goal of removing cc-ldoption, it seems that --hash-style=3D
>> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
>> of binutils for the kernel according to
>> Documentation/process/changes.rst is 2.20.
>>
>> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
>> Cc: clang-built-linux@googlegroups.com
>> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> ---
>>  arch/powerpc/kernel/vdso32/Makefile | 5 ++---
>>  arch/powerpc/kernel/vdso64/Makefile | 5 ++---
>>  2 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/v=
dso32/Makefile
>> index ce199f6e4256..06f54d947057 100644
>> --- a/arch/powerpc/kernel/vdso32/Makefile
>> +++ b/arch/powerpc/kernel/vdso32/Makefile
>> @@ -26,9 +26,8 @@ GCOV_PROFILE :=3D n
>>  KCOV_INSTRUMENT :=3D n
>>  UBSAN_SANITIZE :=3D n
>>
>> -ccflags-y :=3D -shared -fno-common -fno-builtin
>> -ccflags-y +=3D -nostdlib -Wl,-soname=3Dlinux-vdso32.so.1 \
>> -               $(call cc-ldoption, -Wl$(comma)--hash-style=3Dboth)
>> +ccflags-y :=3D -shared -fno-common -fno-builtin -nostdlib \
>> +       -Wl,-soname=3Dlinux-vdso32.so.1 -Wl,--hash-style=3Dboth
>>  asflags-y :=3D -D__VDSO32__ -s
>>
>>  obj-y +=3D vdso32_wrapper.o
>> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/v=
dso64/Makefile
>> index 28e7d112aa2f..32ebb3522ea1 100644
>> --- a/arch/powerpc/kernel/vdso64/Makefile
>> +++ b/arch/powerpc/kernel/vdso64/Makefile
>> @@ -12,9 +12,8 @@ GCOV_PROFILE :=3D n
>>  KCOV_INSTRUMENT :=3D n
>>  UBSAN_SANITIZE :=3D n
>>
>> -ccflags-y :=3D -shared -fno-common -fno-builtin
>> -ccflags-y +=3D -nostdlib -Wl,-soname=3Dlinux-vdso64.so.1 \
>> -               $(call cc-ldoption, -Wl$(comma)--hash-style=3Dboth)
>> +ccflags-y :=3D -shared -fno-common -fno-builtin -nostdlib \
>> +       -Wl,-soname=3Dlinux-vdso64.so.1 -Wl,--hash-style=3Dboth
>>  asflags-y :=3D -D__VDSO64__ -s
>>
>>  obj-y +=3D vdso64_wrapper.o
>> --
>> 2.21.0.593.g511ec345e18-goog
>>
>=20
> bumping for review

This looks like a good cleanup.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

=
