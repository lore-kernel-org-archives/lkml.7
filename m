Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2810C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE82120C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404582AbfITQVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:21:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52740 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393444AbfITQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeY-00041C-SG; Fri, 20 Sep 2019 18:21:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2CD111C0E2F;
        Fri, 20 Sep 2019 18:20:58 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:58 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf memswap: Adopt 'struct u64_swap' from evsel.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-wvzxu7a5l3m868ywwphrnnqo@git.kernel.org>
References: <tip-wvzxu7a5l3m868ywwphrnnqo@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899645812.24167.11578076225294996983.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5cac8ea3e6e736664ee272f94d9099891e25f782
Gitweb:        https://git.kernel.org/tip/5cac8ea3e6e736664ee272f94d9099891e25f782
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 18 Sep 2019 12:28:41 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:22 -03:00

perf memswap: Adopt 'struct u64_swap' from evsel.h

As it is not used in evsel.h and is a memory swap struct, so fits better
in memswap.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wvzxu7a5l3m868ywwphrnnqo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h   | 5 -----
 tools/perf/util/memswap.h | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 68321d1..74df298 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -179,11 +179,6 @@ struct evsel {
 	} side_band;
 };
 
-union u64_swap {
-	u64 val64;
-	u32 val32[2];
-};
-
 struct perf_missing_features {
 	bool sample_id_all;
 	bool exclude_guest;
diff --git a/tools/perf/util/memswap.h b/tools/perf/util/memswap.h
index 1e29ff9..2c38e8c 100644
--- a/tools/perf/util/memswap.h
+++ b/tools/perf/util/memswap.h
@@ -2,6 +2,13 @@
 #ifndef PERF_MEMSWAP_H_
 #define PERF_MEMSWAP_H_
 
+#include <linux/types.h>
+
+union u64_swap {
+	u64 val64;
+	u32 val32[2];
+};
+
 void mem_bswap_64(void *src, int byte_size);
 void mem_bswap_32(void *src, int byte_size);
 
