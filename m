Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EDCC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F4321D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852531;
	bh=EORNhPZLJFNshtpIwBCg2nMHFc3I05xt2lsmpmEoUn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aB5KOUVWbnkBCk4MVg+l6Q58fkQVpNbX2qqkNxz38X1S364LmfG8CGgOJ5NuZfwd0
	 HuR9WsTXj6Sn+WxdYNUncSRO6gy3qq3Ec6Md3jcXHsKLziThnXFTD1zUxznb8q/xwV
	 lJ9KsWllrNP19PqPTpXJBh5JlaUTYpe+ZCGWgeJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfLTOf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbfLTOfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:35:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBD1621D7E;
        Fri, 20 Dec 2019 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852517;
        bh=EORNhPZLJFNshtpIwBCg2nMHFc3I05xt2lsmpmEoUn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnvCNoVaVKyAf/KclV3vK0U4ICRfYYpI0+ArcowBwevHacqj8eMET99GhL1aA6C95
         3lBbhQLPQnfNc5HxidUN5d7EckdMStwnwS+SQ1gm51To9N/14hdPAVq2c+xvzzsnai
         ySLyvPIJAXVm8qWg5PqUkJH0etlq3fbW/bK0w7sA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 34/34] PM / hibernate: memory_bm_find_bit(): Tighten node optimisation
Date:   Fri, 20 Dec 2019 09:34:33 -0500
Message-Id: <20191220143433.9922-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220143433.9922-1-sashal@kernel.org>
References: <20191220143433.9922-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Whitcroft <apw@canonical.com>

[ Upstream commit da6043fe85eb5ec621e34a92540735dcebbea134 ]

When looking for a bit by number we make use of the cached result from the
preceding lookup to speed up operation.  Firstly we check if the requested
pfn is within the cached zone and if not lookup the new zone.  We then
check if the offset for that pfn falls within the existing cached node.
This happens regardless of whether the node is within the zone we are
now scanning.  With certain memory layouts it is possible for this to
false trigger creating a temporary alias for the pfn to a different bit.
This leads the hibernation code to free memory which it was never allocated
with the expected fallout.

Ensure the zone we are scanning matches the cached zone before considering
the cached node.

Deep thanks go to Andrea for many, many, many hours of hacking and testing
that went into cornering this bug.

Reported-by: Andrea Righi <andrea.righi@canonical.com>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/snapshot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 3d37c279c0900..f2635fc751d93 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -736,8 +736,15 @@ static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
 	 * We have found the zone. Now walk the radix tree to find the leaf node
 	 * for our PFN.
 	 */
+
+	/*
+	 * If the zone we wish to scan is the the current zone and the
+	 * pfn falls into the current node then we do not need to walk
+	 * the tree.
+	 */
 	node = bm->cur.node;
-	if (((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
+	if (zone == bm->cur.zone &&
+	    ((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
 		goto node_found;
 
 	node      = zone->rtree;
-- 
2.20.1

