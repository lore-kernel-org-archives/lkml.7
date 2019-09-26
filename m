Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF7FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4FD222C1
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458199;
	bh=l7hVkk55ioRsjqiI+2pYsI5Fo1yfzSoJs+18iwTNJnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RAs2pBDbEaQZntJ32X7hpVITcAQ7DQ0oJ2FyMFwAl7dZucabxxSW1ZjaOp2nmAaCW
	 Wk/f7aIQtcNQiIMpq90nuy+EnB/OXP35GXaZtdItvWFTcE6oIU8Apuu+dC8dHKVkVF
	 qqPDdufOs5FUWtxWFnuJ4nGPAQsCBvyJ0O3/WVvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbfIZAgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390637AbfIZAge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:34 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A790421D7B;
        Thu, 26 Sep 2019 00:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458193;
        bh=l7hVkk55ioRsjqiI+2pYsI5Fo1yfzSoJs+18iwTNJnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiTZ0yCJPpYuuD9jESm3MLyPtjZ6T4NlT0mAYeAd9/KaMNOBLI4p5Z1SQGaH8jQaD
         F8WKY4kMn7UgYRPynBcs7JajWe00QgOpLivcggfz6nvzJsE5WKuvPQtmrkhhshZXST
         VyKXYvSEgf+L8sXkZakh30qVw7JMQ1bvPVvVLoQk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 60/66] perf tools: Replace needless mmap.h with what is needed, event.h
Date:   Wed, 25 Sep 2019 21:32:38 -0300
Message-Id: <20190926003244.13962-61-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The perf_sample struct definition and the event_attr_init() are in
util/event.h, but some places were getting it thru an otherwise needless
util/mmap.h header, fix it by including util/event.h directly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p1anwyjdbbvghrkl9dlxv7h5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c     | 2 +-
 tools/perf/util/parse-events.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 69d0a1991b29..e830eadfca2a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -34,7 +34,7 @@
 #include "bpf-event.h"
 #include "block-range.h"
 #include "string2.h"
-#include "util/mmap.h"
+#include "util/event.h"
 #include "arch/common.h"
 #include <regex.h>
 #include <pthread.h>
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 50737046fa63..b5e2adef49de 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -35,7 +35,7 @@
 #include "util/parse-branch-options.h"
 #include "metricgroup.h"
 #include "util/evsel_config.h"
-#include "util/mmap.h"
+#include "util/event.h"
 
 #define MAX_NAME_LEN 100
 
-- 
2.21.0

