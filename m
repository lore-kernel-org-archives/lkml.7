Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2071C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B801C2054F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124558;
	bh=PneQkg/1LoiWhbHo/3kRwa199moyjmS6osDZ1+b+hS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fgzSmdwwEW3v6TxlS2nOLXMYDOzDOvmCGVf1yhyiYtsgeskpBmBTNCl7kZ1UbdMXf
	 q3hHFWRpSgs64pTR8bwIsoFS2S1nVpfeF2pcJZhegkxfox/lQ0MKnBJnxKwtiQvev3
	 HR4f/KkJTxyJKjGOtRqRxx6Aos6Rox7qgTWj73bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfGCD3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfGCD3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:29:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D077218B6;
        Wed,  3 Jul 2019 03:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124539;
        bh=PneQkg/1LoiWhbHo/3kRwa199moyjmS6osDZ1+b+hS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kvd+ENDB7zDqW2Ebb0df8TU5h7q7TI/vwu2+wQFaLnHAY8ORUcvHD9Ck8VpaF+FQU
         +vAiNDdbt9+E/1fVg775cgDCnM1RgDFJtrfT9jrGsIj1dPwde80nZpsyEkCS98cXSU
         cUEMt1yDkxVGW1oTWgqrMd42duFX4WFk7ibgfM/8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/18] perf tools metric: Don't include duration_time in group
Date:   Wed,  3 Jul 2019 00:27:44 -0300
Message-Id: <20190703032746.21692-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The Memory_BW metric generates groups including duration_time, which
maps to a software event.

For some reason this makes the group always not count.

Always put duration_time outside a group when generating metrics.  It's
always the same time, so no need to group it.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220737.13259-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7d36435fa84c..d8164574cb16 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -409,6 +409,7 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 			const char **ids;
 			int idnum;
 			struct egroup *eg;
+			bool no_group = false;
 
 			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
 
@@ -419,11 +420,25 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
 				strbuf_addf(events, ",");
 			for (j = 0; j < idnum; j++) {
 				pr_debug("found event %s\n", ids[j]);
+				/*
+				 * Duration time maps to a software event and can make
+				 * groups not count. Always use it outside a
+				 * group.
+				 */
+				if (!strcmp(ids[j], "duration_time")) {
+					if (j > 0)
+						strbuf_addf(events, "}:W,");
+					strbuf_addf(events, "duration_time");
+					no_group = true;
+					continue;
+				}
 				strbuf_addf(events, "%s%s",
-					j == 0 ? "{" : ",",
+					j == 0 || no_group ? "{" : ",",
 					ids[j]);
+				no_group = false;
 			}
-			strbuf_addf(events, "}:W");
+			if (!no_group)
+				strbuf_addf(events, "}:W");
 
 			eg = malloc(sizeof(struct egroup));
 			if (!eg) {
-- 
2.20.1

