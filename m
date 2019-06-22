Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED10CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B512070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nhUQ6P5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfFVGlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:41:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:41:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6etrv2005944
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:40:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6etrv2005944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185656;
        bh=7gMmA5ASS1MxOUg7azTGwu56lydKZc9FKYXlKWc+mTA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nhUQ6P5V0mqyLxIXEwYokPGzXctBOh3dsUJroK6f+V4EN1zshQKyruISWU4Ik6mkf
         yfGKc/gFWLZFw9cxLKshQZ+3oe6jpOjNYmcvAvXuG3nEMGqPxRQobJtInEOA1SO78L
         F4iuJWM4QYhuMYhbD3u6wIWySF1O6+6LD1qoqUiqFzK9tlixnTZA0FFNPkuyxGRvqb
         e9f/5eNKaBdocpg9+Yg80ZSr0FsBxAODy5wHjiHuPj059A4Jpxyue+jITr9rAH6YYv
         svv5RDYgdl3s5q+SLsx36GWqoLAjQWhuuyVq4tPs23b8+kuFHgTW1hPo4iefn2x7Im
         YaDqgsf2eZYbQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6etxG2005941;
        Fri, 21 Jun 2019 23:40:55 -0700
Date:   Fri, 21 Jun 2019 23:40:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-143d34a6b387b96aba42c49cb76d18ad3e3863e5@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com
In-Reply-To: <20190610072803.10456-9-adrian.hunter@intel.com>
References: <20190610072803.10456-9-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add XMM registers to synthesized
 PEBS sample
Git-Commit-ID: 143d34a6b387b96aba42c49cb76d18ad3e3863e5
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

Commit-ID:  143d34a6b387b96aba42c49cb76d18ad3e3863e5
Gitweb:     https://git.kernel.org/tip/143d34a6b387b96aba42c49cb76d18ad3e3863e5
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:28:00 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:18 -0300

perf intel-pt: Add XMM registers to synthesized PEBS sample

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
