Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E152FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE7C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LZox4v6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfD2RYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:24:00 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:46034 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728798AbfD2RYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:24:00 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9CCBBC0038;
        Mon, 29 Apr 2019 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1556558637; bh=m4qkc6Una/9g3xtiiboFQMSo/oJ8dA9J62RK9ZySa70=;
        h=From:To:CC:Subject:Date:References:From;
        b=LZox4v6kQr+NqTkFyQVp73N2lXeTFxyvZVwrJAmo05b+AQYmk2h8PV354FgmNaUe+
         NWvw/YAUuLSGRvMi/IkpeEwUTt/ibg1FIXEQ0pUezjTRVl/dQB4yCNhPfPqlpP6Qyi
         Ek0wsYjaqmKQfmqgtTKKbTLys0VBx2/dMo4bjE9nAPdeqt7X05OkoVVJG/tuB/SiQ8
         djgCNJ8NlDPRqUNDEkLO8AxakR5XTfjSksJXq5Of5PwYfGbjUi5Ul+eOgMU9XqJ2TM
         6bIno5rvjNhyt1X12CQge0Taf7/FUpe9szct72X4bAdZASeMdEY7e9kzZj78mE/aD0
         3iT3rk4vikE2A==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F1FA0A0091;
        Mon, 29 Apr 2019 17:23:58 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 29 Apr 2019 10:23:58 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf tools build broken after v5.1-rc1
Thread-Topic: perf tools build broken after v5.1-rc1
Thread-Index: AQHU9whSYuAYlq2eD0OAivz0M0d5Nw==
Date:   Mon, 29 Apr 2019 17:23:57 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A2505863@us01wembx1.internal.synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org> <20190425214800.GC21829@kernel.org>
 <20190426192834.GB28586@kernel.org> <20190426193531.GC28586@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/19 12:35 PM, Arnaldo Carvalho de Melo wrote:=0A=
