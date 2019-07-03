Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E678C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3493021871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ItKs2zFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGCOn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:43:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGCOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:43:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EhCQm3330021
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:43:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EhCQm3330021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164992;
        bh=qVHxPPQLx2W0sf2Ej76La+KW6HUyFCBJviNp1NSLF14=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ItKs2zFyHy9P6j74Yadlx1jsRwMC7Y1ZwBBpZQEIrC/296vCm644HRGt7Bs8xbemq
         CwENqK7eKhl15BZzzuau4ThXUI0MiVVCfMADZKZhOxVG4Cg8kvJxxTtCm+4w00LN3P
         ydtWT65yxvwGhMbUvKlBXNUt8LbgeZkJMUgAZm2zPa2ClK5pn4xb18sRa5MFavCn/W
         SEbG7m5pln4rmZaJzDG9OIGHxEYXkcxQE5cPuF9tnct2USBjXpoC3njJQRa/5Yw5hy
         fP4l3qbTgFWRZpV2JdABDbIqToFgotoD/K1bGt9vD5oMaRo6BeWQKgTHjTqa/yrsAM
         7BELzg8Z3AqhQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EhB9Z3330018;
        Wed, 3 Jul 2019 07:43:11 -0700
Date:   Wed, 3 Jul 2019 07:43:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-488c3bf7ece89e47887607863207021283e37828@git.kernel.org>
Cc:     mingo@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, acme@redhat.com, jolsa@kernel.org,
        hpa@zytor.com
Reply-To: jolsa@kernel.org, tglx@linutronix.de, ak@linux.intel.com,
          mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190628220737.13259-3-andi@firstfloor.org>
References: <20190628220737.13259-3-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools metric: Don't include duration_time in
 group
Git-Commit-ID: 488c3bf7ece89e47887607863207021283e37828
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

Commit-ID:  488c3bf7ece89e47887607863207021283e37828
Gitweb:     https://git.kernel.org/tip/488c3bf7ece89e47887607863207021283e37828
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 15:07:37 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:08:16 -0300

perf tools metric: Don't include duration_time in group

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
