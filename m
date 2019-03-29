Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49169C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190742184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfC2Uex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:34:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfC2Uex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:34:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKYUNZ3937316
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:34:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKYQ7u3937313;
        Fri, 29 Mar 2019 13:34:26 -0700
Date:   Fri, 29 Mar 2019 13:34:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Solomon Tan <tipbot@zytor.com>
Message-ID: <tip-c8fa7a807f3c5f946bd92076fbaf7826edb650dc@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, robert.walker@arm.com,
        peterz@infradead.org, solomonbobstoner@gmail.com, jolsa@redhat.com,
        tglx@linutronix.de, suzuki.poulose@arm.com, mingo@kernel.org,
        hpa@zytor.com, mathieu.poirier@linaro.org
Reply-To: namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, solomonbobstoner@gmail.com,
          peterz@infradead.org, robert.walker@arm.com,
          alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
          tglx@linutronix.de, jolsa@redhat.com, hpa@zytor.com,
          mathieu.poirier@linaro.org, mingo@kernel.org
In-Reply-To: <20190322052255.GA4809@w-OptiPlex-7050>
References: <20190322052255.GA4809@w-OptiPlex-7050>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Add missing case value
Git-Commit-ID: c8fa7a807f3c5f946bd92076fbaf7826edb650dc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c8fa7a807f3c5f946bd92076fbaf7826edb650dc
Gitweb:     https://git.kernel.org/tip/c8fa7a807f3c5f946bd92076fbaf7826edb650dc
Author:     Solomon Tan <solomonbobstoner@gmail.com>
AuthorDate: Fri, 22 Mar 2019 13:22:55 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:31:55 -0300

perf cs-etm: Add missing case value

The following error was thrown when compiling `tools/perf` using OpenCSD
v0.11.1. This patch fixes said error.

    CC       util/intel-pt-decoder/intel-pt-log.o
    CC       util/cs-etm-decoder/cs-etm-decoder.o
  util/cs-etm-decoder/cs-etm-decoder.c: In function
  ‘cs_etm_decoder__buffer_range’:
  util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value
  ‘OCSD_INSTR_WFI_WFE’ not handled in switch [-Werror=switch-enum]
    switch (elem->last_i_type) {
    ^~~~~~
    CC       util/intel-pt-decoder/intel-pt-decoder.o
  cc1: all warnings being treated as errors

Because `OCSD_INSTR_WFI_WFE` case was added only in v0.11.0, the minimum
required OpenCSD library version for this patch is no longer v0.10.0.

Signed-off-by: Solomon Tan <solomonbobstoner@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190322052255.GA4809@w-OptiPlex-7050
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index d68eb4fb40cc..2b0e02c38870 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
+#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 0.10.0 is required"
+#error "OpenCSD >= 0.11.0 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index ba4c623cd8de..39fe21e1cf93 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -387,6 +387,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 		break;
 	case OCSD_INSTR_ISB:
 	case OCSD_INSTR_DSB_DMB:
+	case OCSD_INSTR_WFI_WFE:
 	case OCSD_INSTR_OTHER:
 	default:
 		packet->last_instr_taken_branch = false;
