Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF33C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B05208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 23:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbfG0Xal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 19:30:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51226 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfG0Xak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 19:30:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrW96-0002Lz-8O; Sun, 28 Jul 2019 01:30:36 +0200
Date:   Sat, 27 Jul 2019 23:26:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/urgent for 5.3-rc2 
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
Message-ID: <156426997428.6953.2280314984853805596.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

up to:  289a2d22b5b6: perf/x86/intel: Mark expected switch fall-throughs

A pile of perf related fixes:

 Kernel:
   - Fix SLOTS PEBS event constraints for Icelake CPUs
   
   - Add the missing mask bit to allow counting hardware generated
     prefetches on L3 for Icelake CPUs

   - Make the test for hypervisor platforms more accurate (as far as possible)

   - Handle PMUs correctly which override event->cpu

   - Yet another missing fallthrough annotation

 Tools:
    perf.data:
       - Fix loading of compressed data split across adjacent records
       - Fix buffer size setting for processing CPU topology perf.data header.
    
    perf stat:
       - Fix segfault for event group in repeat mode
        - Always separate "stalled cycles per insn" line, it was being appended to
         the "instructions" line.

    perf script:
      - Fix --max-blocks man page description.
      - Improve man page description of metrics.
      - Fix off by one in brstackinsn IPC computation.
    
    perf probe:
      - Avoid calling freeing routine multiple times for same pointer.
    
    perf build:
      - Do not use -Wshadow on gcc < 4.8, avoiding too strict warnings
        treated as errors, breaking the build.

Thanks,

	tglx

------------------>
Alexey Budankov (1):
      perf session: Fix loading of compressed data split across adjacent records

Andi Kleen (3):
      perf script: Fix --max-blocks man page description
      perf script: Improve man page description of metrics
      perf script: Fix off by one in brstackinsn IPC computation

Arnaldo Carvalho de Melo (3):
      perf probe: Set pev->nargs to zero after freeing pev->args entries
      perf probe: Avoid calling freeing routine multiple times for same pointer
      perf build: Do not use -Wshadow on gcc < 4.8

Cong Wang (1):
      perf stat: Always separate stalled cycles per insn

Gustavo A. R. Silva (1):
      perf/x86/intel: Mark expected switch fall-throughs

Jiri Olsa (2):
      perf tools: Fix proper buffer size for feature processing
      perf stat: Fix segfault for event group in repeat mode

Kan Liang (1):
      perf/x86/intel: Fix SLOTS PEBS event constraint

Leonard Crestez (1):
      perf/core: Fix creating kernel counters for PMUs that override event->cpu

Yunying Sun (1):
      perf/x86/intel: Fix invalid Bit 13 for Icelake MSR_OFFCORE_RSP_x register

Zhenzhong Duan (1):
      perf/x86: Apply more accurate check on hypervisor platform


 arch/x86/events/intel/core.c             |  9 +++++----
 arch/x86/events/intel/ds.c               |  2 +-
 kernel/events/core.c                     |  2 +-
 tools/perf/Documentation/perf-script.txt |  8 ++++----
 tools/perf/builtin-probe.c               | 10 ++++++++++
 tools/perf/builtin-script.c              |  2 +-
 tools/perf/builtin-stat.c                |  9 ++++++++-
 tools/perf/util/evsel.c                  |  2 ++
 tools/perf/util/header.c                 |  2 +-
 tools/perf/util/probe-event.c            |  1 +
 tools/perf/util/session.c                | 22 ++++++++++++++--------
 tools/perf/util/session.h                |  1 +
 tools/perf/util/stat-shadow.c            |  3 ++-
 tools/perf/util/zstd.c                   |  4 ++--
 tools/scripts/Makefile.include           |  9 ++++++++-
 15 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e911a96972b..648260b5f367 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -20,7 +20,6 @@
 #include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
-#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -263,8 +262,8 @@ static struct event_constraint intel_icl_event_constraints[] = {
 };
 
 static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
-	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffff9fffull, RSP_0),
-	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffbfffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffffbfffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
 	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
 	EVENT_EXTRA_END
@@ -4053,7 +4052,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 	 * Disable the check for real HW, so we don't
 	 * mess with potentionaly enabled registers:
 	 */
