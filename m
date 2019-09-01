Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149F9C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC96323711
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340716;
	bh=SxomPdPvcsHyUqw4E9+XZXEAc/m/TCirHyXlotPyxrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oxFyJmOEK0d1pnEP8GRyOKw18mPlbOvOTMAXrFwFHOBaLoBU+pVgDxqEW2lLDRrT5
	 TYoLJENqDC41f+vejL1cStI6C6Jm2nvpi0lYKAesOfiR/4v2l23sHpLDkQXsND7JgS
	 Wfk5QAiJJiDHZTkNNv+gM+GgGAC1kFNq6AzHQaOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfIAMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbfIAMZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A2A921897;
        Sun,  1 Sep 2019 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340711;
        bh=SxomPdPvcsHyUqw4E9+XZXEAc/m/TCirHyXlotPyxrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vykMSgEuQ+cBJDX/xS0LAgRHsPCPjV2qCvKi8qcf89IntgE0lwe9ANUSZfCuoeMjl
         56Lh5XTfEIPtMrSODf4Rnb/HjxnR/HwBVZq9YstniQF4i3shwbE2kug2vCu6T34kgn
         lrQPJjFxoewm4JzuAQ8ukCkxpX53RnGnUCZO3/aU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 33/47] perf tools: Remove needless thread_map.h include directives
Date:   Sun,  1 Sep 2019 09:23:12 -0300
Message-Id: <20190901122326.5793-34-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that thread_map.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fyzvg64cz1ikvyxp8d6nrhz1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 1 -
 tools/perf/builtin-top.c          | 1 -
 tools/perf/util/cs-etm.c          | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 197041fcba25..59e44f90dc46 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -24,7 +24,6 @@
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
 #include "../../util/pmu.h"
-#include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 #include "../../util/util.h"
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index eb941213fa0c..726e3f2dd8c7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -32,7 +32,6 @@
 #include "util/map.h"
 #include "util/session.h"
 #include "util/symbol.h"
-#include "util/thread_map.h"
 #include "util/top.h"
 #include "util/util.h"
 #include <linux/rbtree.h>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3ed1d3bb7089..30c2048ce67d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -30,7 +30,6 @@
 #include "symbol.h"
 #include "tool.h"
 #include "thread.h"
-#include "thread_map.h"
 #include "thread-stack.h"
 #include <tools/libc_compat.h>
 #include "util.h"
-- 
2.21.0

