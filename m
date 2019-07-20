Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBECC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC8921874
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfGTMw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:52:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34313 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbfGTMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:52:26 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hooqQ-0005QW-JF; Sat, 20 Jul 2019 14:52:11 +0200
Date:   Sat, 20 Jul 2019 12:50:00 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.3-rc1
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
Message-ID: <156362700019.18624.13205640129006069326.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  e0c5c5e308ee: Merge tag 'perf-core-for-mingo-5.3-20190715' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

A set of perf improvements and fixes:

     perf db-export:
      - Improvements in how COMM details are exported to databases for
        post processing and use in the sql-viewer.py UI.
    
      - Export switch events to the database.
    
     BPF:
      - Bump rlimit(MEMLOCK) for 'perf test bpf' and 'perf trace', just like
        selftests/bpf/bpf_rlimit.h do, which makes errors due to exhaustion of
        this limit, which are kinda cryptic (EPERM sometimes) less frequent.
    
     perf version:
      - Fix segfault due to missing OPT_END(), noticed on PowerPC.
    
     perf vendor events:
      - Add JSON files for IBM s/390 machine type 8561.
    
     perf cs-etm (ARM):
      - Fix two cases of error returns not bing done properly: Invalid ERR_PTR() use
        and loss of propagation error codes.

Thanks,

	tglx

------------------>
Adrian Hunter (21):
      perf db-export: Get rid of db_export__deferred()
      perf db-export: Rename db_export__comm() to db_export__exec_comm()
      perf db-export: Pass main_thread to db_export__thread()
      perf db-export: Export main_thread in db_export__sample()
      perf db-export: Export comm before exporting thread
      perf db-export: Move export__comm_thread into db_export__sample()
      perf db-export: Fix a white space issue in db_export__sample()
      perf db-export: Export comm details
      perf scripts python: export-to-sqlite.py: Export comm details
      perf scripts python: export-to-postgresql.py: Export comm details
      perf db-export: Factor out db_export__comm()
      perf db-export: Also export thread's current comm
      perf scripts python: export-to-sqlite.py: Add has_calls column to comms table
      perf scripts python: export-to-postgresql.py: Add has_calls column to comms table
      perf scripts python: exported-sql-viewer.py: Remove redundant semi-colons
      perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column
      perf script: Add scripting operation process_switch()
      perf db-export: Factor out db_export__threads()
      perf db-export: Export switch events
      perf scripts python: export-to-sqlite.py: Export switch events
      perf scripts python: export-to-postgresql.py: Export switch events

Arnaldo Carvalho de Melo (3):
      perf tools: Introduce rlimit__bump_memlock() helper
      perf test: Auto bump rlimit(MEMLOCK) for BPF test sake
      perf trace: Auto bump rlimit(MEMLOCK) for eBPF maps sake

Ravi Bangoria (1):
      perf version: Fix segfault due to missing OPT_END()

Thomas Richter (1):
      perf vendor events s390: Add JSON files for machine type 8561

