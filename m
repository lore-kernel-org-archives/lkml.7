Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774CC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BE4206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfDLLkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:40:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:12723 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfDLLkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:40:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 04:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="336687261"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2019 04:39:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
Date:   Fri, 12 Apr 2019 14:38:30 +0300
Message-Id: <20190412113830.4126-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412113830.4126-1-adrian.hunter@intel.com>
References: <20190412113830.4126-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning 1 from intel_pt_sync_switch() causes the current tid to be
set. That negates the need to keep next_tid anymore. Rationalize the code
to that effect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index deaf2888dc55..551ae10d1c7b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1859,7 +1859,6 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 
 	switch (ptq->switch_state) {
 	case INTEL_PT_SS_NOT_TRACING:
-		ptq->next_tid = -1;
 		break;
 	case INTEL_PT_SS_UNKNOWN:
 	case INTEL_PT_SS_TRACING:
@@ -1879,13 +1878,14 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 		ptq->switch_state = INTEL_PT_SS_TRACING;
 		break;
 	case INTEL_PT_SS_EXPECTING_SWITCH_IP:
-		ptq->next_tid = tid;
 		intel_pt_log("ERROR: cpu %d expecting switch ip\n", cpu);
 		break;
 	default:
 		break;
 	}
 
+	ptq->next_tid = -1;
+
 	return 1;
 }
 
-- 
2.17.1

