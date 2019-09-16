Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B4AC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317D7214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568638413;
	bh=OH894bLha2fMUaFbPrQ0KBIaHzUwcWSwPhIKIpFVMsg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=fSwRKDZ9djDfbxbXUqv0K0QngD9bfeekB8vpiNV2y2XW0XdV3fKEgbcHGv9UrY0ol
	 QZGiLR0NCv33mA2Jd/jlhNjHIAhakUHhWmJS2QEJ1eLuTAMWuHYnhy/E1n6bPNiAyk
	 qEg9qKxjU4VDz4EsfAqgxvvSAX9Qdzm7lo/Y1Uz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfIPMxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:53:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55116 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732709AbfIPMxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:53:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so10015221wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GR8OA5Tk9Fiz8+vean7hB//ZCZZwQu81rsX2FiJ38uU=;
        b=Z+J4d+lZrfwKiarN8uwYakcyGUKf/4676S/Euz5yWC9yCztRdy9D74oEkWOkMFA7Yi
         jMae3zJJxHxjwf4fkdDJLiokK9FtC5Kkld4T8FTIRwbV2U61oTND+uaVyuWqY6Jag7S4
         53gIPxVmaoXK3LdPk01Gs7Dd7nrjy+7YWPKN3bMJFnm81LpANbz1LmPabant8OnLyiDZ
         tbBQyiyuMlahQaqZwXw8AIq/C3giF10gXoGMTQSR8UTJ2FMWWzOIbmwdzX1ZWN1Bws7q
         /6wGrbWiLfQkANWcCmj4orTBP7OUoiu4FvtmwbBbiHKpYmW97BcnVUwByZ9oQOP7M7fz
         I1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=GR8OA5Tk9Fiz8+vean7hB//ZCZZwQu81rsX2FiJ38uU=;
        b=I2aoE8PxPUnEuG45QjpyfrOtcvZ7+aM5gP0gCWAhln5vEyxReDpb3oV9coKrmiiT0N
         B9ye61SWgQhcrxx88BhbvnKWWiKXvpJcW80YSCHqF5+DJEx5x0UGIBC0HrDCZOu+VzKJ
         DdWG4vSKEKwcWmzY+oHTyrVggojRyxE5msgJdhb+HXUgoHCfKkA2PxBGlhqD1qdzaALX
         V8+D7nBW17S1SOQ/WyyC02IexvqLOuq1F90xUT8CO3grEbNgH/3/rk8wFif5htpSeRgX
         vyL4DPGt5M1VfbLAFEQ3o/DUB1pL6OtmThKb56D9tnYtjJoi5nJY7l8i37JEIcekJotM
         rVpQ==
X-Gm-Message-State: APjAAAWcjBSTc8PKWdqdsj+XZeJ+PduhX1qBafIbQM+LAM7Q8mfjUV2s
        /RnvDnFjXQ/dHiXxVZ/BIKM=
X-Google-Smtp-Source: APXvYqzU2AWiziFk4IJKPQX15hHK/4HlCBLQqGfOZ8B/eeBuRVj4qpPN0X3yfFaPJeoa8wwQ5iq9cQ==
X-Received: by 2002:a7b:c108:: with SMTP id w8mr2573893wmi.8.1568638409707;
        Mon, 16 Sep 2019 05:53:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y12sm27503913wrn.74.2019.09.16.05.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:53:29 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:53:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v5.4
Message-ID: <20190916125327.GA31120@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

   # HEAD: 0cc5359d8fd45bc410906e009117e78e2b5b2322 x86/cpu: Update init data for new Airmont CPU model

The changes in this cycle were:

 - Rework the Intel model names symbols/macros, which were decades of 
   ad-hoc extensions and added random noise. It's now a coherent, easy to 
   follow nomenclature.

 - Add new Intel CPU model IDs:
   - "Tiger Lake" desktop and mobile models,
   - "Elkhart Lake" model ID,
   - and the "Lightning Mountain" variant of Airmont, plus support code.

 - Add the new AVX512_VP2INTERSECT instruction to cpufeatures

 - Remove Intel MPX user-visible APIs and the self-tests, because the 
   toolchain (gcc) is not supporting it going forward. This is the first, 
   lowest-risk phase of MPX removal.

 - Remove X86_FEATURE_MFENCE_RDTSC.

 - Various smaller cleanups and fixes.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/msr-index: Move AMD MSRs where they belong

Cao Jin (1):
      x86/cpufeature: Explain the macro duplication

Dave Hansen (3):
      x86/mpx: Remove selftests Makefile entry
      x86/mpx: Remove selftests themselves
      x86/mpx: Remove MPX APIs

Gayatri Kammela (4):
      cpu/cpuid-deps: Add a tab to cpuid dependent features
      x86/cpufeatures: Enable a new AVX512 CPU feature
      x86/cpu: Add Tiger Lake to Intel family
      x86/cpu: Add Elkhart Lake to Intel family

Jisheng Zhang (1):
      x86/ftrace: Remove mcount() declaration

Josh Poimboeuf (1):
      x86: Remove X86_FEATURE_MFENCE_RDTSC

