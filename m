Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF5C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADAD272B3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OIkuKoL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfFCN22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:28:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:28:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DSHA9609665
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:28:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DSHA9609665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568498;
        bh=gbQJThFwkE8MxLw8eOWCZ4O/ukMLlgODAsDr5hpi4vk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OIkuKoL6ugK9agu+eMEchfRk2JdnyUAbLwjlRiF82/52ETt30KZHcCXiGpJIVPmhl
         KNpqTt7poOSreAZavGsMXlQxooBmxzZNogX04jqdJrt1XDt8c/VBbRbW+TEDsalJP1
         3Gw8p4Ns80ihqhqDt78IOe8jFwOa2Wxtf2jpo0rAECY5JkBx+nuwphtc3RnF5+x3Wq
         EShLhKeZ35SwQpppZx7VtN2O7sANCe3zT7gR1IIqppgyj0Fqg5KGLWovwldI5yUeE+
         ywnFAPVX2cwNuBnOZIk1Y312Sw7MBYQreqfNp/RldXqVpjCG6Nn/8tEFQOwNSZ8x+n
         1C6sqZUpsF2xw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DSGQC609662;
        Mon, 3 Jun 2019 06:28:16 -0700
Date:   Mon, 3 Jun 2019 06:28:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-3d5672735b2348f5b13679a27f90c0847d22125d@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        mingo@kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          gregkh@linuxfoundation.org, tglx@linutronix.de, acme@kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          jolsa@kernel.org
In-Reply-To: <20190512155518.21468-6-jolsa@kernel.org>
References: <20190512155518.21468-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Add is_visible attribute_group callback
 for base events
Git-Commit-ID: 3d5672735b2348f5b13679a27f90c0847d22125d
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

Commit-ID:  3d5672735b2348f5b13679a27f90c0847d22125d
Gitweb:     https://git.kernel.org/tip/3d5672735b2348f5b13679a27f90c0847d22125d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 12 May 2019 17:55:14 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:58:23 +0200

perf/x86: Add is_visible attribute_group callback for base events

We dont need to pre-filter out unsupported base events,
we can just use its group's is_visible function to do this.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190512155518.21468-6-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c | 53 ++++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index db815ceb5017..b831091d4c10 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1618,42 +1618,6 @@ static struct attribute_group x86_pmu_format_group __ro_after_init = {
 	.attrs = NULL,
 };
 
-/*
- * Remove all undefined events (x86_pmu.event_map(id) == 0)
- * out of events_attr attributes.
- */
-static void __init filter_events(struct attribute **attrs)
-{
-	struct device_attribute *d;
-	struct perf_pmu_events_attr *pmu_attr;
-	int offset = 0;
-	int i, j;
-
-	for (i = 0; attrs[i]; i++) {
-		d = (struct device_attribute *)attrs[i];
-		pmu_attr = container_of(d, struct perf_pmu_events_attr, attr);
-		/* str trumps id */
-		if (pmu_attr->event_str)
-			continue;
-		if (x86_pmu.event_map(i + offset))
-			continue;
-
-		for (j = i; attrs[j]; j++)
-			attrs[j] = attrs[j + 1];
-
-		/* Check the shifted attr. */
-		i--;
-
-		/*
-		 * event_map() is index based, the attrs array is organized
-		 * by increasing event index. If we shift the events, then
-		 * we need to compensate for the event_map(), otherwise
-		 * we are looking up the wrong event in the map
-		 */
-		offset++;
-	}
-}
-
 /* Merge two pointer arrays */
 __init struct attribute **merge_attr(struct attribute **a, struct attribute **b)
 {
@@ -1744,9 +1708,24 @@ static struct attribute *events_attr[] = {
 	NULL,
 };
 
+/*
+ * Remove all undefined events (x86_pmu.event_map(id) == 0)
+ * out of events_attr attributes.
+ */
+static umode_t
+is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
+	/* str trumps id */
+	return pmu_attr->event_str || x86_pmu.event_map(idx) ? attr->mode : 0;
+}
+
 static struct attribute_group x86_pmu_events_group __ro_after_init = {
 	.name = "events",
 	.attrs = events_attr,
+	.is_visible = is_visible,
 };
 
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event)
@@ -1852,8 +1831,6 @@ static int __init init_hw_perf_events(void)
 
 	if (!x86_pmu.events_sysfs_show)
 		x86_pmu_events_group.attrs = &empty_attrs;
-	else
-		filter_events(x86_pmu_events_group.attrs);
 
 	if (x86_pmu.attrs) {
 		struct attribute **tmp;
