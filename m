Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2844ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859812084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570454222;
	bh=XoFW+ekSYf0M5/T9tOhQY2yAWdkCSpxOTSPBpQSw2FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oEO8iNrj+vpymqPYIyhKa5LlFchmwjWcdwyZlKy/kZCV4byxi8NiftCi5f5uL00vf
	 0P1s9VAxCpiTqHByOtB/nq2gz08/uI3LnLHeGHAxO6GbfdkZ4dO6TF4vW0lAyjippY
	 K97oVvhswSK7ZbuQTfpVQ60mkDf0J81K0FlxzivA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfJGNRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:17:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfJGNRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:17:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so12306700wmi.0;
        Mon, 07 Oct 2019 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DmNvj1LW7fFN9Rp6lW/yzKwMB5gqp916EvWviVuWxfo=;
        b=sdiXL7eZEbERg+K45SIU0YFQm7SxK76LlL33k+2/FSYlm9c6BUYOJxenQOrYbJ4B5V
         DdnceF+QfLaGxkY1j3AlrBAeaCmF1EDiRzh8rWSkesTUE3v6YdtO9StJhioli3JHz8aa
         PmlIDFnOUB/kc0Yr2sEIg6zQdzekaWFYmRsEL32c3ELKblbTvolJx8qrfSzIToq2zW3l
         H9hEULrnX8bfw9O53AjIltpLZc2N24Rbu7WbzoC5VcFv/LiiOgHjUsH+2rN3O48tU+At
         HX4tKNGCydzffuq7BPFjUioOJFD4a9LetQSZukVffF0GelSgDg6ACETN0pP1xy1MnW/n
         dUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmNvj1LW7fFN9Rp6lW/yzKwMB5gqp916EvWviVuWxfo=;
        b=UnGllXGxRqAqBXsGw8SpN9VyEE01p2BuiAue+uintDOnUArY9NUlt4bjbx1x/rG1Cc
         YnlPbbOuRG15vjZmbPE9l9+MhMIvJn3WyF/+0J51+NUXBxke2RismEHi8ZpbVpF6iNEC
         yMtUxIUIQtb0D3iEAeXQ6jcmddXcbhkF0Klz2deSR0PjGFHiwshkaA6UGaGXyxzZO//W
         j7zlaiukS/AOB7mTIAIkiXe1Sa1JK85B/AYbhiZZwubKtuocjC+GMJkBO35p01vK3nY2
         I8LXGxA/O0caKfptl0tFvajmD6jnOj3SQhUcEVkdUz7awS2jofutLdnDwiwZSi8eQslF
         vCZQ==
X-Gm-Message-State: APjAAAVVidaB8H8PR1nZqS5lMrdDhsTPRwqDPNsfMwJoYqAH4yklR8km
        OGAEsiYBBr8E4Lusp2bmP4k=
X-Google-Smtp-Source: APXvYqzryL+t8HzJImyLFn9slpfVNoBmFLxN/6hbfjIdplx6Tb15AePHrHX/FGwKpIaN4mWlJCKMYQ==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr10427498wmi.26.1570454218564;
        Mon, 07 Oct 2019 06:16:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a7sm32767956wra.43.2019.10.07.06.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:16:57 -0700 (PDT)
Date:   Mon, 7 Oct 2019 15:16:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Brian Robbins <brianrob@microsoft.com>,
        Ian Rogers <irogers@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Message-ID: <20191007131655.GA78239@gmail.com>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, mostly small fixes, just one extra
