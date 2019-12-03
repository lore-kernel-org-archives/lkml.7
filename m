Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C412073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD3IOaM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLCNXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:23:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45441 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLCNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:23:48 -0500
Received: by mail-il1-f195.google.com with SMTP id o18so3093500ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=b4gNNYdMx7pGklNR55enqmyWePSfWsEKfy3HzCVT/aM=;
        b=UD3IOaM7QyzF48N8HdwEXMWRfYjoGLLzh0rbctGGHueMNgkY9uCd3S/t+0WvrQJnxS
         BKxJB0oU1Hhz8jTc6Uxm4SWJR/Lo0lOUGWWeTLYIHNxZ9rdvgR6gs8cJI9g/WK/Kr5Sc
         n5752mxurRg4mnhBnYiuh9yyPypWh5KtMPrarlDG+txLGmoDIzjp90tuzgDlblgasnG2
         fVHSATZdC/M97UydMT0Bgj7ViWPa1RQkgaQ+yhwRjnYjJyFrg3ClzfcSvG9j0dKsHBQy
         CUFGNvYFg25w1aVXnATWRncCeuQxV64tS3480u9ruvASrf+owHQwYYH9jeVroeVfuEAW
         0YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=b4gNNYdMx7pGklNR55enqmyWePSfWsEKfy3HzCVT/aM=;
        b=DatYI+8lrLzGOGUTzNSzSfKDkaad52/CPCBLwRcEZQOiMRxbLZ01MOl0ceLcYHZNnl
         Mt+Idh5t6tkXGc4LaAD8I434BVpF0gBziggaVqX8u+EZC6MfWFY6NLqdmSnU9mFM+5Bh
         yYcuJnp/MpB0khoSmnxEhs9ojJe3E4ZNXuw5HPbjp+K+O1g70qOFXbmRpJUBG7iNgNmL
         zfx1NJHIkk3kSvXpnXr7rBIgGtz+A+mqVs28dzVM5h4WAO1kqGIHDWGhdlMXYTrjdw07
         8uCCtbNxBG749WLpX7VVUcVdsUpQNPxXd/Gf5089+j7YN0IXzH+arrELtgSTQKKRXecf
         yEwg==
X-Gm-Message-State: APjAAAWwkdEAbeIotbDEnZjAJosHLOlS5bgZknS99z/hOwOab4ZOMSf9
        4jZP+h6cu6xTI8Rmii0mk7HNtH9wEzNMKBNhHwWe5w==
X-Google-Smtp-Source: APXvYqyPBJ1RJS7juvdd7swZ1QCWJhBQxKfs/g8wOPeGyrhs96rNelbgKPO9eoV7TZvm6rFIxHqohIVVJeLe4M1grNg=
X-Received: by 2002:a92:a30d:: with SMTP id a13mr4563382ili.186.1575379425717;
 Tue, 03 Dec 2019 05:23:45 -0800 (PST)
MIME-Version: 1.0
References: <CAKecwXB6CYuykBYrfGUDffF_AY31E_M8HpQddOe4xojjx0xZ8w@mail.gmail.com>
In-Reply-To: <CAKecwXB6CYuykBYrfGUDffF_AY31E_M8HpQddOe4xojjx0xZ8w@mail.gmail.com>
From:   Santiago Pastorino <spastorino@gmail.com>
Date:   Tue, 3 Dec 2019 10:23:05 -0300
Message-ID: <CAKecwXBZrjTcLO62CMh_zDCX1iSC_zN5GLCthAVqs-nw346A-g@mail.gmail.com>
Subject: Re: perf trace segfault
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attaching `valgrind -v perf trace` log below ...

