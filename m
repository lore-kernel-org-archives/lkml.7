Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873E42183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866697;
	bh=Wpkq7fKhOkGK+qcig9edQZnwpwpsFOVc7la2atYG6hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/7NNcWuPNdECXcZmww47yoyC1BZ+hM1l9XnnwFqXXvEedzBQBB1C5+k6ryub2nQb
	 W/XXx8pcwQEhfHaLcKSJfiC5pybp3l078vknGbgzrsVGuq/w0FeQZWgtgIGbPwTQRX
	 phoaEepWsC5EV0uii0n0H1TI9sOyeuIYTbVbAcQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfC2NiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfC2NiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:16 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0199C2173C;
        Fri, 29 Mar 2019 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866694;
        bh=Wpkq7fKhOkGK+qcig9edQZnwpwpsFOVc7la2atYG6hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTluN8uXxN5K8PmCUGCtMNCMycpjrG1cbiKQatFQuFGYXwwHRpenzpw0TT5VxEo/k
         +oU1zfCdqyZ0JHCozOUy8v9v/JNqcxvOSsAPSXKZ8DrQqKlzbOzsQg7NF0scW4MdOC
         TrLbm4dLUK0CgdpP1rJrZM6adCnbiimnp+tst1OM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Solomon Tan <solomonbobstoner@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/13] perf cs-etm: Add missing case value
Date:   Fri, 29 Mar 2019 10:37:49 -0300
Message-Id: <20190329133801.21004-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Solomon Tan <solomonbobstoner@gmail.com>

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
-- 
2.20.1

