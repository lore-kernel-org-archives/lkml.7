Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F1B20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfEOQ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17025 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfEOQ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:27:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72C645D5FE;
        Wed, 15 May 2019 16:27:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B67921084261;
        Wed, 15 May 2019 16:27:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/15] afs: Don't invalidate callback if AFS_VNODE_DIR_VALID
 not set
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:27:11 +0100
Message-ID: <155793763180.31671.1818998763349462440.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 15 May 2019 16:27:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't invalidate the callback promise on a directory if the
AFS_VNODE_DIR_VALID flag is not set (which indicates that the directory
contents are invalid, due to edit failure, callback break, page reclaim).

The directory will be reloaded next time the directory is accessed, so
clearing the callback flag at this point may race with a reload of the
directory and cancel it's recorded callback promise.

Fixes: f3ddee8dc4e2 ("afs: Fix directory handling")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1e630f016dc5..bf8f56e851df 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -430,12 +430,9 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 			vnode->cb_s_break = vnode->cb_interest->server->cb_s_break;
 			vnode->cb_v_break = vnode->volume->cb_v_break;
 			valid = false;
-		} else if (vnode->status.type == AFS_FTYPE_DIR &&
-			   (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags) ||
-			    vnode->cb_expires_at - 10 <= now)) {
+		} else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags)) {
 			valid = false;
-		} else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags) ||
-			   vnode->cb_expires_at - 10 <= now) {
+		} else if (vnode->cb_expires_at - 10 <= now) {
 			valid = false;
 		} else {
 			valid = true;

