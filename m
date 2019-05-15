Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5671BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E62920818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfEOU7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfEOU73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38C41A971A;
        Wed, 15 May 2019 20:59:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A30851001DE1;
        Wed, 15 May 2019 20:59:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/12] afs: Clear AFS_VNODE_CB_PROMISED if we detect
 callback expiry
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:59:25 +0100
Message-ID: <155795396583.28355.9474445071052662182.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 15 May 2019 20:59:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix afs_validate() to clear AFS_VNODE_CB_PROMISED on a vnode if we detect
any condition that causes the callback promise to be broken implicitly,
including server break (cb_s_break), volume break (cb_v_break) or callback
expiry.

Fixes: ae3b7361dc0e ("afs: Fix validation/callback interaction")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3633703dbc0c..866d3575c5de 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -570,7 +570,7 @@ bool afs_check_validity(struct afs_vnode *vnode)
 	struct afs_server *server;
 	struct afs_volume *volume = vnode->volume;
 	time64_t now = ktime_get_real_seconds();
-	bool valid;
+	bool valid, need_clear = false;
 	unsigned int cb_break, cb_s_break, cb_v_break;
 	int seq = 0;
 
@@ -588,10 +588,13 @@ bool afs_check_validity(struct afs_vnode *vnode)
 			    vnode->cb_v_break != cb_v_break) {
 				vnode->cb_s_break = cb_s_break;
 				vnode->cb_v_break = cb_v_break;
+				need_clear = true;
 				valid = false;
 			} else if (test_bit(AFS_VNODE_ZAP_DATA, &vnode->flags)) {
+				need_clear = true;
 				valid = false;
 			} else if (vnode->cb_expires_at - 10 <= now) {
+				need_clear = true;
 				valid = false;
 			} else {
 				valid = true;
@@ -606,6 +609,15 @@ bool afs_check_validity(struct afs_vnode *vnode)
 	} while (need_seqretry(&vnode->cb_lock, seq));
 
 	done_seqretry(&vnode->cb_lock, seq);
+
+	if (need_clear) {
+		write_seqlock(&vnode->cb_lock);
+		if (cb_break == vnode->cb_break)
+			__afs_break_callback(vnode);
+		write_sequnlock(&vnode->cb_lock);
+		valid = false;
+	}
+
 	return valid;
 }
 

