Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB756C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7636C2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfKWIQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:16:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36276 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfKWIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZQ-0002b2-4z; Sat, 23 Nov 2019 09:15:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3961E1C1AD7;
        Sat, 23 Nov 2019 09:15:02 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:02 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Add kernel AUX area sampling definitions
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-3-adrian.hunter@intel.com>
References: <20191115124225.5247-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690216.21853.1371179122478068216.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     98dcf14d7f9c9482144b9015d481bf6b63bce965
Gitweb:        https://git.kernel.org/tip/98dcf14d7f9c9482144b9015d481bf6b63bce965
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:11 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 21 Nov 2019 10:54:20 -03:00

perf tools: Add kernel AUX area sampling definitions

Add kernel AUX area sampling definitions, which brings perf_event.h into
line with the kernel version.

New sample type PERF_SAMPLE_AUX requests a sample of the AUX area
buffer.  New perf_event_attr member 'aux_sample_size' specifies the
desired size of the sample.

Also add support for parsing samples containing AUX area data i.e.
PERF_SAMPLE_AUX.

Committer notes:

I squashed the first two patches in this series to avoid breaking
automatic bisection, i.e. after applying only the original first patch
in this series we would have:

  # perf test -v parsing
  26: Sample parsing                                        :
  --- start ---
  test child forked, pid 17018
  sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating
  test child finished with -1
  ---- end ----
  Sample parsing: FAILED!
  #

With the two paches combined:

  # perf test parsing
  26: Sample parsing                                        : Ok
  #

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h     | 10 ++++++++--
 tools/perf/tests/attr/base-record         |  2 +-
 tools/perf/tests/attr/base-stat           |  2 +-
 tools/perf/tests/sample-parsing.c         | 16 +++++++++++++++-
 tools/perf/util/event.h                   |  6 ++++++
 tools/perf/util/evsel.c                   | 13 +++++++++++++
 tools/perf/util/perf_event_attr_fprintf.c |  3 ++-
 tools/perf/util/session.c                 |  1 +
 tools/perf/util/synthetic-events.c        | 12 ++++++++++++
 9 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271..377d794 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_AUX				= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -300,6 +301,7 @@ enum perf_event_read_format {
 					/* add: sample_stack_user */
 #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
+#define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -424,7 +426,9 @@ struct perf_event_attr {
 	 */
 	__u32	aux_watermark;
 	__u16	sample_max_stack;
-	__u16	__reserved_2;	/* align to __u64 */
+	__u16	__reserved_2;
+	__u32	aux_sample_size;
+	__u32	__reserved_3;
 };
 
 /*
@@ -864,6 +868,8 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			size;
+	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index efd0157..645009c 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=112
+size=120
 config=0
 sample_period=*
 sample_type=263
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index 4d0c2e4..b0f42c3 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=112
+size=120
 config=0
 sample_period=0
 sample_type=65536
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 3a02426..2762e11 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -150,6 +150,15 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		COMP(phys_addr);
 
+	if (type & PERF_SAMPLE_AUX) {
+		COMP(aux_sample.size);
+		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
+			   s1->aux_sample.size)) {
+			pr_debug("Samples differ at 'aux_sample'\n");
+			return false;
+		}
+	}
+
 	return true;
 }
 
@@ -182,6 +191,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	u64 regs[64];
 	const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
 	const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
+	const u64 aux_data[] = {0xa55a, 0, 0xeeddee, 0x0282028202820282};
 	struct perf_sample sample = {
 		.ip		= 101,
 		.pid		= 102,
@@ -218,6 +228,10 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.regs	= regs,
 		},
 		.phys_addr	= 113,
+		.aux_sample	= {
+			.size	= sizeof(aux_data),
+			.data	= (void *)aux_data,
+		},
 	};
 	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
 	struct perf_sample sample_out;
@@ -317,7 +331,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_PHYS_ADDR << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_AUX << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a0a0c91..8522315 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -114,6 +114,11 @@ enum {
 
 #define MAX_INSN 16
 
+struct aux_sample {
+	u64 size;
+	void *data;
+};
+
 struct perf_sample {
 	u64 ip;
 	u32 pid, tid;
@@ -142,6 +147,7 @@ struct perf_sample {
 	struct regs_dump  intr_regs;
 	struct stack_dump user_stack;
 	struct sample_read read;
+	struct aux_sample aux_sample;
 };
 
 #define PERF_MEM_DATA_SRC_NONE \
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1bf60f3..772f487 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2209,6 +2209,19 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_AUX) {
+		OVERFLOW_CHECK_u64(array);
+		sz = *array++;
+
+		OVERFLOW_CHECK(array, sz, max_size);
+		/* Undo swap of data */
+		if (swapped)
+			mem_bswap_64((char *)array, sz);
+		data->aux_sample.size = sz;
+		data->aux_sample.data = (char *)array;
+		array = (void *)array + sz;
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index d4ad3f0..6512031 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -34,7 +34,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
-		bit_name(WEIGHT), bit_name(PHYS_ADDR),
+		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -143,6 +143,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_regs_intr, p_hex);
 	PRINT_ATTRf(aux_watermark, p_unsigned);
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
+	PRINT_ATTRf(aux_sample_size, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 8454a65..dbdb476 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -752,6 +752,7 @@ do { 						\
 	bswap_field_32(sample_stack_user);
 	bswap_field_32(aux_watermark);
 	bswap_field_16(sample_max_stack);
+	bswap_field_32(aux_sample_size);
 
 	/*
 	 * After read_format are bitfields. Check read_format because
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index cfa3c9f..48c3f8b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1228,6 +1228,11 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_AUX) {
+		result += sizeof(u64);
+		result += sample->aux_sample.size;
+	}
+
 	return result;
 }
 
@@ -1396,6 +1401,13 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_AUX) {
+		sz = sample->aux_sample.size;
+		*array++ = sz;
+		memcpy(array, sample->aux_sample.data, sz);
+		array = (void *)array + sz;
+	}
+
 	return 0;
 }
 