-	if (hypervisor_is_type(X86_HYPER_NATIVE))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		return true;
 
 	/*
@@ -4955,6 +4954,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_SKYLAKE_X:
 		pmem = true;
+		/* fall through */
 	case INTEL_FAM6_SKYLAKE_MOBILE:
 	case INTEL_FAM6_SKYLAKE_DESKTOP:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
@@ -5004,6 +5004,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ICELAKE_XEON_D:
 		pmem = true;
+		/* fall through */
 	case INTEL_FAM6_ICELAKE_MOBILE:
 	case INTEL_FAM6_ICELAKE_DESKTOP:
 		x86_pmu.late_ack = true;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2c8db2c19328..f1269e804e9b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -851,7 +851,7 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
 
 struct event_constraint intel_icl_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x400000000ULL),	/* SLOTS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
 
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x1d0, 0xf),	/* MEM_INST_RETIRED.LOAD */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..0463c1151bae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11274,7 +11274,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 		goto err_unlock;
 	}
 
-	perf_install_in_context(ctx, event, cpu);
+	perf_install_in_context(ctx, event, event->cpu);
 	perf_unpin_context(ctx);
 	mutex_unlock(&ctx->mutex);
 
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index d4e2e18a5881..caaab28f8400 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -228,11 +228,11 @@ OPTIONS
 
 	With the metric option perf script can compute metrics for
 	sampling periods, similar to perf stat. This requires
-	specifying a group with multiple metrics with the :S option
+	specifying a group with multiple events defining metrics with the :S option
 	for perf record. perf will sample on the first event, and
-	compute metrics for all the events in the group. Please note
+	print computed metrics for all the events in the group. Please note
 	that the metric computed is averaged over the whole sampling
-	period, not just for the sample point.
+	period (since the last sample), not just for the sample point.
 
 	For sample events it's possible to display misc field with -F +misc option,
 	following letters are displayed for each bit:
@@ -384,7 +384,7 @@ include::itrace.txt[]
 	perf script --time 0%-10%,30%-40%
 
 --max-blocks::
-	Set the maximum number of program blocks to print with brstackasm for
+	Set the maximum number of program blocks to print with brstackinsn for
 	each sample.
 
 --reltime::
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6418782951a4..3d0ffd41fb55 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -698,6 +698,16 @@ __cmd_probe(int argc, const char **argv)
 
 		ret = perf_add_probe_events(params.events, params.nevents);
 		if (ret < 0) {
+
+			/*
+			 * When perf_add_probe_events() fails it calls
+			 * cleanup_perf_probe_events(pevs, npevs), i.e.
+			 * cleanup_perf_probe_events(params.events, params.nevents), which
+			 * will call clear_perf_probe_event(), so set nevents to zero
+			 * to avoid cleanup_params() to call clear_perf_probe_event() again
+			 * on the same pevs.
+			 */
+			params.nevents = 0;
 			pr_err_with_code("  Error: Failed to add events.", ret);
 			return ret;
 		}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8f24865596af..0140ddb8dd0b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1059,7 +1059,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
-				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, insn, fp,
+				printed += ip__fprintf_jump(ip, &br->entries[i], &x, buffer + off, len - off, ++insn, fp,
 							    &total_cycles);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b55a534b4de0..352cf39d7c2f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -607,7 +607,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * group leaders.
 	 */
 	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
-	perf_evlist__close(evsel_list);
+
+	/*
+	 * We need to keep evsel_list alive, because it's processed
+	 * later the evsel_list will be closed after.
+	 */
+	if (!STAT_RECORD)
+		perf_evlist__close(evsel_list);
 
 	return WEXITSTATUS(status);
 }
@@ -1997,6 +2003,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
 		}
 
+		perf_evlist__close(evsel_list);
 		perf_session__delete(perf_stat.session);
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ebb46da4dfe5..52459dd5ad0c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1291,6 +1291,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
 	zfree(&evsel->id);
+	evsel->ids = 0;
 }
 
 static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
@@ -2077,6 +2078,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
 
 	perf_evsel__close_fd(evsel);
 	perf_evsel__free_fd(evsel);
+	perf_evsel__free_id(evsel);
 }
 
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..20111f8da5cb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3747,7 +3747,7 @@ int perf_event__process_feature(struct perf_session *session,
 		return 0;
 
 	ff.buf  = (void *)fe->data;
-	ff.size = event->header.size - sizeof(event->header);
+	ff.size = event->header.size - sizeof(*fe);
 	ff.ph = &session->header;
 
 	if (feat_ops[feat].process(&ff, NULL))
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index cd1eb73cfe83..8394d48f8b32 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2230,6 +2230,7 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 			field = next;
 		}
 	}
