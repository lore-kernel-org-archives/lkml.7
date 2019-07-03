Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511ABC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235D7218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cjfUFey0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGCOFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:05:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58239 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGCOFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:05:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E5YZv3320666
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:05:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E5YZv3320666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162735;
        bh=PBFOKzUnNC8PxxMDAAegv83NGQsMe8vNqVx0vPrYY9o=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cjfUFey022QGv4plafgCUChIV3RTx2qlYlmWnFsyHUKxOKPvePzGQ6Or/tvP+6iKV
         q5HIBiG2KAdF/enwSdkhwvhKy6vE28xGKTScK3LrCtpF0fk0nV6UqHj0XMzwo2lx+P
         EekFMubM/dmogTs9ptE/ZZJ0ExVg8NDLDDiFaDshLtHFRsMTtI80MZJBh3ALDt3635
         PB3sadmEH5p6d/O8BKQdf8+Stybt9hNFk8rn1IVGst61FCSaPq263oPedJCJyKMSk0
         K5ZWSrsS3tbA8qFz9hWhyHPySOK8T4umAZZUIPzRH1hVOlN0LrQe24fUY6tTxeIWGQ
         vwSwEg6Rwfryg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E5YXv3320661;
        Wed, 3 Jul 2019 07:05:34 -0700
Date:   Wed, 3 Jul 2019 07:05:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-51b091861828f5801207a00211ea4e94102389c3@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, acme@redhat.com,
          hpa@zytor.com
In-Reply-To: <20190622093248.581-4-adrian.hunter@intel.com>
References: <20190622093248.581-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add CBR value to decoder state
Git-Commit-ID: 51b091861828f5801207a00211ea4e94102389c3
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

Commit-ID:  51b091861828f5801207a00211ea4e94102389c3
Gitweb:     https://git.kernel.org/tip/51b091861828f5801207a00211ea4e94102389c3
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sat, 22 Jun 2019 12:32:44 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf intel-pt: Add CBR value to decoder state

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
