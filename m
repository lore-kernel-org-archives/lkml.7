Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC3AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE33206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nzBTjrdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfFQS7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:59:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFQS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:59:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIxBS23554018
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:59:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIxBS23554018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797952;
        bh=QRqh2XgDzqcDpW5BriSi6D5i2AlvfxMt1vZHGgT410g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nzBTjrdw3L8S+/L3m9oHNzkgZUqzNTKnUjXThYOVOOD2/0Zz3cq1PA4iq52mnbFZb
         vBPlpMARmOAfVk7LgCchTh13BRqDUw5hUsQojLDjlZ5iltAA5UyPHTANBXE0sIpJzi
         eMnik3xg3frmYV0/6LqS9zHTdn8xdcw1XHzL85eHRmg/K8Sy06Bq6RJe2SkbeeaOUh
         KkZAA8u/2D16mFYJ9i+rS3PYt+3Q3Q+/NN+tfw/dyrT33NY6HTK8u1gKlPm0UbhBXG
         yBAnoGjmMVM5sCreIVhyKUFlDTOZ1ofWvSltK8bSyC35V9J9XltG8bmuBox7zavP78
         s53e/8mzk5Aeg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIxBEx3554015;
        Mon, 17 Jun 2019 11:59:11 -0700
Date:   Mon, 17 Jun 2019 11:59:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-948e9dc8bb266649a618ac974010292bf36fb213@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          jolsa@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
          hpa@zytor.com
In-Reply-To: <20190520113728.14389-5-adrian.hunter@intel.com>
References: <20190520113728.14389-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Factor out
 intel_pt_update_sample_time
Git-Commit-ID: 948e9dc8bb266649a618ac974010292bf36fb213
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

Commit-ID:  948e9dc8bb266649a618ac974010292bf36fb213
Gitweb:     https://git.kernel.org/tip/948e9dc8bb266649a618ac974010292bf36fb213
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:10 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:54 -0300

perf intel-pt: Factor out intel_pt_update_sample_time

To eliminate some duplication and make the code more understandable,
factor out intel_pt_update_sample_time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 18 ++++++++++--------
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
