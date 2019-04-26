Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06823C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D2620693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI6iUpjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDZTfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:35:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46574 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfDZTfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:35:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id w26so5356145qto.13;
        Fri, 26 Apr 2019 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGX1CfH8kr8UbgRwc1CrT6QTBsEK1fDhCrYFKOiiw64=;
        b=lI6iUpjr2EV0vaSlH2XxrPrxoU06/zz/Or3Xh5Og2cQHpgCgSumSKDdkLdgMjaFYL6
         TCsZVX9R6/6OeDbViHPlm/kTD3M0WuLBoqfhEbVoCrrd+ftf14CzNNhuckpAPAbDxoBI
         Lkfd0bVqYg8/Szlzw5oSvyJ2Ntj4In0pIZsWzqfFEfQN/pVWexcXUZ3obEiRemXbUxxD
         yskyh0KEphqk2CsZzyRhlA/4OoNoPjOfIh8GxaBXOWZ61MoQmtakjsYPtwer8c1ff3Ss
         CsYlIgY5gybo/m/qzUT3xczm6mD3lQX5u6L1P8AI9kmqjXi7LVyHf+OwJLq3HkWs9e3l
         7rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGX1CfH8kr8UbgRwc1CrT6QTBsEK1fDhCrYFKOiiw64=;
        b=pEHwnv6NSGMefdK59BMaPf5MGEfHb43GfZ6xhXkKzd+LM/D2RwgQH0p+RvQvKMo+iy
         LSfevuvmG5xqrDBq/CESpUJLm/xZJlW+r01w+kWX4xw5YAD3AKdCt04qJmT2s60bMRlK
         B25bcspFV8J4avgw1X77cZw+zbf7g2XyrkPSdR25T93oC4/+ns21C4VnE040sLlwHOL/
         xjO+IX3aXPwKrKtEuQUaosUsRoiWmV6+7fgEwlE0J80QMvU9YOgygcCJvMGpGt+BY8kZ
         M+Q5V8twScA53e/hODL9b4TL/yGdhu4lDrKJ0w+8Z83WsTc2hsIwewOCYKjWpGJ/ojae
         FNsA==
X-Gm-Message-State: APjAAAUxYfeNFY+N+aIRVOG1tyyNBMrQ+bm5oIVzWW92XzsFwqfJdoaD
        swHnVuPO3EnnS+XMxClmv3o=
X-Google-Smtp-Source: APXvYqwIQy0CTpcJ2CgaN/wLkytE63Pk/aP005n/mpozr5fTzJ0Sdm5lgxlqn6ps21O5aUaHIUl7Rw==
X-Received: by 2002:ac8:3159:: with SMTP id h25mr25587030qtb.61.1556307336664;
        Fri, 26 Apr 2019 12:35:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id c13sm4203358qkk.11.2019.04.26.12.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:35:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCCED4111F; Fri, 26 Apr 2019 16:35:31 -0300 (-03)
Date:   Fri, 26 Apr 2019 16:35:31 -0300
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190426193531.GC28586@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <20190425214800.GC21829@kernel.org>
 <20190426192834.GB28586@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426192834.GB28586@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 26, 2019 at 04:28:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Apr 25, 2019 at 06:48:00PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Apr 22, 2019 at 12:20:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Apr 19, 2019 at 04:32:58PM -0700, Vineet Gupta escreveu:
