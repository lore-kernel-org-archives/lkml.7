Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1741C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908522084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Nm078SuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfFQTie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:38:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:38:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJcE2b3566165
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:38:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJcE2b3566165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800295;
        bh=bOhbHlo2vur31Mm/JjujfWnoWh5XC/2O3FWi+yFo3tc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Nm078SuTX79L036HvyY/UNC75+0G5Av0fOVxGcEtI0wmPrKdirOmgToB8cXysJnhc
         H+3WUWuk/cpKpPY8Dp8w8/aysbQH5cF05VGRfJi6hS1kqra8PmdPmI3TrIH+gW4kV9
         tsEqbfd56Qv0Fi4uInbNvHC+NIHUCgiX8XElO1CyzXrTQ3Goi5yxj/7Xr3M+A9Cltb
         FhxVt/w8VgVKx+z1N4z8/gTV9chYi7DsI/kk5gMV1qb1ltVO7Mz1MZACuY+VqFq1Kc
         lofAA6wF2Ex09BQ96/EyuRaGRon2WCX5OihqXV1gtxcsEl3QqJTEqq3Xwb1hvDQtpf
         DVXa5QNcrSbJg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJcE4i3566162;
        Mon, 17 Jun 2019 12:38:14 -0700
Date:   Mon, 17 Jun 2019 12:38:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-33526f362b019f0a17c6b522eb3b07017dba98a7@git.kernel.org>
Cc:     jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, yao.jin@linux.intel.com
Reply-To: acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          jolsa@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <20190604130017.31207-2-adrian.hunter@intel.com>
References: <20190604130017.31207-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Add perf time interval to
 itrace_synth_ops
Git-Commit-ID: 33526f362b019f0a17c6b522eb3b07017dba98a7
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

Commit-ID:  33526f362b019f0a17c6b522eb3b07017dba98a7
Gitweb:     https://git.kernel.org/tip/33526f362b019f0a17c6b522eb3b07017dba98a7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 15:59:59 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:11 -0300

perf auxtrace: Add perf time interval to itrace_synth_ops

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
