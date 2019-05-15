Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EFAC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BA220881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfEOQ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfEOQ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:27:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1F26308123F;
        Wed, 15 May 2019 16:27:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E2A95D71E;
        Wed, 15 May 2019 16:27:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/15] afs: Fix lock-wait/callback-break double locking
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:27:18 +0100
Message-ID: <155793763869.31671.8230708692054953179.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 15 May 2019 16:27:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__afs_break_callback() holds vnode->lock around its call of
afs_lock_may_be_available() - which also takes that lock.

Fix this by not taking the lock in __afs_break_callback().

Also, there's no point checking the granted_locks and pending_locks queues;
it's sufficient to check lock_state, so move that check out of
afs_lock_may_be_available() into __afs_break_callback() to replace the
queue checks.

Fixes: e8d6c554126b ("AFS: implement file locking")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c |    8 +-------
 fs/afs/flock.c    |    3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 128f2dbe256a..4876079aa643 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -218,14 +218,8 @@ void __afs_break_callback(struct afs_vnode *vnode)
 		vnode->cb_break++;
 		afs_clear_permits(vnode);
 
-		spin_lock(&vnode->lock);
-
-		_debug("break callback");
-
-		if (list_empty(&vnode->granted_locks) &&
-		    !list_empty(&vnode->pending_locks))
+		if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
 			afs_lock_may_be_available(vnode);
-		spin_unlock(&vnode->lock);
 	}
 }
 
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 3501ef7ddbb4..c91cd201013f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -41,9 +41,6 @@ void afs_lock_may_be_available(struct afs_vnode *vnode)
 {
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
-	if (vnode->lock_state != AFS_VNODE_LOCK_WAITING_FOR_CB)
-		return;
-
 	spin_lock(&vnode->lock);
 	if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
 		afs_next_locker(vnode, 0);

