Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28794C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A75218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279852;
	bh=4wucbD7svp8ZtVKKQ2WGa1WWzfPsteglLE8jeq/hsAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zp6mSZVkbR8qH5D9aWEAYlR+klho1UXPsc8KOpmjZbAt0EcvuSSDdsuX3VPJjRxzl
	 yamuc2jLQpUph0QE5LnqUvXHk060q5C8FwPiI/ndbzP2cu26Q7HdykGmFskCbUw7di
	 8L/RLbLGf4hRlDS37955bB6iw0ZquJxnRnrAcyDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407231AbfFKTEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404099AbfFKTEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8609F21881;
        Tue, 11 Jun 2019 19:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279849;
        bh=4wucbD7svp8ZtVKKQ2WGa1WWzfPsteglLE8jeq/hsAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsHhXtiG6qA5zoMnVLjFDfMiGRoSwjkch3ic1YjDoOIIbGEQVb/qbXVxfBTUU5V4R
         IHcRr40kJ0rp4Mv4N7bBYORoNXC07mlme2uvtMUPEnh9zHm1x2i3/ngeqylbjGzcO8
         19Z2UDQzj5s8BFLp+WofpYdJqXn8GTCjJccJr274=
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
Subject: [PATCH 67/85] perf intel-pt: Factor out intel_pt_8b_tsc()
Date:   Tue, 11 Jun 2019 15:58:53 -0300
Message-Id: <20190611185911.11645-68-acme@kernel.org>
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

Factor out intel_pt_8b_tsc() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 13123b195083..c06dceb774e9 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1369,6 +1369,21 @@ static int intel_pt_mode_tsx(struct intel_pt_decoder *decoder, bool *no_tip)
 	return 0;
 }
 
+static uint64_t intel_pt_8b_tsc(uint64_t timestamp, uint64_t ref_timestamp)
+{
+	timestamp |= (ref_timestamp & (0xffULL << 56));
+
+	if (timestamp < ref_timestamp) {
+		if (ref_timestamp - timestamp > (1ULL << 55))
+			timestamp += (1ULL << 56);
+	} else {
+		if (timestamp - ref_timestamp > (1ULL << 55))
+			timestamp -= (1ULL << 56);
+	}
+
+	return timestamp;
+}
+
 static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 {
 	uint64_t timestamp;
@@ -1376,15 +1391,8 @@ static void intel_pt_calc_tsc_timestamp(struct intel_pt_decoder *decoder)
 	decoder->have_tma = false;
 
 	if (decoder->ref_timestamp) {
-		timestamp = decoder->packet.payload |
-			    (decoder->ref_timestamp & (0xffULL << 56));
-		if (timestamp < decoder->ref_timestamp) {
-			if (decoder->ref_timestamp - timestamp > (1ULL << 55))
-				timestamp += (1ULL << 56);
-		} else {
-			if (timestamp - decoder->ref_timestamp > (1ULL << 55))
-				timestamp -= (1ULL << 56);
-		}
+		timestamp = intel_pt_8b_tsc(decoder->packet.payload,
+					    decoder->ref_timestamp);
 		decoder->tsc_timestamp = timestamp;
 		decoder->timestamp = timestamp;
 		decoder->ref_timestamp = 0;
-- 
2.20.1

