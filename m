Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8E3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470212089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfEOQ1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfEOQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:26:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 976F53082A99;
        Wed, 15 May 2019 16:26:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDFD47D561;
        Wed, 15 May 2019 16:26:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/15] afs: Make dynamic root population wait
 uninterruptibly for proc_cells_lock
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:26:58 +0100
Message-ID: <155793761800.31671.11168968011155587642.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 15 May 2019 16:26:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make dynamic root population wait uninterruptibly for proc_cells_lock.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dynroot.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 07484b5a3bbb..af1689d1f32e 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -261,8 +261,7 @@ int afs_dynroot_populate(struct super_block *sb)
 	struct afs_net *net = afs_sb2net(sb);
 	int ret;
 
-	if (mutex_lock_interruptible(&net->proc_cells_lock) < 0)
-		return -ERESTARTSYS;
+	mutex_lock(&net->proc_cells_lock);
 
 	net->dynroot_sb = sb;
 	hlist_for_each_entry(cell, &net->proc_cells, proc_link) {