Krzysztof Wilczynski (1):
      x86/PCI: Remove superfluous returns from void functions

Marco Ammon (1):
      x86: Correct misc typos

Mark Rutland (1):
      lib: Remove redundant ftrace flag removal

Masahiro Yamada (1):
      x86/bitops: Use __builtin_constant_p() directly instead of IS_IMMEDIATE()

Nikolas Nyby (1):
      x86/crash: Remove unnecessary comparison

Peter Zijlstra (5):
      x86/intel: Aggregate big core client naming
      x86/intel: Aggregate big core mobile naming
      x86/intel: Aggregate big core graphics naming
      x86/intel: Aggregate microserver naming
      x86/intel: Add common OPTDIFFs

Pingfan Liu (1):
      x86/realmode: Remove trampoline_status

Rahul Tanwar (3):
      x86/cpu: Use constant definitions for CPU models
      x86/cpu: Add new Airmont variant to Intel family
      x86/cpu: Update init data for new Airmont CPU model


 arch/x86/events/intel/core.c                 |   74 +-
 arch/x86/events/intel/cstate.c               |   40 +-
 arch/x86/events/intel/pt.c                   |    6 +-
 arch/x86/events/intel/rapl.c                 |   28 +-
 arch/x86/events/intel/uncore.c               |   28 +-
 arch/x86/events/msr.c                        |   26 +-
 arch/x86/include/asm/barrier.h               |    3 +-
 arch/x86/include/asm/bitops.h                |    7 +-
 arch/x86/include/asm/cpufeature.h            |    7 +
 arch/x86/include/asm/cpufeatures.h           |    2 +-
 arch/x86/include/asm/intel-family.h          |   60 +-
 arch/x86/include/asm/msr-index.h             |   13 +-
 arch/x86/include/asm/msr.h                   |    3 +-
 arch/x86/include/asm/realmode.h              |    1 -
 arch/x86/include/asm/text-patching.h         |    4 +-
 arch/x86/kernel/alternative.c                |    6 +-
 arch/x86/kernel/apic/apic.c                  |   20 +-
 arch/x86/kernel/cpu/amd.c                    |   21 +-
 arch/x86/kernel/cpu/bugs.c                   |   18 +-
 arch/x86/kernel/cpu/common.c                 |    5 +-
 arch/x86/kernel/cpu/cpuid-deps.c             |   97 +-
 arch/x86/kernel/cpu/hygon.c                  |   21 +-
 arch/x86/kernel/cpu/intel.c                  |   31 +-
 arch/x86/kernel/cpu/mce/intel.c              |    2 +-
 arch/x86/kernel/crash.c                      |    2 -
 arch/x86/kernel/kprobes/opt.c                |    2 +-
 arch/x86/kernel/quirks.c                     |    4 -
 arch/x86/kernel/smpboot.c                    |    5 -
 arch/x86/kernel/tsc.c                        |    2 +-
 arch/x86/kernel/tsc_msr.c                    |    5 +
 arch/x86/realmode/rm/header.S                |    1 -
 arch/x86/realmode/rm/trampoline_32.S         |    3 -
 arch/x86/realmode/rm/trampoline_64.S         |    3 -
 arch/x86/realmode/rm/trampoline_common.S     |    4 -
 drivers/acpi/x86/utils.c                     |    4 +-
 drivers/cpufreq/intel_pstate.c               |   26 +-
 drivers/edac/i10nm_base.c                    |    4 +-
 drivers/edac/pnd2_edac.c                     |    2 +-
 drivers/edac/sb_edac.c                       |    2 +-
 drivers/idle/intel_idle.c                    |   28 +-
 drivers/platform/x86/intel_pmc_core.c        |   12 +-
 drivers/platform/x86/intel_pmc_core_pltdrv.c |   12 +-
 drivers/powercap/intel_rapl_common.c         |   32 +-
 include/uapi/linux/prctl.h                   |    2 +-
 kernel/sys.c                                 |   16 +-
 lib/Makefile                                 |    4 -
 tools/arch/x86/include/asm/cpufeatures.h     |    1 -
 tools/power/x86/turbostat/turbostat.c        |  130 +--
 tools/testing/selftests/x86/Makefile         |    2 +-
 tools/testing/selftests/x86/mpx-debug.h      |   15 -
 tools/testing/selftests/x86/mpx-dig.c        |  497 --------
 tools/testing/selftests/x86/mpx-hw.h         |  124 --
 tools/testing/selftests/x86/mpx-mini-test.c  | 1613 --------------------------
 tools/testing/selftests/x86/mpx-mm.h         |   10 -
 54 files changed, 394 insertions(+), 2696 deletions(-)
 delete mode 100644 tools/testing/selftests/x86/mpx-debug.h
 delete mode 100644 tools/testing/selftests/x86/mpx-dig.c
 delete mode 100644 tools/testing/selftests/x86/mpx-hw.h
 delete mode 100644 tools/testing/selftests/x86/mpx-mini-test.c
 delete mode 100644 tools/testing/selftests/x86/mpx-mm.h
