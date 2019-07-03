Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C85CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540DC21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LooM9Mmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfGCOVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:21:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:21:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63ELMvt3323943
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:21:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63ELMvt3323943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163683;
        bh=zPqhRTGu08XGjm36KmZWL9Y87AmN2NgNsl31/bmIUdg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=LooM9MmxJpPJZ6qmGJebnWOQ51YfnuYEdCCFKrzdIP3+w12314WyjowDaKCn/ZIVF
         dRrL6t8gaifpygTuRx+rvXY94nV6JIpqAZ0/zBQh8xo4Wt0qifaZ/GKSiQmDbtcwxu
         RTDIPH7w9qiO/R4eR/YWOuFPe4kn6LYR1UW1811PRNpunHArOLcLUH+jP9CTr37iH/
         4TxhtC4eMDfAttipbXHiurxvlcgRXVS0rlyNtw+KS1BzKX6ZVrOvIzfFgVaKWJnyFO
         8hdZ3/FyERorfB5NU6ghxOKjKVxLQtRYJtdvT362w+hfgsD8YMYBxdsaXdsokAd8wT
         aByVly5H64r3w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63ELMws3323940;
        Wed, 3 Jul 2019 07:21:22 -0700
Date:   Wed, 3 Jul 2019 07:21:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f2siadtp3hb5o0l1w7bvd8bk@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com, mingo@kernel.org,
        namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, jolsa@kernel.org
Reply-To: acme@redhat.com, namhyung@kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf metricgroup: Use strsep()
Git-Commit-ID: 80e9073f1f4473639d585b89ebc9130bb47920e8
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

Commit-ID:  80e9073f1f4473639d585b89ebc9130bb47920e8
Gitweb:     https://git.kernel.org/tip/80e9073f1f4473639d585b89ebc9130bb47920e8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 11:21:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 26 Jun 2019 11:31:43 -0300

perf metricgroup: Use strsep()

No change in behaviour intended, trivial optimization done by avoiding
looking for spaces in 'g' right after setting it to "No_group".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f2siadtp3hb5o0l1w7bvd8bk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a0cf3cd95ced..90cd84e2a503 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -308,10 +308,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 				struct mep *me;
 				char *s;
 
+				g = skip_spaces(g);
 				if (*g == 0)
 					g = "No_group";
-				while (isspace(*g))
-					g++;
 				if (filter && !strstr(g, filter))
 					continue;
 				if (raw)
