Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD4FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BA020692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fossix-org.20150623.gappssmtp.com header.i=@fossix-org.20150623.gappssmtp.com header.b="UFkVQVLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbfIMODc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:03:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44783 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbfIMODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:03:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so18137349pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vpmitwkoehCvB7dqkSmwhbgYzpwlvWcY38/mwAHllec=;
        b=UFkVQVLLfYMzvetJ9zD6dYwDftLzvnJhg/6r+xH/MrR9sI2bRT7iGFyIhw4skj/Gtq
         UI1p4nIlx32+Z1PZtASeVFd3Vsn/K1RzYxd/PZuKKm7EGf7wTlG+IMIOGibcnvyB0i6Q
         DIAW6+t7xAbx6wgjAvl6jSkThhnm4MujFOlbQWIfW/d3kKhajUXYHbR8x7iMYOiRGdrM
         L8lYFSC8Cki2eJzWIF6bvbPAtww5Y4eovljDt1Qtf8CEgvoP48YFmUWXDnDx+D4j+WRI
         wwaY4bGh67EiNA6rIdMrSWvqWgytLTtVff6BAMuFS9k+n/yd6D0ah1fjhqKcvs0bvQZf
         V/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vpmitwkoehCvB7dqkSmwhbgYzpwlvWcY38/mwAHllec=;
        b=oahSWPm7PgiKj0JIC5zuI/Y9Bmd3OomVHQ9Wrj7kfRTa4wU0Mv2mrNG0fC4jH2wrlV
         Ln5xNINw/TTJVYZhjTbb8k65FOVXnEIKKXVm6/P4y0hMVZ/yHu2sp9NGm2IlNnnYabmZ
         CgFlJ7r5vHupgOZ0dfqgeBxiEKn8cfLgJIAq/Y8NBl1vRqqIiIWAQMX+Z6WQNhlVo+Ew
         GbDZ8XlSe+2Dh2KqI/xxThLik2YVEREePsBq6QBDoG07BJeiNm1ZKwPHjA9ghlmD0maJ
         hWLpxnm2RCacdzVJd3qYcT4f88ik3nk4Se1Fv8cg3VBzjAyoqiGKaLQH/YfyrD20JYg2
         8Yvg==
X-Gm-Message-State: APjAAAVl6OBGWqxn8ulFqt/i+fZW0GgAuhrdylAgkjBvPvOWFQTdWuUL
        W6dhFP+BBkg4iJEIOTUj8k836Q==
X-Google-Smtp-Source: APXvYqz9Ak5zvFaLOBaz8kX/Gcf8o6jJP3aS6fv6pGphH4og6+EVm3Ul8XrvDMoTLaNK0KctWpfX3w==
X-Received: by 2002:a65:6901:: with SMTP id s1mr6335459pgq.338.1568383410623;
        Fri, 13 Sep 2019 07:03:30 -0700 (PDT)
Received: from localhost ([49.207.57.15])
        by smtp.gmail.com with ESMTPSA id l72sm4751241pjb.7.2019.09.13.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:03:29 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] powerpc/vdso32: inline __get_datapage()