+	pev->nargs = 0;
 	zfree(&pev->args);
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0fd6c614e68..37efa1f43d8b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -36,10 +36,16 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	void *src;
 	size_t decomp_size, src_size;
 	u64 decomp_last_rem = 0;
-	size_t decomp_len = session->header.env.comp_mmap_len;
+	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
 	struct decomp *decomp, *decomp_last = session->decomp_last;
 
-	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
+	if (decomp_last) {
+		decomp_last_rem = decomp_last->size - decomp_last->head;
+		decomp_len += decomp_last_rem;
+	}
+
+	mmap_len = sizeof(struct decomp) + decomp_len;
+	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
 		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	if (decomp == MAP_FAILED) {
 		pr_err("Couldn't allocate memory for decompression\n");
@@ -47,10 +53,10 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	}
 
 	decomp->file_pos = file_offset;
+	decomp->mmap_len = mmap_len;
 	decomp->head = 0;
 
-	if (decomp_last) {
-		decomp_last_rem = decomp_last->size - decomp_last->head;
+	if (decomp_last_rem) {
 		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
 		decomp->size = decomp_last_rem;
 	}
@@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
-		munmap(decomp, sizeof(struct decomp) + decomp_len);
+		munmap(decomp, mmap_len);
 		pr_err("Couldn't decompress data\n");
 		return -1;
 	}
@@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
 static void perf_session__release_decomp_events(struct perf_session *session)
 {
 	struct decomp *next, *decomp;
-	size_t decomp_len;
+	size_t mmap_len;
 	next = session->decomp;
-	decomp_len = session->header.env.comp_mmap_len;
 	do {
 		decomp = next;
 		if (decomp == NULL)
 			break;
 		next = decomp->next;
-		munmap(decomp, decomp_len + sizeof(struct decomp));
+		mmap_len = decomp->mmap_len;
+		munmap(decomp, mmap_len);
 	} while (1);
 }
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index dd8920b745bc..863dbad87849 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -46,6 +46,7 @@ struct perf_session {
 struct decomp {
 	struct decomp *next;
 	u64 file_pos;
+	size_t mmap_len;
 	u64 head;
 	size_t size;
 	char data[];
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 656065af4971..accb1bf1cfd8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -819,7 +819,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					"stalled cycles per insn",
 					ratio);
 		} else if (have_frontend_stalled) {
-			print_metric(config, ctxp, NULL, NULL,
+			out->new_line(config, ctxp);
+			print_metric(config, ctxp, NULL, "%7.2f ",
 				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 23bdb9884576..d2202392ffdb 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -99,8 +99,8 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-			pr_err("failed to decompress (B): %ld -> %ld : %s\n",
-			       src_size, output.size, ZSTD_getErrorName(ret));
+			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
+			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
 			break;
 		}
 		output.dst  = dst + output.pos;
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 495066bafbe3..ded7a950dc40 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -32,7 +32,6 @@ EXTRA_WARNINGS += -Wno-system-headers
 EXTRA_WARNINGS += -Wold-style-definition
 EXTRA_WARNINGS += -Wpacked
 EXTRA_WARNINGS += -Wredundant-decls
-EXTRA_WARNINGS += -Wshadow
 EXTRA_WARNINGS += -Wstrict-prototypes
 EXTRA_WARNINGS += -Wswitch-default
 EXTRA_WARNINGS += -Wswitch-enum
@@ -69,8 +68,16 @@ endif
 # will do for now and keep the above -Wstrict-aliasing=3 in place
 # in newer systems.
 # Needed for the __raw_cmpxchg in tools/arch/x86/include/asm/cmpxchg.h
+#
+# See https://lkml.org/lkml/2006/11/28/253 and https://gcc.gnu.org/gcc-4.8/changes.html,
+# that takes into account Linus's comments (search for Wshadow) for the reasoning about
+# -Wshadow not being interesting before gcc 4.8.
+
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)  # make-3
 EXTRA_WARNINGS += -fno-strict-aliasing
+EXTRA_WARNINGS += -Wno-shadow
+else
+EXTRA_WARNINGS += -Wshadow
 endif
 
 ifneq ($(findstring $(MAKEFLAGS), w),w)

