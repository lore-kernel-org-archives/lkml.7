Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DAC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27202085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P43tJP6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfFQTWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:22:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:22:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJMFC33560904
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:22:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJMFC33560904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799336;
        bh=I0f8c8zlutdhaZ/vrHnn52hSauWLCUniL5rHMFHk7Jg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=P43tJP6Ib4Osl3Y9WK2GqOWKjF+cC1Msq9tZVN94xGbREef6TKl8HvPNshSo9qVOb
         T4oL+a1UQM7BeZP1IA8kQYv/EYgp8Dibo2oFcLz6cKpTjOglXaNdMTmIM6705Kvy6I
         khTS7hXnpiEABoWhrl6rNR1VxlLG1dPKhnWOGYv1eP9Hwk1Q45KwCM3WemMALBCqrf
         O7KQlR2z4OdthyMWgKbBR8DGEYIAe98+ggWmfeKhu9Tdxu1jOf3pqWpUTMB4BoW6y7
         jCach/Jh0IQvecXOOBPke4tkSwhs4ruCZMWpOT/mDmxm4DrEAia6TmFo9zA94HigXa
         e1YNAmtxUQTdQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJMFK53560901;
        Mon, 17 Jun 2019 12:22:15 -0700
Date:   Mon, 17 Jun 2019 12:22:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-a465f3c3e3e6da729c645ea17615d4ae673588bf@git.kernel.org>
Cc:     jolsa@redhat.com, leo.yan@linaro.org, peterz@infradead.org,
        hpa@zytor.com, namhyung@kernel.org, mathieu.poirier@linaro.org,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        alexander.shishkin@linux.intel.com
Reply-To: peterz@infradead.org, leo.yan@linaro.org, jolsa@redhat.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
          tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
          mathieu.poirier@linaro.org, acme@redhat.com
In-Reply-To: <20190524173508.29044-5-mathieu.poirier@linaro.org>
References: <20190524173508.29044-5-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add handling of itrace start events
Git-Commit-ID: a465f3c3e3e6da729c645ea17615d4ae673588bf
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

Commit-ID:  a465f3c3e3e6da729c645ea17615d4ae673588bf
Gitweb:     https://git.kernel.org/tip/a465f3c3e3e6da729c645ea17615d4ae673588bf
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:34:55 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf cs-etm: Add handling of itrace start events

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
 