==5275== Memcheck, a memory error detector
==5275== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==5275== Using Valgrind-3.15.0-608cb11914-20190413X and LibVEX; rerun
with -h for copyright info
==5275== Command: perf trace
==5275== Parent PID: 5134
==5275==
--5275--
--5275-- Valgrind options:
--5275--    --log-file=valgrind.log
--5275--    -v
--5275-- Contents of /proc/version:
--5275--   Linux version 5.4.1-arch1-1 (linux@archlinux) (gcc version
9.2.0 (GCC)) #1 SMP PREEMPT Fri, 29 Nov 2019 13:37:24 +0000
--5275--
--5275-- Arch and hwcaps: AMD64, LittleEndian,
amd64-cx16-lzcnt-rdtscp-sse3-ssse3-avx-avx2-bmi-f16c-rdrand
--5275-- Page sizes: currently 4096, max supported 4096
--5275-- Valgrind library directory: /usr/lib/valgrind
--5275-- Reading syms from /usr/bin/perf
--5275-- Reading syms from /usr/lib/ld-2.30.so
--5275-- Reading syms from /usr/lib/valgrind/memcheck-amd64-linux
--5275--    object doesn't have a dynamic symbol table
--5275-- Scheduler: using generic scheduler lock implementation.
--5275-- Reading suppressions file: /usr/lib/valgrind/default.supp
==5275== embedded gdbserver: reading from
/tmp/vgdb-pipe-from-vgdb-to-5275-by-root-on-???
==5275== embedded gdbserver: writing to
/tmp/vgdb-pipe-to-vgdb-from-5275-by-root-on-???
==5275== embedded gdbserver: shared mem
/tmp/vgdb-pipe-shared-mem-vgdb-5275-by-root-on-???
==5275==
==5275== TO CONTROL THIS PROCESS USING vgdb (which you probably
==5275== don't want to do, unless you know exactly what you're doing,
==5275== or are doing some strange experiment):
==5275==   /usr/lib/valgrind/../../bin/vgdb --pid=5275 ...command...
==5275==
==5275== TO DEBUG THIS PROCESS USING GDB: start GDB like this
==5275==   /path/to/gdb perf
==5275== and then give GDB the following command
==5275==   target remote | /usr/lib/valgrind/../../bin/vgdb --pid=5275
==5275== --pid is optional if only one valgrind process is running
==5275==
--5275-- REDIR: 0x40203a0 (ld-linux-x86-64.so.2:strlen) redirected to
0x580c7532 (vgPlain_amd64_linux_REDIR_FOR_strlen)
--5275-- REDIR: 0x4020170 (ld-linux-x86-64.so.2:index) redirected to
0x580c754c (vgPlain_amd64_linux_REDIR_FOR_index)
--5275-- Reading syms from /usr/lib/valgrind/vgpreload_core-amd64-linux.so
--5275-- Reading syms from /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so
==5275== WARNING: new redirection conflicts with existing -- ignoring it
--5275--     old: 0x040203a0 (strlen              ) R-> (0000.0)
0x580c7532 vgPlain_amd64_linux_REDIR_FOR_strlen
--5275--     new: 0x040203a0 (strlen              ) R-> (2007.0)
0x0483bda0 strlen
--5275-- REDIR: 0x401cb80 (ld-linux-x86-64.so.2:strcmp) redirected to
0x483cc90 (strcmp)
--5275-- REDIR: 0x4020900 (ld-linux-x86-64.so.2:mempcpy) redirected to
0x4840670 (mempcpy)
--5275-- Reading syms from /usr/lib/libpthread-2.30.so
--5275-- Reading syms from /usr/lib/librt-2.30.so
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libm-2.30.so
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libdl-2.30.so
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libelf-0.177.so
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libdw-0.177.so
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libunwind-x86_64.so.8.0.1
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libunwind.so.8.0.1
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/liblzma.so.5.2.4
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libslang.so.2.3.2
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libz.so.1.2.11
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libzstd.so.1.4.3
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libcap.so.2.27
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libnuma.so.1.0.0
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libc-2.30.so
--5275-- Reading syms from /usr/lib/libbz2.so.1.0.8
--5275--    object doesn't have a symbol table
--5275-- Reading syms from /usr/lib/libgcc_s.so.1
--5275-- REDIR: 0x5103c60 (libc.so.6:memmove) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102fe0 (libc.so.6:strncpy) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103f90 (libc.so.6:strcasecmp) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102900 (libc.so.6:strcat) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103040 (libc.so.6:rindex) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5105330 (libc.so.6:rawmemchr) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x511d800 (libc.so.6:wmemchr) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x511d340 (libc.so.6:wcscmp) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103dc0 (libc.so.6:mempcpy) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103bf0 (libc.so.6:bcmp) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102f70 (libc.so.6:strncmp) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x51029b0 (libc.so.6:strcmp) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103d20 (libc.so.6:memset) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x511d300 (libc.so.6:wcschr) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102ed0 (libc.so.6:strnlen) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102a90 (libc.so.6:strcspn) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103fe0 (libc.so.6:strncasecmp) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102a30 (libc.so.6:strcpy) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5104130 (libc.so.6:memcpy@@GLIBC_2.14) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x511ea50 (libc.so.6:wcsnlen) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x511d380 (libc.so.6:wcscpy) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103080 (libc.so.6:strpbrk) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102960 (libc.so.6:index) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5102e90 (libc.so.6:strlen) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5109760 (libc.so.6:memrchr) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5104030 (libc.so.6:strcasecmp_l) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103bb0 (libc.so.6:memchr) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x511d450 (libc.so.6:wcslen) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103340 (libc.so.6:strspn) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103f30 (libc.so.6:stpncpy) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103ed0 (libc.so.6:stpcpy) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5105370 (libc.so.6:strchrnul) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5104080 (libc.so.6:strncasecmp_l) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5180ed0 (libc.so.6:__memcpy_chk) redirected to
0x482e1c0 (_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x5103ad0 (libc.so.6:strstr) redirected to 0x482e1c0
(_vgnU_ifunc_wrapper)
--5275-- REDIR: 0x51d5510 (libc.so.6:__strrchr_avx2) redirected to
0x483b7b0 (rindex)
--5275-- REDIR: 0x50fee10 (libc.so.6:malloc) redirected to 0x4838710 (malloc)
--5275-- REDIR: 0x51037f0 (libc.so.6:__GI_strstr) redirected to
0x48408c0 (__strstr_sse2)
--5275-- REDIR: 0x51d1540 (libc.so.6:__memchr_avx2) redirected to
0x483cd10 (memchr)
--5275-- REDIR: 0x51d86f0 (libc.so.6:__memcpy_avx_unaligned_erms)
redirected to 0x483f690 (memmove)
--5275-- REDIR: 0x50ff450 (libc.so.6:free) redirected to 0x4839940 (free)
--5275-- REDIR: 0x50ffb90 (libc.so.6:calloc) redirected to 0x483aab0 (calloc)
--5275-- REDIR: 0x51d5320 (libc.so.6:__strchrnul_avx2) redirected to
0x48401e0 (strchrnul)
--5275-- REDIR: 0x51d86d0 (libc.so.6:__mempcpy_avx_unaligned_erms)
redirected to 0x48402f0 (mempcpy)
--5275-- REDIR: 0x51047a0 (libc.so.6:strcasestr) redirected to
0x4840b70 (strcasestr)
--5275-- REDIR: 0x511bfa0 (libc.so.6:__strstr_sse2_unaligned)
redirected to 0x4840850 (strstr)
--5275-- REDIR: 0x51d56e0 (libc.so.6:__strlen_avx2) redirected to
0x483bc80 (strlen)
--5275-- REDIR: 0x50ff6c0 (libc.so.6:realloc) redirected to 0x483ad00 (realloc)
--5275-- REDIR: 0x51d1020 (libc.so.6:__strncmp_avx2) redirected to
0x483c370 (strncmp)
--5275-- REDIR: 0x50b22f0 (libc.so.6:setenv) redirected to 0x4841040 (setenv)
--5275-- REDIR: 0x51d50f0 (libc.so.6:__strchr_avx2) redirected to
0x483b930 (index)
--5275-- REDIR: 0x51d8b70 (libc.so.6:__memset_avx2_unaligned_erms)
redirected to 0x483f580 (memset)
--5275-- REDIR: 0x51d0be0 (libc.so.6:__strcmp_avx2) redirected to
0x483cb90 (strcmp)
--5275-- REDIR: 0x51d6c20 (libc.so.6:__strcpy_avx2) redirected to
0x483bdd0 (strcpy)
--5275-- REDIR: 0x51d5ba0 (libc.so.6:__strcat_avx2) redirected to
0x483b960 (strcat)
--5275-- REDIR: 0x51d6fb0 (libc.so.6:__strncpy_avx2) redirected to
0x483bf70 (strncpy)
--5275-- REDIR: 0x51d20b0 (libc.so.6:__strcasecmp_avx) redirected to
0x483c530 (strcasecmp)
--5275-- memcheck GC: 1000 nodes, 23 survivors (2.3%)
--5275-- REDIR: 0x51d0ab0 (libc.so.6:__strspn_sse42) redirected to
0x4840ae0 (strspn)
--5275-- REDIR: 0x51d0830 (libc.so.6:__strcspn_sse42) redirected to
0x4840a00 (strcspn)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- memcheck GC: 1000 nodes, 44 survivors (4.4%)
--5275-- REDIR: 0x51d5880 (libc.so.6:__strnlen_avx2) redirected to
0x483bc20 (strnlen)
--5275-- REDIR: 0x51d0970 (libc.so.6:__strpbrk_sse42) redirected to
0x48409a0 (strpbrk)
--5275-- REDIR: 0x51d1810 (libc.so.6:__rawmemchr_avx2) redirected to
0x4840210 (rawmemchr)
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- WARNING: unhandled amd64-linux syscall: 308
==5275==    at 0x517411B: setns (in /usr/lib/libc-2.30.so)
==5275==    by 0x3EC29A: nsinfo__mountns_enter (namespaces.c:233)
==5275==    by 0x3C0575: open_dso (dso.c:526)
==5275==    by 0x3C2D61: try_to_open_dso (dso.c:661)
==5275==    by 0x3C2D61: dso__data_get_fd (dso.c:690)
==5275==    by 0x3C2D61: dso__type (dso.c:1321)
==5275==    by 0x413EBB: machine__thread_dso_type (vdso.c:151)
==5275==    by 0x413EBB: machine__find_vdso (vdso.c:294)
==5275==    by 0x413EBB: machine__findnew_vdso (vdso.c:332)
==5275==    by 0x3E1EAD: map__new (map.c:198)
==5275==    by 0x3E00EF: machine__process_mmap2_event (machine.c:1697)
==5275==    by 0x4210A0: perf_tool__process_synth_event (synthetic-events.c:63)
==5275==    by 0x4210A0: perf_event__synthesize_mmap_events
(synthetic-events.c:403)
==5275==    by 0x4217A7: __event__synthesize_thread (synthetic-events.c:548)
==5275==    by 0x421BE3: __perf_event__synthesize_threads
(synthetic-events.c:681)
==5275==    by 0x422126: perf_event__synthesize_threads.part.0
(synthetic-events.c:750)
==5275==    by 0x3601E9: trace__symbols_init (builtin-trace.c:1418)
==5275==    by 0x3601E9: trace__run (builtin-trace.c:3340)
==5275==    by 0x3601E9: cmd_trace (builtin-trace.c:4423)
--5275-- You may be able to write your own handler.
--5275-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--5275-- Nevertheless we consider this a bug.  Please report
--5275-- it at http://valgrind.org/support/bug_reports.html.
--5275-- REDIR: 0x51d7910 (libc.so.6:__stpcpy_avx2) redirected to
0x483efa0 (stpcpy)
==5275== Invalid write of size 8
==5275==    at 0x35775D: syscall__set_arg_fmts (builtin-trace.c:1490)
==5275==    by 0x35775D: trace__read_syscall_info.isra.0 (builtin-trace.c:1552)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424ae0 is 0 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275== Invalid read of size 8
==5275==    at 0x3586C1: syscall__mask_val (builtin-trace.c:1685)
==5275==    by 0x3586C1: syscall__scnprintf_args (builtin-trace.c:1744)
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424ae8 is 8 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275== Invalid read of size 8
==5275==    at 0x358798: syscall__scnprintf_val (builtin-trace.c:1694)
==5275==    by 0x358798: syscall__scnprintf_args (builtin-trace.c:1765)
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424ae0 is 0 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275== Invalid read of size 8
==5275==    at 0x3587A0: syscall__scnprintf_val (builtin-trace.c:1696)
==5275==    by 0x3587A0: syscall__scnprintf_args (builtin-trace.c:1765)
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424af0 is 16 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275== Jump to the invalid address stated on the next line
==5275==    at 0xFFFFFFFF: ???
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0xffffffff is not stack'd, malloc'd or (recently) free'd
==5275==
==5275== Warning: invalid file descriptor -1 in syscall close()
==5275==    at 0x48926F7: close (in /usr/lib/libpthread-2.30.so)
==5275==    by 0x4A89CDB: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A897F2: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8A0C2: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A88F5F: backtrace (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x3DACC3: dump_stack (debug.c:263)
==5275==    by 0x3DACC3: sighandler_dump_stack (debug.c:281)
==5275==    by 0x50AFFAF: ??? (in /usr/lib/libc-2.30.so)
==5275==    by 0xFFFFFFFE: ???
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275== Warning: invalid file descriptor -1 in syscall close()
==5275==    at 0x48926F7: close (in /usr/lib/libpthread-2.30.so)
==5275==    by 0x4A89CEE: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A897F2: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8A0C2: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A88F5F: backtrace (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x3DACC3: dump_stack (debug.c:263)
==5275==    by 0x3DACC3: sighandler_dump_stack (debug.c:281)
==5275==    by 0x50AFFAF: ??? (in /usr/lib/libc-2.30.so)
==5275==    by 0xFFFFFFFE: ???
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275== Syscall param write(buf) points to uninitialised byte(s)
==5275==    at 0x516DE9D: syscall (in /usr/lib/libc-2.30.so)
==5275==    by 0x4A89B62: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A89913: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8E60D: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8EB0B: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8A951: _ULx86_64_step (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8B5B2: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A88F74: backtrace (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x3DACC3: dump_stack (debug.c:263)
==5275==    by 0x3DACC3: sighandler_dump_stack (debug.c:281)
==5275==    by 0x50AFFAF: ??? (in /usr/lib/libc-2.30.so)
==5275==    by 0xFFFFFFFE: ???
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==  Address 0x1ffeffb000 is on thread 1's stack
==5275==  in frame #5, created by _ULx86_64_step (???:)
==5275==
==5275==
==5275== Process terminating with default action of signal 11
(SIGSEGV): dumping core
==5275==    at 0x4893793: raise (in /usr/lib/libpthread-2.30.so)
==5275==    by 0x3DAD2A: sighandler_dump_stack (debug.c:283)
==5275==    by 0x50AFFAF: ??? (in /usr/lib/libc-2.30.so)
==5275==    by 0xFFFFFFFE: ???
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275== HEAP SUMMARY:
==5275==     in use at exit: 2,945,429 bytes in 20,148 blocks
==5275==   total heap usage: 108,615 allocs, 88,467 frees, 151,839,107
bytes allocated
==5275==
==5275== Searching for pointers to 20,148 not-freed blocks
==5275== Checked 12,224,960 bytes
==5275==
==5275== LEAK SUMMARY:
==5275==    definitely lost: 96 bytes in 11 blocks
==5275==    indirectly lost: 0 bytes in 0 blocks
==5275==      possibly lost: 426,466 bytes in 8,502 blocks
==5275==    still reachable: 2,518,867 bytes in 11,635 blocks
==5275==         suppressed: 0 bytes in 0 blocks
==5275== Rerun with --leak-check=full to see details of leaked memory
==5275==
==5275== Use --track-origins=yes to see where uninitialised values come from
==5275== ERROR SUMMARY: 1502 errors from 6 contexts (suppressed: 0 from 0)
==5275==
==5275== 1 errors in context 1 of 6:
==5275== Jump to the invalid address stated on the next line
==5275==    at 0xFFFFFFFF: ???
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0xffffffff is not stack'd, malloc'd or (recently) free'd
==5275==
==5275==
==5275== 2 errors in context 2 of 6:
==5275== Syscall param write(buf) points to uninitialised byte(s)
==5275==    at 0x516DE9D: syscall (in /usr/lib/libc-2.30.so)
==5275==    by 0x4A89B62: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A89913: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8E60D: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8EB0B: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8A951: _ULx86_64_step (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A8B5B2: ??? (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x4A88F74: backtrace (in /usr/lib/libunwind.so.8.0.1)
==5275==    by 0x3DACC3: dump_stack (debug.c:263)
==5275==    by 0x3DACC3: sighandler_dump_stack (debug.c:281)
==5275==    by 0x50AFFAF: ??? (in /usr/lib/libc-2.30.so)
==5275==    by 0xFFFFFFFE: ???
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==  Address 0x1ffeffb000 is on thread 1's stack
==5275==  in frame #5, created by _ULx86_64_step (???:)
==5275==
==5275==
==5275== 5 errors in context 3 of 6:
==5275== Invalid write of size 8
==5275==    at 0x35775D: syscall__set_arg_fmts (builtin-trace.c:1490)
==5275==    by 0x35775D: trace__read_syscall_info.isra.0 (builtin-trace.c:1552)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424ae0 is 0 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275==
==5275== 498 errors in context 4 of 6:
==5275== Invalid read of size 8
==5275==    at 0x3587A0: syscall__scnprintf_val (builtin-trace.c:1696)
==5275==    by 0x3587A0: syscall__scnprintf_args (builtin-trace.c:1765)
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424af0 is 16 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275==
==5275== 498 errors in context 5 of 6:
==5275== Invalid read of size 8
==5275==    at 0x358798: syscall__scnprintf_val (builtin-trace.c:1694)
==5275==    by 0x358798: syscall__scnprintf_args (builtin-trace.c:1765)
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424ae0 is 0 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275==
==5275== 498 errors in context 6 of 6:
==5275== Invalid read of size 8
==5275==    at 0x3586C1: syscall__mask_val (builtin-trace.c:1685)
==5275==    by 0x3586C1: syscall__scnprintf_args (builtin-trace.c:1744)
==5275==    by 0x35A311: trace__sys_enter (builtin-trace.c:1994)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==  Address 0x5424ae8 is 8 bytes after a block of size 0 alloc'd
==5275==    at 0x483AB65: calloc (vg_replace_malloc.c:762)
==5275==    by 0x3571A2: syscall__alloc_arg_fmts (builtin-trace.c:1443)
==5275==    by 0x3571A2: trace__read_syscall_info.isra.0 (builtin-trace.c:1532)
==5275==    by 0x357875: trace__syscall_info (builtin-trace.c:1825)
==5275==    by 0x35A1D6: trace__sys_enter (builtin-trace.c:1955)
==5275==    by 0x356BDB: trace__handle_event (builtin-trace.c:2707)
==5275==    by 0x356BDB: __trace__deliver_event (builtin-trace.c:3218)
==5275==    by 0x36120B: trace__deliver_event (builtin-trace.c:3245)
==5275==    by 0x36120B: trace__run (builtin-trace.c:3459)
==5275==    by 0x36120B: cmd_trace (builtin-trace.c:4423)
==5275==    by 0x390162: run_builtin (perf.c:312)
==5275==    by 0x30B32B: handle_internal_command (perf.c:364)
==5275==    by 0x30B32B: run_argv (perf.c:408)
==5275==    by 0x30B32B: main (perf.c:538)
==5275==
==5275== ERROR SUMMARY: 1502 errors from 6 contexts (suppressed: 0 from 0)


On Mon, Nov 18, 2019 at 9:33 AM Santiago Pastorino <spastorino@gmail.com> wrote:
>
> Hi,
>
> I'm currently running Linux kernel 5.3.11-arch1-1 and I'm getting a segfault
> when I run `perf trace` after some seconds.
> Here I'm pasting the backtrace:
>
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0 0x00007fdbb2615a40 in main_arena () from /usr/lib/libc.so.6
> (gdb) bt
> #0 0x00007fdbb2615a40 in main_arena () from /usr/lib/libc.so.6
> #1 0x0000562fc44e22d7 in syscall__scnprintf_val (sc=0x562fc50cc4a0,
> val=6, arg=0x7ffd10440870, size=2021, bf=0x562fc52b722b "") at
> builtin-trace.c:1649
> #2 syscall__scnprintf_args (sc=sc@entry=0x562fc50cc4a0,
> bf=0x562fc52b721b "fd: 223, level: ", size=2037,
> args=args@entry=0x7fdbb21a118c <error: Cannot access memory at address
> 0x7fdbb21a118c>, augmented_args=augmented_args@entry=0x0,
> augmented_args_size=augmented_args_size@entry=0, trace=0x7ffd10440fa0,
> thread=0x562fc51da000) at builtin-trace.c:1716
> #3 0x0000562fc44e3e22 in trace__sys_enter (trace=0x7ffd10440fa0,
> evsel=<optimized out>, event=<optimized out>, sample=0x7ffd10440990)
> at builtin-trace.c:1935
> #4 0x0000562fc44e11ac in trace__handle_event (sample=0x7ffd10440990,
> event=0x7fdbb21a1140, trace=0x7ffd10440fa0) at builtin-trace.c:2645
> #5 __trace__deliver_event (trace=trace@entry=0x7ffd10440fa0,
> event=0x7fdbb21a1140) at builtin-trace.c:2899
> #6 0x0000562fc44ea7dc in trace__deliver_event (event=<optimized out>,
> trace=0x7ffd10440fa0) at builtin-trace.c:2926
> #7 trace__run (argv=<optimized out>, argc=<optimized out>,
> trace=0x7ffd10440fa0) at builtin-trace.c:3124
> #8 cmd_trace (argc=<optimized out>, argv=<optimized out>) at
> builtin-trace.c:4060
> #9 0x0000562fc4519043 in run_builtin (p=0x562fc4a026c0 <commands+576>,
> argc=1, argv=0x7ffd10444560) at perf.c:304
> #10 0x0000562fc44952fc in handle_internal_command (argv=<optimized
> out>, argc=<optimized out>) at perf.c:356
> #11 run_argv (argcp=<optimized out>, argv=<optimized out>) at perf.c:400
> #12 main (argc=1, argv=0x7ffd10444560) at perf.c:522
> (gdb) quit
>
> # perf --version
> perf version 5.3.g4d856f72c10e
>
> Thanks for reading and feel free to cc me in replies since I'm not
> subscribed to lkml.
