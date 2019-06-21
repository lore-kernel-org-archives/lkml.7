Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F806C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC45D208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138807;
	bh=t9CCxh4zIXgKlh7Gmh86IjsL2zZv7Nb51NANWPDbW24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5dr9qNsmKkt3i4KYuoNLaTiMu4wmW0JKm1RPHOWm936bukZZQh8bXJktAXkGFy8b
	 QnaQvPal609/mGD+6zmeUxRsii7uk34VmpYZ0YeCV73ad93of5Br6m5+PmeMTkX4EN
	 GuwGaBBU6lAeMXMU6c0itQYobCBXeIL8DiX0HBHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFURkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFURkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:06 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DDAD21655;
        Fri, 21 Jun 2019 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138804;
        bh=t9CCxh4zIXgKlh7Gmh86IjsL2zZv7Nb51NANWPDbW24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pshD5DNCWekKeTbcZz4zYwmGE5iDemwc++dO7XwnTESOEzxvy9uHLiAGPHVu3Bbec
         UqwaKWR5l9O1yCbBJ2tts5lM5/hNSLtH8rl1AMGRHITGSN+ajSKSLuWrKD1EKAUzIO
         o5TAeJb5TNcjPz+23gt3W+1ZOVYmGJoBSXVdX4r8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/25] perf intel-pt: Add XMM registers to synthesized PEBS sample
Date:   Fri, 21 Jun 2019 14:38:16 -0300
Message-Id: <20190621173831.13780-11-acme@kernel.org>
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

Add XMM register information from PEBS data in the Intel PT trace to the
synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 00c2c96bb805..f83dd10bb7d0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1603,6 +1603,31 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
 	return pos;
 }
 
+#ifndef PERF_REG_X86_XMM0
+#define PERF_REG_X86_XMM0 32
+#endif
+
+static void intel_pt_add_xmm(struct regs_dump *intr_regs, u64 *pos,
+			     const struct intel_pt_blk_items *items,
+			     u64 regs_mask)
+{
+	u32 mask = items->has_xmm & (regs_mask >> PERF_REG_X86_XMM0);
+	const u64 *xmm = items->xmm;
+
+	/*
+	 * If there are any XMM registers, then there should be all of them.
+	 * Nevertheless, follow the logic to add only registers that were
+	 * requested (i.e. 'regs_mask') and that were provided (i.e. 'mask'),
+	 * and update the resulting mask (i.e. 'intr_regs->mask') accordingly.
+	 */
+	intr_regs->mask |= (u64)mask << PERF_REG_X86_XMM0;
+
+	for (; mask; mask >>= 1, xmm++) {
+		if (mask & 1)
+			*pos++ = *xmm;
+	}
+}
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1657,13 +1682,16 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	    items->mask[INTEL_PT_GP_REGS_POS]) {
 		u64 regs[sizeof(sample.intr_regs.mask)];
 		u64 regs_mask = evsel->attr.sample_regs_intr;
+		u64 *pos;
 
 		sample.intr_regs.abi = items->is_32_bit ?
 				       PERF_SAMPLE_REGS_ABI_32 :
 				       PERF_SAMPLE_REGS_ABI_64;
 		sample.intr_regs.regs = regs;
 
-		intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+		pos = intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+
+		intel_pt_add_xmm(&sample.intr_regs, pos, items, regs_mask);
 	}
 
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
-- 
2.20.1

