Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB55C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39712208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221182;
	bh=7FAW7vk51GdQWiCZOgAWfFUmSANBHzF6YiSIxdESRF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iEVyX/KB+PHzvNA5sQVe+0P/zarOseGN95cr9ONQ7svFyLFNxGm6tq0TBhKLHVMXw
	 fqscQGNKAdKbU/aGnTwwJIUKDYI//hmlWCdysXH22VqH8PM2laUrcX2855yVUad5aD
	 6I0FJJCcoaKQqjXuksVWU3GfDBiQRDBvwcdFx5q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfDBQGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbfDBQGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:19 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DB32084C;
        Tue,  2 Apr 2019 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221179;
        bh=7FAW7vk51GdQWiCZOgAWfFUmSANBHzF6YiSIxdESRF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4DtWMJrpTk2v59X+z5Torhb45DTtg041IKobA4XEv51sjqbjc//ke8voebbiWdrf
         IW+Hi4Cn6G/Vbbi7ZUgmYp/KfCOb5H9hqvqCU00XdZr486fzVYv0jggmCHKLew1pMN
         lDvyfJPbW7/poSKSEI54JWWvEJgV7nOn9DvPsdTI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCH 05/44] perf tools: Add header defining used namespace struct to event.h
Date:   Tue,  2 Apr 2019 13:05:10 -0300
Message-Id: <20190402160549.13544-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When adding the 'struct namespaces_event' to event.h, referencing the
'struct perf_ns_link_info' type, we forgot to add the header where it is
defined, getting that definition only by sheer luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: f3b3614a284d ("perf tools: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: https://lkml.kernel.org/n/tip-qkrld0v7boc9uabjbd8csxux@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 36ae7e92dab1..4e908ec1ef64 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <linux/kernel.h>
 #include <linux/bpf.h>
+#include <linux/perf_event.h>
 
 #include "../perf.h"
 #include "build-id.h"
-- 
2.20.1

