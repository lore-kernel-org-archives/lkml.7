Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C597DC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D1217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429411;
	bh=SCTpNe73w03WFMGCTgSs09EQkuxblGIon7LU4ul75hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VfQNLPSUZz9c7kFoVs+2MZFJ25vRhSrHym78rTKeJrw8quVeSWNBIRlFKTW0Qnf8W
	 HLTNEH4miV+QqjtJnJzxNbvq7UMiC5gZMIN5NVEP/V8waedMnG9zeYjNKYh8p6sUMe
	 3eFyk/mLiDFYe+TBdXegq/+nt/v+4jOmH/bpYilc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389660AbfG2Tna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389647AbfG2Tn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:43:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7091A21773;
        Mon, 29 Jul 2019 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429405;
        bh=SCTpNe73w03WFMGCTgSs09EQkuxblGIon7LU4ul75hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUIWVHZg+LZUHkDQr+VI78tv2Th4WOUK4S9X+Y+6zBvrbBxFA4MZwum1elgEhh0Mr
         gjNZo3c128D3zGRtq0URUJpkOE9B1BttHFdFb5avGUK0MC5D+MQCjRgzsH4o86GCv+
         c2KbdTX85I5TSzCOroTOO0OxO8kgLIjT7FCFughg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 088/113] mm/mmu_notifier: use hlist_add_head_rcu()
Date:   Mon, 29 Jul 2019 21:22:55 +0200
Message-Id: <20190729190716.582894769@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 543bdb2d825fe2400d6e951f1786d92139a16931 ]

Make mmu_notifier_register() safer by issuing a memory barrier before
registering a new notifier.  This fixes a theoretical bug on weakly
ordered CPUs.  For example, take this simplified use of notifiers by a
driver:

	my_struct->mn.ops = &my_ops; /* (1) */
	mmu_notifier_register(&my_struct->mn, mm)
		...
		hlist_add_head(&mn->hlist, &mm->mmu_notifiers); /* (2) */
		...

Once mmu_notifier_register() releases the mm locks, another thread can
invalidate a range:

	mmu_notifier_invalidate_range()
		...
		hlist_for_each_entry_rcu(mn, &mm->mmu_notifiers, hlist) {
			if (mn->ops->invalidate_range)

The read side relies on the data dependency between mn and ops to ensure
that the pointer is properly initialized.  But the write side doesn't have
any dependency between (1) and (2), so they could be reordered and the
readers could dereference an invalid mn->ops.  mmu_notifier_register()
does take all the mm locks before adding to the hlist, but those have
acquire semantics which isn't sufficient.

By calling hlist_add_head_rcu() instead of hlist_add_head() we update the
hlist using a store-release, ensuring that readers see prior
initialization of my_struct.  This situation is better illustated by
litmus test MP+onceassign+derefonce.

Link: http://lkml.kernel.org/r/20190502133532.24981-1-jean-philippe.brucker@arm.com
Fixes: cddb8a5c14aa ("mmu-notifiers: core")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmu_notifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 82bb1a939c0e..06dedb175572 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -316,7 +316,7 @@ static int do_mmu_notifier_register(struct mmu_notifier *mn,
 	 * thanks to mm_take_all_locks().
 	 */
 	spin_lock(&mm->mmu_notifier_mm->lock);
-	hlist_add_head(&mn->hlist, &mm->mmu_notifier_mm->list);
+	hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
 	spin_unlock(&mm->mmu_notifier_mm->lock);
 
 	mm_drop_all_locks(mm);
-- 
2.20.1



