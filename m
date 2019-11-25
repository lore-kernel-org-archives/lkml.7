Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4382068F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574698110;
	bh=Ngg9SkgskXjPCL4Y8GsxRQzSMwbtRJSS0pCYAAWoQlU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cB/7ivS2J4eWt19rR5tF/1iOx6itwtkUCUTHGWAXchLSeIPWoRZOfvW3ZzHNJvzPN
	 /M6nxsPLV8ywCmr1cGiAbcRrgRpHo9xtbYlwJ1fDlSVC0rKRdYVGgWqdqc4wqm3Ql4
	 ooffB2k/pw6BtEPk02oOtknn9wyRNQewAgy51cDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfKYQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:08:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40531 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfKYQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:08:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id y5so16610566wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=goV778ckOehj7w0Yi1uhR/jlexk3GiKSg6DeetWiPKM=;
        b=ZsgaXSYfioiTvcRwNKcmWwB3TPbg/VWrhuDo5wteG2otDxmDO/eQySmK5KcKNC/a7h
         RRl6WfMdu0d3TCztxVFnUtKgTTp+bOuUKFCpfDi1KINQSSxzCkorxcoGndm40o6IGzpd
         o6EZ302xzjQCU2CcmPT/TJdMB6T1dFI3eBxATldvaNMwcoyBRFB+aHNGC8FupNmArlFX
         ol13bAhDEPcVHddNVS4P+QCZ0dptNSGGy2Yw4ThDQYYl+61VoIEIxHAJo75jKn7NiwQv
         Rw5bDIZmvxMGq2/q36zJjHNyJA86Qh1eUgHVSSvJqLucKtJrcaIBqhIC6QtxAdk7Bo9a
         a7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=goV778ckOehj7w0Yi1uhR/jlexk3GiKSg6DeetWiPKM=;
        b=CUv4GuE3jAtqd+cXP/cRUuPWzFBsAq/Z6GvrtQnCoDPJXiYoxeKH/lplAr+s7ecXsR
         KYvWpKbI6r8YxBuQak4tpT0UJQkegfn47CEfGpD2uJLc+iJnTpmpcJNsUroyCazGLnZh
         /tKgE/t85yO8cR8Hk82wfhKDOiQQsgHLxTGeRIpqHakB17lXoDO9K03khIkccfxL9PWy
         ZZubQgDB8yuy4JhvXqyKYhe38JrCffRFihJHnOe/UHcTW/xw6Pd0o92H75Zh4FJYMdlU
         r80/zFRX68qXosldlYIHjOjWUNAzV+eU2asLD9fRh2A+8jIJT9i66wCZaqf++OYJ1ZYk
         AEKA==
X-Gm-Message-State: APjAAAWz1HNLJwFvr/QfAtACiVCm3669Eer2xlywC3qbvVXt/7WJLoqL
        aqplYzNDzC9d8JOtFjOj42c=
X-Google-Smtp-Source: APXvYqxR6a8bj2dJ4m8IkbWUmXejTD8B8S7ohuy0SY87VGbHYxSJ7DxilWM+AW2ZH5fua2I8yRiNQA==
X-Received: by 2002:a05:600c:2143:: with SMTP id v3mr29084800wml.3.1574698104379;
        Mon, 25 Nov 2019 08:08:24 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t185sm9310924wmf.45.2019.11.25.08.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 08:08:23 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:08:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v5.5
Message-ID: <20191125160821.GA42496@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: f01ec4fca8207e31b59a010c3de679c833f3a877 Merge branch 'x86/build' into x86/asm, to pick up completed topic branch

