Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F474CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECC62084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sPEnRcrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfJVJZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:25:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37278 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbfJVJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WY6KImieCGZAjEO6KzSr9f0KT5JTeFka9FBaH89KLj0=; b=sPEnRcrtXhmnfZeDpfkVk+nbEO
        D/Ik8q1Xi20bN9wIK5hZhQtXd9FC4yfqId+7etImPpvCCDInzVY6hO4/tUPb0/NkbcNwkgoKq15jV
        W6pw0BORHWaT/rn+XY/6u53jpB/BJTcvchHLNCkevdszLRnZ6hDE9j2Y7YsNMYrePx+GewF8bONM2
        QYxm2jx6Tstxu7+d+x9vjAJ/oVDy9dDTHcps/CEWFiC7A+XDiXa4JavCeGPAuPDtaapGfvOM1LtP3
        Xr/1QxKVyyyzRnhC6c1hHvKAa1lbvRI1AVQn7TNYvRREuoXScbkPyKzrpW3AgpffsZg3VtCkZvScZ
        wRJ4zExg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMqPg-00029C-J9; Tue, 22 Oct 2019 09:25:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93366301124;
        Tue, 22 Oct 2019 11:24:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1F69420D8D3C2; Tue, 22 Oct 2019 11:25:09 +0200 (CEST)
Message-Id: <20191022092307.483110884@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 22 Oct 2019 11:20:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, andi@firstfloor.org, kan.liang@linux.intel.com
Subject: [PATCH 3/3] perf: Optimize perf_init_event() for TYPE_SOFTWARE
References: <20191022092017.740591163@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liang, Kan" <kan.liang@linux.intel.com>

Andi reported that he was hitting the linear search in
perf_init_event() a lot. Now that all !TYPE_SOFTWARE events should hit
the IDR, make sure the TYPE_SOFTWARE events are at the head of the
list such that we'll quickly find the right PMU (provided a valid
event was given).

Reported-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10167,7 +10167,16 @@ int perf_pmu_register(struct pmu *pmu, c
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-	list_add_rcu(&pmu->entry, &pmus);
+	/*
+	 * Ensure the TYPE_SOFTWARE PMUs are at the head of the list,
+	 * since these cannot be in the IDR. This way the linear search
+	 * is fast, provided a valid software event is provided.
+	 */
+	if (type == PERF_TYPE_SOFTWARE || !name)
+		list_add_rcu(&pmu->entry, &pmus);
+	else
+		list_add_tail_rcu(&pmu->entry, &pmus);
+
 	atomic_set(&pmu->exclusive_cnt, 0);
 	ret = 0;
 unlock:


