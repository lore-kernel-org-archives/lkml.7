Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A8DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1294E20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEOQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfEOQ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:26:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 517DF309264E;
        Wed, 15 May 2019 16:26:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 961C2608B9;
        Wed, 15 May 2019 16:26:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/15] afs: Fix missing lock when replacing VL server list
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:26:06 +0100
Message-ID: <155793756678.31671.3057069610724058972.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 15 May 2019 16:26:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When afs_update_cell() replaces the cell->vl_servers list, it uses RCU
protocol so that proc is protected, but doesn't take ->vl_servers_lock to
protect afs_start_vl_iteration() (which does actually take a shared lock).

Fix this by making afs_update_cell() take an exclusive lock when replacing
->vl_servers.

Fixes: 0a5143f2f89c ("afs: Implement VL server rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9de46116c749..9ca075e11239 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -404,12 +404,11 @@ static void afs_update_cell(struct afs_cell *cell)
 		clear_bit(AFS_CELL_FL_DNS_FAIL, &cell->flags);
 		clear_bit(AFS_CELL_FL_NOT_FOUND, &cell->flags);
 
-		/* Exclusion on changing vl_addrs is achieved by a
-		 * non-reentrant work item.
-		 */
+		write_lock(&cell->vl_servers_lock);
 		old = rcu_dereference_protected(cell->vl_servers, true);
 		rcu_assign_pointer(cell->vl_servers, vllist);
 		cell->dns_expiry = expiry;
+		write_unlock(&cell->vl_servers_lock);
 
 		if (old)
 			afs_put_vlserverlist(cell->net, old);