> Em Fri, Apr 26, 2019 at 04:28:34PM -0300, Arnaldo Carvalho de Melo escrev=
eu:=0A=
>> Em Thu, Apr 25, 2019 at 06:48:00PM -0300, Arnaldo Carvalho de Melo escre=
veu:=0A=
>>> Em Mon, Apr 22, 2019 at 12:20:27PM -0300, Arnaldo Carvalho de Melo escr=
eveu:=0A=
>>>> Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:=0A=
>>>>> When building perf for ARC (v5.1-rc2) I get the following=0A=
>>>>  =0A=
>>>>> | In file included from bench/futex-hash.c:26:=0A=
>>>>> | bench/futex.h: In function 'futex_wait':=0A=
>>>>> | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in th=
is function);=0A=
>>>>  =0A=
>>>>> git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools he=
aders uapi:=0A=
>>>>> Sync copy of asm-generic/unistd.h with the kernel sources")=0A=
>>>> Humm, I have to check why this:=0A=
>>>>=0A=
>>>> [perfbuilder@quaco ~]$ podman images | grep ARC=0A=
>>>> docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-=
uClibc          4c259582a8e6   5 weeks ago      846 MB=0A=
>>>> [perfbuilder@quaco ~]$=0A=
>>>>=0A=
>>>> isn't catching this... :-\=0A=
>>>>=0A=
>>>> FROM docker.io/fedora:24=0A=
>>>> MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>=0A=
>>>> ENV TOOLCHAIN=3Darc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_in=
stall=0A=
>>>> ENV CROSS=3Darc-linux-=0A=
>>>> ENV SOURCEFILE=3D${TOOLCHAIN}.tar.gz=0A=
>>>> RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc find=
utils xz=0A=
>>>> RUN wget https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github=
.com_foss-2Dfor-2Dsynopsys-2Ddwc-2Darc-2Dprocessors_toolchain_releases_down=
load_arc-2D2017.09-2Drc2_-24-257BSOURCEFILE-257D&d=3DDwIBAg&c=3DDPL6_X_6JkX=
Fx7AXWqB0tg&r=3D7FgpX6o3vAhwMrMhLh-4ZJey5kjdNUwOL2CWsFwR4T8&m=3DobdUU5ZihUr=
Fi8F2O4JfVYScd7CLKNItF83dHmezlkU&s=3DoOPRKzvGneimee7GFXWyqqoVfgvHu-jwSMKPbS=
qwP5M&e=3D=0A=
>>>> <SNIP>=0A=
>>>> COPY rx_and_build.sh /=0A=
>>>> ENV EXTRA_MAKE_ARGS=3DNO_LIBBPF=3D1=0A=
>>>> ENV ARCH=3Darc=0A=
>>>> ENV CROSS_COMPILE=3D/${TOOLCHAIN}/bin/${CROSS}=0A=
>>>> ENV EXTRA_CFLAGS=3D-matomic=0A=
>>> So, now I have a libnuma crossbuilt in this container that allows me to=
=0A=
>>> build a ARC perf binary linked with zlib and numactl-devel, but only=0A=
>>> after I applied the fix below.=0A=
>>>=0A=
>>> Can you please provide the feature detection header in the build? I.e.=
=0A=
>>> what I have with my ARC cross build container right now, after applying=
=0A=
>>> the patch below is:=0A=
>> So, switched from the uCLibc build system to the glibc based one, so=0A=
>> that I could get elfutils building (it needs argp that isn't available=
=0A=
>> with uCLibc) I have it reproduced, see below, now I'm testing with the=
=0A=
>> fix, which is to grab the unistd.h files you noticed missing for the=0A=
>> arches that are present in tools/arch/, will post results soon=0A=
> Yep, now it builds:=0A=
>=0A=
> /tmp/build/perf/perf: ELF 32-bit LSB executable, *unknown arch 0xc3* vers=
ion 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-arc.so.2, for G=
NU/Linux 3.9.0, with debug_info, not stripped=0A=
>=0A=
> With this patch:=0A=
>=0A=
> commit dd423246b321967eace3f3e0fe73d638050b447c=0A=
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>=0A=
> Date:   Mon Apr 22 15:21:35 2019 -0300=0A=
>=0A=
>     WIP=0A=
>     =0A=
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>=0A=
>=0A=
> diff --git a/tools/arch/arc/include/uapi/asm/unistd.h b/tools/arch/arc/in=
clude/uapi/asm/unistd.h=0A=
> new file mode 100644=0A=
> index 000000000000..5eafa1115162=0A=
> --- /dev/null=0A=
> +++ b/tools/arch/arc/include/uapi/asm/unistd.h=0A=
> @@ -0,0 +1,51 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */=0A=
> +/*=0A=
> + * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (http://www.s=
ynopsys.com)=0A=
> + *=0A=
> + * This program is free software; you can redistribute it and/or modify=
=0A=
> + * it under the terms of the GNU General Public License version 2 as=0A=
> + * published by the Free Software Foundation.=0A=
> + */=0A=
> +=0A=
> +/******** no-legacy-syscalls-ABI *******/=0A=
> +=0A=
> +/*=0A=
> + * Non-typical guard macro to enable inclusion twice in ARCH sys.c=0A=
> + * That is how the Generic syscall wrapper generator works=0A=
> + */=0A=
> +#if !defined(_UAPI_ASM_ARC_UNISTD_H) || defined(__SYSCALL)=0A=
=0A=
This guard ifdef is not present in existing tools/arch/*/**/unistd.h , nor =
in the=0A=
ones below so I'd suggest just drop it to keep things consistent.=0A=
If you still want them, best to call it _TOOLS_UAPI_ASM_ARC_UNISTD_H=0A=
=0A=
> +#define _UAPI_ASM_ARC_UNISTD_H=0A=
> +=0A=
> +#define __ARCH_WANT_RENAMEAT=0A=
> +#define __ARCH_WANT_STAT64=0A=
> +#define __ARCH_WANT_SET_GET_RLIMIT=0A=
> +#define __ARCH_WANT_SYS_EXECVE=0A=
> +#define __ARCH_WANT_SYS_CLONE=0A=
> +#define __ARCH_WANT_SYS_VFORK=0A=
> +#define __ARCH_WANT_SYS_FORK=0A=
> +#define __ARCH_WANT_TIME32_SYSCALLS=0A=
> +=0A=
> +#define sys_mmap2 sys_mmap_pgoff=0A=
> +=0A=
> +#include <asm-generic/unistd.h>=0A=
=0A=
> +=0A=
> +#define NR_syscalls	__NR_syscalls=0A=
> +=0A=
> +/* Generic syscall (fs/filesystems.c - lost in asm-generic/unistd.h */=
=0A=
> +#define __NR_sysfs		(__NR_arch_specific_syscall + 3)=0A=
> +=0A=
> +/* ARC specific syscall */=0A=
> +#define __NR_cacheflush		(__NR_arch_specific_syscall + 0)=0A=
> +#define __NR_arc_settls		(__NR_arch_specific_syscall + 1)=0A=
> +#define __NR_arc_gettls		(__NR_arch_specific_syscall + 2)=0A=
> +#define __NR_arc_usr_cmpxchg	(__NR_arch_specific_syscall + 4)=0A=
> +=0A=
> +__SYSCALL(__NR_cacheflush, sys_cacheflush)=0A=
> +__SYSCALL(__NR_arc_settls, sys_arc_settls)=0A=
> +__SYSCALL(__NR_arc_gettls, sys_arc_gettls)=0A=
> +__SYSCALL(__NR_arc_usr_cmpxchg, sys_arc_usr_cmpxchg)=0A=
> +__SYSCALL(__NR_sysfs, sys_sysfs)=0A=
> +=0A=
> +#undef __SYSCALL=0A=
> +=0A=
> +#endif=0A=
> diff --git a/tools/arch/hexagon/include/uapi/asm/unistd.h b/tools/arch/he=
xagon/include/uapi/asm/unistd.h=0A=
> new file mode 100644=0A=
> index 000000000000..432c4db1b623=0A=
> --- /dev/null=0A=
> +++ b/tools/arch/hexagon/include/uapi/asm/unistd.h=0A=
> @@ -0,0 +1,40 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */=0A=
> +/*=0A=
> + * Syscall support for Hexagon=0A=
> + *=0A=
> + * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.=
=0A=
> + *=0A=
> + * This program is free software; you can redistribute it and/or modify=
=0A=
> + * it under the terms of the GNU General Public License version 2 and=0A=
> + * only version 2 as published by the Free Software Foundation.=0A=
> + *=0A=
> + * This program is distributed in the hope that it will be useful,=0A=
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> + * GNU General Public License for more details.=0A=
> + *=0A=
> + * You should have received a copy of the GNU General Public License=0A=
> + * along with this program; if not, write to the Free Software=0A=
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA=0A=
> + * 02110-1301, USA.=0A=
> + */=0A=
> +=0A=
> +/*=0A=
> + *  The kernel pulls this unistd.h in three different ways:=0A=
> + *  1.  the "normal" way which gets all the __NR defines=0A=
> + *  2.  with __SYSCALL defined to produce function declarations=0A=
> + *  3.  with __SYSCALL defined to produce syscall table initialization=
=0A=
> + *  See also:  syscalltab.c=0A=
> + */=0A=
> +=0A=
> +#define sys_mmap2 sys_mmap_pgoff=0A=
> +#define __ARCH_WANT_RENAMEAT=0A=
> +#define __ARCH_WANT_STAT64=0A=
> +#define __ARCH_WANT_SET_GET_RLIMIT=0A=
> +#define __ARCH_WANT_SYS_EXECVE=0A=
> +#define __ARCH_WANT_SYS_CLONE=0A=
> +#define __ARCH_WANT_SYS_VFORK=0A=
> +#define __ARCH_WANT_SYS_FORK=0A=
> +#define __ARCH_WANT_TIME32_SYSCALLS=0A=
> +=0A=
> +#include <asm-generic/unistd.h>=0A=
> diff --git a/tools/arch/riscv/include/uapi/asm/unistd.h b/tools/arch/risc=
v/include/uapi/asm/unistd.h=0A=
> new file mode 100644=0A=
> index 000000000000..0e2eeeb1fd27=0A=
> --- /dev/null=0A=
> +++ b/tools/arch/riscv/include/uapi/asm/unistd.h=0A=
> @@ -0,0 +1,42 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */=0A=
> +/*=0A=
> + * Copyright (C) 2018 David Abdurachmanov <david.abdurachmanov@gmail.com=
>=0A=
> + *=0A=
> + * This program is free software; you can redistribute it and/or modify=
=0A=
> + * it under the terms of the GNU General Public License version 2 as=0A=
> + * published by the Free Software Foundation.=0A=
> + *=0A=
> + * This program is distributed in the hope that it will be useful,=0A=
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
> + * GNU General Public License for more details.=0A=
> + *=0A=
> + * You should have received a copy of the GNU General Public License=0A=
> + * along with this program.  If not, see <https://urldefense.proofpoint.=
com/v2/url?u=3Dhttp-3A__www.gnu.org_licenses_&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7=
AXWqB0tg&r=3D7FgpX6o3vAhwMrMhLh-4ZJey5kjdNUwOL2CWsFwR4T8&m=3DobdUU5ZihUrFi8=
F2O4JfVYScd7CLKNItF83dHmezlkU&s=3Dqw-VNuV5RBu7T5rL77GOTAKBzZB-zvizjJ3Haik7x=
9g&e=3D>.=0A=
> + */=0A=
> +=0A=
> +#ifdef __LP64__=0A=
> +#define __ARCH_WANT_NEW_STAT=0A=
> +#define __ARCH_WANT_SET_GET_RLIMIT=0A=
> +#endif /* __LP64__ */=0A=
> +=0A=
> +#include <asm-generic/unistd.h>=0A=
> +=0A=
> +/*=0A=
> + * Allows the instruction cache to be flushed from userspace.  Despite R=
ISC-V=0A=
> + * having a direct 'fence.i' instruction available to userspace (which w=
e=0A=
> + * can't trap!), that's not actually viable when running on Linux becaus=
e the=0A=
> + * kernel might schedule a process on another hart.  There is no way for=
=0A=
> + * userspace to handle this without invoking the kernel (as it doesn't k=
now the=0A=
> + * thread->hart mappings), so we've defined a RISC-V specific system cal=
l to=0A=
> + * flush the instruction cache.=0A=
> + *=0A=
> + * __NR_riscv_flush_icache is defined to flush the instruction cache ove=
r an=0A=
> + * address range, with the flush applying to either all threads or just =
the=0A=
> + * caller.  We don't currently do anything with the address range, that'=
s just=0A=
> + * in there for forwards compatibility.=0A=
> + */=0A=
> +#ifndef __NR_riscv_flush_icache=0A=
> +#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)=0A=
> +#endif=0A=
> +__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)=0A=
>=0A=
=0A=
