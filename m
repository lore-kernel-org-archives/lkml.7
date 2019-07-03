Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD71218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QVisEJIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGCOUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:20:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:20:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EJEIp3323439
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:19:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EJEIp3323439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163555;
        bh=l+g9MQ1EnvRuflAwRD4OCi1i8pjHcUmnIYmOhq0xwEU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=QVisEJIZT631+BzcWaaYCPhZWLFh0bUu9p7tfhry7kIFjXYITdi7KMUH5VHZEiO/f
         sdm+Whqo29H3FelYcqlkHIkt37+dGoV1T36Uu8bQzww49HwaKu/Ay/kLIQtg3KWmJj
         mQ8/LPWiFtdIPPZoD+0xLrex5TSxRny1LoDjaePOAyGRKi0/AFqyTFunRWoDTxTVPH
         iuBASAQaQ13KQGBexJ3Wfe2ytlzxs2XFwRMOco5s7ws7WVTV7d6AhaLI2He021BfjD
         hhR3h625HJQ9PQf7stJaJ5730yxeqorV/Lg8QNybEnl9zmRTAE8YZJBUsxYIhEbaLX
         kPf2IFgIN0O7A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EJDNY3323432;
        Wed, 3 Jul 2019 07:19:13 -0700
Date:   Wed, 3 Jul 2019 07:19:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-cpugv7qd5vzhbtvnlydo90jv@git.kernel.org>
Cc:     hpa@zytor.com, yao.jin@linux.intel.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        jolsa@kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, yao.jin@linux.intel.com, jolsa@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, dsahern@gmail.com,
          namhyung@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Use skip_spaces()
Git-Commit-ID: 9bb5a27ac7958ce11cb02463b5a5f7f160d60916
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

Commit-ID:  9bb5a27ac7958ce11cb02463b5a5f7f160d60916
Gitweb:     https://git.kernel.org/tip/9bb5a27ac7958ce11cb02463b5a5f7f160d60916
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 21:39:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 21:39:18 -0300

perf time-utils: Use skip_spaces()

No change in behaviour intended.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cpugv7qd5vzhbtvnlydo90jv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 369fa19dd596..c2abc259b51d 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <string.h>
+#include <linux/string.h>
 #include <sys/time.h>
 #include <linux/time64.h>
 #include <time.h>
@@ -141,10 +142,7 @@ static int perf_time__parse_strs(struct perf_time_interval *ptime,
 	for (i = 0, p = str; i < num - 1; i++) {
 		arg = p;
 		/* Find next comma, there must be one */
-		p = strchr(p, ',') + 1;
-		/* Skip white space */
-		while (isspace(*p))
-			p++;
+		p = skip_spaces(strchr(p, ',') + 1);
 		/* Skip the value, must not contain space or comma */
 		while (*p && !isspace(*p)) {
 			if (*p++ == ',') {