YueHaibing (2):
      perf cs-etm: Remove errnoeous ERR_PTR() usage in cs_etm__process_auxtrace_info
      perf cs-etm: Return errcode in cs_etm__process_auxtrace_info()


 tools/perf/builtin-script.c                        |   8 +-
 tools/perf/builtin-trace.c                         |  10 +
 tools/perf/builtin-version.c                       |   1 +
 .../perf/pmu-events/arch/s390/cf_m8561/basic.json  |  58 ++++
 .../perf/pmu-events/arch/s390/cf_m8561/crypto.json | 114 +++++++
 .../pmu-events/arch/s390/cf_m8561/crypto6.json     |  30 ++
 .../pmu-events/arch/s390/cf_m8561/extended.json    | 373 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 tools/perf/scripts/python/export-to-postgresql.py  |  68 +++-
 tools/perf/scripts/python/export-to-sqlite.py      |  54 ++-
 tools/perf/scripts/python/exported-sql-viewer.py   |  34 +-
 tools/perf/tests/builtin-test.c                    |   6 +
 tools/perf/util/Build                              |   1 +
 tools/perf/util/cs-etm.c                           |  12 +-
 tools/perf/util/db-export.c                        | 291 ++++++++++------
 tools/perf/util/db-export.h                        |  19 +-
 tools/perf/util/rlimit.c                           |  29 ++
 tools/perf/util/rlimit.h                           |   6 +
 .../util/scripting-engines/trace-event-python.c    |  53 ++-
 tools/perf/util/trace-event.h                      |   3 +
 20 files changed, 1029 insertions(+), 142 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
 create mode 100644 tools/perf/util/rlimit.c
 create mode 100644 tools/perf/util/rlimit.h

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 79367087bd18..8f24865596af 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2289,6 +2289,12 @@ static int process_switch_event(struct perf_tool *tool,
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
+	if (scripting_ops && scripting_ops->process_switch)
+		scripting_ops->process_switch(event, sample, machine);
+
+	if (!script->show_switch_events)
+		return 0;
+
 	thread = machine__findnew_thread(machine, sample->pid,
 					 sample->tid);
 	if (thread == NULL) {
@@ -2467,7 +2473,7 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.mmap = process_mmap_event;
 		script->tool.mmap2 = process_mmap2_event;
 	}
-	if (script->show_switch_events)
+	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1aa2ed096f65..4f0bbffee05f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #include <api/fs/tracing_path.h>
 #include <bpf/bpf.h>
 #include "util/bpf_map.h"
+#include "util/rlimit.h"
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
@@ -3864,6 +3865,15 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
+	/*
+	 * Parsing .perfconfig may entail creating a BPF event, that may need
+	 * to create BPF maps, so bump RLIM_MEMLOCK as the default 64K setting
+	 * is too small. This affects just this process, not touching the
+	 * global setting. If it fails we'll get something in 'perf trace -v'
+	 * to help diagnose the problem.
+	 */
+	rlimit__bump_memlock();
+
 	err = perf_config(trace__config, &trace);
 	if (err)
 		goto out;
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index f470144d1a70..bf114ca9ca87 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -19,6 +19,7 @@ static struct version version;
 static struct option version_options[] = {
 	OPT_BOOLEAN(0, "build-options", &version.build_options,
 		    "display the build options"),
+	OPT_END(),
 };
 
 static const char * const version_usage[] = {
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json b/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
new file mode 100644
index 000000000000..17fb5241928b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/basic.json
@@ -0,0 +1,58 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "0",
+		"EventName": "CPU_CYCLES",
+		"BriefDescription": "CPU Cycles",
+		"PublicDescription": "Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "1",
+		"EventName": "INSTRUCTIONS",
+		"BriefDescription": "Instructions",
+		"PublicDescription": "Instruction Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "2",
+		"EventName": "L1I_DIR_WRITES",
+		"BriefDescription": "L1I Directory Writes",
+		"PublicDescription": "Level-1 I-Cache Directory Write Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "3",
+		"EventName": "L1I_PENALTY_CYCLES",
+		"BriefDescription": "L1I Penalty Cycles",
+		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "4",
+		"EventName": "L1D_DIR_WRITES",
+		"BriefDescription": "L1D Directory Writes",
+		"PublicDescription": "Level-1 D-Cache Directory Write Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "5",
+		"EventName": "L1D_PENALTY_CYCLES",
+		"BriefDescription": "L1D Penalty Cycles",
+		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "32",
+		"EventName": "PROBLEM_STATE_CPU_CYCLES",
+		"BriefDescription": "Problem-State CPU Cycles",
+		"PublicDescription": "Problem-State Cycle Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "33",
+		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
+		"BriefDescription": "Problem-State Instructions",
+		"PublicDescription": "Problem-State Instruction Count"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
new file mode 100644
index 000000000000..db286f19e7b6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto.json
@@ -0,0 +1,114 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "64",
+		"EventName": "PRNG_FUNCTIONS",
+		"BriefDescription": "PRNG Functions",
+		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "65",
+		"EventName": "PRNG_CYCLES",
+		"BriefDescription": "PRNG Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "66",
+		"EventName": "PRNG_BLOCKED_FUNCTIONS",
+		"BriefDescription": "PRNG Blocked Functions",
+		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "67",
+		"EventName": "PRNG_BLOCKED_CYCLES",
+		"BriefDescription": "PRNG Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "68",
+		"EventName": "SHA_FUNCTIONS",
+		"BriefDescription": "SHA Functions",
+		"PublicDescription": "Total number of SHA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "69",
+		"EventName": "SHA_CYCLES",
+		"BriefDescription": "SHA Cycles",
+		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "70",
+		"EventName": "SHA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "SHA Blocked Functions",
+		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "71",
+		"EventName": "SHA_BLOCKED_CYCLES",
+		"BriefDescription": "SHA Bloced Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "72",
+		"EventName": "DEA_FUNCTIONS",
+		"BriefDescription": "DEA Functions",
+		"PublicDescription": "Total number of the DEA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "73",
+		"EventName": "DEA_CYCLES",
+		"BriefDescription": "DEA Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "74",
+		"EventName": "DEA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "DEA Blocked Functions",
+		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "75",
+		"EventName": "DEA_BLOCKED_CYCLES",
+		"BriefDescription": "DEA Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "76",
+		"EventName": "AES_FUNCTIONS",
+		"BriefDescription": "AES Functions",
+		"PublicDescription": "Total number of AES functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "77",
+		"EventName": "AES_CYCLES",
+		"BriefDescription": "AES Cycles",
+		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "78",
+		"EventName": "AES_BLOCKED_FUNCTIONS",
+		"BriefDescription": "AES Blocked Functions",
+		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "79",
+		"EventName": "AES_BLOCKED_CYCLES",
+		"BriefDescription": "AES Blocked Cycles",
+		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
new file mode 100644
index 000000000000..5e36bc2468d0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/crypto6.json
@@ -0,0 +1,30 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "80",
+		"EventName": "ECC_FUNCTION_COUNT",
+		"BriefDescription": "ECC Function Count",
+		"PublicDescription": "Long ECC function Count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "81",
+		"EventName": "ECC_CYCLES_COUNT",
+		"BriefDescription": "ECC Cycles Count",
+		"PublicDescription": "Long ECC Function cycles count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "82",
+		"EventName": "ECC_BLOCKED_FUNCTION_COUNT",
+		"BriefDescription": "Ecc Blocked Function Count",
+		"PublicDescription": "Long ECC blocked function count"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "83",
+		"EventName": "ECC_BLOCKED_CYCLES_COUNT",
+		"BriefDescription": "ECC Blocked Cycles Count",
+		"PublicDescription": "Long ECC blocked cycles count"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json b/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
new file mode 100644
index 000000000000..89e070727e1b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_m8561/extended.json
@@ -0,0 +1,373 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "128",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "129",
+		"EventName": "DTLB2_WRITES",
+		"BriefDescription": "DTLB2 Writes",
+		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "130",
+		"EventName": "DTLB2_MISSES",
+		"BriefDescription": "DTLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "131",
+		"EventName": "DTLB2_HPAGE_WRITES",
+		"BriefDescription": "DTLB2 One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page or a Last Host Translation was done"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "132",
+		"EventName": "DTLB2_GPAGE_WRITES",
+		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
+		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "133",
+		"EventName": "L1D_L2D_SOURCED_WRITES",
+		"BriefDescription": "L1D L2D Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "134",
+		"EventName": "ITLB2_WRITES",
+		"BriefDescription": "ITLB2 Writes",
+		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "135",
+		"EventName": "ITLB2_MISSES",
+		"BriefDescription": "ITLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "136",
+		"EventName": "L1I_L2I_SOURCED_WRITES",
+		"BriefDescription": "L1I L2I Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "137",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 PTE Writes",
+		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "138",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 CRSTE Writes",
+		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "139",
+		"EventName": "TLB2_ENGINES_BUSY",
+		"BriefDescription": "TLB2 Engines Busy",
+		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "140",
+		"EventName": "TX_C_TEND",
+		"BriefDescription": "Completed TEND instructions in constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "141",
+		"EventName": "TX_NC_TEND",
+		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "143",
+		"EventName": "L1C_TLB2_MISSES",
+		"BriefDescription": "L1C TLB2 Misses",
+		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "144",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "145",
+		"EventName": "L1D_ONCHIP_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "146",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "147",
+		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache withountervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "148",
+		"EventName": "L1D_ONCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "149",
+		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "150",
+		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "151",
+		"EventName": "L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "152",
+		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "153",
+		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "154",
+		"EventName": "L1D_OFFDRAWER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "155",
+		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "156",
+		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "157",
+		"EventName": "L1D_OFFDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "158",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_RO",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes read-only",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "162",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "163",
+		"EventName": "L1I_ONCHIP_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "164",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "165",
+		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "166",
+		"EventName": "L1I_ONCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "167",
+		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "168",
+		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "169",
+		"EventName": "L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Cluster Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "170",
+		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "171",
+		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "172",
+		"EventName": "L1I_OFFDRAWER_MEMORY_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "173",
+		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "174",
+		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "175",
+		"EventName": "L1I_OFFDRAWER_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Drawer L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "224",
+		"EventName": "BCD_DFP_EXECUTION_SLOTS",
+		"BriefDescription": "BCD DFP Execution Slots",
+		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "225",
+		"EventName": "VX_BCD_EXECUTION_SLOTS",
+		"BriefDescription": "VX BCD Execution Slots",
+		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "226",
+		"EventName": "DECIMAL_INSTRUCTIONS",
+		"BriefDescription": "Decimal Instructions",
+		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "232",
+		"EventName": "LAST_HOST_TRANSLATIONS",
+		"BriefDescription": "Last host translation done",
+		"PublicDescription": "Last Host Translation done"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "243",
+		"EventName": "TX_NC_TABORT",
+		"BriefDescription": "Aborted transactions in non-constrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "244",
+		"EventName": "TX_C_TABORT_NO_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "245",
+		"EventName": "TX_C_TABORT_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "448",
+		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
+		"BriefDescription": "Cycle count with one thread active",
+		"PublicDescription": "Cycle count with one thread active"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "449",
+		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
+		"BriefDescription": "Cycle count with two threads active",
+		"PublicDescription": "Cycle count with two threads active"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index 78bcf7f8e206..bd3fc577139c 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -4,3 +4,4 @@ Family-model,Version,Filename,EventType
 ^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
+^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_m8561,core
diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 92713d93e956..7bd73a904b4e 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -353,7 +353,10 @@ do_query(query, 'CREATE TABLE threads ('
 		'tid		integer)')
 do_query(query, 'CREATE TABLE comms ('
 		'id		bigint		NOT NULL,'
-		'comm		varchar(16))')
+		'comm		varchar(16),'
+		'c_thread_id	bigint,'
+		'c_time		bigint,'
+		'exec_flag	boolean)')
 do_query(query, 'CREATE TABLE comm_threads ('
 		'id		bigint		NOT NULL,'
 		'comm_id	bigint,'
@@ -479,6 +482,17 @@ do_query(query, 'CREATE TABLE pwrx ('
 	'last_cstate	integer,'
 	'wake_reason	integer)')
 
+do_query(query, 'CREATE TABLE context_switches ('
+		'id		bigint		NOT NULL,'
+		'machine_id	bigint,'
+		'time		bigint,'
+		'cpu		integer,'
+		'thread_out_id	bigint,'
+		'comm_out_id	bigint,'
+		'thread_in_id	bigint,'
+		'comm_in_id	bigint,'
+		'flags		integer)')
+
 do_query(query, 'CREATE VIEW machines_view AS '
 	'SELECT '
 		'id,'
@@ -692,6 +706,29 @@ do_query(query, 'CREATE VIEW power_events_view AS '
 	' INNER JOIN selected_events ON selected_events.id = samples.evsel_id'
 	' ORDER BY samples.id')
 
+do_query(query, 'CREATE VIEW context_switches_view AS '
+	'SELECT '
+		'context_switches.id,'
+		'context_switches.machine_id,'
+		'context_switches.time,'
+		'context_switches.cpu,'
+		'th_out.pid AS pid_out,'
+		'th_out.tid AS tid_out,'
+		'comm_out.comm AS comm_out,'
+		'th_in.pid AS pid_in,'
+		'th_in.tid AS tid_in,'
+		'comm_in.comm AS comm_in,'
+		'CASE	  WHEN context_switches.flags = 0 THEN \'in\''
+			' WHEN context_switches.flags = 1 THEN \'out\''
+			' WHEN context_switches.flags = 3 THEN \'out preempt\''
+			' ELSE CAST ( context_switches.flags AS VARCHAR(11) )'
+		'END AS flags'
+	' FROM context_switches'
+	' INNER JOIN threads AS th_out ON th_out.id   = context_switches.thread_out_id'
+	' INNER JOIN threads AS th_in  ON th_in.id    = context_switches.thread_in_id'
+	' INNER JOIN comms AS comm_out ON comm_out.id = context_switches.comm_out_id'
+	' INNER JOIN comms AS comm_in  ON comm_in.id  = context_switches.comm_in_id')
+
 file_header = struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
 file_trailer = b"\377\377"
 
@@ -756,6 +793,7 @@ mwait_file		= open_output_file("mwait_table.bin")
 pwre_file		= open_output_file("pwre_table.bin")
 exstop_file		= open_output_file("exstop_table.bin")
 pwrx_file		= open_output_file("pwrx_table.bin")
+context_switches_file	= open_output_file("context_switches_table.bin")
 
 def trace_begin():
 	printdate("Writing to intermediate files...")
@@ -763,7 +801,7 @@ def trace_begin():
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
 	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown")
+	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -804,6 +842,7 @@ def trace_end():
 	copy_output_file(pwre_file,		"pwre")
 	copy_output_file(exstop_file,		"exstop")
 	copy_output_file(pwrx_file,		"pwrx")
+	copy_output_file(context_switches_file,	"context_switches")
 
 	printdate("Removing intermediate files...")
 	remove_output_file(evsel_file)
@@ -825,6 +864,7 @@ def trace_end():
 	remove_output_file(pwre_file)
 	remove_output_file(exstop_file)
 	remove_output_file(pwrx_file)
+	remove_output_file(context_switches_file)
 	os.rmdir(output_dir_name)
 	printdate("Adding primary keys")
 	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
@@ -846,11 +886,14 @@ def trace_end():
 	do_query(query, 'ALTER TABLE pwre            ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE exstop          ADD PRIMARY KEY (id)')
 	do_query(query, 'ALTER TABLE pwrx            ADD PRIMARY KEY (id)')
+	do_query(query, 'ALTER TABLE context_switches ADD PRIMARY KEY (id)')
 
 	printdate("Adding foreign keys")
 	do_query(query, 'ALTER TABLE threads '
 					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
 					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
+	do_query(query, 'ALTER TABLE comms '
+					'ADD CONSTRAINT threadfk   FOREIGN KEY (c_thread_id)  REFERENCES threads    (id)')
 	do_query(query, 'ALTER TABLE comm_threads '
 					'ADD CONSTRAINT commfk     FOREIGN KEY (comm_id)      REFERENCES comms      (id),'
 					'ADD CONSTRAINT threadfk   FOREIGN KEY (thread_id)    REFERENCES threads    (id)')
@@ -881,6 +924,8 @@ def trace_end():
 					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
+		do_query(query, 'UPDATE comms SET has_calls = TRUE WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
 	do_query(query, 'ALTER TABLE ptwrite '
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
 	do_query(query, 'ALTER TABLE  cbr '
@@ -893,6 +938,12 @@ def trace_end():
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
 	do_query(query, 'ALTER TABLE  pwrx '
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
+	do_query(query, 'ALTER TABLE  context_switches '
+					'ADD CONSTRAINT machinefk   FOREIGN KEY (machine_id)    REFERENCES machines (id),'
+					'ADD CONSTRAINT toutfk      FOREIGN KEY (thread_out_id) REFERENCES threads  (id),'
+					'ADD CONSTRAINT tinfk       FOREIGN KEY (thread_in_id)  REFERENCES threads  (id),'
+					'ADD CONSTRAINT coutfk      FOREIGN KEY (comm_out_id)   REFERENCES comms    (id),'
+					'ADD CONSTRAINT cinfk       FOREIGN KEY (comm_in_id)    REFERENCES comms    (id)')
 
 	printdate("Dropping unused tables")
 	if is_table_empty("ptwrite"):
@@ -905,6 +956,8 @@ def trace_end():
 		drop("pwrx")
 		if is_table_empty("cbr"):
 			drop("cbr")
+	if is_table_empty("context_switches"):
+		drop("context_switches")
 
 	if (unhandled_count):
 		printdate("Warning: ", unhandled_count, " unhandled events")
@@ -935,11 +988,11 @@ def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
 	value = struct.pack("!hiqiqiqiiii", 5, 8, thread_id, 8, machine_id, 8, process_id, 4, pid, 4, tid)
 	thread_file.write(value)
 
-def comm_table(comm_id, comm_str, *x):
+def comm_table(comm_id, comm_str, thread_id, time, exec_flag, *x):
 	comm_str = toserverstr(comm_str)
 	n = len(comm_str)
-	fmt = "!hiqi" + str(n) + "s"
-	value = struct.pack(fmt, 2, 8, comm_id, n, comm_str)
+	fmt = "!hiqi" + str(n) + "s" + "iqiqiB"
+	value = struct.pack(fmt, 5, 8, comm_id, n, comm_str, 8, thread_id, 8, time, 1, exec_flag)
 	comm_file.write(value)
 
 def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
@@ -1051,3 +1104,8 @@ def synth_data(id, config, raw_buf, *x):
 		pwrx(id, raw_buf)
 	elif config == 5:
 		cbr(id, raw_buf)
+
+def context_switch_table(id, machine_id, time, cpu, thread_out_id, comm_out_id, thread_in_id, comm_in_id, flags, *x):
+	fmt = "!hiqiqiqiiiqiqiqiqii"
+	value = struct.pack(fmt, 9, 8, id, 8, machine_id, 8, time, 4, cpu, 8, thread_out_id, 8, comm_out_id, 8, thread_in_id, 8, comm_in_id, 4, flags)
+	context_switches_file.write(value)
diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 021326c46285..8043a7272a56 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -177,7 +177,10 @@ do_query(query, 'CREATE TABLE threads ('
 		'tid		integer)')
 do_query(query, 'CREATE TABLE comms ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
-		'comm		varchar(16))')
+		'comm		varchar(16),'
+		'c_thread_id	bigint,'
+		'c_time		bigint,'
+		'exec_flag	boolean)')
 do_query(query, 'CREATE TABLE comm_threads ('
 		'id		integer		NOT NULL	PRIMARY KEY,'
 		'comm_id	bigint,'
@@ -303,6 +306,17 @@ do_query(query, 'CREATE TABLE pwrx ('
 		'last_cstate	integer,'
 		'wake_reason	integer)')
 
+do_query(query, 'CREATE TABLE context_switches ('
+		'id		integer		NOT NULL	PRIMARY KEY,'
+		'machine_id	bigint,'
+		'time		bigint,'
+		'cpu		integer,'
+		'thread_out_id	bigint,'
+		'comm_out_id	bigint,'
+		'thread_in_id	bigint,'
+		'comm_in_id	bigint,'
+		'flags		integer)')
+
 # printf was added to sqlite in version 3.8.3
 sqlite_has_printf = False
 try:
@@ -527,6 +541,29 @@ do_query(query, 'CREATE VIEW power_events_view AS '
 	' INNER JOIN selected_events ON selected_events.id = evsel_id'
 	' WHERE selected_events.name IN (\'cbr\',\'mwait\',\'exstop\',\'pwre\',\'pwrx\')')
 
+do_query(query, 'CREATE VIEW context_switches_view AS '
+	'SELECT '
+		'context_switches.id,'
+		'context_switches.machine_id,'
+		'context_switches.time,'
+		'context_switches.cpu,'
+		'th_out.pid AS pid_out,'
+		'th_out.tid AS tid_out,'
+		'comm_out.comm AS comm_out,'
+		'th_in.pid AS pid_in,'
+		'th_in.tid AS tid_in,'
+		'comm_in.comm AS comm_in,'
+		'CASE	  WHEN context_switches.flags = 0 THEN \'in\''
+			' WHEN context_switches.flags = 1 THEN \'out\''
+			' WHEN context_switches.flags = 3 THEN \'out preempt\''
+			' ELSE context_switches.flags '
+		'END AS flags'
+	' FROM context_switches'
+	' INNER JOIN threads AS th_out ON th_out.id   = context_switches.thread_out_id'
+	' INNER JOIN threads AS th_in  ON th_in.id    = context_switches.thread_in_id'
+	' INNER JOIN comms AS comm_out ON comm_out.id = context_switches.comm_out_id'
+	' INNER JOIN comms AS comm_in  ON comm_in.id  = context_switches.comm_in_id')
+
 do_query(query, 'END TRANSACTION')
 
 evsel_query = QSqlQuery(db)
@@ -536,7 +573,7 @@ machine_query.prepare("INSERT INTO machines VALUES (?, ?, ?)")
 thread_query = QSqlQuery(db)
 thread_query.prepare("INSERT INTO threads VALUES (?, ?, ?, ?, ?)")
 comm_query = QSqlQuery(db)
-comm_query.prepare("INSERT INTO comms VALUES (?, ?)")
+comm_query.prepare("INSERT INTO comms VALUES (?, ?, ?, ?, ?)")
 comm_thread_query = QSqlQuery(db)
 comm_thread_query.prepare("INSERT INTO comm_threads VALUES (?, ?, ?)")
 dso_query = QSqlQuery(db)
@@ -568,6 +605,8 @@ exstop_query = QSqlQuery(db)
 exstop_query.prepare("INSERT INTO exstop VALUES (?, ?)")
 pwrx_query = QSqlQuery(db)
 pwrx_query.prepare("INSERT INTO pwrx VALUES (?, ?, ?, ?)")
+context_switch_query = QSqlQuery(db)
+context_switch_query.prepare("INSERT INTO context_switches VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
 
 def trace_begin():
 	printdate("Writing records...")
@@ -576,7 +615,7 @@ def trace_begin():
 	evsel_table(0, "unknown")
 	machine_table(0, 0, "unknown")
 	thread_table(0, 0, 0, -1, -1)
-	comm_table(0, "unknown")
+	comm_table(0, "unknown", 0, 0, 0)
 	dso_table(0, 0, "unknown", "unknown", "")
 	symbol_table(0, 0, 0, 0, 0, "unknown")
 	sample_table(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
@@ -603,6 +642,8 @@ def trace_end():
 	if perf_db_export_calls:
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
+		do_query(query, 'UPDATE comms SET has_calls = 1 WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
 
 	printdate("Dropping unused tables")
 	if is_table_empty("ptwrite"):
@@ -615,6 +656,8 @@ def trace_end():
 		drop("pwrx")
 		if is_table_empty("cbr"):
 			drop("cbr")
+	if is_table_empty("context_switches"):
+		drop("context_switches")
 
 	if (unhandled_count):
 		printdate("Warning: ", unhandled_count, " unhandled events")
@@ -642,7 +685,7 @@ def thread_table(*x):
 	bind_exec(thread_query, 5, x)
 
 def comm_table(*x):
-	bind_exec(comm_query, 2, x)
+	bind_exec(comm_query, 5, x)
 
 def comm_thread_table(*x):
 	bind_exec(comm_thread_query, 3, x)
@@ -748,3 +791,6 @@ def synth_data(id, config, raw_buf, *x):
 		pwrx(id, raw_buf)
 	elif config == 5:
 		cbr(id, raw_buf)
+
+def context_switch_table(*x):
+	bind_exec(context_switch_query, 9, x)
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 6e7934f2ac9a..61b3911d91e6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -392,7 +392,7 @@ class FindBar():
 		self.hbox.addWidget(self.close_button)
 
 		self.bar = QWidget()
-		self.bar.setLayout(self.hbox);
+		self.bar.setLayout(self.hbox)
 		self.bar.hide()
 
 	def Widget(self):
@@ -470,7 +470,7 @@ class CallGraphLevelItemBase(object):
 		self.params = params
 		self.row = row
 		self.parent_item = parent_item
-		self.query_done = False;
+		self.query_done = False
 		self.child_count = 0
 		self.child_items = []
 		if parent_item:
@@ -517,7 +517,7 @@ class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 		self.time = time
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		if self.params.have_ipc:
 			ipc_str = ", SUM(insn_count), SUM(cyc_count)"
@@ -604,7 +604,7 @@ class CallGraphLevelOneItem(CallGraphLevelItemBase):
 		self.dbid = comm_id
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		QueryExec(query, "SELECT thread_id, pid, tid"
 					" FROM comm_threads"
@@ -622,9 +622,12 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 	def __init__(self, glb, params):
 		super(CallGraphRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
-		self.query_done = True;
+		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
@@ -793,7 +796,7 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 		self.time = time
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		if self.calls_id == 0:
 			comm_thread = " AND comm_id = " + str(self.comm_id) + " AND thread_id = " + str(self.thread_id)
 		else:
@@ -881,7 +884,7 @@ class CallTreeLevelOneItem(CallGraphLevelItemBase):
 		self.dbid = comm_id
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		QueryExec(query, "SELECT thread_id, pid, tid"
 					" FROM comm_threads"
@@ -899,9 +902,12 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 	def __init__(self, glb, params):
 		super(CallTreeRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
-		self.query_done = True;
+		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
@@ -971,7 +977,7 @@ class VBox():
 
 	def __init__(self, w1, w2, w3=None):
 		self.vbox = QWidget()
-		self.vbox.setLayout(QVBoxLayout());
+		self.vbox.setLayout(QVBoxLayout())
 
 		self.vbox.layout().setContentsMargins(0, 0, 0, 0)
 
@@ -1391,7 +1397,7 @@ class FetchMoreRecordsBar():
 		self.hbox.addWidget(self.close_button)
 
 		self.bar = QWidget()
-		self.bar.setLayout(self.hbox);
+		self.bar.setLayout(self.hbox)
 		self.bar.show()
 
 		self.in_progress = False
@@ -2206,7 +2212,7 @@ class ReportDialogBase(QDialog):
 		self.vbox.addLayout(self.grid)
 		self.vbox.addLayout(self.hbox)
 
-		self.setLayout(self.vbox);
+		self.setLayout(self.vbox)
 
 	def Ok(self):
 		vars = self.report_vars
@@ -3139,7 +3145,7 @@ class AboutDialog(QDialog):
 		self.vbox = QVBoxLayout()
 		self.vbox.addWidget(self.text)
 
-		self.setLayout(self.vbox);
+		self.setLayout(self.vbox)
 
 # Font resize
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 66a82badc1d1..c3bec9d2c201 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -21,6 +21,7 @@
 #include <subcmd/parse-options.h>
 #include "string2.h"
 #include "symbol.h"
+#include "util/rlimit.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <subcmd/exec-cmd.h>
@@ -727,6 +728,11 @@ int cmd_test(int argc, const char **argv)
 
 	if (skip != NULL)
 		skiplist = intlist__new(skip);
+	/*
+	 * Tests that create BPF maps, for instance, need more than the 64K
+	 * default:
+	 */
+	rlimit__bump_memlock();
 
 	return __cmd_test(argc, argv, skiplist);
 }
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index d7e3b008a613..14f812bb07a7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -20,6 +20,7 @@ perf-y += parse-events.o
 perf-y += perf_regs.o
 perf-y += path.o
 perf-y += print_binary.o
+perf-y += rlimit.o
 perf-y += argv_split.o
 perf-y += rbtree.o
 perf-y += libstring.o
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 67b88b599a53..3d1c34fc4d68 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2460,7 +2460,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 		/* Something went wrong, no need to continue */
 		if (!inode) {
-			err = PTR_ERR(inode);
+			err = -ENOMEM;
 			goto err_free_metadata;
 		}
 
@@ -2517,8 +2517,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	session->auxtrace = &etm->auxtrace;
 
 	etm->unknown_thread = thread__new(999999999, 999999999);
-	if (!etm->unknown_thread)
+	if (!etm->unknown_thread) {
+		err = -ENOMEM;
 		goto err_free_queues;
+	}
 
 	/*
 	 * Initialize list node so that at thread__zput() we can avoid
@@ -2530,8 +2532,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
-	if (thread__init_map_groups(etm->unknown_thread, etm->machine))
+	if (thread__init_map_groups(etm->unknown_thread, etm->machine)) {
+		err = -ENOMEM;
 		goto err_delete_thread;
+	}
 
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
@@ -2575,5 +2579,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 err_free_hdr:
 	zfree(&hdr);
 
-	return -EINVAL;
+	return err;
 }
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 2394c7506abe..ffbb3e7d3288 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -20,70 +20,14 @@
 #include "db-export.h"
 #include <linux/zalloc.h>
 
-struct deferred_export {
-	struct list_head node;
-	struct comm *comm;
-};
-
-static int db_export__deferred(struct db_export *dbe)
-{
-	struct deferred_export *de;
-	int err;
-
-	while (!list_empty(&dbe->deferred)) {
-		de = list_entry(dbe->deferred.next, struct deferred_export,
-				node);
-		err = dbe->export_comm(dbe, de->comm);
-		list_del_init(&de->node);
-		free(de);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-static void db_export__free_deferred(struct db_export *dbe)
-{
-	struct deferred_export *de;
-
-	while (!list_empty(&dbe->deferred)) {
-		de = list_entry(dbe->deferred.next, struct deferred_export,
-				node);
-		list_del_init(&de->node);
-		free(de);
-	}
-}
-
-static int db_export__defer_comm(struct db_export *dbe, struct comm *comm)
-{
-	struct deferred_export *de;
-
-	de = zalloc(sizeof(struct deferred_export));
-	if (!de)
-		return -ENOMEM;
-
-	de->comm = comm;
-	list_add_tail(&de->node, &dbe->deferred);
-
-	return 0;
-}
-
 int db_export__init(struct db_export *dbe)
 {
 	memset(dbe, 0, sizeof(struct db_export));
-	INIT_LIST_HEAD(&dbe->deferred);
 	return 0;
 }
 
-int db_export__flush(struct db_export *dbe)
-{
-	return db_export__deferred(dbe);
-}
-
 void db_export__exit(struct db_export *dbe)
 {
-	db_export__free_deferred(dbe);
 	call_return_processor__free(dbe->crp);
 	dbe->crp = NULL;
 }
@@ -115,71 +59,73 @@ int db_export__machine(struct db_export *dbe, struct machine *machine)
 }
 
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm)
+		      struct machine *machine, struct thread *main_thread)
 {
-	struct thread *main_thread;
 	u64 main_thread_db_id = 0;
-	int err;
 
 	if (thread->db_id)
 		return 0;
 
 	thread->db_id = ++dbe->thread_last_db_id;
 
-	if (thread->pid_ != -1) {
-		if (thread->pid_ == thread->tid) {
-			main_thread = thread;
-		} else {
-			main_thread = machine__findnew_thread(machine,
-							      thread->pid_,
-							      thread->pid_);
-			if (!main_thread)
-				return -ENOMEM;
-			err = db_export__thread(dbe, main_thread, machine,
-						comm);
-			if (err)
-				goto out_put;
-			if (comm) {
-				err = db_export__comm_thread(dbe, comm, thread);
-				if (err)
-					goto out_put;
-			}
-		}
+	if (main_thread)
 		main_thread_db_id = main_thread->db_id;
-		if (main_thread != thread)
-			thread__put(main_thread);
-	}
 
 	if (dbe->export_thread)
 		return dbe->export_thread(dbe, thread, main_thread_db_id,
 					  machine);
 
 	return 0;
+}
 
-out_put:
-	thread__put(main_thread);
-	return err;
+static int __db_export__comm(struct db_export *dbe, struct comm *comm,
+			     struct thread *thread)
+{
+	comm->db_id = ++dbe->comm_last_db_id;
+
+	if (dbe->export_comm)
+		return dbe->export_comm(dbe, comm, thread);
+
+	return 0;
 }
 
 int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread)
+		    struct thread *thread)
+{
+	if (comm->db_id)
+		return 0;
+
+	return __db_export__comm(dbe, comm, thread);
+}
+
+/*
+ * Export the "exec" comm. The "exec" comm is the program / application command
+ * name at the time it first executes. It is used to group threads for the same
+ * program. Note that the main thread pid (or thread group id tgid) cannot be
+ * used because it does not change when a new program is exec'ed.
+ */
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread)
 {
 	int err;
 
 	if (comm->db_id)
 		return 0;
 
-	comm->db_id = ++dbe->comm_last_db_id;
-
-	if (dbe->export_comm) {
-		if (main_thread->comm_set)
-			err = dbe->export_comm(dbe, comm);
-		else
-			err = db_export__defer_comm(dbe, comm);
-		if (err)
-			return err;
-	}
+	err = __db_export__comm(dbe, comm, main_thread);
+	if (err)
+		return err;
 
+	/*
+	 * Record the main thread for this comm. Note that the main thread can
+	 * have many "exec" comms because there will be a new one every time it
+	 * exec's. An "exec" comm however will only ever have 1 main thread.
+	 * That is different to any other threads for that same program because
+	 * exec() will effectively kill them, so the relationship between the
+	 * "exec" comm and non-main threads is 1-to-1. That is why
+	 * db_export__comm_thread() is called here for the main thread, but it
+	 * is called for non-main threads when they are exported.
+	 */
 	return db_export__comm_thread(dbe, comm, main_thread);
 }
 
@@ -340,11 +286,65 @@ int db_export__branch_type(struct db_export *dbe, u32 branch_type,
 	return 0;
 }
 
+static int db_export__threads(struct db_export *dbe, struct thread *thread,
+			      struct thread *main_thread,
+			      struct machine *machine, struct comm **comm_ptr)
+{
+	struct comm *comm = NULL;
+	struct comm *curr_comm;
+	int err;
+
+	if (main_thread) {
+		/*
+		 * A thread has a reference to the main thread, so export the
+		 * main thread first.
+		 */
+		err = db_export__thread(dbe, main_thread, machine, main_thread);
+		if (err)
+			return err;
+		/*
+		 * Export comm before exporting the non-main thread because
+		 * db_export__comm_thread() can be called further below.
+		 */
+		comm = machine__thread_exec_comm(machine, main_thread);
+		if (comm) {
+			err = db_export__exec_comm(dbe, comm, main_thread);
+			if (err)
+				return err;
+			*comm_ptr = comm;
+		}
+	}
+
+	if (thread != main_thread) {
+		/*
+		 * For a non-main thread, db_export__comm_thread() must be
+		 * called only if thread has not previously been exported.
+		 */
+		bool export_comm_thread = comm && !thread->db_id;
+
+		err = db_export__thread(dbe, thread, machine, main_thread);
+		if (err)
+			return err;
+
+		if (export_comm_thread) {
+			err = db_export__comm_thread(dbe, comm, thread);
+			if (err)
+				return err;
+		}
+	}
+
+	curr_comm = thread__comm(thread);
+	if (curr_comm)
+		return db_export__comm(dbe, curr_comm, thread);
+
+	return 0;
+}
+
 int db_export__sample(struct db_export *dbe, union perf_event *event,
 		      struct perf_sample *sample, struct perf_evsel *evsel,
 		      struct addr_location *al)
 {
-	struct thread* thread = al->thread;
+	struct thread *thread = al->thread;
 	struct export_sample es = {
 		.event = event,
 		.sample = sample,
@@ -364,19 +364,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		return err;
 
 	main_thread = thread__main_thread(al->machine, thread);
-	if (main_thread)
-		comm = machine__thread_exec_comm(al->machine, main_thread);
 
-	err = db_export__thread(dbe, thread, al->machine, comm);
+	err = db_export__threads(dbe, thread, main_thread, al->machine, &comm);
 	if (err)
 		goto out_put;
 
-	if (comm) {
-		err = db_export__comm(dbe, comm, main_thread);
-		if (err)
-			goto out_put;
+	if (comm)
 		es.comm_db_id = comm->db_id;
-	}
 
 	es.db_id = ++dbe->sample_last_db_id;
 
@@ -525,3 +519,92 @@ int db_export__call_return(struct db_export *dbe, struct call_return *cr,
 
 	return 0;
 }
+
+static int db_export__pid_tid(struct db_export *dbe, struct machine *machine,
+			      pid_t pid, pid_t tid, u64 *db_id,
+			      struct comm **comm_ptr, bool *is_idle)
+{
+	struct thread *thread = machine__find_thread(machine, pid, tid);
+	struct thread *main_thread;
+	int err = 0;
+
+	if (!thread || !thread->comm_set)
+		goto out_put;
+
+	*is_idle = !thread->pid_ && !thread->tid;
+
+	main_thread = thread__main_thread(machine, thread);
+
+	err = db_export__threads(dbe, thread, main_thread, machine, comm_ptr);
+
+	*db_id = thread->db_id;
+
+	thread__put(main_thread);
+out_put:
+	thread__put(thread);
+
+	return err;
+}
+
+int db_export__switch(struct db_export *dbe, union perf_event *event,
+		      struct perf_sample *sample, struct machine *machine)
+{
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+	bool out_preempt = out &&
+		(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT);
+	int flags = out | (out_preempt << 1);
+	bool is_idle_a = false, is_idle_b = false;
+	u64 th_a_id = 0, th_b_id = 0;
+	u64 comm_out_id, comm_in_id;
+	struct comm *comm_a = NULL;
+	struct comm *comm_b = NULL;
+	u64 th_out_id, th_in_id;
+	u64 db_id;
+	int err;
+
+	err = db_export__machine(dbe, machine);
+	if (err)
+		return err;
+
+	err = db_export__pid_tid(dbe, machine, sample->pid, sample->tid,
+				 &th_a_id, &comm_a, &is_idle_a);
+	if (err)
+		return err;
+
+	if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
+		pid_t pid = event->context_switch.next_prev_pid;
+		pid_t tid = event->context_switch.next_prev_tid;
+
+		err = db_export__pid_tid(dbe, machine, pid, tid, &th_b_id,
+					 &comm_b, &is_idle_b);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Do not export if both threads are unknown (i.e. not being traced),
+	 * or one is unknown and the other is the idle task.
+	 */
+	if ((!th_a_id || is_idle_a) && (!th_b_id || is_idle_b))
+		return 0;
+
+	db_id = ++dbe->context_switch_last_db_id;
+
+	if (out) {
+		th_out_id   = th_a_id;
+		th_in_id    = th_b_id;
+		comm_out_id = comm_a ? comm_a->db_id : 0;
+		comm_in_id  = comm_b ? comm_b->db_id : 0;
+	} else {
+		th_out_id   = th_b_id;
+		th_in_id    = th_a_id;
+		comm_out_id = comm_b ? comm_b->db_id : 0;
+		comm_in_id  = comm_a ? comm_a->db_id : 0;
+	}
+
+	if (dbe->export_context_switch)
+		return dbe->export_context_switch(dbe, db_id, machine, sample,
+						  th_out_id, comm_out_id,
+						  th_in_id, comm_in_id, flags);
+	return 0;
+}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index e8a64028a386..ba1f62a5fe10 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -43,7 +43,8 @@ struct db_export {
 	int (*export_machine)(struct db_export *dbe, struct machine *machine);
 	int (*export_thread)(struct db_export *dbe, struct thread *thread,
 			     u64 main_thread_db_id, struct machine *machine);
-	int (*export_comm)(struct db_export *dbe, struct comm *comm);
+	int (*export_comm)(struct db_export *dbe, struct comm *comm,
+			   struct thread *thread);
 	int (*export_comm_thread)(struct db_export *dbe, u64 db_id,
 				  struct comm *comm, struct thread *thread);
 	int (*export_dso)(struct db_export *dbe, struct dso *dso,
@@ -56,6 +57,11 @@ struct db_export {
 	int (*export_call_path)(struct db_export *dbe, struct call_path *cp);
 	int (*export_call_return)(struct db_export *dbe,
 				  struct call_return *cr);
+	int (*export_context_switch)(struct db_export *dbe, u64 db_id,
+				     struct machine *machine,
+				     struct perf_sample *sample,
+				     u64 th_out_id, u64 comm_out_id,
+				     u64 th_in_id, u64 comm_in_id, int flags);
 	struct call_return_processor *crp;
 	struct call_path_root *cpr;
 	u64 evsel_last_db_id;
@@ -68,18 +74,19 @@ struct db_export {
 	u64 sample_last_db_id;
 	u64 call_path_last_db_id;
 	u64 call_return_last_db_id;
-	struct list_head deferred;
+	u64 context_switch_last_db_id;
 };
 
 int db_export__init(struct db_export *dbe);
-int db_export__flush(struct db_export *dbe);
 void db_export__exit(struct db_export *dbe);
 int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm);
+		      struct machine *machine, struct thread *main_thread);
 int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread);
+		    struct thread *thread);
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 			   struct thread *thread);
 int db_export__dso(struct db_export *dbe, struct dso *dso,
@@ -97,5 +104,7 @@ int db_export__branch_types(struct db_export *dbe);
 int db_export__call_path(struct db_export *dbe, struct call_path *cp);
 int db_export__call_return(struct db_export *dbe, struct call_return *cr,
 			   u64 *parent_db_id);
+int db_export__switch(struct db_export *dbe, union perf_event *event,
+		      struct perf_sample *sample, struct machine *machine);
 
 #endif
diff --git a/tools/perf/util/rlimit.c b/tools/perf/util/rlimit.c
new file mode 100644
index 000000000000..13521d392a22
--- /dev/null
+++ b/tools/perf/util/rlimit.c
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+#include "util/debug.h"
+#include "util/rlimit.h"
+#include <sys/time.h>
+#include <sys/resource.h>
+
+/*
+ * Bump the memlock so that we can get bpf maps of a reasonable size,
+ * like the ones used with 'perf trace' and with 'perf test bpf',
+ * improve this to some specific request if needed.
+ */
+void rlimit__bump_memlock(void)
+{
+	struct rlimit rlim;
+
+	if (getrlimit(RLIMIT_MEMLOCK, &rlim) == 0) {
+		rlim.rlim_cur *= 4;
+		rlim.rlim_max *= 4;
+
+		if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0) {
+			rlim.rlim_cur /= 2;
+			rlim.rlim_max /= 2;
+
+			if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0)
+				pr_debug("Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc\n");
+		}
+	}
+}
diff --git a/tools/perf/util/rlimit.h b/tools/perf/util/rlimit.h
new file mode 100644
index 000000000000..9f59d8e710a3
--- /dev/null
+++ b/tools/perf/util/rlimit.h
@@ -0,0 +1,6 @@
+#ifndef __PERF_RLIMIT_H_
+#define __PERF_RLIMIT_H_
+/* SPDX-License-Identifier: LGPL-2.1 */
+
+void rlimit__bump_memlock(void);
+#endif // __PERF_RLIMIT_H_
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 112bed65232f..25dc1d765553 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -113,6 +113,7 @@ struct tables {
 	PyObject		*call_path_handler;
 	PyObject		*call_return_handler;
 	PyObject		*synth_handler;
+	PyObject		*context_switch_handler;
 	bool			db_export_mode;
 };
 
@@ -1011,15 +1012,19 @@ static int python_export_thread(struct db_export *dbe, struct thread *thread,
 	return 0;
 }
 
-static int python_export_comm(struct db_export *dbe, struct comm *comm)
+static int python_export_comm(struct db_export *dbe, struct comm *comm,
+			      struct thread *thread)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(2);
+	t = tuple_new(5);
 
 	tuple_set_u64(t, 0, comm->db_id);
 	tuple_set_string(t, 1, comm__str(comm));
+	tuple_set_u64(t, 2, thread->db_id);
+	tuple_set_u64(t, 3, comm->start);
+	tuple_set_s32(t, 4, comm->exec);
 
 	call_object(tables->comm_handler, t, "comm_table");
 
@@ -1233,6 +1238,34 @@ static int python_export_call_return(struct db_export *dbe,
 	return 0;
 }
 
+static int python_export_context_switch(struct db_export *dbe, u64 db_id,
+					struct machine *machine,
+					struct perf_sample *sample,
+					u64 th_out_id, u64 comm_out_id,
+					u64 th_in_id, u64 comm_in_id, int flags)
+{
+	struct tables *tables = container_of(dbe, struct tables, dbe);
+	PyObject *t;
+
+	t = tuple_new(9);
+
+	tuple_set_u64(t, 0, db_id);
+	tuple_set_u64(t, 1, machine->db_id);
+	tuple_set_u64(t, 2, sample->time);
+	tuple_set_s32(t, 3, sample->cpu);
+	tuple_set_u64(t, 4, th_out_id);
+	tuple_set_u64(t, 5, comm_out_id);
+	tuple_set_u64(t, 6, th_in_id);
+	tuple_set_u64(t, 7, comm_in_id);
+	tuple_set_s32(t, 8, flags);
+
+	call_object(tables->context_switch_handler, t, "context_switch");
+
+	Py_DECREF(t);
+
+	return 0;
+}
+
 static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
 				      void *data)
 {
@@ -1296,6 +1329,16 @@ static void python_process_event(union perf_event *event,
 	}
 }
 
+static void python_process_switch(union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine)
+{
+	struct tables *tables = &tables_global;
+
+	if (tables->db_export_mode)
+		db_export__switch(&tables->dbe, event, sample, machine);
+}
+
 static void get_handler_name(char *str, size_t size,
 			     struct perf_evsel *evsel)
 {
@@ -1511,6 +1554,7 @@ static void set_table_handlers(struct tables *tables)
 	SET_TABLE_HANDLER(sample);
 	SET_TABLE_HANDLER(call_path);
 	SET_TABLE_HANDLER(call_return);
+	SET_TABLE_HANDLER(context_switch);
 
 	/*
 	 * Synthesized events are samples but with architecture-specific data
@@ -1620,9 +1664,7 @@ static int python_start_script(const char *script, int argc, const char **argv)
 
 static int python_flush_script(void)
 {
-	struct tables *tables = &tables_global;
-
-	return db_export__flush(&tables->dbe);
+	return 0;
 }
 
 /*
@@ -1831,6 +1873,7 @@ struct scripting_ops python_scripting_ops = {
 	.flush_script		= python_flush_script,
 	.stop_script		= python_stop_script,
 	.process_event		= python_process_event,
+	.process_switch		= python_process_switch,
 	.process_stat		= python_process_stat,
 	.process_stat_interval	= python_process_stat_interval,
 	.generate_script	= python_generate_script,
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index d9b0a942090a..c7002fe11673 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -81,6 +81,9 @@ struct scripting_ops {
 			       struct perf_sample *sample,
 			       struct perf_evsel *evsel,
 			       struct addr_location *al);
+	void (*process_switch)(union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine);
 	void (*process_stat)(struct perf_stat_config *config,
 			     struct perf_evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);

