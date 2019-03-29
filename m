Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87804C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581AF2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866693;
	bh=AdR+qTVfA5LZo6c4REksEelkUykNKPbnPbK4SNPhWmM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xnPgcKxhQHQz7QGgXKh/4BxTPBYfeWbKOdfzn62qZKCr0+VUAnT0D1/Enmz+0KcJn
	 kHakHl3GJF1V7O85FBzwyeMY4gcizJ5icbU0JDfuLxeXIZOBQIiui0zgyxnffrpZtJ
	 AdvDziKhfEW3mTdNCGzoR94xatNjQH7Ee2QkUKrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfC2NiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfC2NiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:11 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C69217F5;
        Fri, 29 Mar 2019 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866690;
        bh=AdR+qTVfA5LZo6c4REksEelkUykNKPbnPbK4SNPhWmM=;
        h=From:To:Cc:Subject:Date:From;
        b=N3k9K6DllVOl/rO93lfBG2g5MWlDhzFzrKseTgU1ivSCP0+kNJsQ2vpTk214olF8h
         EzQn5PBsJU7VILMtG4K6QRUGoc9wDwITedbCKjAusbWwd//VaroWBoxtUmvWSZXtm8
         R4a10WR+B2atTWb9T/LITuGf9QMGWHNutyPD3ZXo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Solomon Tan <solomonbobstoner@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/13] perf/urgent fixes
Date:   Fri, 29 Mar 2019 10:37:48 -0300
Message-Id: <20190329133801.21004-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas,

	Some fixes plus syncronization of kernel header copies to have
the perf build without warnings,

- Arnaldo

The following changes since commit 8c7ae38d1ce12a0eaeba655df8562552b3596c7f:

  afs: Fix StoreData op marshalling (2019-03-28 08:54:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.1-20190329

for you to fetch changes up to e94d6b7f615e6dfbaf9fba7db6011db561461d0c:

  perf pmu: Fix parser error for uncore event alias (2019-03-28 15:53:27 -0300)

----------------------------------------------------------------
perf/urgent fixes:

Core libraries:

  Jiri Olsa:

  - Fix max perf_event_attr.precise_ip detection.

  Kan Liang:

  - Fix parser error for uncore event alias

  Wei Lin:

  - Fixup ordering of kernel maps after obtaining the main kernel map address.

Intel PT:

  Adrian Hunter:

  - Fix TSC slip where A TSC packet can slip past MTC packets so that the
    timestamp appears to go backwards.

  - Fixes for exported-sql-viewer GUI conversion to python3.

ARM coresight:

  Solomon Tan:

  - Fix the build by adding a missing case value for enumeration value introduced
    in newer library, that now is the required one.

tool headers:

  Arnaldo Carvalho de Melo:

  - Syncronize kernel headers with the kernel, getting new io_uring and
    pidfd_send_signal syscalls so that 'perf trace' can handle them.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (3):
      perf intel-pt: Fix TSC slip
      perf scripts python: exported-sql-viewer.py: Fix never-ending loop
      perf scripts python: exported-sql-viewer.py: Fix python3 support

Arnaldo Carvalho de Melo (6):
      tools headers uapi: Sync asm-generic/mman-common.h and linux/mman.h
      tools headers uapi: Sync linux/fcntl.h to get the F_SEAL_FUTURE_WRITE addition
      tools arch x86: Sync asm/cpufeatures.h with the kernel sources
      tools headers uapi: Update drm/i915_drm.h
      tools headers: Update x86's syscall_64.tbl and uapi/asm-generic/unistd
      tools headers uapi: Sync powerpc's asm/kvm.h copy with the kernel sources

Jiri Olsa (1):
      perf evsel: Fix max perf_event_attr.precise_ip detection

Kan Liang (1):
      perf pmu: Fix parser error for uncore event alias

Solomon Tan (1):
      perf cs-etm: Add missing case value

Wei Li (1):
      perf machine: Update kernel map address and re-order properly

 tools/arch/alpha/include/uapi/asm/mman.h           |  2 -
 tools/arch/mips/include/uapi/asm/mman.h            |  2 -
 tools/arch/parisc/include/uapi/asm/mman.h          |  2 -
 tools/arch/powerpc/include/uapi/asm/kvm.h          |  2 +
 tools/arch/x86/include/asm/cpufeatures.h           |  1 +
 tools/arch/xtensa/include/uapi/asm/mman.h          |  2 -
 tools/build/feature/test-libopencsd.c              |  4 +-
 tools/include/uapi/asm-generic/mman-common-tools.h | 23 +++++++
 tools/include/uapi/asm-generic/mman-common.h       |  4 +-
 tools/include/uapi/asm-generic/mman.h              |  2 +-
 tools/include/uapi/asm-generic/unistd.h            | 11 +++-
 tools/include/uapi/drm/i915_drm.h                  | 64 ++++++++++++++++++
 tools/include/uapi/linux/fcntl.h                   |  1 +
 tools/include/uapi/linux/mman.h                    |  4 ++
 tools/perf/Makefile.perf                           |  4 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  4 ++
 tools/perf/check-headers.sh                        |  2 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 77 ++++++++++++++++++----
 tools/perf/trace/beauty/mmap_flags.sh              | 14 +++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  1 +
 tools/perf/util/evlist.c                           | 29 --------
 tools/perf/util/evlist.h                           |  2 -
 tools/perf/util/evsel.c                            | 72 ++++++++++++++++----
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 20 +++---
 tools/perf/util/machine.c                          | 32 +++++----
 tools/perf/util/pmu.c                              | 10 +++
 26 files changed, 288 insertions(+), 103 deletions(-)
 create mode 100644 tools/include/uapi/asm-generic/mman-common-tools.h
