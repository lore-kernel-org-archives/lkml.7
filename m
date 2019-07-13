Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35DC742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34692084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YKttcKeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfGMLJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:09:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfGMLJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:09:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB9R7C3841578
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:09:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB9R7C3841578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563016168;
        bh=vguI2+ZzMuiT2lnZgJovZs4ew2EyEBVJFzPRcLpeRZ0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YKttcKeF3qUUAUrdtGwOgg42+qhSKL5z/zlYdCBKYvNTc0aHA68muCV9oF+WwGp/j
         +v9u9rw7VtNGRWSfM4tkFi37JsQrIdx5Li9fCEOaQv8Ult55xr5mwAsgbccqhSwJlQ
         tIb52zSS8brvTGgHzGy3GH64erQkvrdUBoZxJxoo3q67qqi5ThJht2uihlvSASbrnF
         Mgpm9PDLNstdK96ReEhGD7WYj1Iuus+aBoDY7RqlP45OBfZbUjb90pHsyu2AjdICbc
         mepUuf+75MZY/7XHtm7PerSvwEy0d6pKqJZMeFiJrH8LhGP/Nsik7S5vaN38ya7kdi
         YZqPKA+ubyAGQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB9QNJ3841575;
        Sat, 13 Jul 2019 04:09:26 -0700
Date:   Sat, 13 Jul 2019 04:09:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-323fd749821daab0f327ec86d707c4542963cdb0@git.kernel.org>
Cc:     jolsa@redhat.com, suzuki.poulose@arm.com, namhyung@kernel.org,
        leo.yan@linaro.org, hpa@zytor.com, tglx@linutronix.de,
        mathieu.poirier@linaro.org, mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org,
          mingo@kernel.org, leo.yan@linaro.org, hpa@zytor.com,
          tglx@linutronix.de, jolsa@redhat.com, namhyung@kernel.org,
          suzuki.poulose@arm.com
In-Reply-To: <20190708143937.7722-4-leo.yan@linaro.org>
References: <20190708143937.7722-4-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Fix potential NULL pointer
 dereference found by the smatch tool
Git-Commit-ID: 323fd749821daab0f327ec86d707c4542963cdb0
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

Commit-ID:  323fd749821daab0f327ec86d707c4542963cdb0
Gitweb:     https://git.kernel.org/tip/323fd749821daab0f327ec86d707c4542963cdb0
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Mon, 8 Jul 2019 22:39:36 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:28 -0300

perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool

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
