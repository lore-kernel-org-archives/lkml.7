Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F5C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3362183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEvS8Xbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGBKf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40818 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id e8so16625411otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oEKxu+SRBR2p4slj10y4/Ir+izytEa7NCXuzbUYce7M=;
        b=wEvS8XbwFUFKdw+GxKZqyPYxrcjlJT6R7i4Djuo1pSo+8XRmo7dDVof0wJA6PCR3vd
         qFIwAcP7pDtAB8QbnK8W71bnfDTiUGrGvzNBaQ0BVXdhbpi92FhKXZpRzcCfxHl/1lrQ
         0cnaFXJ4pGbGcg1Yj4KSf+weubc02b4z+z7aH8vZoygulTfyy1oCju1llcUE2/B5TAxO
         CBNT+MRWqFb+e57BQqcIPMsbBIg6p2JsXmSoO7EAI5kgLk7RIPuGCzZnvROcdx4biUl9
         MWos28VX/AKKwLxXLoiRvshrmKgM0HO7EpW4LV9lPKGSBYUH2dyccIMucEgvK6w26lQT
         61Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oEKxu+SRBR2p4slj10y4/Ir+izytEa7NCXuzbUYce7M=;
        b=GNqSNC1cwK/wKR72ZXJa37YlDHM02vLqOc2GqTno5QLw/LTCeMya2fg0OtkpO7kyA/
         YarGl+G5JazzwEjeTmKBhDnWvWSc73fanQxrKNsUmM7MacSc8mkDbnuoiXiKhNDhkopZ
         4DrrX3757WLYRdDlRAk0IJ0Dav9bt68C1vysk8fLImkSflS7N0Qyc4JKIzhCE59scFbi
         FOERrfenHSsZsVxZgSCNPfICC0wXeam9DUuHwFJzfXjFPY2jM3fNSOY/AB2aC2sivFlD
         sAtplDg6kgxjknvouajcS9zxOTQj4EB9mQmjB2maTh3aBPG2m6QrHvmMG+ZCxkhiImja
         EaXg==
X-Gm-Message-State: APjAAAVvvBf26lcFuV+0K+bIXJDCiCK8umFmdJm+b/LT860dczjMeVf+
        v7RM1cIBRg2ZSFqsfsvRNIVLjw==
X-Google-Smtp-Source: APXvYqzv573LaZWJ+oWSjYOyiWtpwFtAqVjEDnjXIEMctJXO5xnl/SqqwZcakrrKfpTXJTxRUb5hOw==
X-Received: by 2002:a9d:664c:: with SMTP id q12mr21775879otm.175.1562063757276;
        Tue, 02 Jul 2019 03:35:57 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 09/11] perf intel-bts: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:18 +0800
Message-Id: <20190702103420.27540-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/intel-bts.c:898
  intel_bts_process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 894)

  tools/perf/util/intel-bts.c:899
  intel_bts_process_auxtrace_info() warn: variable dereferenced before
  check 'session->itrace_synth_opts' (see line 898)

tools/perf/util/intel-bts.c
894         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
895                 bts->synth_opts = *session->itrace_synth_opts;
896         } else {
897                 itrace_synth_opts__set_default(&bts->synth_opts,
898                                 session->itrace_synth_opts->default_no_sample);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
899                 if (session->itrace_synth_opts)
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^
900                         bts->synth_opts.thread_stack =
901                                 session->itrace_synth_opts->thread_stack;
902         }

To dismiss the potential NULL pointer dereference, this patch validates
the pointer 'session->itrace_synth_opts' before access its elements.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/intel-bts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index e32dbffebb2f..332e647fecaa 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -893,11 +893,10 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		bts->synth_opts = *session->itrace_synth_opts;
-	} else {
+	} else if (session->itrace_synth_opts) {
 		itrace_synth_opts__set_default(&bts->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		if (session->itrace_synth_opts)
-			bts->synth_opts.thread_stack =
+		bts->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
 
-- 
2.17.1