> > > > When building perf for ARC (v5.1-rc2) I get the following
> > >  
> > > > | In file included from bench/futex-hash.c:26:
> > > > | bench/futex.h: In function 'futex_wait':
> > > > | bench/futex.h:37:10: error: 'SYS_futex' undeclared (first use in this function);
> > >  
> > > > git bisect led to 1a787fc5ba18ac767e635c58d06a0b46876184e3 ("tools headers uapi:
> > > > Sync copy of asm-generic/unistd.h with the kernel sources")
> > > 
> > > Humm, I have to check why this:
> > > 
> > > [perfbuilder@quaco ~]$ podman images | grep ARC
> > > docker.io/acmel/linux-perf-tools-build-fedora                24-x-ARC-uClibc          4c259582a8e6   5 weeks ago      846 MB
> > > [perfbuilder@quaco ~]$
> > > 
> > > isn't catching this... :-\
> > > 
> > > FROM docker.io/fedora:24
> > > MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
> > > ENV TOOLCHAIN=arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install
> > > ENV CROSS=arc-linux-
> > > ENV SOURCEFILE=${TOOLCHAIN}.tar.gz
> > > RUN dnf -y install make flex bison binutils gcc wget tar bzip2 bc findutils xz
> > > RUN wget https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-2017.09-rc2/${SOURCEFILE}
> > > <SNIP>
> > > COPY rx_and_build.sh /
> > > ENV EXTRA_MAKE_ARGS=NO_LIBBPF=1
> > > ENV ARCH=arc
> > > ENV CROSS_COMPILE=/${TOOLCHAIN}/bin/${CROSS}
> > > ENV EXTRA_CFLAGS=-matomic
> > 
> > So, now I have a libnuma crossbuilt in this container that allows me to
> > build a ARC perf binary linked with zlib and numactl-devel, but only
> > after I applied the fix below.
> > 
> > Can you please provide the feature detection header in the build? I.e.
> > what I have with my ARC cross build container right now, after applying
> > the patch below is:
> 
> So, switched from the uCLibc build system to the glibc based one, so
> that I could get elfutils building (it needs argp that isn't available
> with uCLibc) I have it reproduced, see below, now I'm testing with the
> fix, which is to grab the unistd.h files you noticed missing for the
> arches that are present in tools/arch/, will post results soon

Yep, now it builds:

/tmp/build/perf/perf: ELF 32-bit LSB executable, *unknown arch 0xc3* version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-arc.so.2, for GNU/Linux 3.9.0, with debug_info, not stripped

With this patch:

commit dd423246b321967eace3f3e0fe73d638050b447c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Apr 22 15:21:35 2019 -0300

    WIP
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/arch/arc/include/uapi/asm/unistd.h b/tools/arch/arc/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..5eafa1115162
--- /dev/null
+++ b/tools/arch/arc/include/uapi/asm/unistd.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/******** no-legacy-syscalls-ABI *******/
+
+/*
+ * Non-typical guard macro to enable inclusion twice in ARCH sys.c
+ * That is how the Generic syscall wrapper generator works
+ */
+#if !defined(_UAPI_ASM_ARC_UNISTD_H) || defined(__SYSCALL)
+#define _UAPI_ASM_ARC_UNISTD_H
+
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_EXECVE
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
+
+#define sys_mmap2 sys_mmap_pgoff
+
+#include <asm-generic/unistd.h>
+
+#define NR_syscalls	__NR_syscalls
+
+/* Generic syscall (fs/filesystems.c - lost in asm-generic/unistd.h */
+#define __NR_sysfs		(__NR_arch_specific_syscall + 3)
+
+/* ARC specific syscall */
+#define __NR_cacheflush		(__NR_arch_specific_syscall + 0)
+#define __NR_arc_settls		(__NR_arch_specific_syscall + 1)
+#define __NR_arc_gettls		(__NR_arch_specific_syscall + 2)
+#define __NR_arc_usr_cmpxchg	(__NR_arch_specific_syscall + 4)
+
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
+__SYSCALL(__NR_arc_settls, sys_arc_settls)
+__SYSCALL(__NR_arc_gettls, sys_arc_gettls)
+__SYSCALL(__NR_arc_usr_cmpxchg, sys_arc_usr_cmpxchg)
+__SYSCALL(__NR_sysfs, sys_sysfs)
+
+#undef __SYSCALL
+
+#endif
diff --git a/tools/arch/hexagon/include/uapi/asm/unistd.h b/tools/arch/hexagon/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..432c4db1b623
--- /dev/null
+++ b/tools/arch/hexagon/include/uapi/asm/unistd.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Syscall support for Hexagon
+ *
+ * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/*
+ *  The kernel pulls this unistd.h in three different ways:
+ *  1.  the "normal" way which gets all the __NR defines
+ *  2.  with __SYSCALL defined to produce function declarations
+ *  3.  with __SYSCALL defined to produce syscall table initialization
+ *  See also:  syscalltab.c
+ */
+
+#define sys_mmap2 sys_mmap_pgoff
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_EXECVE
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_VFORK
+#define __ARCH_WANT_SYS_FORK
+#define __ARCH_WANT_TIME32_SYSCALLS
+
+#include <asm-generic/unistd.h>
diff --git a/tools/arch/riscv/include/uapi/asm/unistd.h b/tools/arch/riscv/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..0e2eeeb1fd27
--- /dev/null
+++ b/tools/arch/riscv/include/uapi/asm/unistd.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2018 David Abdurachmanov <david.abdurachmanov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifdef __LP64__
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#endif /* __LP64__ */
+
+#include <asm-generic/unistd.h>
+
+/*
+ * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
+ * having a direct 'fence.i' instruction available to userspace (which we
+ * can't trap!), that's not actually viable when running on Linux because the
+ * kernel might schedule a process on another hart.  There is no way for
+ * userspace to handle this without invoking the kernel (as it doesn't know the
+ * thread->hart mappings), so we've defined a RISC-V specific system call to
+ * flush the instruction cache.
+ *
+ * __NR_riscv_flush_icache is defined to flush the instruction cache over an
+ * address range, with the flush applying to either all threads or just the
+ * caller.  We don't currently do anything with the address range, that's just
+ * in there for forwards compatibility.
+ */
+#ifndef __NR_riscv_flush_icache
+#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
+#endif
+__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
