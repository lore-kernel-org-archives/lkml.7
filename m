Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3046C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A240B2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="s26h3N4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfGMK44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:56:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38621 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:56:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAtG4p3837887
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:55:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAtG4p3837887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015318;
        bh=sXJ+2Wqybls0oxi+KINrhC0N+oQ/gfJpo8zKjXL216c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=s26h3N4HHdlqHUS3IDVRiRxJ9yTxJQUyvBhbH8NWknYv6xrihQwVd9JNj0Nkyb6UG
         7UGkNhDBYQVJRTvQsmBsJnF9/WDlMjn8vQd/qJpkAtEnZ1ZK7se+tWAqtIWMVYkFgm
         VuI0WBnpW/U+kPdQaVXNT2zFefoBVdXyCqUlos1Re/fPb9vpaMm8xNdYeQctKPOB7M
         9bQcbVHvZctsRZup3RNnfWpm/p2bCmqc7Jkg9Pqm9MHmuCWx/WcMKU9OboffgtB/mA
         yL5Ftj1mq5cbjkLDlviVZtyyxzJbEo8oa9RjV1xfVeNNWboajloJGyu7dJ6lDFY1zT
         TkORCNYQq1asQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAtGAb3837883;
        Sat, 13 Jul 2019 03:55:16 -0700
Date:   Sat, 13 Jul 2019 03:55:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-7a6d49dc8cad8fa1f3d63994102af8f9ae9c859f@git.kernel.org>
Cc:     songliubraving@fb.com, linux@rasmusvillemoes.dk,
        alexios.zavras@intel.com, davem@davemloft.net,
        tmricht@linux.ibm.com, ak@linux.intel.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        adrian.hunter@intel.com, mingo@kernel.org,
        alexey.budankov@linux.intel.com, mathieu.poirier@linaro.org,
        hpa@zytor.com, changbin.du@intel.com, namhyung@kernel.org,
        peterz@infradead.org, eric.saint.etienne@oracle.com,
        khlebnikov@yandex-team.ru, suzuki.poulose@arm.com,
        yao.jin@linux.intel.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@kernel.org
Reply-To: jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, yao.jin@linux.intel.com, tglx@linutronix.de,
          khlebnikov@yandex-team.ru, suzuki.poulose@arm.com,
          eric.saint.etienne@oracle.com, peterz@infradead.org,
          namhyung@kernel.org, hpa@zytor.com, changbin.du@intel.com,
          mathieu.poirier@linaro.org, alexey.budankov@linux.intel.com,
          mingo@kernel.org, adrian.hunter@intel.com, leo.yan@linaro.org,
          linux-kernel@vger.kernel.org, dave@stgolabs.net,
          ak@linux.intel.com, tmricht@linux.ibm.com, davem@davemloft.net,
          alexios.zavras@intel.com, linux@rasmusvillemoes.dk,
          songliubraving@fb.com
In-Reply-To: <20190702103420.27540-6-leo.yan@linaro.org>
References: <20190702103420.27540-6-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Fix potential NULL pointer
 dereference found by the smatch tool
Git-Commit-ID: 7a6d49dc8cad8fa1f3d63994102af8f9ae9c859f
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

Commit-ID:  7a6d49dc8cad8fa1f3d63994102af8f9ae9c859f
Gitweb:     https://git.kernel.org/tip/7a6d49dc8cad8fa1f3d63994102af8f9ae9c859f
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 2 Jul 2019 18:34:14 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:55 -0300

perf trace: Fix potential NULL pointer dereference found by the smatch tool

Based on the following report from Smatch, fix the potential NULL
pointer dereference check.

  tools/perf/builtin-trace.c:1044
  thread_trace__new() error: we previously assumed 'ttrace' could be
  null (see line 1041).

  tools/perf/builtin-trace.c
  1037 static struct thread_trace *thread_trace__new(void)
  1038 {
  1039         struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
  1040
  1041         if (ttrace)
  1042                 ttrace->files.max = -1;
  1043
  1044         ttrace->syscall_stats = intlist__new(NULL);
               ^^^^^^^^
  1045
  1046         return ttrace;
  1047 }

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190702103420.27540-6-leo.yan@linaro.org
[ Just made it look like other tools/perf constructors, same end result ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d0eb7224dd36..e3fc9062f136 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1038,10 +1038,10 @@ static struct thread_trace *thread_trace__new(void)
 {
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
-	if (ttrace)
+	if (ttrace) {
 		ttrace->files.max = -1;
-
-	ttrace->syscall_stats = intlist__new(NULL);
+		ttrace->syscall_stats = intlist__new(NULL);
+	}
 
 	return ttrace;
 }
