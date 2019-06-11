Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF8A2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279744;
	bh=0QqK2QyuTErClmvoocneuDu3zXEc1BnQfm/OZFXX5d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gla93n11BUYaoB/jd8Qjs1rSADE/f9ZkB6LY+z+s/MEuYKVUAq6bU3hs9ck+DkyrD
	 7i8hxmJYW3oKcKWwmlmy2xZAEldoifqJO+nZSX04RQWMYGNXPwE10dPlfMJTqm4UYQ
	 YO8QkTipJCf7yAIEc/77D/3ZQAB1VRIHG0jENYk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404429AbfFKTCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392376AbfFKTCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED042183E;
        Tue, 11 Jun 2019 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279742;
        bh=0QqK2QyuTErClmvoocneuDu3zXEc1BnQfm/OZFXX5d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRolsfTuLKg0f6cffJnti4xLZNJJrXHyMaYuSic9pR4Q1MQ20Um4GnsmS9kvaNbGa
         xNIx2O81A8Oc3jUlqynpgX8qax7YHMie+WHW0+Mm4CTa88hyhI+vKRIBoh8k130T4D
         wwLLQLDlW/xIgSL9ido2Ute3+M73XZZ9w+Xo096I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/85] perf cs-etm: Add handling of itrace start events
Date:   Tue, 11 Jun 2019 15:58:26 -0300
Message-Id: <20190611185911.11645-41-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Add handling of ITRACE events in order to add the tid/pid of the
executing process to the perf tools machine infrastructure.  This
information is later retrieved when a contextID packet is found in the
trace stream.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-5-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index de488b43f440..0742c50fce46 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1657,6 +1657,29 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
+					union perf_event *event)
+{
+	struct thread *th;
+
+	if (etm->timeless_decoding)
+		return 0;
+
+	/*
+	 * Add the tid/pid to the log so that we can get a match when
+	 * we get a contextID from the decoder.
+	 */
+	th = machine__findnew_thread(etm->machine,
+				     event->itrace_start.pid,
+				     event->itrace_start.tid);
+	if (!th)
+		return -ENOMEM;
+
+	thread__put(th);
+
+	return 0;
+}
+
 static int cs_etm__process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -1694,6 +1717,9 @@ static int cs_etm__process_event(struct perf_session *session,
 		return cs_etm__process_timeless_queues(etm,
 						       event->fork.tid);
 
+	if (event->header.type == PERF_RECORD_ITRACE_START)
+		return cs_etm__process_itrace_start(etm, event);
+
 	return 0;
 }
 
-- 
2.20.1