> header copied due to linux/fs.h now having parts of it moved to
> linux/fscrypt.h that then needs syncing so that tooling continues to
> build on older systems.
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit da05b5ea12c1e50b2988a63470d6b69434796f8b:
> 
>   Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-09-26 15:53:17 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.4-20191001
> 
> for you to fetch changes up to 11aad897f6d1a28eae3b7e5b293647c522d65819:
> 
>   perf annotate: Don't return -1 for error when doing BPF disassembly (2019-09-30 17:30:06 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf script:
> 
>   Andi Kleen:
> 
>     - Fix recovery from LBR/binary mismatch in the "brstackinsn" --field.
> 
> perf annotate:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Propagate errors so that meaningful messages can be presented to the
>     user in case of problems.
> 
> perf map:
> 
>   Steve MacLean:
> 
>   - Fix handling of maps partially overlapped, resolving symbols in the
>     ranges not replaced by new mmaps.
> 
> perf tests:
> 
>   Ian Rogers:
> 
>   - Use raise() instead of NULL derefs to avoid causing a SIGILL rather than a
>     SIGSEGV for optimized builds that turn NULL derefs into ud2 instructions.
> 
> perf LLVM:
> 
>   Ian Rogers:
> 
>   - Don't access out-of-scope array.
> 
> perf inject:
> 
>   Steve MacLean:
> 
>   - Fix JIT_CODE_MOVE filename, that was having a u64 truncaded into a 32-bit
>     snprintf format and also a missing ".so" suffix in another case.
> 
> libsubcmd:
> 
>   Ian Rogers:
> 
>   - Make _FORTIFY_SOURCE defines dependent on the feature, avoiding
>     false positives with with memory sanitizers such as LLVM's ASan.
> 
> Vendor specific events:
> 
> Intel:
> 
>   Andi Kleen:
> 
>   - Fix period for Intel fixed counters.
> 
> s390:
> 
>   Thomas Richter (2):
> 
>   - Fix some event details transaction for machine type 8561.
> 
> tools headers UAPI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Sync headers with the kernel, catching new usbdevfs ioctls and
>     madvise behaviours to properly decode in 'perf trace' output.
> 
> Documentation:
> 
>   Steve MacLean:
> 
>   - Correct and clarify jitdump spec.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (2):
>       perf script brstackinsn: Fix recovery from LBR/binary mismatch
>       perf jevents: Fix period for Intel fixed counters
> 
> Arnaldo Carvalho de Melo (13):
>       tools headers uapi: Sync drm/i915_drm.h with the kernel sources
>       tools headers uapi: Sync asm-generic/mman-common.h with the kernel
>       tools headers uapi: Sync linux/usbdevice_fs.h with the kernel sources
>       tools headers uapi: Sync linux/fs.h with the kernel sources
>       tools headers kvm: Sync kvm headers with the kernel sources
>       perf tools: Propagate get_cpuid() error
>       perf evsel: Fall back to global 'perf_env' in perf_evsel__env()
>       perf annotate: Propagate perf_env__arch() error
>       perf annotate: Fix the signedness of failure returns
>       perf annotate: Propagate the symbol__annotate() error return
>       perf annotate: Fix arch specific ->init() failure errors
>       perf annotate: Return appropriate error code for allocation failures
>       perf annotate: Don't return -1 for error when doing BPF disassembly
> 
> Ian Rogers (4):
>       libsubcmd: Make _FORTIFY_SOURCE defines dependent on the feature
>       perf tests: Avoid raising SEGV using an obvious NULL dereference
>       perf docs: Allow man page date to be specified
>       perf llvm: Don't access out-of-scope array
> 
> Steve MacLean (3):
>       perf map: Fix overlapped map handling
>       perf inject jit: Fix JIT_CODE_MOVE filename
>       perf docs: Correct and clarify jitdump spec
> 
> Thomas Richter (2):
>       perf vendor events s390: Add JSON transaction for machine type 8561
>       perf vendor events s390: Use s390 machine name instead of type 8561
> 
>  tools/arch/arm/include/uapi/asm/kvm.h              |   4 +-
>  tools/arch/arm64/include/uapi/asm/kvm.h            |   4 +-
>  tools/arch/s390/include/uapi/asm/kvm.h             |   6 +
>  tools/arch/x86/include/uapi/asm/vmx.h              |   2 +
>  tools/include/uapi/asm-generic/mman-common.h       |   3 +
>  tools/include/uapi/drm/i915_drm.h                  |   1 +
>  tools/include/uapi/linux/fs.h                      |  55 +------
>  tools/include/uapi/linux/fscrypt.h                 | 181 +++++++++++++++++++++
>  tools/include/uapi/linux/kvm.h                     |   3 +
>  tools/include/uapi/linux/usbdevice_fs.h            |   4 +
>  tools/lib/subcmd/Makefile                          |   8 +-
>  tools/perf/Documentation/asciidoc.conf             |   3 +
>  tools/perf/Documentation/jitdump-specification.txt |   4 +-
>  tools/perf/arch/arm/annotate/instructions.c        |   4 +-
>  tools/perf/arch/arm64/annotate/instructions.c      |   4 +-
>  tools/perf/arch/powerpc/util/header.c              |   3 +-
>  tools/perf/arch/s390/annotate/instructions.c       |   6 +-
>  tools/perf/arch/s390/util/header.c                 |   9 +-
>  tools/perf/arch/x86/annotate/instructions.c        |   6 +-
>  tools/perf/arch/x86/util/header.c                  |   3 +-
>  tools/perf/builtin-kvm.c                           |   7 +-
>  tools/perf/builtin-script.c                        |   6 +-
>  tools/perf/check-headers.sh                        |   1 +
>  .../arch/s390/{cf_m8561 => cf_z15}/basic.json      |   0
>  .../arch/s390/{cf_m8561 => cf_z15}/crypto.json     |   0
>  .../arch/s390/{cf_m8561 => cf_z15}/crypto6.json    |   0
>  .../arch/s390/{cf_m8561 => cf_z15}/extended.json   |   0
>  .../pmu-events/arch/s390/cf_z15/transaction.json   |   7 +
>  tools/perf/pmu-events/arch/s390/mapfile.csv        |   2 +-
>  tools/perf/pmu-events/jevents.c                    |  12 +-
>  tools/perf/tests/perf-hooks.c                      |   3 +-
>  tools/perf/util/annotate.c                         |  35 +++-
>  tools/perf/util/annotate.h                         |   4 +
>  tools/perf/util/evsel.c                            |   3 +-
>  tools/perf/util/jitdump.c                          |   6 +-
>  tools/perf/util/llvm-utils.c                       |   6 +-
>  tools/perf/util/map.c                              |   3 +
>  tools/perf/util/python.c                           |   6 +
>  38 files changed, 315 insertions(+), 99 deletions(-)
>  create mode 100644 tools/include/uapi/linux/fscrypt.h
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/basic.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/crypto6.json (100%)
>  rename tools/perf/pmu-events/arch/s390/{cf_m8561 => cf_z15}/extended.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z15/transaction.json

Pulled, thanks a lot Arnaldo!

	Ingo
