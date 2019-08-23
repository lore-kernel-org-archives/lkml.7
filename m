Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38291C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F387F2341D
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391034AbfHWC2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33810 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389611AbfHWC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJB-00019p-Fu; Fri, 23 Aug 2019 04:28:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F2C461C0890;
        Fri, 23 Aug 2019 04:28:08 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:08 -0000
From:   tip-bot2 for Alexey Budankov <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report: Prefer DWARF callstacks to LBR ones
 when captured both
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
In-Reply-To: <ccbd9583-82f4-dec5-7e84-64bf56e351fb@linux.intel.com>
References: <ccbd9583-82f4-dec5-7e84-64bf56e351fb@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156652728884.12704.14948438831949421867.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     10ccbc1cc0b8a05a5c8491630d36d1e2672036c1
Gitweb:        https://git.kernel.org/tip/10ccbc1cc0b8a05a5c8491630d36d1e2672036c1
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Fri, 09 Aug 2019 18:31:28 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:20:16 -03:00

perf report: Prefer DWARF callstacks to LBR ones when captured both

Display DWARF based callchains when the perf.data file contains raw thread
stack data as LBR callstack data.

Commiter testing:

This changes the output from the branch stack based one, i.e. without
this patch, for the same file as in the previous csets:

  # perf report --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  # Total Lost Samples: 0
  #
  # Samples: 13  of event 'cycles'
  # Event count (approx.): 13
  #
  # Overhead  Command  Source Shared Object  Source Symbol                Target Symbol                              Basic Block Cycles
  # ........  .......  ....................  ...........................  .........................................  ..................
  #
       7.69%  ls       libpthread-2.29.so    [.] _init                    [.] __pthread_initialize_minimal_internal  6827
       7.69%  ls       ld-2.29.so            [k] _start                   [k] _dl_start                              -
       7.69%  ls       ld-2.29.so            [.] _dl_start_user           [.] _dl_init                               -24790
       7.69%  ls       ld-2.29.so            [k] _dl_start                [k] _dl_sysdep_start                       278
       7.69%  ls       ld-2.29.so            [k] dl_main                  [k] _dl_map_object_deps                    15581
       7.69%  ls       ld-2.29.so            [k] open_verify.constprop.0  [k] lseek64                                4228
       7.69%  ls       ld-2.29.so            [k] _dl_map_object           [k] open_verify.constprop.0                55
       7.69%  ls       ld-2.29.so            [k] openaux                  [k] _dl_map_object                         67
       7.69%  ls       ld-2.29.so            [k] _dl_map_object_deps      [k] 0x00007f441b57c090                     112
       7.69%  ls       ld-2.29.so            [.] call_init.part.0         [.] _init                                  334
       7.69%  ls       ld-2.29.so            [.] _dl_init                 [.] call_init.part.0                       383
       7.69%  ls       ld-2.29.so            [k] _dl_sysdep_start         [k] dl_main                                45
       7.69%  ls       ld-2.29.so            [k] _dl_catch_exception      [k] openaux                                116

  #
  # (Tip: For memory address profiling, try: perf mem record / perf mem report)
  #

To the one that shows call chains:

  # perf report --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 10  of event 'cycles'
  # Event count (approx.): 3204047
  #
  # Children      Self  Command  Shared Object       Symbol
  # ........  ........  .......  ..................  .........................................
  #
      55.01%     0.00%  ls       [kernel.vmlinux]    [k] entry_SYSCALL_64_after_hwframe
              |
              ---entry_SYSCALL_64_after_hwframe
                 do_syscall_64
                 |
                  --16.01%--__x64_sys_execve
                            __do_execve_file.isra.0
                            search_binary_handler
                            load_elf_binary
                            elf_map
                            vm_mmap_pgoff
                            do_mmap
                            mmap_region
                            perf_event_mmap
                            perf_iterate_sb
                            perf_iterate_ctx
                            perf_event_mmap_output
                            perf_output_copy
                            memcpy_erms

      55.01%    39.00%  ls       [kernel.vmlinux]    [k] do_syscall_64
              |
              |--39.00%--0xffffffffffffffff
              |          _dl_map_object
              |          open_verify.constprop.0
              |          __lseek64 (inlined)
              |          entry_SYSCALL_64_after_hwframe
              |          do_syscall_64
              |
               --16.01%--do_syscall_64
                         __x64_sys_execve
                         __do_execve_file.isra.0
                         search_binary_handler
                         load_elf_binary
                         elf_map
                         vm_mmap_pgoff
                         do_mmap
                         mmap_region
                         perf_event_mmap
                         perf_iterate_sb
                         perf_iterate_ctx
                         perf_event_mmap_output
                         perf_output_copy
                         memcpy_erms

      42.95%    42.95%  ls       libpthread-2.29.so  [.] __pthread_initialize_minimal_internal
              |
              ---_init
                 __pthread_initialize_minimal_internal

      42.95%     0.00%  ls       libpthread-2.29.so  [.] _init
              |
              ---_init
                 __pthread_initialize_minimal_internal

  <SNIP>

  #
  # (Tip: Profiling branch (mis)predictions with: perf record -b / perf report)
  #
  #

The branch stack view be explicitely selected using:

  # perf report -h branch-stack

   Usage: perf report [<options>]

      -b, --branch-stack    use branch records for per branch histogram filling

  #

I.e. after this patch:

  # perf report -b --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 13  of event 'cycles'
  # Event count (approx.): 13
  #
  # Overhead  Command  Source Shared Object  Source Symbol                Target Symbol                              Basic Block Cycles
  # ........  .......  ....................  ...........................  .........................................  ..................
  #
       7.69%  ls       libpthread-2.29.so    [.] _init                    [.] __pthread_initialize_minimal_internal  6827
       7.69%  ls       ld-2.29.so            [k] _start                   [k] _dl_start                              -
       7.69%  ls       ld-2.29.so            [.] _dl_start_user           [.] _dl_init                               -24790
       7.69%  ls       ld-2.29.so            [k] _dl_start                [k] _dl_sysdep_start                       278
       7.69%  ls       ld-2.29.so            [k] dl_main                  [k] _dl_map_object_deps                    15581
       7.69%  ls       ld-2.29.so            [k] open_verify.constprop.0  [k] lseek64                                4228
       7.69%  ls       ld-2.29.so            [k] _dl_map_object           [k] open_verify.constprop.0                55
       7.69%  ls       ld-2.29.so            [k] openaux                  [k] _dl_map_object                         67
       7.69%  ls       ld-2.29.so            [k] _dl_map_object_deps      [k] 0x00007f441b57c090                     112
       7.69%  ls       ld-2.29.so            [.] call_init.part.0         [.] _init                                  334
       7.69%  ls       ld-2.29.so            [.] _dl_init                 [.] call_init.part.0                       383
       7.69%  ls       ld-2.29.so            [k] _dl_sysdep_start         [k] dl_main                                45
       7.69%  ls       ld-2.29.so            [k] _dl_catch_exception      [k] openaux                                116

  #
  # (Tip: Show current config key-value pairs: perf config --list)
  #
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/ccbd9583-82f4-dec5-7e84-64bf56e351fb@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 5e003d0..79dfb11 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1281,6 +1281,8 @@ int cmd_report(int argc, const char **argv)
 
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
+	if (perf_evlist__combined_sample_type(session->evlist) & PERF_SAMPLE_STACK_USER)
+		has_br_stack = false;
 
 	setup_forced_leader(&report, session->evlist);
 
