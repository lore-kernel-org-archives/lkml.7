Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF2C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED88C20848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558168062;
	bh=AuCkxsociycxh6PKyElcv5lPY5nCgenDemJit5qqrgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lxJOVJHkSJSgaeW1ktNX6ahYmJOb+y7AwT3fC+6vAVjAEWQIVZdiB3qcqtB0gV7kZ
	 a96ibzFsUdqYrO19CCXLWJRFiFlAZWMr54iRXXeGzPacu31UmdXCii2WNeaYN6kHZd
	 DXT99HLCPkEGA3UYyoy2fa7D3M7UrMXlM4kvEofc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfERI1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:27:41 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53820 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:27:40 -0400
Received: by mail-wm1-f53.google.com with SMTP id 198so8866996wme.3;
        Sat, 18 May 2019 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WxiI1y7+UOFtd6Wj3WRNsZ+U8SmBzR26mUHKO7Fa95o=;
        b=cWWrDd22zwOH6DRsYDlnaWJ9DdPVK3qubKTBgp3BZMqh0f5mIc8r4YNZxTj8rX/V+U
         voTJfvaS5yaRPwGHXdf06L4Nmq9UAPxG0IdhpYdNROu+BzIC4RYUkd+i0AGlFNYEynZ9
         n55XJdVuTxQCbkn/RwtGcdUfrJcdYKk/mOBsqleg+nP7oNk/p5o4TktcIFdw9+bIsQum
         dXGwG+Qu40VH/YQlsMtnag1G/uVexGBKx4jN1ajxxf+mY2iFnIQHAmitXpzk2Se0hfHe
         qDtkXis7v+pWiNwd5M3JhZb2KvFiS+PzKIcWcbvQi7MSInu1aGibLbY6SdIeTETwsY2E
         XvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxiI1y7+UOFtd6Wj3WRNsZ+U8SmBzR26mUHKO7Fa95o=;
        b=opU3NkIv89fp7CM0l6WpgdaK8RVEjZq/fW0zhXbAH4Nxolqqv2ZVQWEGE1ixOdXVkp
         rIUnIP4mUULHNOyGU4BPwq+uFvbz8So5HQUC/CXJ2xWVxDI9B1qnytm99o36XU1M+ZZa
         RvFqb1l6S5HJxgw/KhyCk68FE3+4CWfK607MP65j5tB36kWgY7Su8ar6q504/1xBzjDi
         5AQ+5/0Esm1+xvE6KAkykiHdRq8JXjKk+DZJa9bxZoUvhR87UGHhaXIu/vQpDdKQ+46X
         fdZ3qwzSUkHqQ+cfggJQq9W1mhRtUxSHf8Yo4rhBaR6QSvlU3KxbupNtdV+c+Gs34H2/
         XMnw==
X-Gm-Message-State: APjAAAVoQ7MoO3YeLJSuNoB4wadYI+4yswf4SXprZlgKagWS+q7r/ZLe
        j2dNuf2OLOhhUUqWv6DfwQ0=
X-Google-Smtp-Source: APXvYqyrHnTuMUvANXvRXsz/uvE6bT/fGTaM/g+1VJPTgB2UtM/+SmIg+dS+KI/aQI+x09KKu5oxCQ==
X-Received: by 2002:a1c:701a:: with SMTP id l26mr34129161wmc.50.1558168055403;
        Sat, 18 May 2019 01:27:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 88sm24080970wrc.33.2019.05.18.01.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 01:27:34 -0700 (PDT)
