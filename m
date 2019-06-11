Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39982186A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279848;
	bh=c036uJy5BaI9Z1gwfDoxs2/30ojVEyr33h0rkqRzbw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VO0kBGSpBLczvP4QYiDZkCZVXklXVuGMGFGMRu4BCpqq/MXDatYDvKN8jRu6Sr9sA
	 1FOOGw6cFKHdGsjzX4v017/TndbRPERnyqMNZBAdh3fnIm2jALyUP/7m3nzUfukOFB
	 QTJi5pe6LzhhrsyvoNj8ZaxfYDXbXnqHJPaCx6dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407218AbfFKTEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404099AbfFKTEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669F92183F;
        Tue, 11 Jun 2019 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279846;
        bh=c036uJy5BaI9Z1gwfDoxs2/30ojVEyr33h0rkqRzbw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oX1QqSX4OeVr4WN86ENt6S1PZZUa054DPI1kWBiBY1Kaperm2hoXplvvtNY8cabpc
         KJXd9axlkHV7DPl+lBAiGoNOB6ycrTq5h/aKp2eVjLxRAEOC4i01QqLEBcQuv0xs/i
         ToV07bs8RbefgMC02112NuiYLYDEP26A2ZHu7qq8=
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
Subject: [PATCH 66/85] perf intel-pt: Add lookahead callback
Date:   Tue, 11 Jun 2019 15:58:52 -0300
Message-Id: <20190611185911.11645-67-acme@kernel.org>
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

Add a callback function to enable the decoder to lookahead at subsequent
trace buffers. This will be used to implement a "fast forward" facility
which will be needed to support efficient time interval filtering.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 9eb778f9c911..13123b195083 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -104,6 +104,7 @@ struct intel_pt_decoder {
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	struct intel_pt_state state;
 	const unsigned char *buf;
@@ -233,6 +234,7 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
 	decoder->get_trace          = params->get_trace;
 	decoder->walk_insn          = params->walk_insn;
 	decoder->pgd_ip             = params->pgd_ip;
+	decoder->lookahead          = params->lookahead;
 	decoder->data               = params->data;
 	decoder->return_compression = params->return_compression;
 	decoder->branch_enable      = params->branch_enable;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 6a61773dc44b..de36254c6ac9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -102,12 +102,15 @@ struct intel_pt_buffer {
 	uint64_t trace_nr;
 };
 
+typedef int (*intel_pt_lookahead_cb_t)(struct intel_pt_buffer *, void *);
+
 struct intel_pt_params {
 	int (*get_trace)(struct intel_pt_buffer *buffer, void *data);
 	int (*walk_insn)(struct intel_pt_insn *intel_pt_insn,
 			 uint64_t *insn_cnt_ptr, uint64_t *ip, uint64_t to_ip,
 			 uint64_t max_insn_cnt, void *data);
 	bool (*pgd_ip)(uint64_t ip, void *data);
+	int (*lookahead)(void *data, intel_pt_lookahead_cb_t cb, void *cb_data);
 	void *data;
 	bool return_compression;
 	bool branch_enable;
-- 
2.20.1

