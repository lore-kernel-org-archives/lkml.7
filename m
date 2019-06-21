Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80607C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57978216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138818;
	bh=1d/OCzcaFQkfknnPMMyj+EC+fTumFpysACsa7mXJbkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lRfkD/36sDRPDzq2qvDYL3HTfSN8c4WSix48RV8XlDyXZYPeriwFGA4CC7lCegu0S
	 ct5GWjFt9JTYTIoM8KirOM0bV/eFHBH3zcNWO/0c+jjdAm+WldZYbh6Sv0Zmb7hCw2
	 Cw6gTwQRviPp8V+iveR/Wg1Fydb7WxiqNSbT1L4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfFURkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFURkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:16 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5133321537;
        Fri, 21 Jun 2019 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138815;
        bh=1d/OCzcaFQkfknnPMMyj+EC+fTumFpysACsa7mXJbkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vhaCZJEe/g+THA4Xer0vw7puyjFTzpTOW/wAQWLBpX0GnApOVGyd8MK630HFIHcJ2
         vIPeo+9GVYZrXy0uqJHWVSjiSA5g1lq6IzHSErrGJphrRuauskubezH+bSJuwSx3Dx
         He0EU9w9F/YWsDgvaQSInUX3bkBdDuiSLEBtYnGs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/25] perf intel-pt: Add memory information to synthesized PEBS sample
Date:   Fri, 21 Jun 2019 14:38:18 -0300
Message-Id: <20190621173831.13780-13-acme@kernel.org>
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

Add memory information from PEBS data in the Intel PT trace to the
synthesized PEBS sample. This provides sample types PERF_SAMPLE_ADDR,
PERF_SAMPLE_WEIGHT, and PERF_SAMPLE_TRANSACTION, but not
PERF_SAMPLE_DATA_SRC.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index db00c13dc36f..bf7647897e8a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1766,6 +1766,33 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		}
 	}
 
+	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
+		sample.addr = items->mem_access_address;
+
+	if (sample_type & PERF_SAMPLE_WEIGHT) {
+		/*
+		 * Refer kernel's setup_pebs_adaptive_sample_data() and
+		 * intel_hsw_weight().
+		 */
+		if (items->has_mem_access_latency)
+			sample.weight = items->mem_access_latency;
+		if (!sample.weight && items->has_tsx_aux_info) {
+			/* Cycles last block */
+			sample.weight = (u32)items->tsx_aux_info;
+		}
+	}
+
+	if (sample_type & PERF_SAMPLE_TRANSACTION && items->has_tsx_aux_info) {
+		u64 ax = items->has_rax ? items->rax : 0;
+		/* Refer kernel's intel_hsw_transaction() */
+		u64 txn = (u8)(items->tsx_aux_info >> 32);
+
+		/* For RTM XABORTs also log the abort code from AX */
+		if (txn & PERF_TXN_TRANSACTION && ax & 1)
+			txn |= ((ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
+		sample.transaction = txn;
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
-- 
2.20.1

