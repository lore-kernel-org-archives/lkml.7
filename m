Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A12921783
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121790;
	bh=HLAlx/KPhSY3VaM9NmfB/axgG3msZJ1VRCmKY5dClYA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2u1MbXv9mQfgMSskeq1TwU1tSQtrCcQklhRlAXR9oIDfmwT7IXbFoG3FHn0MQYwMP
	 rDxJcTwVtENdPmnM3d2ReYoXMDc76GJMtdKcu/Nj6s+V3tSBQD8AojLkgy0LpQzbNc
	 01LpYXK/N3QKNzsWeLmgyFIu32ZLZxGMWJfVIvCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfEQTg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfEQTg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:36:29 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7402166E;
        Fri, 17 May 2019 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121786;
        bh=HLAlx/KPhSY3VaM9NmfB/axgG3msZJ1VRCmKY5dClYA=;
        h=From:To:Cc:Subject:Date:From;
        b=noT1kgNvKiSOinXzhRVn1GUeaNLSFjDuEU8nke+ofZVYAr31QJBt3kV6yNmF/SOuF
         ZPw+rk8sCrAcrqfllC3PtBSR2SmeAdGBZ/U4DMpy94imSmyxV+YT5U+ezYAnyNC324
         upgXByy2i4HsOZrIYs35JwRTU+wv4kh1YLHWdrZo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Donald Yandt <donald.yandt@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <ren_guo@c-sky.com>, Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mao Han <han_mao@c-sky.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Fri, 17 May 2019 16:34:58 -0300
Message-Id: <20190517193611.4974-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling, I pulled tip/perf/urgent into
tip/pref/core, IIRC was just a fast forward at that point, yeap, just
did it again and it still is:

  $ git checkout -b t tip/perf/core
  Branch 't' set up to track remote branch 'perf/core' from 'tip'.
  Switched to a new branch 't'
  $ git merge tip/perf/urgent
  Updating d15d356887e7..c7a286577d75
  Fast-forward
  <SNIP>

         IIRC Jiri needs this for a pile of patches he submitted and
