Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10083C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE53B2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697210;
	bh=yAP7lLk8scvs8z72JtKyaa3K2i32Wc49Nr1SyOz2l3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jAVpGorZ0mUaquUK9Q3u/cVIthb2yTSFhiyDs+xad6Yav95Kas9YPmzvWbp0Mm39K
	 Vo/3wh4LGUaYAejFlvCTZWK76BKtyuyu0aq4dwyQJMFnxwQU7Vm3G2zS7BK7HyiN0V
	 qedmJTDByXpwLVr464+EpdiPohDrNbvi7TUBBIOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfGISd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfGISd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:33:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E3D20656;
        Tue,  9 Jul 2019 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697207;
        bh=yAP7lLk8scvs8z72JtKyaa3K2i32Wc49Nr1SyOz2l3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKFilR8ZSDMQ1SkWeWA3Li198T/E6FamZeMgPqVQ6ToJ38qlAhi99VtfYYPROyasb
         pjvJQfxgjUiT2IbDYEICDj3cffL3tGgoY13Cm6D2Nypc9DXTkwOlFTwt3t6x5WgO56
         9L37svk73hrJY1BnddgDill4IWSC8nS4stvKIm8U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/25] perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool
Date:   Tue,  9 Jul 2019 15:31:26 -0300
Message-Id: <20190709183126.30257-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Based on the following report from Smatch, fix the potential NULL
pointer dereference check.

  tools/perf/util/intel-pt.c:3200
  intel_pt_process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 3196)

  tools/perf/util/intel-pt.c:3206
  intel_pt_process_auxtrace_info() warn: variable dereferenced before
  check 'session->itrace_synth_opts' (see line 3200)

  tools/perf/util/intel-pt.c
  3196         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
  3197                 pt->synth_opts = *session->itrace_synth_opts;
  3198         } else {
  3199                 itrace_synth_opts__set_default(&pt->synth_opts,
  3200                                 session->itrace_synth_opts->default_no_sample);
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^
  3201                 if (!session->itrace_synth_opts->default_no_sample &&
  3202                     !session->itrace_synth_opts->inject) {
  3203                         pt->synth_opts.branches = false;
  3204                         pt->synth_opts.callchain = true;
  3205                 }
  3206                 if (session->itrace_synth_opts)
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  3207                         pt->synth_opts.thread_stack =
  3208                                 session->itrace_synth_opts->thread_stack;
  3209         }

'session->itrace_synth_opts' is impossible to be a NULL pointer in
intel_pt_process_auxtrace_info(), thus this patch removes the NULL test
for 'session->itrace_synth_opts'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190708143937.7722-4-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index c76a96f777fb..df061599fef4 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3210,7 +3210,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		goto err_delete_thread;
 	}
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
+	if (session->itrace_synth_opts->set) {
 		pt->synth_opts = *session->itrace_synth_opts;
 	} else {
 		itrace_synth_opts__set_default(&pt->synth_opts,
@@ -3220,8 +3220,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 			pt->synth_opts.branches = false;
 			pt->synth_opts.callchain = true;
 		}
-		if (session->itrace_synth_opts)
-			pt->synth_opts.thread_stack =
+		pt->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
 
@@ -3241,11 +3240,9 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		pt->cbr2khz = tsc_freq / pt->max_non_turbo_ratio / 1000;
 	}
 
-	if (session->itrace_synth_opts) {
-		err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
-		if (err)
-			goto err_delete_thread;
-	}
+	err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
+	if (err)
+		goto err_delete_thread;
 
 	if (pt->synth_opts.calls)
 		pt->branches_filter |= PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |
-- 
2.21.0