Date:   Sat, 18 May 2019 10:27:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190518082732.GA85914@gmail.com>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, I pulled tip/perf/urgent into
> tip/pref/core, IIRC was just a fast forward at that point, yeap, just
> did it again and it still is:
> 
>   $ git checkout -b t tip/perf/core
>   Branch 't' set up to track remote branch 'perf/core' from 'tip'.
>   Switched to a new branch 't'
>   $ git merge tip/perf/urgent
>   Updating d15d356887e7..c7a286577d75
>   Fast-forward
>   <SNIP>
> 
>          IIRC Jiri needs this for a pile of patches he submitted and
> that I'll process next,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 6b89d4c1ae8596a8c9240f169ef108704de373f2:
> 
>   perf/x86/intel: Fix INTEL_FLAGS_EVENT_CONSTRAINT* masking (2019-05-10 08:04:17 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.2-20190517
> 
> for you to fetch changes up to 4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c:
> 
>   perf stat: Support 'percore' event qualifier (2019-05-16 14:17:24 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf.data:
> 
>   Alexey Budankov:
> 
>   - Streaming compression of perf ring buffer into PERF_RECORD_COMPRESSED
>     user space records, resulting in ~3-5x perf.data file size reduction
>     on variety of tested workloads what saves storage space on larger
>     server systems where perf.data size can easily reach several tens or
>     even hundreds of GiBs, especially when profiling with DWARF-based
>     stacks and tracing of context switches.
> 
> perf record:
> 
>   Arnaldo Carvalho de Melo
> 
>   - Improve -user-regs/intr-regs suggestions to overcome errors.
> 
> perf annotate:
> 
>   Jin Yao:
> 
>   - Remove hist__account_cycles() from callback, speeding up branch processing
>     (perf record -b).
> 
> perf stat:
> 
>   - Add a 'percore' event qualifier, e.g.: -e cpu/event=0,umask=0x3,percore=1/,
>     that sums up the event counts for both hardware threads in a core.
> 
>     We can already do this with --per-core, but it's often useful to do
>     this together with other metrics that are collected per hardware thread.
> 
>     I.e. now its possible to do this per-event, and have it mixed with other
>     events not aggregated by core.
> 
> core libraries:
> 
>   Donald Yandt:
> 
>   - Check for errors when doing fgets(/proc/version).
> 
>   Jiri Olsa:
> 
>   - Speed up report for perf compiled with linbunwind.
> 
> tools headers:
> 
>   Arnaldo Carvalho de Melo
> 
>   - Update memcpy_64.S, x86's kvm.h and pt_regs.h.
> 
> arm64:
> 
>   Florian Fainelli:
> 
>   - Map Brahma-B53 CPUID to cortex-a53 events.
> 
>   - Add Cortex-A57 and Cortex-A72 events.
> 
> csky:
> 
>   Mao Han:
> 
>   - Add DWARF register mappings for libdw, allowing --call-graph=dwarf to work
>     on the C-SKY arch.
> 
> x86:
> 
>   Andi Kleen/Kan Liang:
> 
>   - Add support for recording and printing XMM registers, available, for
>     instance, on Icelake.
> 
>   Kan Liang:
> 
>   - Add uncore_upi (Intel's "Ultra Path Interconnect" events) JSON support.
>     UPI replaced the Intel QuickPath Interconnect (QPI) in Xeon Skylake-SP.
> 
> Intel PT:
> 
>   Adrian Hunter
> 
>   . Fix instructions sampling rate.
> 
>   . Timestamp fixes.
> 
>   . Improve exported-sql-viewer GUI, allowing, for instance, to copy'n'paste
>     the trees, useful for e-mailing.
> 
> Documentation:
> 
>   Thomas Richter:
> 
>   - Add description for 'perf --debug stderr=1', which redirects stderr to stdout.
> 
> libtraceevent:
> 
>   Tzvetomir Stoyanov:
> 
>   - Add man pages for the various APIs.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (9):
>       perf scripts python: exported-sql-viewer.py: Move view creation
>       perf scripts python: exported-sql-viewer.py: Fix error when shrinking / enlarging font
>       perf scripts python: exported-sql-viewer.py: Add tree level
>       perf scripts python: exported-sql-viewer.py: Add copy to clipboard
>       perf scripts python: exported-sql-viewer.py: Add context menu
>       perf scripts python: exported-sql-viewer.py: Add 'About' dialog box
>       perf intel-pt: Fix instructions sampling rate
>       perf intel-pt: Fix improved sample timestamp
>       perf intel-pt: Fix sample timestamp wrt non-taken branches
> 
> Alexey Budankov (11):
>       perf session: Define 'bytes_transferred' and 'bytes_compressed' metrics
>       perf record: Implement COMPRESSED event record and its attributes
>       perf mmap: Implement dedicated memory buffer for data compression
>       perf tools: Introduce Zstd streaming based compression API
>       perf record: Implement compression for serial trace streaming
>       perf record: Implement compression for AIO trace streaming
>       perf report: Add stub processing of compressed events for -D
>       perf record: Implement -z,--compression_level[=<n>] option
>       perf report: Implement perf.data record decompression
>       perf inject: Enable COMPRESSED record decompression
>       perf tests: Implement Zstd comp/decomp integration test
> 
> Andi Kleen (1):
>       perf tools x86: Add support for recording and printing XMM registers
> 
> Arnaldo Carvalho de Melo (8):
>       tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
>       tools arch uapi: Sync the x86 kvm.h copy
>       tools x86 uapi asm: Sync the pt_regs.h copy with the kernel sources
>       tools pci: Do not delete pcitest.sh in 'make clean'
>       perf record: Fix suggestion to get list of registers usable with --user-regs and --intr-regs
>       perf parse-regs: Improve error output when faced with unknown register name
>       perf build tests: Add NO_LIBZSTD=1 to make_minimal
>       perf test zstd: Fixup verbose mode output
> 
> Colin Ian King (1):
>       perf test: Fix spelling mistake "leadking" -> "leaking"
> 
> Donald Yandt (1):
>       perf machine: Null-terminate version char array upon fgets(/proc/version) error
> 
> Florian Fainelli (3):
>       perf vendor events arm64: Remove [[:xdigit:]] wildcard
>       perf vendor events arm64: Map Brahma-B53 CPUID to cortex-a53 events
>       perf vendor events arm64: Add Cortex-A57 and Cortex-A72 events
> 
> Jin Yao (4):
>       perf annotate: Remove hist__account_cycles() from callback
>       perf tools: Add a 'percore' event qualifier
>       perf stat: Factor out aggregate counts printing
>       perf stat: Support 'percore' event qualifier
> 
> Jiri Olsa (1):
>       perf tools: Speed up report for perf compiled with linwunwind
> 
> Kan Liang (4):
>       perf vendor events intel: Add uncore_upi JSON support
>       perf parse-regs: Split parse_regs
>       perf parse-regs: Add generic support for arch__intr/user_reg_mask()
>       perf regs x86: Add X86 specific arch__intr_reg_mask()
> 
> Mao Han (1):
>       csky: Add support for libdw
> 
> Thomas Richter (1):
>       perf docs: Add description for stderr
> 
> Tzvetomir Stoyanov (27):
>       tools lib traceevent: Remove hard coded install paths from pkg-config file
>       tools lib traceevent: Introduce man pages
>       tools lib traceevent: Add support for man pages with multiple names
>       tools lib traceevent: Man pages for tep_handler related APIs
>       tools lib traceevent: Man page for header_page APIs
>       tools lib traceevent: Man page for get/set cpus APIs
>       tools lib traceevent: Man page for file endian APIs
>       tools lib traceevent: Man page for host endian APIs
>       tools lib traceevent: Man page for page size APIs
>       tools lib traceevent: Man page for tep_strerror()
>       tools lib traceevent: Man pages for event handler APIs
>       tools lib traceevent: Man pages for function related libtraceevent APIs
>       tools lib traceevent: Man pages for registering print function
>       tools lib traceevent: Man page for tep_read_number()
>       tools lib traceevent: Man pages for event find APIs
>       tools lib traceevent: Man page for list events APIs
>       tools lib traceevent: Man pages for libtraceevent event get APIs
>       tools lib traceevent: Man pages for find field APIs
>       tools lib traceevent: Man pages for get field value APIs
>       tools lib traceevent: Man pages for print field APIs
>       tools lib traceevent: Man page for tep_read_number_field()
>       tools lib traceevent: Man pages for event fields APIs
>       tools lib traceevent: Man pages for event filter APIs
>       tools lib traceevent: Man pages for parse event APIs
>       tools lib traceevent: Man page for tep_parse_header_page()
>       tools lib traceevent: Man pages for APIs used to extract common fields from a record
>       tools lib traceevent: Man pages for trace sequences APIs
> 
> Zenghui Yu (1):
>       perf jevents: Remove unused variable
> 
>  tools/arch/csky/include/uapi/asm/perf_regs.h       |  51 ++++
>  tools/arch/x86/include/uapi/asm/kvm.h              |   1 +
>  tools/arch/x86/include/uapi/asm/perf_regs.h        |  23 +-
>  tools/arch/x86/lib/memcpy_64.S                     |   3 +-
>  tools/lib/traceevent/Documentation/Makefile        | 207 +++++++++++++
>  tools/lib/traceevent/Documentation/asciidoc.conf   | 120 ++++++++
>  .../Documentation/libtraceevent-commands.txt       | 153 ++++++++++
>  .../Documentation/libtraceevent-cpus.txt           |  77 +++++
>  .../Documentation/libtraceevent-endian_read.txt    |  78 +++++
>  .../Documentation/libtraceevent-event_find.txt     | 103 +++++++
>  .../Documentation/libtraceevent-event_get.txt      |  99 ++++++
>  .../Documentation/libtraceevent-event_list.txt     | 122 ++++++++
>  .../Documentation/libtraceevent-field_find.txt     | 118 +++++++
>  .../Documentation/libtraceevent-field_get_val.txt  | 122 ++++++++
>  .../Documentation/libtraceevent-field_print.txt    | 126 ++++++++
>  .../Documentation/libtraceevent-field_read.txt     |  81 +++++
>  .../Documentation/libtraceevent-fields.txt         | 105 +++++++
>  .../Documentation/libtraceevent-file_endian.txt    |  91 ++++++
>  .../Documentation/libtraceevent-filter.txt         | 209 +++++++++++++
>  .../Documentation/libtraceevent-func_apis.txt      | 183 +++++++++++
>  .../Documentation/libtraceevent-func_find.txt      |  88 ++++++
>  .../Documentation/libtraceevent-handle.txt         | 101 ++++++
>  .../Documentation/libtraceevent-header_page.txt    | 102 +++++++
>  .../Documentation/libtraceevent-host_endian.txt    | 104 +++++++
>  .../Documentation/libtraceevent-long_size.txt      |  78 +++++
>  .../Documentation/libtraceevent-page_size.txt      |  82 +++++
>  .../Documentation/libtraceevent-parse_event.txt    |  90 ++++++
>  .../Documentation/libtraceevent-parse_head.txt     |  82 +++++
>  .../Documentation/libtraceevent-record_parse.txt   | 137 +++++++++
>  .../libtraceevent-reg_event_handler.txt            | 156 ++++++++++
>  .../Documentation/libtraceevent-reg_print_func.txt | 155 ++++++++++
>  .../Documentation/libtraceevent-set_flag.txt       | 104 +++++++
>  .../Documentation/libtraceevent-strerror.txt       |  85 ++++++
>  .../Documentation/libtraceevent-tseq.txt           | 158 ++++++++++
>  .../lib/traceevent/Documentation/libtraceevent.txt | 203 ++++++++++++
>  .../lib/traceevent/Documentation/manpage-1.72.xsl  |  14 +
>  .../lib/traceevent/Documentation/manpage-base.xsl  |  35 +++
>  .../Documentation/manpage-bold-literal.xsl         |  17 ++
>  .../traceevent/Documentation/manpage-normal.xsl    |  13 +
>  .../Documentation/manpage-suppress-sp.xsl          |  21 ++
>  tools/lib/traceevent/Makefile                      |  46 ++-
>  tools/lib/traceevent/libtraceevent.pc.template     |   4 +-
>  tools/pci/Makefile                                 |   4 +-
>  tools/perf/Documentation/perf-list.txt             |  12 +
>  tools/perf/Documentation/perf-record.txt           |   8 +-
>  tools/perf/Documentation/perf-stat.txt             |   4 +
>  tools/perf/Documentation/perf.data-file-format.txt |  24 ++
>  tools/perf/Documentation/perf.txt                  |   2 +
>  tools/perf/Makefile.config                         |   6 +-
>  tools/perf/arch/csky/Build                         |   1 +
>  tools/perf/arch/csky/Makefile                      |   3 +
>  tools/perf/arch/csky/include/perf_regs.h           | 100 ++++++
>  tools/perf/arch/csky/util/Build                    |   2 +
>  tools/perf/arch/csky/util/dwarf-regs.c             |  49 +++
>  tools/perf/arch/csky/util/unwind-libdw.c           |  77 +++++
>  tools/perf/arch/x86/include/perf_regs.h            |  26 +-
>  tools/perf/arch/x86/util/perf_regs.c               |  44 +++
>  tools/perf/builtin-annotate.c                      |   4 +-
>  tools/perf/builtin-inject.c                        |   4 +
>  tools/perf/builtin-record.c                        | 229 ++++++++++++--
>  tools/perf/builtin-report.c                        |  16 +-
>  tools/perf/builtin-stat.c                          |  21 ++
>  tools/perf/perf.h                                  |   1 +
>  .../arm64/arm/cortex-a57-a72/core-imp-def.json     | 179 +++++++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |   5 +-
>  tools/perf/pmu-events/jevents.c                    |   2 +-
>  tools/perf/scripts/python/exported-sql-viewer.py   | 340 ++++++++++++++++++++-
>  tools/perf/tests/dso-data.c                        |   4 +-
>  tools/perf/tests/make                              |   2 +-
>  tools/perf/tests/shell/record+zstd_comp_decomp.sh  |  34 +++
>  tools/perf/util/Build                              |   2 +
>  tools/perf/util/annotate.c                         |   2 +-
>  tools/perf/util/compress.h                         |  53 ++++
>  tools/perf/util/env.h                              |  11 +
>  tools/perf/util/event.c                            |   1 +
>  tools/perf/util/event.h                            |   7 +
>  tools/perf/util/evlist.c                           |   8 +-
>  tools/perf/util/evlist.h                           |   2 +-
>  tools/perf/util/evsel.c                            |   2 +
>  tools/perf/util/evsel.h                            |   3 +
>  tools/perf/util/header.c                           |  53 ++++
>  tools/perf/util/header.h                           |   1 +
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  31 +-
>  tools/perf/util/machine.c                          |   3 +-
>  tools/perf/util/mmap.c                             | 102 ++-----
>  tools/perf/util/mmap.h                             |  16 +-
>  tools/perf/util/parse-events.c                     |  27 ++
>  tools/perf/util/parse-events.h                     |   1 +
>  tools/perf/util/parse-events.l                     |   1 +
>  tools/perf/util/parse-regs-options.c               |  33 +-
>  tools/perf/util/parse-regs-options.h               |   3 +-
>  tools/perf/util/perf_regs.c                        |  10 +
>  tools/perf/util/perf_regs.h                        |   3 +
>  tools/perf/util/session.c                          | 133 +++++++-
>  tools/perf/util/session.h                          |  14 +
>  tools/perf/util/stat-display.c                     | 107 +++++--
>  tools/perf/util/stat.c                             |   8 +-
>  tools/perf/util/thread.c                           |   3 +-
>  tools/perf/util/tool.h                             |   2 +
>  tools/perf/util/unwind-libunwind-local.c           |   6 -
>  tools/perf/util/unwind-libunwind.c                 |  10 +
>  tools/perf/util/zstd.c                             | 111 +++++++
>  102 files changed, 5703 insertions(+), 216 deletions(-)
>  create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/lib/traceevent/Documentation/Makefile
>  create mode 100644 tools/lib/traceevent/Documentation/asciidoc.conf
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-commands.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-cpus.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-endian_read.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_find.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_get.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-event_list.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_find.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_get_val.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_print.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-field_read.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-fields.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-file_endian.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-filter.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-func_find.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-handle.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-header_page.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-host_endian.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-long_size.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-page_size.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_event.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-parse_head.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-record_parse.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_event_handler.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-reg_print_func.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-set_flag.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-strerror.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-tseq.txt
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent.txt
>  create mode 100644 tools/lib/traceevent/Documentation/manpage-1.72.xsl
>  create mode 100644 tools/lib/traceevent/Documentation/manpage-base.xsl
>  create mode 100644 tools/lib/traceevent/Documentation/manpage-bold-literal.xsl
>  create mode 100644 tools/lib/traceevent/Documentation/manpage-normal.xsl
>  create mode 100644 tools/lib/traceevent/Documentation/manpage-suppress-sp.xsl
>  create mode 100644 tools/perf/arch/csky/Build
>  create mode 100644 tools/perf/arch/csky/Makefile
>  create mode 100644 tools/perf/arch/csky/include/perf_regs.h
>  create mode 100644 tools/perf/arch/csky/util/Build
>  create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
>  create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh
>  create mode 100644 tools/perf/util/zstd.c

Pulled, thanks a lot Arnaldo!

	Ingo
