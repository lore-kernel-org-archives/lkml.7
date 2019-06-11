Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F8AC06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCF721850
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279855;
	bh=6JpFPYbh482EzfzbM+gAv8NdrtHiLpYsZJziqliDkXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pJWYmQ5vGi2i+bXUzxXmlMN8lBCjhLCiARJheZHRqyutYHUuVwRPbet55EjgqCVRW
	 QwSe5ljimfZQdpsBLOp/u8FldlA2zYvzAleSt/L/FOvXrgmc/IskfcvyUBUyaD1Dkb
	 Y70F0Fivah09eWYDm9PODt6Wtnm0f4JKtHHzPzeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407245AbfFKTEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407232AbfFKTEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE372186A;
        Tue, 11 Jun 2019 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279852;
        bh=6JpFPYbh482EzfzbM+gAv8NdrtHiLpYsZJziqliDkXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Py32z4ipa0REYu+rik9P154/3ZtEHFV7GxiL8qPu2beBO4I353FMau33SdZrJEyea
         AMggMpwKqon5ph0q667dolsurmUl1QqGOOURcJumzwEPvihfKNuKByPJUNpyD6npwS
         7LHegClR4ollhs3zLWLkyR1QcLGdf8nHbHQxJij4=
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
Subject: [PATCH 68/85] perf intel-pt: Factor out intel_pt_reposition()
Date:   Tue, 11 Jun 2019 15:58:54 -0300
Message-Id: <20190611185911.11645-69-acme@kernel.org>
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

Factor out intel_pt_reposition() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index c06dceb774e9..70bff7bb79f3 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -494,6 +494,14 @@ static inline void intel_pt_update_sample_time(struct intel_pt_decoder *decoder)
 	decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
 }
 
+static void intel_pt_reposition(struct intel_pt_decoder *decoder)
+{
+	decoder->ip = 0;
+	decoder->pkt_state = INTEL_PT_STATE_NO_PSB;
+	decoder->timestamp = 0;
+	decoder->have_tma = false;
+}
+
 static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
@@ -512,11 +520,8 @@ static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 		return -ENODATA;
 	}
 	if (!buffer.consecutive) {
-		decoder->ip = 0;
-		decoder->pkt_state = INTEL_PT_STATE_NO_PSB;
+		intel_pt_reposition(decoder);
 		decoder->ref_timestamp = buffer.ref_timestamp;
-		decoder->timestamp = 0;
-		decoder->have_tma = false;
 		decoder->state.trace_nr = buffer.trace_nr;
 		intel_pt_log("Reference timestamp 0x%" PRIx64 "\n",
 			     decoder->ref_timestamp);
-- 
2.20.1

