Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A5F21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WjNUtNjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfGCOSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:18:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCOSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:18:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EIVxO3323338
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:18:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EIVxO3323338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163512;
        bh=8xsTt3uqZERadWIavQP7O7dZE77NCzBPlqMH0fFV2Dg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=WjNUtNjtBuS1XhdExT1QNP5ZwiTrt1eXm311NfHL9LICfwunH//DSOBp4CpFGS13z
         198hIX+vH2JxaemuyX40YMM6sv6ItkTrDp6Zf67Y7SXTpBPwYV4slcFj3lBYJdtP6Q
         IsHWlZeqrS2jdw5okEyrbBDiw4ElOHLNMk99Ls/TXjwkH1HZfS/Mbj/jyu9svSp//5
         BKumebJdujPqsQ/JsSt04GOIsWf03ksNScx/EqHCAHvDSkOiY6dCuUjXUVZ6rVqbSk
         3j2234o/FwtU2tw6aedksOgPFAWAh0lWJm5Dd1W9e6k00BtuCrCyITl+k7tXpc/Dlv
         BW9qEsTMjq2mw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EIV583323335;
        Wed, 3 Jul 2019 07:18:31 -0700
Date:   Wed, 3 Jul 2019 07:18:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0dbfpi70aa66s6mtd8z6p391@git.kernel.org>
Cc:     eranian@google.com, namhyung@kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          namhyung@kernel.org, mingo@kernel.org, eranian@google.com,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Use skip_spaces() in __write_cpudesc()
Git-Commit-ID: fc6a172600cd54e9b4efeb684daa8464991b6c26
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

Commit-ID:  fc6a172600cd54e9b4efeb684daa8464991b6c26
Gitweb:     https://git.kernel.org/tip/fc6a172600cd54e9b4efeb684daa8464991b6c26
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 21:33:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 21:34:31 -0300

perf header: Use skip_spaces() in __write_cpudesc()

No change in behaviour.

Cc: Stephane Eranian <eranian@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0dbfpi70aa66s6mtd8z6p391@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fca9dbaf61ae..1eb15f7517b0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
@@ -416,10 +417,8 @@ static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 	while (*p) {
 		if (isspace(*p)) {
 			char *r = p + 1;
-			char *q = r;
+			char *q = skip_spaces(r);
 			*p = ' ';
-			while (*q && isspace(*q))
-				q++;
 			if (q != (p+1))
 				while ((*r++ = *q++));
 		}
