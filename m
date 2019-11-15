Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B05C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0E22072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfKOMnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfKOMnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749648"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:23 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] perf tools: Add kernel AUX area sampling definitions
Date:   Fri, 15 Nov 2019 14:42:11 +0200
Message-Id: <20191115124225.5247-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel AUX area sampling definitions, which brings perf_event.h into
line with the kernel version.

New sample type PERF_SAMPLE_AUX requests a sample of the AUX area buffer.
New perf_event_attr member 'aux_sample_size' specifies the desired size of
the sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/uapi/linux/perf_event.h     | 10 ++++++++--
 tools/perf/tests/attr/base-record         |  2 +-
 tools/perf/tests/attr/base-stat           |  2 +-
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/session.c                 |  1 +
 5 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271397a6..377d794d3105 100644
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
index efd0157b9d22..645009c08b3c 100644
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
index 4d0c2e42b64e..b0f42c34882e 100644
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
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index d4ad3f04923a..06add607e72d 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -143,6 +143,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_regs_intr, p_hex);
 	PRINT_ATTRf(aux_watermark, p_unsigned);
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
+	PRINT_ATTRf(aux_sample_size, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ecb91bc..eb7ffd5524dc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -752,6 +752,7 @@ do { 						\
 	bswap_field_32(sample_stack_user);
 	bswap_field_32(aux_watermark);
 	bswap_field_16(sample_max_stack);
+	bswap_field_32(aux_sample_size);
 
 	/*
 	 * After read_format are bitfields. Check read_format because
-- 
2.17.1

