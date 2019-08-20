Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F29FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456102332A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329317;
	bh=swG7zWzEufKgLlsLjkzEw5DqyoyKOqjAW11ALqdrNMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QtCmVdEYpvqLx1HYvSS4n0/Hb+aP7pnJhKQXirB/9L1S8cjzYp2Y3y/Db40+2dNCv
	 X0/wHANNu/w8VeTANouqr4dLddyBJDvInImUh/r2h9eTbWKf1bVw2QtY8fDedDkx3z
	 VP2I4a4wWeYa/y2t++/PGEHHNOicChHvdf54oepc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfHTT2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbfHTT2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:35 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01F922DA7;
        Tue, 20 Aug 2019 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329314;
        bh=swG7zWzEufKgLlsLjkzEw5DqyoyKOqjAW11ALqdrNMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpasWYOc57y9B2QiG0QojzO2kJjiJeQZxdCvVx6Bf3e5exSjr8/fnLbTX+qqM6Jhk
         f8ka940w1oBxJVKG5iYch2dkHUUooa6aCFIhIBQm/tghAaYNGriFMquPa1UMc8sJpl
         ZZ45LAa9BhheR5uJ2ot+iyc51C5xItgSyncP4gE4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 10/17] perf report: Prefer DWARF callstacks to LBR ones when captured both
Date:   Tue, 20 Aug 2019 16:27:26 -0300
Message-Id: <20190820192733.19180-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
index 5e003d02821e..79dfb1139f94 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1281,6 +1281,8 @@ int cmd_report(int argc, const char **argv)
 
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
+	if (perf_evlist__combined_sample_type(session->evlist) & PERF_SAMPLE_STACK_USER)
+		has_br_stack = false;
 
 	setup_forced_leader(&report, session->evlist);
 
-- 
2.21.0

