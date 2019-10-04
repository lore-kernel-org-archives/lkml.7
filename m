Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2573C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9064F215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbfJDIdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:33:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:57519 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730607AbfJDIcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:32:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:32:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="204236430"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2019 01:32:43 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf data: Correctly identify directory data files
Date:   Fri,  4 Oct 2019 11:31:17 +0300
Message-Id: <20191004083121.12182-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004083121.12182-1-adrian.hunter@intel.com>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to rename the "header" file to "data" without conflicting,
correctly identify the non-header files as starting with "data."

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 88fba2ba549f..8993253c5564 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -96,7 +96,7 @@ int perf_data__open_dir(struct perf_data *data)
 		if (stat(path, &st))
 			continue;
 
-		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data", 4))
+		if (!S_ISREG(st.st_mode) || strncmp(dent->d_name, "data.", 5))
 			continue;
 
 		ret = -ENOMEM;
-- 
2.17.1