The main changes in this cycle were:

 - Cross-arch changes to move the linker sections for NOTES and 
   EXCEPTION_TABLE into the RO_DATA area, where they belong on most 
   architectures. (Kees Cook)

 - Switch the x86 linker fill byte from x90 (NOP) to 0xcc (INT3), to trap
   jumps into the middle of those padding areas instead of sliding execution.
   (Kees Cook)

 - A thorough cleanup of symbol definitions within x86 assembler code. 
   The rather randomly named macros got streamlined around a (hopefully) 
   straightforward naming scheme:

	SYM_START(name, linkage, align...)
	SYM_END(name, sym_type)

	SYM_FUNC_START(name)
	SYM_FUNC_END(name)

	SYM_CODE_START(name)
	SYM_CODE_END(name)

	SYM_DATA_START(name)
	SYM_DATA_END(name)

        etc. - with about three times of these basic primitives with some 
        label, local symbol or attribute variant, expressed via 
        postfixes.

    No change in functionality intended.

    (Jiri Slaby)

  - Misc other changes, cleanups and smaller fixes.

Unfortunately the symbol rework will generate conflicts with pending 
changes to assembly files.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/ftrace: Get rid of function_hook

Bruce Ashfield (1):
      arch/x86/boot: Use prefix map to avoid embedded paths

Jiri Slaby (31):
      x86/asm: Reorder early variables
      x86/asm: Make boot_gdt_descr local
      x86/asm: Make more symbols local
      linkage: Introduce new macros for assembler symbols
      x86/asm/suspend: Use SYM_DATA for data
      x86/asm: Annotate relocate_kernel_{32,64}.c
      x86/asm/entry: Annotate THUNKs
      x86/asm: Annotate local pseudo-functions
      x86/asm/crypto: Annotate local functions
      x86/boot: Annotate local functions
      x86/uaccess: Annotate local function
      x86/asm: Annotate aliases
      x86/asm/entry: Annotate interrupt symbols properly
      x86/asm/head: Annotate data appropriately
      x86/boot: Annotate data appropriately
      x86/um: Annotate data appropriately
      xen/pvh: Annotate data appropriately
      x86/asm/purgatory: Start using annotations
      x86/asm: Do not annotate functions with GLOBAL
      x86/asm: Use SYM_INNER_LABEL instead of GLOBAL
      x86/asm/realmode: Use SYM_DATA_* instead of GLOBAL
      x86/asm: Remove the last GLOBAL user and remove the macro
      x86/asm: Make some functions local
      x86/asm/ftrace: Mark function_hook as function
      x86/asm/64: Add ENDs to some functions and relabel with SYM_CODE_*
      x86/asm/64: Change all ENTRY+END to SYM_CODE_*
      x86/asm: Change all ENTRY+ENDPROC to SYM_FUNC_*
      x86/asm/32: Add ENDs to some functions and relabel with SYM_CODE_*
      x86/asm/32: Change all ENTRY+END to SYM_CODE_*
      x86/asm/32: Change all ENTRY+ENDPROC to SYM_FUNC_*
      x86/asm: Replace WEAK uses by SYM_INNER_LABEL_ALIGN

Kees Cook (30):
      powerpc: Rename "notes" PT_NOTE to "note"
      powerpc: Remove PT_NOTE workaround
      powerpc: Rename PT_LOAD identifier "kernel" to "text"
      alpha: Rename PT_LOAD identifier "kernel" to "text"
      ia64: Rename PT_LOAD identifier "code" to "text"
      s390: Move RO_DATA into "text" PT_LOAD Program Header
      x86/vmlinux: Restore "text" Program Header with dummy section
      vmlinux.lds.h: Provide EMIT_PT_NOTE to indicate export of .notes
      vmlinux.lds.h: Move Program Header restoration into NOTES macro
      vmlinux.lds.h: Move NOTES into RO_DATA
      vmlinux.lds.h: Replace RODATA with RO_DATA
      vmlinux.lds.h: Replace RO_DATA_SECTION with RO_DATA
      vmlinux.lds.h: Replace RW_DATA_SECTION with RW_DATA
      vmlinux.lds.h: Allow EXCEPTION_TABLE to live in RO_DATA
      x86/vmlinux: Actually use _etext for the end of the text segment
      x86/vmlinux: Move EXCEPTION_TABLE to RO_DATA segment
      alpha: Move EXCEPTION_TABLE to RO_DATA segment
      arm64: Move EXCEPTION_TABLE to RO_DATA segment
      c6x: Move EXCEPTION_TABLE to RO_DATA segment
      h8300: Move EXCEPTION_TABLE to RO_DATA segment
      ia64: Move EXCEPTION_TABLE to RO_DATA segment
      microblaze: Move EXCEPTION_TABLE to RO_DATA segment
      parisc: Move EXCEPTION_TABLE to RO_DATA segment
      powerpc: Move EXCEPTION_TABLE to RO_DATA segment
      xtensa: Move EXCEPTION_TABLE to RO_DATA segment
      x86/mm: Remove redundant address-of operators on addresses
      x86/mm: Report which part of kernel image is freed
      x86/mm: Report actual image regions in /proc/iomem
      x86/vmlinux: Use INT3 instead of NOP for linker fill bytes
      m68k: Convert missed RODATA to RO_DATA

