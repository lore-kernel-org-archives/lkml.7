Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9E4C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2577B2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279579;
	bh=pnxjdAmx1SIh7mvkZW8yfvB7HgK0n7oO6nN1w+/hrRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Thdd41QU38ftfr82iaaTXP7rnP/dlYWWGLlwX3AO3AT59TK/vO7DxZl3yjOa5fSsa
	 viK0++a8sDksql8vBkdC+gjt0sFVV9P1kjrV8T1YOHPEXvExpmPkpidRt5+6Rt40LU
	 y27cVF9ny2K93zzx5gwFJGVpr+oHmS2PTMsnhfnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392219AbfFKS7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392180AbfFKS7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC9921851;
        Tue, 11 Jun 2019 18:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279577;
        bh=pnxjdAmx1SIh7mvkZW8yfvB7HgK0n7oO6nN1w+/hrRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7W40+7YmAaaMncqoab5mFdGxxUnIUxOIJ7wyR98LjZZXs8DmNzWSmh1v4K3TyqgP
         6Bd/IJTlw0gia4lqmtROw7tUgRK38Y54biM+k8n9UAqyxBNnhYGZKe2nA3LPNvBgsU
         ZtGoqWi1iLC4R6pe0OU+wuiiroA8+EOO1oEFmLvc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chong Jiang <chongjiang@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 04/85] perf data: Document directory format header: HEADER_DIR_FORMAT
Date:   Tue, 11 Jun 2019 15:57:50 -0300
Message-Id: <20190611185911.11645-5-acme@kernel.org>
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

We forgot to update the perf.data file format document for the
HEADER_DIR_FORMAT header, do it now from comments in the patch
introducing it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Fixes: 258031c017c3 ("perf header: Add DIR_FORMAT feature to describe directory data")
Link: https://lkml.kernel.org/n/tip-jbrzb7ijb5al33gi8br6f9rr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../Documentation/perf.data-file-format.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 600999f89c6d..6375e6fb8bac 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -302,6 +302,23 @@ One uint64_t for the clockid frequency, specified, for instance, via 'perf
 record -k' (see clock_gettime()), to enable timestamps derived metrics
 conversion into wall clock time on the reporting stage.
 
+	HEADER_DIR_FORMAT = 24,
+
+The data files layout is described by HEADER_DIR_FORMAT feature.  Currently it
+holds only version number (1):
+
+  uint64_t version;
+
+The current version holds only version value (1) means that data files:
+
+- Follow the 'data.*' name format.
+
+- Contain raw events data in standard perf format as read from kernel (and need
+  to be sorted)
+
+Future versions are expected to describe different data files layout according
+to special needs.
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
-- 
2.20.1

