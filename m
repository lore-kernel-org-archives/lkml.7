Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6C7C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020E1206A3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556974348;
	bh=c45lMWl+tzp9dLEbI6wga+Hk1i0joi8BAMF4G4RsiT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jwPX8OguWae5xR0OZri8b4vo7xvJUjnIEndQgFs3tzbbtCgsuqn5IS3XauThb17En
	 CJplWSVHTSX4plZAPocLfNJXJCpHAnQqnxvbtMGmLJcBtr3BVVfejzrmRFx3IUvXUC
	 NbIeh+lF11Pttn/ukrkHMm3wlDvp/JitffFZtoF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfEDMw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:52:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44025 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfEDMwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86589356D3;
        Sat,  4 May 2019 12:52:19 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE19A5C298;
        Sat,  4 May 2019 12:52:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/8] perf/x86: Add is_visible attribute_group callback for base events
Date:   Sat,  4 May 2019 14:52:04 +0200
Message-Id: <20190504125207.24662-6-jolsa@kernel.org>
In-Reply-To: <20190504125207.24662-1-jolsa@kernel.org>
References: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 04 May 2019 12:52:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We dont need to pre-filter out unsupported base events,
we can just use its group's is_visible function to do this.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c | 52 ++++++++++++------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a43d8d1e8590..1889e45e6742 100644
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
@@ -1744,9 +1708,23 @@ static struct attribute *events_attr[] = {
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
+	return pmu_attr->event_str || x86_pmu.event_map(idx) ? attr->mode : 0;
+}
+
 static struct attribute_group x86_pmu_events_group __ro_after_init = {
 	.name = "events",
 	.attrs = events_attr,
+	.is_visible = is_visible,
 };
 
 ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event)
@@ -1852,8 +1830,6 @@ static int __init init_hw_perf_events(void)
 
 	if (!x86_pmu.events_sysfs_show)
 		x86_pmu_events_group.attrs = &empty_attrs;
-	else
-		filter_events(x86_pmu_events_group.attrs);
 
 	if (x86_pmu.attrs) {
 		struct attribute **tmp;
-- 
2.20.1

