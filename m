Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EB8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F63D20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfEOQ1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfEOQ13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:27:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99C0F30821B2;
        Wed, 15 May 2019 16:27:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDAC45D9C2;
        Wed, 15 May 2019 16:27:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/15] afs: Fix double inc of vnode->cb_break
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:27:28 +0100
Message-ID: <155793764807.31671.15353972412997485464.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 15 May 2019 16:27:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When __afs_break_callback() clears the CB_PROMISED flag, it increments
vnode->cb_break to trigger a future refetch of the status and callback -
however it also calls afs_clear_permits(), which also increments
vnode->cb_break.

Fix this by removing the increment from afs_clear_permits().

Whilst we're at it, fix the conditional call to afs_put_permits() as the
function checks to see if the argument is NULL, so the check is redundant.

Fixes: be080a6f43c4 ("afs: Overhaul permit caching");
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/security.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/afs/security.c b/fs/afs/security.c
index 5f58a9a17e69..db5529e47eb8 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -87,11 +87,9 @@ void afs_clear_permits(struct afs_vnode *vnode)
 	permits = rcu_dereference_protected(vnode->permit_cache,
 					    lockdep_is_held(&vnode->lock));
 	RCU_INIT_POINTER(vnode->permit_cache, NULL);
-	vnode->cb_break++;
 	spin_unlock(&vnode->lock);
 
-	if (permits)
-		afs_put_permits(permits);
+	afs_put_permits(permits);
 }
 
 /*

