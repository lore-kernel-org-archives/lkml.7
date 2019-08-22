Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92C1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C70B23406
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507733;
	bh=2DrlLcTd1l3Twm/SjC+AGH+HYuDLsHGaxsl6OvmAqwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l18flOHacxahdbrITGkV6V4r0ZNlfXH2xQZygYP/y6uXnJJ5Z2zRLbeL6ca5FVfgM
	 S42TkQRx4SpKfmrJzOSuSHTDV4FVdG505C16w9IOzXWIfj0UyIsBtZ/bBWo71hZSuy
	 9J74tEkBFnniijGDbb2hmnq6byZn+5txbllAq5Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393459AbfHVVCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393445AbfHVVCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:09 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACBD23404;
        Thu, 22 Aug 2019 21:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507728;
        bh=2DrlLcTd1l3Twm/SjC+AGH+HYuDLsHGaxsl6OvmAqwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUX3v2fSjwYOqSt7BNPeGwyufytL8bLdxZwPV+vdaa9S9RUTKHbLhsl9vozqNJ23v
         rSjy8iLNk4DkUZjICUlM7L3UOv/OwGJf9yZNuktwRZRsX/Kw3Qw4/MpOYsBYH+woLu
         du1h93g28OWHHUXJRCZrFXmyEK77NYYabTrC3koc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/25] perf stat: Add missing counts.h
Date:   Thu, 22 Aug 2019 18:00:49 -0300
Message-Id: <20190822210100.3461-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is getting this via evsel.h, that don't strictly need counts.h, just
forward declarations for some structs, so add it here before we remove
it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jwcbm9gv9llloe3he5qkdefs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 1 +
 tools/perf/util/stat.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3df0e39ccd52..605a1fdbda7a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -4,6 +4,7 @@
 #include <linux/time64.h>
 #include <math.h>
 #include "color.h"
+#include "counts.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "stat.h"
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 2715112290cf..1e6a25abe00f 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
+#include "counts.h"
 #include "stat.h"
 #include "evlist.h"
 #include "evsel.h"
-- 
2.21.0

