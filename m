Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C370DC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6A208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MHAOU+Xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfFVGmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:42:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48679 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:42:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6gJ9P2006463
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:42:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6gJ9P2006463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185740;
        bh=q89IqUXrL6XcfvGSMIPMqy5ferCUkxcSV+Zh9VjqR6A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MHAOU+XczOLWCh499XBNS/6Xy4pOsk4O31LbkLlpnpXLzJyxK8FgQyTIUsceBeVTx
         yZ+Jvvb0Io9kDbfvgkg1LdEpv/978Y9k37Ny4CpJKqiy4rRDI+shoRRW3x8m8Z8FqL
         AJjOsdRlU1BmRSYVs7/6lITFg7hTPE3IKE51rh4SFMSdAV/crwjKp4BAR+5BAqAYiU
         nZFfGI3nV+UeeNFLDgxU52Hm/tLGwztB9B9TDiY5UO6SeE0qkxON0fYfpcFmrYUkrs
         PvTOsRl/qgG5RRClI0y2MszV3udppzU/WwpS9UW7yitQ4BaZBvAJPewIREtDv2poMQ
         IjI9e98ckwkqA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6gJgA2006450;
        Fri, 21 Jun 2019 23:42:19 -0700
Date:   Fri, 21 Jun 2019 23:42:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-975846eddf907297aa036544545cd839c7c7dd31@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        hpa@zytor.com
Reply-To: jolsa@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190610072803.10456-11-adrian.hunter@intel.com>
References: <20190610072803.10456-11-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Add memory information to
 synthesized PEBS sample
Git-Commit-ID: 975846eddf907297aa036544545cd839c7c7dd31
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

Commit-ID:  975846eddf907297aa036544545cd839c7c7dd31
Gitweb:     https://git.kernel.org/tip/975846eddf907297aa036544545cd839c7c7dd31
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:28:02 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:18 -0300

perf intel-pt: Add memory information to synthesized PEBS sample

Add memory information from PEBS data in the Intel PT trace to the
synthesized PEBS sample. This provides sample types PERF_SAMPLE_ADDR,
PERF_SAMPLE_WEIGHT, and PERF_SAMPLE_TRANSACTION, but not
PERF_SAMPLE_DATA_SRC.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index db00c13dc36f..bf7647897e8a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1766,6 +1766,33 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		}
 	}
 
+	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
+		sample.addr = items->mem_access_address;
+
+	if (sample_type & PERF_SAMPLE_WEIGHT) {
+		/*
+		 * Refer kernel's setup_pebs_adaptive_sample_data() and
+		 * intel_hsw_weight().
+		 */
+		if (items->has_mem_access_latency)
+			sample.weight = items->mem_access_latency;
+		if (!sample.weight && items->has_tsx_aux_info) {
+			/* Cycles last block */
+			sample.weight = (u32)items->tsx_aux_info;
+		}
+	}
+
+	if (sample_type & PERF_SAMPLE_TRANSACTION && items->has_tsx_aux_info) {
+		u64 ax = items->has_rax ? items->rax : 0;
+		/* Refer kernel's intel_hsw_transaction() */
+		u64 txn = (u8)(items->tsx_aux_info >> 32);
+
+		/* For RTM XABORTs also log the abort code from AX */
+		if (txn & PERF_TXN_TRANSACTION && ax & 1)
+			txn |= ((ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
+		sample.transaction = txn;
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
