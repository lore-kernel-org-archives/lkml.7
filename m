Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A06C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5707D21734
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 18:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578248974;
	bh=NM7rtwMdhq5AzVyVvFhwlCWu0V9S/cm1HP9t6rBm9rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZY4rzKgUDGjeIIOP3ILR/YbRK8iycZSa53a+yxwBh8B0+3lpJ2lXcUkzuIRms+s6O
	 JFMKAVA3bZ95xOrIEzM4d60S78twffL8TCWhMWkoIWIJzeX4dEQ7meo0xayUNL2NuK
	 59wZpxkJMlYRKyLV06/cM/NGOpKdmqJBDHQrKDWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgAES3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 13:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAES3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 13:29:33 -0500
Received: from localhost (96-81-74-198-static.hfc.comcastbusiness.net [96.81.74.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3113620866;
        Sun,  5 Jan 2020 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578248971;
        bh=NM7rtwMdhq5AzVyVvFhwlCWu0V9S/cm1HP9t6rBm9rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYEfBqraDCieqlUCmkoFYnlujgSgO7eV4o8lepaGfv04cdg8XokRJUPGXVtRXfK+L
         mUw3tQu0L90NoYDzLsRP50oPzlSG9xCev+7VrzQPOdwvSvt555X6DrF9F3ULE5qUpt
         0+JRdTSMbPxNE90zdHmt54hnMg2+d66JSnGbCgOU=
Date:   Sun, 5 Jan 2020 13:29:29 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Gordan Bobic <gordan@redsleeve.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 4.9.208 regression in perf building
Message-ID: <20200105182929.GA2530@sasha-vm>
References: <CAMx4oe38RytiyqWfYb=So8iC6N=8nebqy3DsekiT7A5DGjpe+w@mail.gmail.com>
 <CAMx4oe2JKTsOKg3P324PYRH=0ajOVDaXTLa7p=16Fo9fGiQSpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMx4oe2JKTsOKg3P324PYRH=0ajOVDaXTLa7p=16Fo9fGiQSpQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 05:01:00PM +0000, Gordan Bobic wrote:
>It looks like 4.9.208 introduces a build regression for perf:
>
>make -f /builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/build/Makefile.build
>dir=. obj=perf
>  gcc -Wp,-MD,./.builtin-report.o.d,-MT,builtin-report.o
>-Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
>-Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes
>-Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked
>-Wredundant-decls -Wshadow -Wstrict-aliasing=3 -Wstrict-prototypes
>-Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat
>-DHAVE_ARCH_X86_64_SUPPORT -DHAVE_SYSCALL_TABLE
>-Iarch/x86/include/generated -DHAVE_PERF_REGS_SUPPORT
>-DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -O6 -fno-omit-frame-pointer
>-ggdb3 -funwind-tables -Wall -Wextra -std=gnu99 -fstack-protector-all
>-D_FORTIFY_SOURCE=2
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/perf/util/include
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/perf/arch/x86/include
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/include/uapi
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/include/
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/arch/x86/include/uapi
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/arch/x86/include/
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/arch/x86/
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/perf/util
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/perf
>-I/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/lib/
>-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
>-DHAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
>-DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_DWARF_GETLOCATIONS
>-DHAVE_LIBELF_SUPPORT -DHAVE_LIBELF_MMAP_SUPPORT
>-DHAVE_ELF_GETPHDRNUM_SUPPORT -DHAVE_GELF_GETNOTE_SUPPORT
>-DHAVE_ELF_GETSHDRSTRNDX_SUPPORT -DHAVE_DWARF_SUPPORT
>-DHAVE_LIBBPF_SUPPORT -DHAVE_BPF_PROLOGUE -DHAVE_SDT_EVENT
>-DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DHAVE_LIBAUDIT_SUPPORT
>-DHAVE_LIBCRYPTO_SUPPORT -I/usr/include/slang -DHAVE_SLANG_SUPPORT
>-DHAVE_TIMERFD_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHAVE_ZLIB_SUPPORT
>-DHAVE_LZMA_SUPPORT -DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPORT
>-DHAVE_KVM_STAT_SUPPORT -DHAVE_AUXTRACE_SUPPORT -D"BUILD_STR(s)=#s"
>-DTIPDIR="BUILD_STR(share/doc/perf-tip)"
>-DDOCDIR="BUILD_STR(/builddir/build/BUILD/kernel-4.9.208/linux-4.9.208-1.el7.x86_64/tools/perf/Documentation)"
> -c -o builtin-report.o builtin-report.c
>builtin-report.c: In function ‘report__setup_sample_type’:
>builtin-report.c:296:6: error: ‘dwarf_callchain_users’ undeclared
>(first use in this function)
>  if (dwarf_callchain_users) {
>      ^
>builtin-report.c:296:6: note: each undeclared identifier is reported
>only once for each function it appears in
>mv: cannot stat ‘./.builtin-report.o.tmp’: No such file or directory
>make[3]: *** [builtin-report.o] Error 1
>make[2]: *** [perf-in.o] Error 2
>make[1]: *** [sub-make] Error 2
>make: *** [all] Error 2
>
>4,9.207 works fine.

Looks like 59b706ce44db ("perf report: Add warning when libunwind not
compiled in") depends on eabad8c6856f ("perf unwind: Do not look just at
the global callchain_param.record_mode") which is tricky to backport.
I'll just drop 59b706ce44db from 4.9 and 4.4. Thanks for the report!

-- 
Thanks,
Sasha
