Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F5C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8883121841
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279834;
	bh=ZQd3IzTwaK/v9ig5rXc0mekftl21FY0IiQJFu3eVKLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sJMtqPrtpTs88tXyhcaONHtwbYkjIRAH6iyfSDc9mhqybcJ0sASbB40MvtibKTgAn
	 ASNpD9md+vT+ey6Zkgps1NPD+zH0JGl/H5jR7QlmX0NotTH2PcdZOidTDJ4ibRMfxz
	 lenJZC8ZvdRNXWxbTe7/qJizHpCNHK+UMJWxm2gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405557AbfFKTDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405353AbfFKTDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEEA9217D6;
        Tue, 11 Jun 2019 19:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279827;
        bh=ZQd3IzTwaK/v9ig5rXc0mekftl21FY0IiQJFu3eVKLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxoVSDfCHABhnKaZGU46YaDqfJjSFqPz1RdhzZvUo7bKhMBpJEylram8Y2kGHRE0N
         sKF1AkfuP9n3o+v600+2uCPS67BIskObBiYjwyxTtpSjGBWY/UO5Stks6gOdF826v3
         aZPKyDlpXymrbfTzk97zvOLMa00H/CGpPAHDzvP4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 61/85] perf cs-etm: Remove duplicate GENMASK() define, use linux/bits.h instead
Date:   Tue, 11 Jun 2019 15:58:47 -0300
Message-Id: <20190611185911.11645-62-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Suzuki noticed that this should be more useful in a generic header, and
after looking I noticed we have it already in our copy of
include/linux/bits.h in tools/include, so just use it, test built on
x86-64 and ubuntu 19.04 with:

  perfbuilder@46646c9e848e:/$ aarch64-linux-gnu-gcc --version |& head -1
  aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  perfbuilder@46646c9e848e:/$

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/r/68c1c548-33cd-31e8-100d-7ffad008c7b2@arm.com
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
Link: https://lkml.kernel.org/n/tip-69pd3mqvxdlh2shddsc7yhyv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 33b57e748c3d..bc848fd095f4 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -9,6 +9,7 @@
 
 #include "util/event.h"
 #include "util/session.h"
+#include <linux/bits.h>
 
 /* Versionning header in case things need tro change in the future.  That way
  * decoding of old snapshot is still possible.
@@ -161,16 +162,6 @@ struct cs_etm_packet_queue {
 
 #define CS_ETM_INVAL_ADDR 0xdeadbeefdeadbeefUL
 
-/*
- * Create a contiguous bitmask starting at bit position @l and ending at
- * position @h. For example
- * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
- *
- * Carbon copy of implementation found in $KERNEL/include/linux/bitops.h
- */
-#define GENMASK(h, l) \
-	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
-
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
 
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
-- 
2.20.1

