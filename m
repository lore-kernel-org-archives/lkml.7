Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED6C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2232084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OC2Ksi8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfFQTl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:41:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfFQTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:41:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJfgYj3566957
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:41:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJfgYj3566957
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560800502;
        bh=xgVgshx4TpccXfZmnpHVlig2Zznm6hmAtq7XqKoacJk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OC2Ksi8N10b/Bck9feKP58oyM8v+dXQJWeVSlWDbyJGoVhjwwJm8LXlrqU1G9puLK
         XZ2/utgKrxWjRnDPiSde3nPY0B7TxEAugILqtgndNttcwuPrA2CNzERPRvYieUuJ3c
         yozK6k2rJS+OkqV0VHSS1NDfnlYpS2Fpml47t/7xadU6h7m2yb0d/Dxl1OB3GnEJia
         Ic6a+6/OOqp5U8GWy7TrbRTRhjF0/bz9Owj6XY9QVyaqm/KBesniyvei4j3byX0Njl
         fs3JYvk/br75KY3bXSdyk2krKr6GSmnHFOEMjGiWi+HCNfushEPQItWVgjJ2LgImvA
         jIrIXZUeUUX9g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJfgi53566954;
        Mon, 17 Jun 2019 12:41:42 -0700
Date:   Mon, 17 Jun 2019 12:41:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-6492e5f013d9975d68528150edadead91e97a78a@git.kernel.org>
Cc:     yao.jin@linux.intel.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          yao.jin@linux.intel.com, acme@redhat.com, jolsa@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190604130017.31207-7-adrian.hunter@intel.com>
References: <20190604130017.31207-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Factor out intel_pt_reposition()
Git-Commit-ID: 6492e5f013d9975d68528150edadead91e97a78a
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

Commit-ID:  6492e5f013d9975d68528150edadead91e97a78a
Gitweb:     https://git.kernel.org/tip/6492e5f013d9975d68528150edadead91e97a78a
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:04 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:12 -0300

perf intel-pt: Factor out intel_pt_reposition()

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