In-Reply-To: <559296a2-37f6-dc83-7f60-07567637a9a8@c-s.fr>
References: <cover.1566491310.git.christophe.leroy@c-s.fr> <194fb7bc973ef2ce43016c97dd32f2b2dcbae4e7.1566491310.git.christophe.leroy@c-s.fr> <87h864iiq9.fsf@santosiv.in.ibm.com> <a95c4a58-bc59-3e75-46db-414f6d0f1412@c-s.fr> <87blvonwzz.fsf@santosiv.in.ibm.com> <559296a2-37f6-dc83-7f60-07567637a9a8@c-s.fr>
Date:   Fri, 13 Sep 2019 19:33:27 +0530
Message-ID: <875zlwnvio.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 13/09/2019 =C3=A0 15:31, Santosh Sivaraj a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>=20
>>> Hi Santosh,
>>>
>>> Le 26/08/2019 =C3=A0 07:44, Santosh Sivaraj a =C3=A9crit=C2=A0:
>>>> Hi Christophe,
>>>>
>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>
>>>>> __get_datapage() is only a few instructions to retrieve the
>>>>> address of the page where the kernel stores data to the VDSO.
>>>>>
>>>>> By inlining this function into its users, a bl/blr pair and
>>>>> a mflr/mtlr pair is avoided, plus a few reg moves.
>>>>>
>>>>> The improvement is noticeable (about 55 nsec/call on an 8xx)
>>>>>
>>>>> vdsotest before the patch:
>>>>> gettimeofday:    vdso: 731 nsec/call
>>>>> clock-gettime-realtime-coarse:    vdso: 668 nsec/call
>>>>> clock-gettime-monotonic-coarse:    vdso: 745 nsec/call
>>>>>
>>>>> vdsotest after the patch:
>>>>> gettimeofday:    vdso: 677 nsec/call
>>>>> clock-gettime-realtime-coarse:    vdso: 613 nsec/call
>>>>> clock-gettime-monotonic-coarse:    vdso: 690 nsec/call
>>>>>
>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> ---
>>>>>    arch/powerpc/kernel/vdso32/cacheflush.S   | 10 +++++-----
>>>>>    arch/powerpc/kernel/vdso32/datapage.S     | 29 ++++---------------=
----------
>>>>>    arch/powerpc/kernel/vdso32/datapage.h     | 11 +++++++++++
>>>>>    arch/powerpc/kernel/vdso32/gettimeofday.S | 13 ++++++-------
>>>>>    4 files changed, 26 insertions(+), 37 deletions(-)
>>>>>    create mode 100644 arch/powerpc/kernel/vdso32/datapage.h
>>>>
>>>> The datapage.h file should ideally be moved under include/asm, then we=
 can use
>>>> the same for powerpc64 too.
>>>
>>> I have a more ambitious project indeed.
>>>
>>> Most of the VDSO code is duplicated between vdso32 and vdso64. I'm
>>> aiming at merging everything into a single source code.
>>>
>>> This means we would have to generate vdso32.so and vdso64.so out of the
>>> same source files. Any idea on how to do that ? I'm not too good at
>>> creating Makefiles. I guess we would have everything in
>>> arch/powerpc/kernel/vdso/ and would have to build the objects twice,
>>> once in arch/powerpc/kernel/vdso32/ and once in arch/powerpc/kernel/vds=
o64/
>>=20
>> Should we need to build the objects twice? For 64 bit config it is going=
 to be
>> a 64 bit build else a 32 bit build. It should suffice to get the single =
source
>> code compile for both, maybe with macros or (!)CONFIG_PPC64 conditional
>> compilation. Am I missing something when you say build twice?
>>=20
>
> IIUC, on PPC64 we build vdso64 for 64bits user apps and vdso32 for=20
> 32bits user apps.
>
> In arch/powerpc/kernel/Makefile, you have:
>
> obj-$(CONFIG_VDSO32)		+=3D vdso32/
> obj-$(CONFIG_PPC64)		+=3D vdso64/
>
> And in arch/powerpc/platforms/Kconfig.cputype, you have:
>
> config VDSO32
> 	def_bool y
> 	depends on PPC32 || CPU_BIG_ENDIAN
> 	help
> 	  This symbol controls whether we build the 32-bit VDSO. We obviously
> 	  want to do that if we're building a 32-bit kernel. If we're building
> 	  a 64-bit kernel then we only want a 32-bit VDSO if we're building for
> 	  big endian. That is because the only little endian configuration we
> 	  support is ppc64le which is 64-bit only.
>

I didn't know we build 32 bit vdso for 64 bit big endians. But I don't think
its difficult to do it, might be a bit tricky. We can have two targets from
the same source.

SRC =3D vdso/*.c
OBJS_32 =3D $(SRC:.c=3Dvdso32/.o)
OBJS_64 =3D $(SRC:.c=3Dvdso64/.o)

Something like this would work. Of course, this is out of memory, might hav=
e to
do something slightly different for the Makefiles in kernel.

Thanks,
Santosh

>
>
>
> Christophe
