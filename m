Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868CAC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F04E2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138787;
	bh=GY3P4sh2QdALpkjgFfv+73uimqBb8uHqwlKU92hoWNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfcTZLt72/VWOV6T59DU+SJLU3DMztUzmpihqYwksCzUtMuoyYONkhpN2hKewUP99
	 1khl15OyFXuRkq6sXGRyTSG9wOuzszRy6+b421SqeK9Uv+RP0nR23SPwfaqBnCJBBc
	 Hp4ljaIUgrdn27Bzj54vD72LBoLBwBNwusTV0+EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFURjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:39:43 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF19208C3;
        Fri, 21 Jun 2019 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138783;
        bh=GY3P4sh2QdALpkjgFfv+73uimqBb8uHqwlKU92hoWNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cP+PSgnNopda2cPpMz6QJf+8cyLeF0MJEkyvNIASz/evcVDImeHwUQC37Wbkm0Y/R
         zlpK7XnNxZzlNKYfYXItWHPCOUjR1KPWRPOGL4aNxN8qjHBEj05VWTkXEe/JxgdYHr
         xpVOKSgHQWrt8Zmv/6G2/2ert3E0jx6p2mPgWX9o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/25] perf intel-pt: Prepare to synthesize PEBS samples
Date:   Fri, 21 Jun 2019 14:38:12 -0300
Message-Id: <20190621173831.13780-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.20.1

