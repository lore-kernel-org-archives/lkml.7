Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD52C43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B13208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142279;
	bh=ynaErUTl8+VKC74rImywBO6Po3jc/xm37V2gxxiQ00c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oleVFV69KPg69ZRVHy4fTBZVA8ZJDaYxa06KB7Q83cmv2AmHi0qMfN6gKOEopNEjr
	 6JrxIuq2YwvREOMT6RJP2mdNTHO4H2nrMMpmDeGFz9QROOYTzcNCGatpu15JPv09W6
	 3pOd9MDVahDrIdNEFkqI+Srw3DRJ+9xrQBHJZK1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfKSFoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfKSFog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF3C208C3;
        Tue, 19 Nov 2019 05:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142276;
        bh=ynaErUTl8+VKC74rImywBO6Po3jc/xm37V2gxxiQ00c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHVFxN6sw94ARQAvSo4KkZM7bRl4kLsD0ulAQi5onzphVULY5qc/jdZ7+JBuvGKtt
         NKPK0XlGvz648y+mFV85je/PpjRfw3y1AyQO5ea1HowyF8RIoeLmdKZ37O+RC/cMHT
         iJJCQsn8o/WON0n8LPjV30XUUuxOAQ8M9qg74Kng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 026/239] mm: hugetlb: switch to css_tryget() in hugetlb_cgroup_charge_cgroup()
Date:   Tue, 19 Nov 2019 06:17:06 +0100
Message-Id: <20191119051302.851557319@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

commit 0362f326d86c645b5e96b7dbc3ee515986ed019d upstream.

An exiting task might belong to an offline cgroup.  In this case an
attempt to grab a cgroup reference from the task can end up with an
infinite loop in hugetlb_cgroup_charge_cgroup(), because neither the
cgroup will become online, neither the task will be migrated to a live
cgroup.

Fix this by switching over to css_tryget().  As css_tryget_online()
can't guarantee that the cgroup won't go offline, in most cases the
check doesn't make sense.  In this particular case users of
hugetlb_cgroup_charge_cgroup() are not affected by this change.

A similar problem is described by commit 18fa84a2db0e ("cgroup: Use
css_tryget() instead of css_tryget_online() in task_get_css()").

Link: http://lkml.kernel.org/r/20191106225131.3543616-2-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hugetlb_cgroup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -196,7 +196,7 @@ int hugetlb_cgroup_charge_cgroup(int idx
 again:
 	rcu_read_lock();
 	h_cg = hugetlb_cgroup_from_task(current);
-	if (!css_tryget_online(&h_cg->css)) {
+	if (!css_tryget(&h_cg->css)) {
 		rcu_read_unlock();
 		goto again;
 	}


