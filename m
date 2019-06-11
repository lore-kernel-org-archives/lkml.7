Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98BC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DA02184E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279840;
	bh=McIxz4iOyiBOq9OURz1UZN3YQo9i5sFMbEtzFIt494U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FNqh/mRhp7PT+yEMOc4VqZx5+xl/tFRp3JZFY/2gh4Tz77Tlg4nAHXUoSfgnBOdrC
	 RE7DdbxjiyxwNQ4v8Wr5HDzmWEKzygw+RfE8e/wHkolKV0GWWDkxcTfuRO1vWhi+CG
	 3JuuMO5/ot4u5tXEAzn1044pr4fm1G+Sa4BJzZI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405753AbfFKTD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405486AbfFKTD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86DD421881;
        Tue, 11 Jun 2019 19:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279836;
        bh=McIxz4iOyiBOq9OURz1UZN3YQo9i5sFMbEtzFIt494U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQCZpixbPfrk+dYCXUTTscqvox19rlqLadGfJeSutU6ZA3kFwZS5YZmaTGXiXUwyA
         Q/HlrIMq2T6usZ8Pmhz/JiYt/4EtTsES1bBudhoDGsJzlitxt0e1VpE2Jsvm0Gu1Th
         OB48uRPEUKQ250QOCUBIPdhDjV7VnGgZdPIBDVyo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 63/85] perf auxtrace: Add perf time interval to itrace_synth_ops
Date:   Tue, 11 Jun 2019 15:58:49 -0300
Message-Id: <20190611185911.11645-64-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Instruction trace decoders can optimize output based on what time
intervals will be filtered, so pass that information in
itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index c69bcd9a3091..c80c58eb7f4d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -83,6 +83,8 @@ enum itrace_period_type {
  * @period_type: 'instructions' events period type
  * @initial_skip: skip N events at the beginning.
  * @cpu_bitmap: CPUs for which to synthesize events, or NULL for all
+ * @ptime_range: time intervals to trace or NULL
+ * @range_num: number of time intervals to trace
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -107,6 +109,8 @@ struct itrace_synth_opts {
 	enum itrace_period_type	period_type;
 	unsigned long		initial_skip;
 	unsigned long		*cpu_bitmap;
+	struct perf_time_interval *ptime_range;
+	int			range_num;
 };
 
 /**
@@ -599,6 +603,21 @@ static inline void auxtrace__free(struct perf_session *session)
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is ibxwpe or cewp\n"
 
+static inline
+void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts,
+				       struct perf_time_interval *ptime_range,
+				       int range_num)
+{
+	opts->ptime_range = ptime_range;
+	opts->range_num = range_num;
+}
+
+static inline
+void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts)
+{
+	opts->ptime_range = NULL;
+	opts->range_num = 0;
+}
 
 #else
 
@@ -742,6 +761,21 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 
 #define ITRACE_HELP ""
 
+static inline
+void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts
+				       __maybe_unused,
+				       struct perf_time_interval *ptime_range
+				       __maybe_unused,
+				       int range_num __maybe_unused)
+{
+}
+
+static inline
+void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts
+					 __maybe_unused)
+{
+}
+
 #endif
 
 #endif
-- 
2.20.1

