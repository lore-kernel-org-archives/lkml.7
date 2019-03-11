Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E2CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1DE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfCKOpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:45:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:29004 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbfCKOpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:45:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 07:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="153966028"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2019 07:45:10 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0C8A2301B8D; Mon, 11 Mar 2019 07:45:10 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 02/11] perf tools report: Parse time quantum
Date:   Mon, 11 Mar 2019 07:44:53 -0700
Message-Id: <20190311144502.15423-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311144502.15423-1-andi@firstfloor.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Many workloads change over time. perf report currently aggregates
the whole time range reported in perf.data.

This patch adds an option for a time quantum to quantisize the
perf.data over time.

This just adds the option, will be used in follow on patches
for a time sort key.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Move time_quantum to symbol_conf. check for zero time quantum
v3:
Document s unit
v4:
Use _NSEC defines
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 6b73a0eeb6a1..967066d4d899 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -30,6 +30,7 @@
 #include <elf.h>
 #include <limits.h>
 #include <symbol/kallsyms.h>
+#include <linux/time64.h>
 #include <sys/utsname.h>
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
-- 
2.20.1

