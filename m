Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7EBC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ACC21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PbTxhM/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfGCO2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:28:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59579 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGCO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:28:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63ERoKX3326835
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:27:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63ERoKX3326835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164070;
        bh=wU1K/XwJMno8cHqoLmV+jJjjpGSNVErjtRupzb4JzlA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PbTxhM/Yik0bGYQIzm4AvQBIkHDob2wQUN/Kw9FlGEvqWqE4Zasu7jELanqLU4tpz
         v6oFzQ7OGvlFmLU6plCvx5QfT7509ES0nDOVaX+xDYrnFhuW4we85jIkzVKwyNoCHB
         JE09Oyz5V+KKbpKnDLoJH5dGmEWdyP8DjgUWd2ECgWeLOzQmhKQ7+ikmw1xM93eCAh
         xsx1vk//zDl6gURoWCwYPVDGm2faallrc0lsD/LAwLcO7XFlALJHcxzMkWP55YieSA
         3Kw1RBurhDfvQYtTiTMuZHWUQLksAbuPKclNxDNQXE7CAHMfmZ0+63zANa0Yqct+Z9
         Fkep0o1bp54lw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63ERnJ63326832;
        Wed, 3 Jul 2019 07:27:49 -0700
Date:   Wed, 3 Jul 2019 07:27:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-145c407c808352acd625be793396fd4f33c794f8@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, kan.liang@linux.intel.com, jolsa@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          acme@redhat.com, ak@linux.intel.com
In-Reply-To: <20190624193711.35241-2-andi@firstfloor.org>
References: <20190624193711.35241-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Make metric event lookup more robust
Git-Commit-ID: 145c407c808352acd625be793396fd4f33c794f8
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

Commit-ID:  145c407c808352acd625be793396fd4f33c794f8
Gitweb:     https://git.kernel.org/tip/145c407c808352acd625be793396fd4f33c794f8
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 24 Jun 2019 12:37:08 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:41 -0300

perf stat: Make metric event lookup more robust

After setting up metric groups through the event parser, the metricgroup
code looks them up again in the event list.

Make sure we only look up events that haven't been used by some other
metric. The data structures currently cannot handle more than one metric
per event. This avoids problems with multiple events partially
overlapping.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: http://lkml.kernel.org/r/20190624193711.35241-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 027b09aaa4cf..3f8fd127d31e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -304,7 +304,7 @@ static struct perf_evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
 	struct perf_evsel *c2;
 
 	evlist__for_each_entry (evsel_list, c2) {
-		if (!strcasecmp(c2->name, name))
+		if (!strcasecmp(c2->name, name) && !c2->collect_stat)
 			return c2;
 	}
 	return NULL;
@@ -343,7 +343,8 @@ void perf_stat__collect_metric_expr(struct perf_evlist *evsel_list)
 			if (leader) {
 				/* Search in group */
 				for_each_group_member (oc, leader) {
-					if (!strcasecmp(oc->name, metric_names[i])) {
+					if (!strcasecmp(oc->name, metric_names[i]) &&
+						!oc->collect_stat) {
 						found = true;
 						break;
 					}
