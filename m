Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D03C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4422085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="u213Ud3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfFQTYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:24:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfFQTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:24:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJMvqS3560980
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:22:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJMvqS3560980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799378;
        bh=0LpUTzT55sD8s4HcTpVvquBmaFsugFfc5cYz43X3kQg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=u213Ud3xxtTkixyT4dw4eAHsiz6WDn4ykC80ZsZOArWDeuGaTtVD0VHuke+P6nQGV
         xJgiSL+C2CyWJ6JLwkjk7I1tZ/9qt5w1L8nULX76JKyrWIneU2ZbqNFb64Ig3cU7tP
         Dc98jQaoCFgRZLLGpSW9DBxzMZo8nf8EMn2rn2H5impC3xqFjG4opysmJENCtriNCB
         a14kX/CvpKAAAPxeXLUduX0xTecOCU5U6gHYdjit649c82NdCdOB9CLGy7lebvBpvE
         Ciaxqaf8IglP40Jdu5XQ/N9tB6Jep0RszC2+nnpcYsMwo+YZx4Xmc4ieEqz1FakzSs
         Fy1cX+efIkHcQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJMvb33560977;
        Mon, 17 Jun 2019 12:22:57 -0700
Date:   Mon, 17 Jun 2019 12:22:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-e0d170fa9a5c6dfc29fb8f900497d8c5ec29c6e7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, suzuki.poulose@arm.com, acme@redhat.com,
        hpa@zytor.com, namhyung@kernel.org, mingo@kernel.org,
        mathieu.poirier@linaro.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, leo.yan@linaro.org
Reply-To: namhyung@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          mathieu.poirier@linaro.org, leo.yan@linaro.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, suzuki.poulose@arm.com, hpa@zytor.com,
          acme@redhat.com
In-Reply-To: <20190524173508.29044-6-mathieu.poirier@linaro.org>
References: <20190524173508.29044-6-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add handling of switch-CPU-wide events
Git-Commit-ID: e0d170fa9a5c6dfc29fb8f900497d8c5ec29c6e7
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

Commit-ID:  e0d170fa9a5c6dfc29fb8f900497d8c5ec29c6e7
Gitweb:     https://git.kernel.org/tip/e0d170fa9a5c6dfc29fb8f900497d8c5ec29c6e7
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:34:56 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf cs-etm: Add handling of switch-CPU-wide events

Add handling of SWITCH-CPU-WIDE events in order to add the tid/pid of
the incoming process to the perf tools machine infrastructure.  This
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
Link: http://lkml.kernel.org/r/20190524173508.29044-6-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0742c50fce46..5322dcaaf654 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1680,6 +1680,42 @@ static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
+					   union perf_event *event)
+{
+	struct thread *th;
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+
+	/*
+	 * Context switch in per-thread mode are irrelevant since perf
+	 * will start/stop tracing as the process is scheduled.
+	 */
+	if (etm->timeless_decoding)
+		return 0;
+
+	/*
+	 * SWITCH_IN events carry the next process to be switched out while
+	 * SWITCH_OUT events carry the process to be switched in.  As such
+	 * we don't care about IN events.
+	 */
+	if (!out)
+		return 0;
+
+	/*
+	 * Add the tid/pid to the log so that we can get a match when
+	 * we get a contextID from the decoder.
+	 */
+	th = machine__findnew_thread(etm->machine,
+				     event->context_switch.next_prev_pid,
+				     event->context_switch.next_prev_tid);
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
@@ -1719,6 +1755,8 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if (event->header.type == PERF_RECORD_ITRACE_START)
 		return cs_etm__process_itrace_start(etm, event);
+	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+		return cs_etm__process_switch_cpu_wide(etm, event);
 
 	return 0;
 }
