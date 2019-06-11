Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08057C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EEF217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279589;
	bh=mnaXBA+2kLapJhrLyRUJCKN4ABDJhK+EZbjaUlHF8X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y1HLC/SXpMZOiXP5MzXzGrS8JP+aw60XxRCda3QkHB6RlNSPgkQpCfXbfZ/gV4Xo+
	 gJVLErFeNIw02SAe5HOxPe94FRmwsCOqcz6RiJ8WbEH95kWXbK3XAOhz/VF5h5MwFb
	 L66Vz1XFZVly1ZwGBqwyqEA3h0OkDljJCzMAC7cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407085AbfFKS7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404869AbfFKS7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8E32183F;
        Tue, 11 Jun 2019 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279587;
        bh=mnaXBA+2kLapJhrLyRUJCKN4ABDJhK+EZbjaUlHF8X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuwN/pzIS98d1E7akc0Y1rzJc+QYuxWYGPR6OuZbWmht32vYfXdBl6a3qSzKPosZQ
         XeqeSxnjtTEF2GarvaCWXPDUeygBnmlG7k0+UjyMN8C7qODdynd721Oz+Oel5AScvY
         O/jD8yr8mANjX4HirIZyJ49IUh4FGkXkB4gmorBg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/85] perf intel-pt: Factor out intel_pt_update_sample_time
Date:   Tue, 11 Jun 2019 15:57:53 -0300
Message-Id: <20190611185911.11645-8-acme@kernel.org>
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

To eliminate some duplication and make the code more understandable,
factor out intel_pt_update_sample_time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f4c3c84b090f..1ab4070b5633 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -479,6 +479,12 @@ static int intel_pt_bad_packet(struct intel_pt_decoder *decoder)
 	return -EBADMSG;
 }
 
+static inline void intel_pt_update_sample_time(struct intel_pt_decoder *decoder)
+{
+	decoder->sample_timestamp = decoder->timestamp;
+	decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+}
+
 static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
@@ -1319,8 +1325,7 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 			}
 			decoder->ip += intel_pt_insn.length;
 			if (!decoder->tnt.count) {
-				decoder->sample_timestamp = decoder->timestamp;
-				decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+				intel_pt_update_sample_time(decoder);
 				return -EAGAIN;
 			}
 			decoder->tnt.payload <<= 1;
@@ -2413,8 +2418,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 	if (err) {
 		decoder->state.err = intel_pt_ext_err(err);
 		decoder->state.from_ip = decoder->ip;
-		decoder->sample_timestamp = decoder->timestamp;
-		decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+		intel_pt_update_sample_time(decoder);
 	} else {
 		decoder->state.err = 0;
 		if (decoder->cbr != decoder->cbr_seen && decoder->state.type) {
@@ -2422,10 +2426,8 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
 		}
-		if (intel_pt_sample_time(decoder->pkt_state)) {
-			decoder->sample_timestamp = decoder->timestamp;
-			decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
-		}
+		if (intel_pt_sample_time(decoder->pkt_state))
+			intel_pt_update_sample_time(decoder);
 	}
 
 	decoder->state.timestamp = decoder->sample_timestamp;
-- 
2.20.1

