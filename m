Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438B2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F8A21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b7drFcih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfGCO0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:26:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:26:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EQLlU3326377
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:26:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EQLlU3326377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163982;
        bh=fa0CF/d8CONRYbFytMB5HTeYDpleS/xM0ICX7vM4W54=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=b7drFcihDkHuwGXnPmKSWFFQMWznCfVAM0I+QXW4TOr16JVgB+uA1RnLgwAg61SHH
         4I/ThV/krxagk0vjdC5RGejeWBken5P8K/rtjz9s+BZz1HfevH6na37kUTuwyJR8jq
         y0dE8IGVLT/7BaFz1lchW2xLiq/8tb29e70aFTx1pDs3W4UuARN+YmODvX1w3Ohc1C
         6vfqyxyh6463ZwVWteKHjyAhZbL6zIKl+xXHJemkTUKhvHis2/QupWs9CNz8CbjhaQ
         pyI/dhaa6h4cv12FwB6ySMw1cXeNWBIMSO1lPOy25G+UQBikoQBAgAPeB77vW+db5x
         rzCDfLklSKPkQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EQKvF3326374;
        Wed, 3 Jul 2019 07:26:20 -0700
Date:   Wed, 3 Jul 2019 07:26:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-oyi6zif3810nwi4uu85odnhv@git.kernel.org>
Cc:     acme@redhat.com, adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, namhyung@kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Drop strxfrchar(), use strreplace()
 equivalent from kernel
Git-Commit-ID: af0de0c5f060b1d4eae6033043eb9eafd15aa738
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  af0de0c5f060b1d4eae6033043eb9eafd15aa738
Gitweb:     https://git.kernel.org/tip/af0de0c5f060b1d4eae6033043eb9eafd15aa738
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 12:45:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:40 -0300

perf tools: Drop strxfrchar(), use strreplace() equivalent from kernel

No change in behaviour intended, just reducing the codebase and using
something available in tools/lib/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-oyi6zif3810nwi4uu85odnhv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c     |  3 ++-
 tools/perf/util/string.c  | 18 ------------------
 tools/perf/util/string2.h |  1 -
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 1fb18292c2d3..c7fde04400f7 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/bug.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <sys/types.h>
@@ -394,7 +395,7 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 				return -ENOMEM;
 		}
 
-		strxfrchar(m->name, '-', '_');
+		strreplace(m->name, '-', '_');
 	}
 
 	return 0;
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 93a5340424df..9b7fbb0cbecd 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -300,24 +300,6 @@ int strtailcmp(const char *s1, const char *s2)
 	return 0;
 }
 
-/**
- * strxfrchar - Locate and replace character in @s
- * @s:    The string to be searched/changed.
- * @from: Source character to be replaced.
- * @to:   Destination character.
- *
- * Return pointer to the changed string.
- */
-char *strxfrchar(char *s, char from, char to)
-{
-	char *p = s;
-
-	while ((p = strchr(p, from)) != NULL)
-		*p++ = to;
-
-	return s;
-}
-
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
 {
 	/*
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 6da835ad8f5b..2696c3fcd780 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -21,7 +21,6 @@ static inline bool strisglob(const char *str)
 	return strpbrk(str, "*?[") != NULL;
 }
 int strtailcmp(const char *s1, const char *s2);
-char *strxfrchar(char *s, char from, char to);
 
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
