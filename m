Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A33C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DB321852
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279575;
	bh=CEF+vfaUm199cKv54pV8TJNqD1rd4Sgq6l3Y8h2S4h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDJ8rAqJ+U74qf5xYm3b/RoeCEfCItP0J+dtaXMtU/s9Rc7DfhxVa06/nQPsDvnSH
	 biXeIweAp293ilVWAHXvc4IL1p2BjTWCfEUCTAlQUvkCH6yrosSy5nkDiukCqrQGDQ
	 pU2k/0/aOOiujHti48XW8jj2BQpl4pPJxHih6EyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405181AbfFKS7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392181AbfFKS7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB67A21841;
        Tue, 11 Jun 2019 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279573;
        bh=CEF+vfaUm199cKv54pV8TJNqD1rd4Sgq6l3Y8h2S4h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkLAp+Svr4U8DMF5iAO97Ni4Vl19DWSLmllb7dINiWNd0d3ECNxFy3PYJKwhbGZBe
         rZl3AEaP51tMij9tmd/IQo6wWNjdad5Lm7ukUJcfvgNnXHB1PZCkEhQ5CxwpUqSY3s
         CePA0oh027b6kA8scDDWEr/JHOHM5Dg6/rBJBlXg=
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
Subject: [PATCH 03/85] perf data: Document clockid header: HEADER_CLOCKID
Date:   Tue, 11 Jun 2019 15:57:49 -0300
Message-Id: <20190611185911.11645-4-acme@kernel.org>
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
HEADER_CLOCKID header, do it now from comments in the patch introducing
it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chong Jiang <chongjiang@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Fixes: cf7905165fee ("perf record: Encode -k clockid frequency into Perf trace")
Link: https://lkml.kernel.org/n/tip-slhnjp06027j3ae17qqetzxj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 99733751695b..600999f89c6d 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -296,6 +296,12 @@ $ perf report --header-only -I
 # memory nodes (nr 1, block size 0x8000000):
 #    0 [7G]: 0-23,32-69
 
+	HEADER_CLOCKID = 23,
+
+One uint64_t for the clockid frequency, specified, for instance, via 'perf
+record -k' (see clock_gettime()), to enable timestamps derived metrics
+conversion into wall clock time on the reporting stage.
+
         HEADER_BPF_PROG_INFO = 25,
 
 struct bpf_prog_info_linear, which contains detailed information about
-- 
2.20.1

