Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C11C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF582083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138824;
	bh=TUol6OPfE0HYdhldmbcFt9RBMC3YElzv3rBkCRQfJ50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BUFB0k53EkSRX45ncCZTZYhQ7WT16HcZPMQElUcMR0iT2YfoXsHvM4g1wGIA5pbB5
	 n4bAdeKHdXuVrsQZgyHfspD00WO8+swrx5IpYDYlkZXODWmAgOpBAzN1SaUjz846sg
	 3M1HAcdx0uFroFfnZ56kwXB6+44cnK3esvCztNOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfFURkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFURkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:22 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D10D21670;
        Fri, 21 Jun 2019 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138820;
        bh=TUol6OPfE0HYdhldmbcFt9RBMC3YElzv3rBkCRQfJ50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIV6kUlyuyuVQX1FAIx1SuqQV8k2NVQjpBDUYHr62Btda4mzId3zIKPFMRkdfjIMI
         ouCjnt7Yt/jwXBBpQ9CfEo43kRCtjhKK/wqaOzt8E8qIwzjsYM0vpVoluqu4Uhfmdb
         cf/h8XGhJlKf6KitFPS+n0/QmTy6PH3vJ2dSoX7c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/25] perf intel-pt: Add callchain to synthesized PEBS sample
Date:   Fri, 21 Jun 2019 14:38:19 -0300
Message-Id: <20190621173831.13780-14-acme@kernel.org>
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

Like other synthesized events, if there is also an Intel PT branch
trace, then a call stack can also be synthesized.  Add that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index bf7647897e8a..550db6e77968 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1730,6 +1730,14 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
 	}
 
+	if (sample_type & PERF_SAMPLE_CALLCHAIN &&
+	    pt->synth_opts.callchain) {
+		thread_stack__sample(ptq->thread, ptq->cpu, ptq->chain,
+				     pt->synth_opts.callchain_sz, sample.ip,
+				     pt->kernel_start);
+		sample.callchain = ptq->chain;
+	}
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR &&
 	    items->mask[INTEL_PT_GP_REGS_POS]) {
 		u64 regs[sizeof(sample.intr_regs.mask)];
-- 
2.20.1

