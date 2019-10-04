Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD4EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD4E215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfJDIcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:32:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:57519 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730489AbfJDIcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:32:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 01:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,255,1566889200"; 
   d="scan'208";a="204236439"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2019 01:32:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf data: Move perf_dir_version into data.h
Date:   Fri,  4 Oct 2019 11:31:18 +0300
Message-Id: <20191004083121.12182-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004083121.12182-1-adrian.hunter@intel.com>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_dir_version belongs to struct perf_data which is declared in data.h.
To allow its use in inline perf_data functions, move perf_dir_version to
data.h

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/data.h   | 4 ++++
 tools/perf/util/header.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 259868a39019..218fe9a16801 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -9,6 +9,10 @@ enum perf_data_mode {
 	PERF_DATA_MODE_READ,
 };
 
+enum perf_dir_version {
+	PERF_DIR_VERSION	= 1,
+};
+
 struct perf_data_file {
 	char		*path;
 	int		 fd;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ca53a929e9fd..840f95cee349 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -52,10 +52,6 @@ enum perf_header_version {
 	PERF_HEADER_VERSION_2,
 };
 
-enum perf_dir_version {
-	PERF_DIR_VERSION	= 1,
-};
-
 struct perf_file_section {
 	u64 offset;
 	u64 size;
-- 
2.17.1

