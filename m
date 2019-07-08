Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4417C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC70216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQqQMln6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfGHOkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:40:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36237 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGHOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:40:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so16441546oti.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P0UfYuSIVn3ZdoCHgmfMQcQ4Bx5Zeyc6tJ2jWiXjhtc=;
        b=MQqQMln6WxFnwJIxVdQq725CZ83Q5i8yiXXUbwPqunDJgW98k01CN/JD82UlujQDg/
         xvc5BqdXrI7B2KwEaXdC6hl4VQKtrnKVZNmiYbAWtYG0kDWAgtu+3JxUWrfZzNAoOIhL
         iLWZiyTa8qIrbYcNkUidLc/TpnZMFhl7DFZ/eiwZ9LXKbHVhU8HFHrRgacH66/AzYTtM
         G3oDjb17sTWOV7mptFn+ZvPtuFddiAyZ6dtWk/RlotyddhooGD197KRCHZPP/pf9M1yb
         RNLqLQ18cPnZqslKQNDY6jmTbFexEJZ2Ywgxy6iQSeP4Ys2LGPb6I8y91dmORZAsw9jG
         c13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P0UfYuSIVn3ZdoCHgmfMQcQ4Bx5Zeyc6tJ2jWiXjhtc=;
        b=c+SXYoSFmoCPO4hypwQntJtHPEDTHpMQ2WclkshZYZMy5IoRR8Y9ulaqFd3eaEuiOR
         1bMRtD+EIrWAqkF0Ghx0sT07/5YveqtJzWDrTLc773OD6T7d7mg+lvwgT0uTqgf29dVz
         cu5wmwqOQCmTunUJpIqmdnMz1O4FHFiYtDlfyhOqWVTXhjtjK0eCXYCsqLCA+if2llfe
         hEaZi2dlliMyOPBuXTZC/qg/5t6tADHUN8jFL46R4rvS0NazcvN65TQLunFP/ZtNl+3x
         T2/NkUzEiHfgsUDFhno05QICa8oylYtEnuHJ1ovD4cafEAtYIQ2BjvTHGqdhG7sLQczr
         hCaA==
X-Gm-Message-State: APjAAAVOr9pSOY4CSaAB19mmi1jvDJihTEhLuTT2WhDQtjg0wzN1mhpE
        mmtNbYxhR21V3XeeDhwQd+JlvHisph/jqA==
X-Google-Smtp-Source: APXvYqwwTW9A3b+wXlBAVQIpYYoeWSItpKpNNsXpU0V7ZdJPO57xQJQciFgrGOSa91Y67e+LLHjOFQ==
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr15287602oti.91.1562596819691;
        Mon, 08 Jul 2019 07:40:19 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id x5sm6386021otb.6.2019.07.08.07.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:40:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/4] perf intel-pt: Smatch: Fix potential NULL pointer dereference
Date:   Mon,  8 Jul 2019 22:39:36 +0800
Message-Id: <20190708143937.7722-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708143937.7722-1-leo.yan@linaro.org>
References: <20190708143937.7722-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

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
intel_pt_process_auxtrace_info(), thus this patch removes the NULL
test for 'session->itrace_synth_opts'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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
2.17.1

