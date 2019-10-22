Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B97CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E972084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTrZSEeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfJVJZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:25:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbfJVJZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yLtJ8P6gz03aUZVPIm6Z/OVxKfrGoXfiB2G4aC34xIE=; b=VTrZSEeQi/av4rzOjJIj7/KPmD
        QW+UhvFedRUw5r38vvezqEdelaRO/tAPyjOlCiggCUkOXvhLe2dOW89m8HMXdDRuBD8U35hnkNWK4
        oNUP6PRxvw6NCUen2muCd4F51WwsSBiKJ9Hwu+NjntbgQmHHag64hvuE0HGhyxW59PO4Zpuk9XLUt
        8WZE4BJiQYmuGrd6oNu5A/HGrv/8u98sU581BW13c/dZht2rV4uv3ubLu0t6GNwGdY1GSi223CgI3
        eC/edMAsMc7/WzkOJ2SRGTQ9qjHDaVZ1YB3SmhP1AehrnpE7LRiiCM19iPU875MKlZnLArOuxqrft
        JeatnYGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMqPf-0005LY-Dp; Tue, 22 Oct 2019 09:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9534E301A79;
        Tue, 22 Oct 2019 11:24:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A59720977B04; Tue, 22 Oct 2019 11:25:09 +0200 (CEST)
Message-Id: <20191022092307.425783389@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 22 Oct 2019 11:20:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, andi@firstfloor.org, kan.liang@linux.intel.com
Subject: [PATCH 2/3] perf: Optimize perf_init_event()
References: <20191022092017.740591163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi reported that he was hitting the linear search in
perf_init_event() a lot. Make more agressive use of the IDR lookup to
avoid hitting the linear search.

With exception of PERF_TYPE_SOFTWARE (which relies on a hideous hack),
we can put everything in the IDR. On top of that, we can alias
TYPE_HARDWARE and TYPE_HW_CACHE to TYPE_RAW on the lookup side.

This greatly reduces the chances of hitting the linear search.

Reported-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Kan <kan.liang@linux.intel.com>
---
 kernel/events/core.c |   41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10067,7 +10067,7 @@ static struct lock_class_key cpuctx_lock
 
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
-	int cpu, ret;
+	int cpu, ret, max = PERF_TYPE_MAX;
 
 	mutex_lock(&pmus_lock);
 	ret = -ENOMEM;
@@ -10080,12 +10080,17 @@ int perf_pmu_register(struct pmu *pmu, c
 		goto skip_type;
 	pmu->name = name;
 
-	if (type < 0) {
-		type = idr_alloc(&pmu_idr, pmu, PERF_TYPE_MAX, 0, GFP_KERNEL);
-		if (type < 0) {
-			ret = type;
+	if (type != PERF_TYPE_SOFTWARE) {
+		if (type >= 0)
+			max = type;
+
+		ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+		if (ret < 0)
 			goto free_pdc;
-		}
+
+		WARN_ON(type >= 0 && ret != type);
+
+		type = ret;
 	}
 	pmu->type = type;
 
@@ -10175,7 +10180,7 @@ int perf_pmu_register(struct pmu *pmu, c
 	put_device(pmu->dev);
 
 free_idr:
-	if (pmu->type >= PERF_TYPE_MAX)
+	if (pmu->type != PERF_TYPE_SOFTWARE)
 		idr_remove(&pmu_idr, pmu->type);
 
 free_pdc:
@@ -10197,7 +10202,7 @@ void perf_pmu_unregister(struct pmu *pmu
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	if (pmu->type >= PERF_TYPE_MAX)
+	if (pmu->type != PERF_TYPE_SOFTWARE)
 		idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running) {
 		if (pmu->nr_addr_filters)
@@ -10267,9 +10272,8 @@ static int perf_try_init_event(struct pm
 
 static struct pmu *perf_init_event(struct perf_event *event)
 {
+	int idx, type, ret;
 	struct pmu *pmu;
-	int idx;
-	int ret;
 
 	idx = srcu_read_lock(&pmus_srcu);
 
@@ -10282,12 +10286,27 @@ static struct pmu *perf_init_event(struc
 	}
 
 	rcu_read_lock();
-	pmu = idr_find(&pmu_idr, event->attr.type);
+	/*
+	 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+	 * are often aliases for PERF_TYPE_RAW.
+	 */
+	type = event->attr.type;
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
+		type = PERF_TYPE_RAW;
+
+again:
+	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
 		ret = perf_try_init_event(pmu, event);
+		if (ret == -ENOENT && event->attr.type != type) {
+			type = event->attr.type;
+			goto again;
+		}
+
 		if (ret)
 			pmu = ERR_PTR(ret);
+
 		goto unlock;
 	}
 


