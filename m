Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D6C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCCF21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034411;
	bh=YF1qbLkTdGFMsdlNTx0Pi1h1T7YAEeEZnVrz15yIeOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bdjJZoNP34AGz/5yFnqvEykS9roznHEDmWyaurO8DuqboIgAUCrowWsLSy3yCMLES
	 1GsOVP9w5G3BU2eLywEzED2G7d9il7yDt6hLyio/35zpbiJqBhowop8VHx5YSHFpQN
	 VlL745/liq2qum8GZ/aR+Vq2/l2gVXkg89ONKatU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfGBC0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfGBC0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:26:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEBFD2173E;
        Tue,  2 Jul 2019 02:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034406;
        bh=YF1qbLkTdGFMsdlNTx0Pi1h1T7YAEeEZnVrz15yIeOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvrQYxX2UqBEYKlIiyqU9hr3sTLeeakgk2SucCSfyXgGQ8d1+CDKoI2pG2xV6b3Fv
         gg2h98KGG09RDQXiEEK2iU/mYjqo1hzNFwu3Y44QudqqUsg/FPngdsyjsVDgO/bK/n
         4PdgrlsjnfL7hOLrILwrDX9Y3DQ0tZSfMQz90n+U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/43] perf intel-pt: Add CBR value to decoder state
Date:   Mon,  1 Jul 2019 23:25:40 -0300
Message-Id: <20190702022616.1259-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

For convenience, add the core-to-bus ratio (CBR) value to the decoder
state.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5eb792cc5d3a..4d14e78c5927 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -2633,6 +2633,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			}
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
+			decoder->state.cbr = decoder->cbr;
 		}
 		if (intel_pt_sample_time(decoder->pkt_state)) {
 			intel_pt_update_sample_time(decoder);
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 9957f2ccdca8..e289e463d635 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -213,6 +213,7 @@ struct intel_pt_state {
 	uint64_t pwre_payload;
 	uint64_t pwrx_payload;
 	uint64_t cbr_payload;
+	uint32_t cbr;
 	uint32_t flags;
 	enum intel_pt_insn_op insn_op;
 	int insn_len;
-- 
2.20.1