Masahiro Yamada (1):
      x86/build/vdso: Remove meaningless CFLAGS_REMOVE_*.o

Peter Zijlstra (1):
      ubsan, x86: Annotate and allow __ubsan_handle_shift_out_of_bounds() in uaccess regions

Thomas Gleixner (2):
      x86/entry/32: Remove unused resume_userspace label
      x86/entry/64: Remove pointless jump in paranoid_exit


 Documentation/asm-annotations.rst            | 216 +++++++++++++++++++++++
 Documentation/index.rst                      |   8 +
 arch/alpha/kernel/vmlinux.lds.S              |  18 +-
 arch/arc/kernel/vmlinux.lds.S                |   6 +-
 arch/arm/kernel/vmlinux-xip.lds.S            |   4 +-
 arch/arm/kernel/vmlinux.lds.S                |   4 +-
 arch/arm64/kernel/vmlinux.lds.S              |  10 +-
 arch/c6x/kernel/vmlinux.lds.S                |   8 +-
 arch/csky/kernel/vmlinux.lds.S               |   5 +-
 arch/h8300/kernel/vmlinux.lds.S              |   9 +-
 arch/hexagon/kernel/vmlinux.lds.S            |   5 +-
 arch/ia64/kernel/vmlinux.lds.S               |  20 +--
 arch/m68k/kernel/vmlinux-nommu.lds           |   4 +-
 arch/m68k/kernel/vmlinux-std.lds             |   4 +-
 arch/m68k/kernel/vmlinux-sun3.lds            |   4 +-
 arch/microblaze/kernel/vmlinux.lds.S         |   8 +-
 arch/mips/kernel/vmlinux.lds.S               |  15 +-
 arch/nds32/kernel/vmlinux.lds.S              |   5 +-
 arch/nios2/kernel/vmlinux.lds.S              |   5 +-
 arch/openrisc/kernel/vmlinux.lds.S           |   7 +-
 arch/parisc/kernel/vmlinux.lds.S             |  11 +-
 arch/powerpc/kernel/vmlinux.lds.S            |  37 +---
 arch/riscv/kernel/vmlinux.lds.S              |   5 +-
 arch/s390/kernel/vmlinux.lds.S               |  12 +-
 arch/sh/kernel/vmlinux.lds.S                 |   3 +-
 arch/sparc/kernel/vmlinux.lds.S              |   3 +-
 arch/um/include/asm/common.lds.S             |   3 +-
 arch/unicore32/kernel/vmlinux.lds.S          |   5 +-
 arch/x86/boot/Makefile                       |   1 +
 arch/x86/boot/compressed/Makefile            |   1 +
 arch/x86/boot/compressed/efi_stub_32.S       |   4 +-
 arch/x86/boot/compressed/efi_thunk_64.S      |  33 ++--
 arch/x86/boot/compressed/head_32.S           |  15 +-
 arch/x86/boot/compressed/head_64.S           |  63 +++----
 arch/x86/boot/compressed/mem_encrypt.S       |  11 +-
 arch/x86/boot/copy.S                         |  16 +-
 arch/x86/boot/pmjump.S                       |  10 +-
 arch/x86/crypto/aegis128-aesni-asm.S         |  36 ++--
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S      |  12 +-
 arch/x86/crypto/aesni-intel_asm.S            | 114 ++++++------
 arch/x86/crypto/aesni-intel_avx-x86_64.S     |  32 ++--
 arch/x86/crypto/blowfish-x86_64-asm_64.S     |  16 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S  |  44 ++---
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  44 ++---
 arch/x86/crypto/camellia-x86_64-asm_64.S     |  16 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S    |  24 +--
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S    |  32 ++--
 arch/x86/crypto/chacha-avx2-x86_64.S         |  12 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S     |  12 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S        |  16 +-
 arch/x86/crypto/crc32-pclmul_asm.S           |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S       |   4 +-
 arch/x86/crypto/des3_ede-asm_64.S            |   8 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S    |  12 +-
 arch/x86/crypto/nh-avx2-x86_64.S             |   4 +-
 arch/x86/crypto/nh-sse2-x86_64.S             |   4 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S       |   4 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S       |   8 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S  |  32 ++--
 arch/x86/crypto/serpent-avx2-asm_64.S        |  32 ++--
 arch/x86/crypto/serpent-sse2-i586-asm_32.S   |   8 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S |   8 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S       |   4 +-
 arch/x86/crypto/sha1_ni_asm.S                |   4 +-
 arch/x86/crypto/sha1_ssse3_asm.S             |   4 +-
 arch/x86/crypto/sha256-avx-asm.S             |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S            |   4 +-
 arch/x86/crypto/sha256-ssse3-asm.S           |   4 +-
 arch/x86/crypto/sha256_ni_asm.S              |   4 +-
 arch/x86/crypto/sha512-avx-asm.S             |   4 +-
 arch/x86/crypto/sha512-avx2-asm.S            |   4 +-
 arch/x86/crypto/sha512-ssse3-asm.S           |   4 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S  |  32 ++--
 arch/x86/crypto/twofish-i586-asm_32.S        |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S      |   8 +-
 arch/x86/entry/entry_32.S                    | 162 ++++++++---------
 arch/x86/entry/entry_64.S                    | 112 ++++++------
 arch/x86/entry/entry_64_compat.S             |  16 +-
 arch/x86/entry/thunk_32.S                    |   4 +-
 arch/x86/entry/thunk_64.S                    |   7 +-
 arch/x86/entry/vdso/Makefile                 |   2 -
 arch/x86/entry/vdso/vdso32/system_call.S     |   2 +-
 arch/x86/include/asm/linkage.h               |   4 -
 arch/x86/include/asm/processor.h             |   2 +-
 arch/x86/include/asm/sections.h              |   1 -
 arch/x86/kernel/acpi/wakeup_32.S             |   9 +-
 arch/x86/kernel/acpi/wakeup_64.S             |  10 +-
 arch/x86/kernel/ftrace_32.S                  |  23 ++-
 arch/x86/kernel/ftrace_64.S                  |  47 +++--
 arch/x86/kernel/head_32.S                    |  62 +++----
 arch/x86/kernel/head_64.S                    | 113 ++++++------
 arch/x86/kernel/irqflags.S                   |   8 +-
 arch/x86/kernel/relocate_kernel_32.S         |  13 +-
 arch/x86/kernel/relocate_kernel_64.S         |  13 +-
 arch/x86/kernel/setup.c                      |  12 +-
 arch/x86/kernel/verify_cpu.S                 |   4 +-
 arch/x86/kernel/vmlinux.lds.S                |  16 +-
 arch/x86/kvm/vmx/vmenter.S                   |  12 +-
 arch/x86/lib/atomic64_386_32.S               |   4 +-
 arch/x86/lib/atomic64_cx8_32.S               |  32 ++--
 arch/x86/lib/checksum_32.S                   |  16 +-
 arch/x86/lib/clear_page_64.S                 |  12 +-
 arch/x86/lib/cmpxchg16b_emu.S                |   4 +-
 arch/x86/lib/cmpxchg8b_emu.S                 |   4 +-
 arch/x86/lib/copy_page_64.S                  |   8 +-
 arch/x86/lib/copy_user_64.S                  |  21 ++-
 arch/x86/lib/csum-copy_64.S                  |   4 +-
 arch/x86/lib/getuser.S                       |  22 +--
 arch/x86/lib/hweight.S                       |   8 +-
 arch/x86/lib/iomap_copy_64.S                 |   4 +-
 arch/x86/lib/memcpy_64.S                     |  20 +--
 arch/x86/lib/memmove_64.S                    |   8 +-
 arch/x86/lib/memset_64.S                     |  16 +-
 arch/x86/lib/msr-reg.S                       |   8 +-
 arch/x86/lib/putuser.S                       |  19 +-
 arch/x86/lib/retpoline.S                     |   4 +-
 arch/x86/math-emu/div_Xsig.S                 |   4 +-
 arch/x86/math-emu/div_small.S                |   4 +-
 arch/x86/math-emu/mul_Xsig.S                 |  12 +-
 arch/x86/math-emu/polynom_Xsig.S             |   4 +-
 arch/x86/math-emu/reg_norm.S                 |   8 +-
 arch/x86/math-emu/reg_round.S                |   4 +-
 arch/x86/math-emu/reg_u_add.S                |   4 +-
 arch/x86/math-emu/reg_u_div.S                |   4 +-
 arch/x86/math-emu/reg_u_mul.S                |   4 +-
 arch/x86/math-emu/reg_u_sub.S                |   4 +-
 arch/x86/math-emu/round_Xsig.S               |   8 +-
 arch/x86/math-emu/shr_Xsig.S                 |   4 +-
 arch/x86/math-emu/wm_shrx.S                  |   8 +-
 arch/x86/math-emu/wm_sqrt.S                  |   4 +-
 arch/x86/mm/init.c                           |   8 +-
 arch/x86/mm/init_64.c                        |  16 +-
 arch/x86/mm/mem_encrypt_boot.S               |   8 +-
 arch/x86/mm/pti.c                            |   2 +-
 arch/x86/platform/efi/efi_stub_32.S          |   4 +-
 arch/x86/platform/efi/efi_stub_64.S          |   4 +-
 arch/x86/platform/efi/efi_thunk_64.S         |  16 +-
 arch/x86/platform/olpc/xo1-wakeup.S          |   3 +-
 arch/x86/platform/pvh/head.S                 |  18 +-
 arch/x86/power/hibernate_asm_32.S            |  14 +-
 arch/x86/power/hibernate_asm_64.S            |  14 +-
 arch/x86/purgatory/entry64.S                 |  24 +--
 arch/x86/purgatory/setup-x86_64.S            |  14 +-
 arch/x86/purgatory/stack.S                   |   7 +-
 arch/x86/realmode/rm/header.S                |   8 +-
 arch/x86/realmode/rm/reboot.S                |  13 +-
 arch/x86/realmode/rm/stack.S                 |  14 +-
 arch/x86/realmode/rm/trampoline_32.S         |  16 +-
 arch/x86/realmode/rm/trampoline_64.S         |  29 ++--
 arch/x86/realmode/rm/trampoline_common.S     |   2 +-
 arch/x86/realmode/rm/wakeup_asm.S            |  17 +-
 arch/x86/realmode/rmpiggy.S                  |  10 +-
 arch/x86/um/vdso/vdso.S                      |   6 +-
 arch/x86/xen/xen-asm.S                       |  28 +--
 arch/x86/xen/xen-asm_32.S                    |   7 +-
 arch/x86/xen/xen-asm_64.S                    |  34 ++--
 arch/x86/xen/xen-head.S                      |   8 +-
 arch/xtensa/kernel/vmlinux.lds.S             |   8 +-
 include/asm-generic/vmlinux.lds.h            |  53 ++++--
 include/linux/linkage.h                      | 249 ++++++++++++++++++++++++++-
 lib/ubsan.c                                  |   5 +-
 tools/objtool/check.c                        |   1 +
 164 files changed, 1654 insertions(+), 1186 deletions(-)
 create mode 100644 Documentation/asm-annotations.rst