that I'll process next,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 6b89d4c1ae8596a8c9240f169ef108704de373f2:

  perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking (2019-05-10 08:04:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.2-20190517

for you to fetch changes up to 4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c:

  perf stat: Support 'percore' event qualifier (2019-05-16 14:17:24 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf.data:

  Alexey Budankov:

  - Streaming compression of perf ring buffer into PERF_RECORD_COMPRESSED
    user space records, resulting in ~3-5x perf.data file size reduction
    on variety of tested workloads what saves storage space on larger
    server systems where perf.data size can easily reach several tens or
    even hundreds of GiBs, especially when profiling with DWARF-based
    stacks and tracing of context switches.

perf record:

  Arnaldo Carvalho de Melo

  - Improve -user-regs/intr-regs suggestions to overcome errors.

perf annotate:

  Jin Yao:

  - Remove hist__account_cycles() from callback, speeding up branch processing
    (perf record -b).

perf stat:

  - Add a 'percore' event qualifier, e.g.: -e cpu/event=0,umask=0x3,percore=1/,
    that sums up the event counts for both hardware threads in a core.

    We can already do this with --per-core, but it's often useful to do
    this together with other metrics that are collected per hardware thread.

    I.e. now its possible to do this per-event, and have it mixed with other
    events not aggregated by core.

core libraries:

  Donald Yandt:

  - Check for errors when doing fgets(/proc/version).

  Jiri Olsa:

  - Speed up report for perf compiled with linbunwind.

tools headers:

  Arnaldo Carvalho de Melo

  - Update memcpy_64.S, x86's kvm.h and pt_regs.h.

arm64:

  Florian Fainelli:

  - Map Brahma-B53 CPUID to cortex-a53 events.

  - Add Cortex-A57 and Cortex-A72 events.

csky:

  Mao Han:

  - Add DWARF register mappings for libdw, allowing --call-graph=dwarf to work
    on the C-SKY arch.

x86:

  Andi Kleen/Kan Liang:

  - Add support for recording and printing XMM registers, available, for
    instance, on Icelake.

  Kan Liang:

  - Add uncore_upi (Intel's "Ultra Path Interconnect" events) JSON support.
    UPI replaced the Intel QuickPath Interconnect (QPI) in Xeon Skylake-SP.

Intel PT:

  Adrian Hunter

  . Fix instructions sampling rate.

  . Timestamp fixes.

  . Improve exported-sql-viewer GUI, allowing, for instance, to copy'n'paste
    the trees, useful for e-mailing.

Documentation:

  Thomas Richter:

  - Add description for 'perf --debug stderr=1', which redirects stderr to stdout.

libtraceevent:

  Tzvetomir Stoyanov:

  - Add man pages for the various APIs.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (9):
      perf scripts python: exported-sql-viewer.py: Move view creation
      perf scripts python: exported-sql-viewer.py: Fix error when shrinking / enlarging font
      perf scripts python: exported-sql-viewer.py: Add tree level
      perf scripts python: exported-sql-viewer.py: Add copy to clipboard
      perf scripts python: exported-sql-viewer.py: Add context menu
      perf scripts python: exported-sql-viewer.py: Add 'About' dialog box
      perf intel-pt: Fix instructions sampling rate
      perf intel-pt: Fix improved sample timestamp
      perf intel-pt: Fix sample timestamp wrt non-taken branches

Alexey Budankov (11):
      perf session: Define 'bytes_transferred' and 'bytes_compressed' metrics
      perf record: Implement COMPRESSED event record and its attributes
      perf mmap: Implement dedicated memory buffer for data compression
      perf tools: Introduce Zstd streaming based compression API
      perf record: Implement compression for serial trace streaming
      perf record: Implement compression for AIO trace streaming
      perf report: Add stub processing of compressed events for -D
      perf record: Implement -z,--compression_level[=<n>] option
      perf report: Implement perf.data record decompression
      perf inject: Enable COMPRESSED record decompression
      perf tests: Implement Zstd comp/decomp integration test

Andi Kleen (1):
      perf tools x86: Add support for recording and printing XMM registers

Arnaldo Carvalho de Melo (8):
      tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
      tools arch uapi: Sync the x86 kvm.h copy
      tools x86 uapi asm: Sync the pt_regs.h copy with the kernel sources
      tools pci: Do not delete pcitest.sh in 'make clean'
      perf record: Fix suggestion to get list of registers usable with --user-regs and --intr-regs
      perf parse-regs: Improve error output when faced with unknown register name
      perf build tests: Add NO_LIBZSTD=1 to make_minimal
      perf test zstd: Fixup verbose mode output

Colin Ian King (1):
      perf test: Fix spelling mistake "leadking" -> "leaking"

Donald Yandt (1):
      perf machine: Null-terminate version char array upon fgets(/proc/version) error

Florian Fainelli (3):
      perf vendor events arm64: Remove [[:xdigit:]] wildcard
      perf vendor events arm64: Map Brahma-B53 CPUID to cortex-a53 events
      perf vendor events arm64: Add Cortex-A57 and Cortex-A72 events

Jin Yao (4):
      perf annotate: Remove hist__account_cycles() from callback
      perf tools: Add a 'percore' event qualifier
      perf stat: Factor out aggregate counts printing
      perf stat: Support 'percore' event qualifier

Jiri Olsa (1):
      perf tools: Speed up report for perf compiled with linwunwind

Kan Liang (4):
      perf vendor events intel: Add uncore_upi JSON support
      perf parse-regs: Split parse_regs
      perf parse-regs: Add generic support for arch__intr/user_reg_mask()
      perf regs x86: Add X86 specific arch__intr_reg_mask()

Mao Han (1):
      csky: Add support for libdw

Thomas Richter (1):
      perf docs: Add description for stderr

Tzvetomir Stoyanov (27):
      tools lib traceevent: Remove hard coded install paths from pkg-config file
      tools lib traceevent: Introduce man pages
      tools lib traceevent: Add support for man pages with multiple names
      tools lib traceevent: Man pages for tep_handler related APIs
      tools lib traceevent: Man page for header_page APIs
      tools lib traceevent: Man page for get/set cpus APIs
      tools lib traceevent: Man page for file endian APIs
      tools lib traceevent: Man page for host endian APIs
      tools lib traceevent: Man page for page size APIs
      tools lib traceevent: Man page for tep_strerror()
      tools lib traceevent: Man pages for event handler APIs
      tools lib traceevent: Man pages for function related libtraceevent APIs
      tools lib traceevent: Man pages for registering print function
      tools lib traceevent: Man page for tep_read_number()
      tools lib traceevent: Man pages for event find APIs
      tools lib traceevent: Man page for list events APIs
      tools lib traceevent: Man pages for libtraceevent event get APIs
      tools lib traceevent: Man pages for find field APIs
      tools lib traceevent: Man pages for get field value APIs
      tools lib traceevent: Man pages for print field APIs
      tools lib traceevent: Man page for tep_read_number_field()
      tools lib traceevent: Man pages for event fields APIs
      tools lib traceevent: Man pages for event filter APIs
      tools lib traceevent: Man pages for parse event APIs
      tools lib traceevent: Man page for tep_parse_header_page()
      tools lib traceevent: Man pages for APIs used to extract common fields from a record
      tools lib traceevent: Man pages for trace sequences APIs

Zenghui Yu (1):
      perf jevents: Remove unused variable

 tools/arch/csky/include/uapi/asm/perf_regs.h       |  51 ++++
 tools/arch/x86/include/uapi/asm/kvm.h              |   1 +
 tools/arch/x86/include/uapi/asm/perf_regs.h        |  23 +-
 tools/arch/x86/lib/memcpy_64.S                     |   3 +-
 tools/lib/traceevent/Documentation/Makefile        | 207 +++++++++++++
 tools/lib/traceevent/Documentation/asciidoc.conf   | 120 ++++++++
 .../Documentation/libtraceevent-commands.txt       | 153 ++++++++++
 .../Documentation/libtraceevent-cpus.txt           |  77 +++++
 .../Documentation/libtraceevent-endian_read.txt    |  78 +++++
 .../Documentation/libtraceevent-event_find.txt     | 103 +++++++
 .../Documentation/libtraceevent-event_get.txt      |  99 ++++++
 .../Documentation/libtraceevent-event_list.txt     | 122 ++++++++
 .../Documentation/libtraceevent-field_find.txt     | 118 +++++++
 .../Documentation/libtraceevent-field_get_val.txt  | 122 ++++++++
 .../Documentation/libtraceevent-field_print.txt    | 126 ++++++++
 .../Documentation/libtraceevent-field_read.txt     |  81 +++++
 .../Documentation/libtraceevent-fields.txt         | 105 +++++++
 .../Documentation/libtraceevent-file_endian.txt    |  91 ++++++
 .../Documentation/libtraceevent-filter.txt         | 209 +++++++++++++
 .../Documentation/libtraceevent-func_apis.txt      | 183 +++++++++++
 .../Documentation/libtraceevent-func_find.txt      |  88 ++++++
 .../Documentation/libtraceevent-handle.txt         | 101 ++++++
 .../Documentation/libtraceevent-header_page.txt    | 102 +++++++
 .../Documentation/libtraceevent-host_endian.txt    | 104 +++++++
 .../Documentation/libtraceevent-long_size.txt      |  78 +++++
 .../Documentation/libtraceevent-page_size.txt      |  82 +++++
 .../Documentation/libtraceevent-parse_event.txt    |  90 ++++++
 .../Documentation/libtraceevent-parse_head.txt     |  82 +++++
 .../Documentation/libtraceevent-record_parse.txt   | 137 +++++++++
 .../libtraceevent-reg_event_handler.txt            | 156 ++++++++++
 .../Documentation/libtraceevent-reg_print_func.txt | 155 ++++++++++
 .../Documentation/libtraceevent-set_flag.txt       | 104 +++++++
 .../Documentation/libtraceevent-strerror.txt       |  85 ++++++
 .../Documentation/libtraceevent-tseq.txt           | 158 ++++++++++
 .../lib/traceevent/Documentation/libtraceevent.txt | 203 ++++++++++++
 .../lib/traceevent/Documentation/manpage-1.72.xsl  |  14 +
 .../lib/traceevent/Documentation/manpage-base.xsl  |  35 +++
 .../Documentation/manpage-bold-literal.xsl         |  17 ++
 .../traceevent/Documentation/manpage-normal.xsl    |  13 +
 .../Documentation/manpage-suppress-sp.xsl          |  21 ++
 tools/lib/traceevent/Makefile                      |  46 ++-
 tools/lib/traceevent/libtraceevent.pc.template     |   4 +-
 tools/pci/Makefile                                 |   4 +-
 tools/perf/Documentation/perf-list.txt             |  12 +
 tools/perf/Documentation/perf-record.txt           |   8 +-
 tools/perf/Documentation/perf-stat.txt             |   4 +
 tools/perf/Documentation/perf.data-file-format.txt |  24 ++
 tools/perf/Documentation/perf.txt                  |   2 +
 tools/perf/Makefile.config                         |   6 +-
 tools/perf/arch/csky/Build                         |   1 +
 tools/perf/arch/csky/Makefile                      |   3 +
 tools/perf/arch/csky/include/perf_regs.h           | 100 ++++++
 tools/perf/arch/csky/util/Build                    |   2 +
 tools/perf/arch/csky/util/dwarf-regs.c             |  49 +++
 tools/perf/arch/csky/util/unwind-libdw.c           |  77 +++++
 tools/perf/arch/x86/include/perf_regs.h            |  26 +-
 tools/perf/arch/x86/util/perf_regs.c               |  44 +++
 tools/perf/builtin-annotate.c                      |   4 +-
 tools/perf/builtin-inject.c                        |   4 +
 tools/perf/builtin-record.c                        | 229 ++++++++++++--
 tools/perf/builtin-report.c                        |  16 +-
 tools/perf/builtin-stat.c                          |  21 ++
 tools/perf/perf.h                                  |   1 +
 .../arm64/arm/cortex-a57-a72/core-imp-def.json     | 179 +++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   5 +-
 tools/perf/pmu-events/jevents.c                    |   2 +-
 tools/perf/scripts/python/exported-sql-viewer.py   | 340 ++++++++++++++++++++-
 tools/perf/tests/dso-data.c                        |   4 +-
 tools/perf/tests/make                              |   2 +-
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |  34 +++
 tools/perf/util/Build                              |   2 +
 tools/perf/util/annotate.c                         |   2 +-
 tools/perf/util/compress.h                         |  53 ++++
 tools/perf/util/env.h                              |  11 +
 tools/perf/util/event.c                            |   1 +
 tools/perf/util/event.h                            |   7 +
 tools/perf/util/evlist.c                           |   8 +-
 tools/perf/util/evlist.h                           |   2 +-
 tools/perf/util/evsel.c                            |   2 +
 tools/perf/util/evsel.h                            |   3 +
 tools/perf/util/header.c                           |  53 ++++
 tools/perf/util/header.h                           |   1 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  31 +-
 tools/perf/util/machine.c                          |   3 +-
 tools/perf/util/mmap.c                             | 102 ++-----
 tools/perf/util/mmap.h                             |  16 +-
 tools/perf/util/parse-events.c                     |  27 ++
 tools/perf/util/parse-events.h                     |   1 +
 tools/perf/util/parse-events.l                     |   1 +
 tools/perf/util/parse-regs-options.c               |  33 +-
 tools/perf/util/parse-regs-options.h               |   3 +-
 tools/perf/util/perf_regs.c                        |  10 +
 tools/perf/util/perf_regs.h                        |   3 +
 tools/perf/util/session.c                          | 133 +++++++-
 tools/perf/util/session.h                          |  14 +
 tools/perf/util/stat-display.c                     | 107 +++++--
 tools/perf/util/stat.c                             |   8 +-
 tools/perf/util/thread.c                           |   3 +-
 tools/perf/util/tool.h                             |   2 +
 tools/perf/util/unwind-libunwind-local.c           |   6 -
 tools/perf/util/unwind-libunwind.c                 |  10 +
 tools/perf/util/zstd.c                             | 111 +++++++
 102 files changed, 5703 insertions(+), 216 deletions(-)
 create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 tools/lib/traceevent/Documentation/Makefile
 create mode 100644 tools/lib/traceevent/Documentation/asciidoc.conf
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-commands.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_print.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-fields.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-filter.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_find.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-handle.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
 create mode 100644 tools/lib/traceevent/Documentation/libtraceevent.txt
 create mode 100644 tools/lib/traceevent/Documentation/manpage-1.72.xsl
 create mode 100644 tools/lib/traceevent/Documentation/manpage-base.xsl
 create mode 100644 tools/lib/traceevent/Documentation/manpage-bold-literal.xsl
 create mode 100644 tools/lib/traceevent/Documentation/manpage-normal.xsl
 create mode 100644 tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl
 create mode 100644 tools/perf/arch/csky/Build
 create mode 100644 tools/perf/arch/csky/Makefile
 create mode 100644 tools/perf/arch/csky/include/perf_regs.h
 create mode 100644 tools/perf/arch/csky/util/Build
 create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh
 create mode 100644 tools/perf/util/zstd.c

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.1.0.tar.xz
  $ dm
     1	alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
     2	alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
     3	alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
     4	alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0
     5	alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0
     6	alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0
     7	alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0
     8	amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
     9	amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
    10	android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    11	android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
    12	centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
    13	centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
    14	centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
    15	clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.0.1 20190501 (prerelease) gcc-8-branch@270761
    16	debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2
    17	debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
    18	debian:experimental           : Ok   gcc (Debian 8.3.0-7) 8.3.0
    19	debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
    20	debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
    21	debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
    22	debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
    23	fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
    24	fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
    25	fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
    26	fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
    27	fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
    28	fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
    29	fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
    30	fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
    31	fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
    32	fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
    33	fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1)
    34	fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
    35	fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
    36	fedora:rawhide                : Ok   gcc (GCC) 9.0.1 20190418 (Red Hat 9.0.1-0.14)
    37	mageia:5                      : Ok   gcc (GCC) 4.9.2
    38	mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0
    39	opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.0
    40	opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0
    41	opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
    42	opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 8.3.1 20190226 [gcc-8-branch revision 269204]
    43	oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
    44	oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1)
    45	ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
    46	ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
    47	ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609
    48	ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    49	ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    50	ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    51	ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    52	ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    53	ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    54	ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
    55	ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    56	ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
    57	ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
    58	ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    59	ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    60	ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    61	ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    62	ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    63	ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    64	ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    65	ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
    66	ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
    67	ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
    68	ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
    69	ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
    70	ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0

  The getname_flags related tests failing at the end (tests 65, 66 and 67) are
  being investigated, getname_flags() seems to have become just a tail call from
  getname(), something in this are changed and we're not anymore being able to
  add a probe at a suitable place to collect the just copied from userspace
  pathname.
       
  # uname -a
  Linux quaco 5.1.0-rc7+ #1 SMP Thu May 2 09:47:59 EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  4fc4d8dfa056 perf stat: Support 'percore' event qualifier
  # perf version --build-options
  perf version 5.1.g4fc4d8
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: x86 rdpmc                                             : Ok
  60: Convert perf time to TSC                              : Ok
  61: DWARF unwind                                          : Ok
  62: x86 instruction decoder - new instructions            : Ok
  63: x86 bp modify                                         : Ok
  64: probe libc's inet_pton & backtrace it with ping       : Ok
  65: Use vfs_getname probe to get syscall args filenames   : FAILED!
  66: Add vfs_getname probe to get syscall args filenames   : FAILED!
  67: Check open filename arg using perf trace + vfs_getname: FAILED!
  68: Zstd perf.data compression/decompression              : Ok

  $ time make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                    make_doc_O: make doc
                 make_cscope_O: make cscope
                make_no_newt_O: make NO_NEWT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_no_demangle_O: make NO_DEMANGLE=1
                  make_debug_O: make DEBUG=1
              make_no_libelf_O: make NO_LIBELF=1
                make_no_gtk2_O: make NO_GTK2=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_perf_o_O: make perf.o
                make_install_O: make install
                   make_pure_O: make
             make_util_map_o_O: make util/map.o
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                 make_static_O: make LDFLAGS=-static
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_libnuma_O: make NO_LIBNUMA=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libperl_O: make NO_LIBPERL=1
              make_clean_all_O: make clean all
       make_util_pmu_bison_o_O: make util/pmu-bison.o
        make_with_babeltrace_O: make LIBBABELTRACE=1
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
                   make_help_O: make help
              make_no_libbpf_O: make NO_LIBBPF=1
            make_install_bin_O: make install-bin
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_tags_O: make tags
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ 
