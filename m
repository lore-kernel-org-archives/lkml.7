Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC75C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0620421721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808298;
	bh=kRMFizJqIJZpoJbbmObmbAVv4dulE58uVf29t9TQ54w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sXS0JBw9+4Pd7cV3CMj4T6ToiwskT5oGSybhABgBydjWOTlXHLofeil1W+6VlCNtJ
	 HHl1HJm0xxdB9k7OsLCisjD8FL6HNzvU2jX5RYHiLK4K1Jhq5SI+NRJhWVEM8RAAio
	 gy4HgSy9104A4ET390xKr+TP5rg5C1kfu2olXU5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfHNSo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfHNSoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:44:55 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76ABE2064A;
        Wed, 14 Aug 2019 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808295;
        bh=kRMFizJqIJZpoJbbmObmbAVv4dulE58uVf29t9TQ54w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBpRNHkh/5UJJezwe11pAnAwJWoDU9vxYuK1X1vItne0s3Y+gTtxm8Z2uBbwlShDQ
         jsP+XltWlRsQ/S3Xh9Ofqw5z3Mn/Yu3cqrEzi/wSQeEH17GYuQvL3KRr7KQBau+BuM
         pvLs8XGFVUhDesRnloIMES87d3JyGZ1XiG73OsLA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/28] perf tools: Add aux_output attribute flag
Date:   Wed, 14 Aug 2019 15:40:42 -0300
Message-Id: <20190814184051.3125-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add aux_output attribute flag to match the kernel's perf_event.h file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-4-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 3 ++-
 tools/perf/util/evsel.c               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..bb7b271397a6 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -374,7 +374,8 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_output     :  1, /* generate AUX records instead of events */
+				__reserved_1   : 32;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 64bc32ed6dfa..897a97af2d81 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1587,6 +1587,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(namespaces, p_unsigned);
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
+	PRINT_ATTRf(aux_output, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
-- 
2.21.0

