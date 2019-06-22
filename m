Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F39C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E10C2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x4D7l62t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFVGib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:38:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:38:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6c8IK2005078
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:38:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6c8IK2005078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185489;
        bh=BzYmC+8qxlNB699SyCh80KLwrF8LCiWkQQMXyOdVG8w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=x4D7l62t6QS4ViuilAHkg2HOZNYOSbRI2TcHRTh2WUJlrFdqZPagAVkm5rrpK94XC
         Z6kpRv8VUH2wA5Sf3vG4BnodugOGPsl2R8144/g9oUsY/iMX8Tgkz+aj3K55EJBgjA
         zUixCao43M6sQoKmncLpu1onQBimYF3pAxGqS6+Qkm01vxrOHu7wy5JoC6RpTz9zp0
         t6H8uiY0zpNTQXuua+GGkmaG7h3Gz78ixQ3bwx2ZfvANgqApv8P6Z8j1aMNGieNt8z
         LSrJVxBorxZWrFqyhyJFsc6F9kmP9sn3ajlQVE1qR8OljjaropJBUzazFYm88Gou05
         4cEOnf+WvZCVw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6c8oo2005075;
        Fri, 21 Jun 2019 23:38:08 -0700
Date:   Fri, 21 Jun 2019 23:38:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-e62ca655eea7ad4956929f647c2d9fb36aeff90e@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, jolsa@redhat.com, mingo@kernel.org,
          hpa@zytor.com, adrian.hunter@intel.com
In-Reply-To: <20190610072803.10456-5-adrian.hunter@intel.com>
References: <20190610072803.10456-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Prepare to synthesize PEBS samples
Git-Commit-ID: e62ca655eea7ad4956929f647c2d9fb36aeff90e
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

Commit-ID:  e62ca655eea7ad4956929f647c2d9fb36aeff90e
Gitweb:     https://git.kernel.org/tip/e62ca655eea7ad4956929f647c2d9fb36aeff90e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:27:56 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:17 -0300

perf intel-pt: Prepare to synthesize PEBS samples

Add infrastructure to prepare for synthesizing PEBS samples but leave
the actual synthesis to later patches.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 893cef494a43..cc91c1413c22 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -101,6 +101,9 @@ struct intel_pt {
 	u64 pwrx_id;
 	u64 cbr_id;
 
+	bool sample_pebs;
+	struct perf_evsel *pebs_evsel;
+
 	u64 tsc_bit;
 	u64 mtc_bit;
 	u64 mtc_freq_bits;
@@ -1535,6 +1538,11 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
+static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq __maybe_unused)
+{
+	return 0;
+}
+
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 				pid_t pid, pid_t tid, u64 ip, u64 timestamp)
 {
@@ -1622,6 +1630,16 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
 	}
 
+	/*
+	 * Do PEBS first to allow for the possibility that the PEBS timestamp
+	 * precedes the current timestamp.
+	 */
+	if (pt->sample_pebs && state->type & INTEL_PT_BLK_ITEMS) {
+		err = intel_pt_synth_pebs_sample(ptq);
+		if (err)
+			return err;
+	}
+
 	if (pt->sample_pwr_events && (state->type & INTEL_PT_PWR_EVT)) {
 		if (state->type & INTEL_PT_CBR_CHG) {
 			err = intel_pt_synth_cbr_sample(ptq);
