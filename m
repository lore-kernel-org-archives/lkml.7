Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16BFC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DFC208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vADK7xuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfFVGkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:40:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:40:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6eDd92005811
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:40:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6eDd92005811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185614;
        bh=NH3dQWr+0uqNvVft2ZrBB4arxQsDXzDzYY4y9AUxcNc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vADK7xuAt1J30koqRVj+YxslNqUk1msa2fWABZK0JqjKgLyGuFPiDtfDKgFXDPbb6
         bPXIqlB+HDzqW9CmjoEOiBWriEobdJYM7PC0YVj2X3xgVCkw/HdF5rZKLxK43Wqv3U
         cF8BBQcRC9ckSUyCt+W5whnOpEM/Q0BGrN4y1GqG96WRAyYjl53eyooLS2FCUf02x0
         ssnZ2nohBNLZ5jv6fnSmgb+pzA7mo3+5z4PTL0IRM5mHch6c2XUmnJr6cpwZaWBLQl
         cY3nFK8Xj4ekcgJ1hQM1Tn7UoMy1c5nWgO3Z1hrIsN0gYmVG7JvMEhYTnhz2rkU0Br
         pRnWGQG94UdXA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6eDFu2005806;
        Fri, 21 Jun 2019 23:40:13 -0700
Date:   Fri, 21 Jun 2019 23:40:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-9e9a618afc178e747cc449464ba54d9c932f7af2@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        jolsa@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          jolsa@redhat.com, tglx@linutronix.de
In-Reply-To: <20190610072803.10456-8-adrian.hunter@intel.com>
References: <20190610072803.10456-8-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add gp registers to synthesized PEBS
 sample
Git-Commit-ID: 9e9a618afc178e747cc449464ba54d9c932f7af2
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

Commit-ID:  9e9a618afc178e747cc449464ba54d9c932f7af2
Gitweb:     https://git.kernel.org/tip/9e9a618afc178e747cc449464ba54d9c932f7af2
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:27:59 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:18 -0300

perf intel-pt: Add gp registers to synthesized PEBS sample

Add general purpose register information from PEBS data in the Intel PT
trace to the synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 979519b00a74..00c2c96bb805 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -35,6 +35,8 @@
 #include "config.h"
 #include "time-utils.h"
 
+#include "../arch/x86/include/uapi/asm/perf_regs.h"
+
 #include "intel-pt-decoder/intel-pt-log.h"
 #include "intel-pt-decoder/intel-pt-decoder.h"
 #include "intel-pt-decoder/intel-pt-insn-decoder.h"
@@ -1547,6 +1549,60 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
+/*
+ * PEBS gp_regs array indexes plus 1 so that 0 means not present. Refer
+ * intel_pt_add_gp_regs().
+ */
+static const int pebs_gp_regs[] = {
+	[PERF_REG_X86_FLAGS]	= 1,
+	[PERF_REG_X86_IP]	= 2,
+	[PERF_REG_X86_AX]	= 3,
+	[PERF_REG_X86_CX]	= 4,
+	[PERF_REG_X86_DX]	= 5,
+	[PERF_REG_X86_BX]	= 6,
+	[PERF_REG_X86_SP]	= 7,
+	[PERF_REG_X86_BP]	= 8,
+	[PERF_REG_X86_SI]	= 9,
+	[PERF_REG_X86_DI]	= 10,
+	[PERF_REG_X86_R8]	= 11,
+	[PERF_REG_X86_R9]	= 12,
+	[PERF_REG_X86_R10]	= 13,
+	[PERF_REG_X86_R11]	= 14,
+	[PERF_REG_X86_R12]	= 15,
+	[PERF_REG_X86_R13]	= 16,
+	[PERF_REG_X86_R14]	= 17,
+	[PERF_REG_X86_R15]	= 18,
+};
+
+static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
+				 const struct intel_pt_blk_items *items,
+				 u64 regs_mask)
+{
+	const u64 *gp_regs = items->val[INTEL_PT_GP_REGS_POS];
+	u32 mask = items->mask[INTEL_PT_GP_REGS_POS];
+	u32 bit;
+	int i;
+
+	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
+		/* Get the PEBS gp_regs array index */
+		int n = pebs_gp_regs[i] - 1;
+
+		if (n < 0)
+			continue;
+		/*
+		 * Add only registers that were requested (i.e. 'regs_mask') and
+		 * that were provided (i.e. 'mask'), and update the resulting
+		 * mask (i.e. 'intr_regs->mask') accordingly.
+		 */
+		if (mask & 1 << n && regs_mask & bit) {
+			intr_regs->mask |= bit;
+			*pos++ = gp_regs[n];
+		}
+	}
+
+	return pos;
+}
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1597,6 +1653,19 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
 	}
 
+	if (sample_type & PERF_SAMPLE_REGS_INTR &&
+	    items->mask[INTEL_PT_GP_REGS_POS]) {
+		u64 regs[sizeof(sample.intr_regs.mask)];
+		u64 regs_mask = evsel->attr.sample_regs_intr;
+
+		sample.intr_regs.abi = items->is_32_bit ?
+				       PERF_SAMPLE_REGS_ABI_32 :
+				       PERF_SAMPLE_REGS_ABI_64;
+		sample.intr_regs.regs = regs;
+
+		intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
