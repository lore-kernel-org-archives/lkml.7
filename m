Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A0C06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EC821851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279604;
	bh=bwU8hXrCIOIDYC1i8aOCrLSvLPVwOZ0b9Q8iHKgIBbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/4xlGKjTe+qrmo7gEVGqQiy0cnU7hISncirbAeKuPdLMYuLtRUoEk/2V2/BZAbX7
	 Vq/hmHtByoQ6DXvnQtElDAQbKUAW34UU1DK8GzEPybzPt4eKktMBZLB4eBVUgLmNWJ
	 +VEiqFeVokETbOI9iASi6Y2Lnwa0LdbZtXf7Ofys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407143AbfFKTAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404869AbfFKTAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4742184E;
        Tue, 11 Jun 2019 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279602;
        bh=bwU8hXrCIOIDYC1i8aOCrLSvLPVwOZ0b9Q8iHKgIBbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxklUCv8GHNcHIpZwSCFGYAJ7ArgSED1fIv6v0AiZzMo6VnP8aenaagdzv2boRvmO
         KHXhKjPRyLom2a9br47gxftzhxjMQVHwo9rZxRlmO3zL8j7bvQflmaiOMR25FHeT7B
         qJNHuUnW5dmQw8yW+LIKhtRFHHQ2f9LTBBOlHn38=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/85] perf intel-pt: Record when decoding PSB+ packets
Date:   Tue, 11 Jun 2019 15:57:58 -0300
Message-Id: <20190611185911.11645-13-acme@kernel.org>
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

In preparation for using MTC packets to count cycles, record whether
decoding is between a PSB and PSBEND packets.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index ef3a1c1cd250..a2384a314990 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -116,6 +116,7 @@ struct intel_pt_decoder {
 	bool have_cyc;
 	bool fixup_last_mtc;
 	bool have_last_ip;
+	bool in_psb;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -1549,14 +1550,17 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_TIP_PGD:
 		case INTEL_PT_TIP_PGE:
@@ -1574,10 +1578,12 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRX:
 			decoder->have_tma = false;
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -EAGAIN;
+			err = -EAGAIN;
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_TSC:
 			intel_pt_calc_tsc_timestamp(decoder);
@@ -1623,6 +1629,10 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
@@ -1996,10 +2006,12 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
@@ -2015,7 +2027,8 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_FUP:
 			decoder->pge = true;
@@ -2074,16 +2087,20 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 				decoder->pkt_state = INTEL_PT_STATE_ERR4;
 			else
 				decoder->pkt_state = INTEL_PT_STATE_ERR3;
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_BAD: /* Does not happen */
-			return intel_pt_bug(decoder);
+			err = intel_pt_bug(decoder);
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_PSB:
 		case INTEL_PT_VMCS:
@@ -2093,6 +2110,10 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
-- 
2.20.1

