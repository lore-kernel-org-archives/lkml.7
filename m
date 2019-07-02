Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C2CC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30572089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjPXkNjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfGBKgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:36:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43983 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:36:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so12633872oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQcQ7p8oORqYUmw8MhMOFx6e3+qYvK2rxF9oxDoZM7o=;
        b=JjPXkNjNwzvim2+CUz73ozuGlX5deuQwPQXRLkI9Fyk/R2nArA59R51YaLMo8npnVO
         oDx52w/nnl82obHSJkgpF8mTIFXGgbsPgPRY0VhOjMmYjUfylrDBve/OsYv5SO5HwI/t
         fJtTAVO+HkS47kqFPjOMzwwEZDDJvwgP7lEbyF1Voea5leDzo8xMvT97Wip/cBsMj5HC
         qb+vN0sL1ae3v1Lp2+ZMoD6/7mRVeEM/HozhAt6Nchk7yTPvTc9H31mPH+gFGlRyx5hx
         n8EIseeSRFabSWYYZvbYMFwVKE8LJaUpguIJXOkH/Nu/sENoYoO49Zw4nIctWDhGf81L
         pkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQcQ7p8oORqYUmw8MhMOFx6e3+qYvK2rxF9oxDoZM7o=;
        b=kGb8lw7mS5IjbZqt8L9sSsQGrKwhK30M6RQJ/+ZncbSPj6LobBCCJ3jkDlbU/n0Z86
         g3tsANgagV5eAmXnZxn6JXPzNz6DOtym2wyDAKGSXLo3ZTOlv2564LbmXdatDgK7IenN
         foSv93QVB3urJW3uDJH71kupAMLGrO79gV1uUCk+vgqEGIyqx0ipBoH0Q6nGHbvqZUM6
         nM4v+3vVJls2uuO15Gf/m7BVmzVoQQXU9+tV+z6vHCszEcFYGVoSXUZJhHnKZH4JNqMq
         +QFwXzhwb140xCPh/7LAjkfZcDR+7KDNR2Tavy+mBG6klLJKGAdsuHZY4op5dAbWwIVQ
         CxKg==
X-Gm-Message-State: APjAAAVVSC58k9p5VDUGpo0gyA/dB94Yw5FPFn8xXUHtkaqjJgaTCrWA
        Fb/kyO5CpzbBsrg/+okITD+8Aw==
X-Google-Smtp-Source: APXvYqy4PfZ2f8WzbFVNWCQAGxoRu5uiQd1w+JSL9GGeOLIehFvhdbjrx+tZn3DQYJaC+vao4GhoPg==
X-Received: by 2002:aca:be88:: with SMTP id o130mr2506821oif.122.1562063772431;
        Tue, 02 Jul 2019 03:36:12 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:36:11 -0700 (PDT)
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
Subject: [PATCH v1 11/11] perf cs-etm: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:20 +0800
Message-Id: <20190702103420.27540-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/cs-etm.c:2545
  cs_etm__process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 2541)

tools/perf/util/cs-etm.c
2541         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
2542                 etm->synth_opts = *session->itrace_synth_opts;
2543         } else {
2544                 itrace_synth_opts__set_default(&etm->synth_opts,
2545                                 session->itrace_synth_opts->default_no_sample);
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
2546                 etm->synth_opts.callchain = false;
2547         }

To dismiss the potential NULL pointer dereference, this patch validates
the pointer 'session->itrace_synth_opts' before access its elements.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0c7776b51045..b79df56eb9df 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2540,7 +2540,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
 		etm->synth_opts = *session->itrace_synth_opts;
-	} else {
+	} else if (session->itrace_synth_opts) {
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
 		etm->synth_opts.callchain = false;
-- 
2.17.1

