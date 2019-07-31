Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F76C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1B6206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfGaObo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:31:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:50163 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbfGaObk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:31:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 07:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="183704284"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2019 07:31:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 7/7] perf intel-pt: Add brief documentation for PEBS via Intel PT
Date:   Wed, 31 Jul 2019 17:30:41 +0300
Message-Id: <20190731143041.64678-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731143041.64678-1-alexander.shishkin@linux.intel.com>
References: <20190731143041.64678-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Document how to select PEBS via Intel PT and how to display synthesized
PEBS samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/Documentation/intel-pt.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index 50c5b60101bd..8c40f898685b 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -919,3 +919,18 @@ amended to take the number of elements as a parameter.
 
 Note there is currently no advantage to using Intel PT instead of LBR, but
 that may change in the future if greater use is made of the data.
+
+
+PEBS via Intel PT
+=================
+
+Some hardware has the feature to redirect PEBS records to the Intel PT trace.
+Recording is selected by using the aux-source config term e.g.
+
+	perf record  -c 10000 -e cycles/aux-source/ppp -e intel_pt/branch=0/ uname
+
+Note that currently, software only supports redirecting at most one PEBS event.
+
+To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
+
+	perf script --itrace=oe
-- 
2.20.1

