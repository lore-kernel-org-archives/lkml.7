Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC347C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4766214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfCLDwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:52:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:58135 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfCLDw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:52:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 20:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,469,1544515200"; 
   d="scan'208";a="151466441"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 11 Mar 2019 20:52:29 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 50957301E31; Mon, 11 Mar 2019 20:52:29 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/3] perf, tools, report: Set up samples correctly in hierarchy mode
Date:   Mon, 11 Mar 2019 20:52:24 -0700
Message-Id: <20190312035224.30350-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312035224.30350-1-andi@firstfloor.org>
References: <20190312035224.30350-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In hierarchy mode the res samples need to be cloned from the parent
entry. Copy them in this case. This fixes res sample browsing
with --hierarchy.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/hist.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 1f230285d78a..dcf24581dfbd 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -437,8 +437,15 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 
 	if (symbol_conf.res_sample) {
-		he->res_samples = calloc(sizeof(struct res_sample),
-					symbol_conf.res_sample);
+		if (he->res_samples) {
+			he->res_samples = memdup(he->res_samples,
+						sizeof(struct res_sample) *
+						symbol_conf.res_sample);
+		} else {
+			he->res_samples = calloc(sizeof(struct res_sample),
+						 symbol_conf.res_sample);
+			he->num_res = 0;
+		}
 		if (!he->res_samples)
 			goto err_srcline;
 	}
-- 
2.20.1

