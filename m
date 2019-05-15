Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A61C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C192082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfEOU63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:58:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfEOU63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:58:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E637D8553A;
        Wed, 15 May 2019 20:58:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4027260BF7;
        Wed, 15 May 2019 20:58:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/12] afs: Don't pass the vnode pointer through into the
 inline bulk status op
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:58:27 +0100
Message-ID: <155795390751.28355.1045942367260377574.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 15 May 2019 20:58:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't pass the vnode pointer through into the inline bulk status op.  We
want to process the status records outside of it anyway.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c  |    7 +------
 fs/afs/yfsclient.c |   10 +---------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 721ff8d04401..80948af115d4 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -2236,7 +2236,6 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 {
 	struct afs_file_status *statuses;
 	struct afs_callback *callbacks;
-	struct afs_vnode *vnode = call->reply[0];
 	const __be32 *bp;
 	u32 tmp;
 	int ret;
@@ -2277,8 +2276,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		bp = call->buffer;
 		statuses = call->reply[1];
 		ret = afs_decode_status(call, &bp, &statuses[call->count],
-					call->count == 0 ? vnode : NULL,
-					NULL, NULL);
+					NULL, NULL, NULL);
 		if (ret < 0)
 			return ret;
 
@@ -2320,8 +2318,6 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		callbacks = call->reply[2];
 		xdr_decode_AFSCallBack_raw(call, &callbacks[call->count], &bp);
 		statuses = call->reply[1];
-		if (call->count == 0 && vnode && statuses[0].abort_code == 0)
-			xdr_decode_AFSCallBack(call, vnode, &bp);
 		call->count++;
 		if (call->count < call->count2)
 			goto more_cbs;
@@ -2389,7 +2385,6 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	}
 
 	call->key = fc->key;
-	call->reply[0] = NULL; /* vnode for fid[0] */
 	call->reply[1] = statuses;
 	call->reply[2] = callbacks;
 	call->reply[3] = volsync;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index b42bd412dba1..3f6d50edf498 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -2055,7 +2055,6 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 {
 	struct afs_file_status *statuses;
 	struct afs_callback *callbacks;
-	struct afs_vnode *vnode = call->reply[0];
 	const __be32 *bp;
 	u32 tmp;
 	int ret;
@@ -2096,8 +2095,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		bp = call->buffer;
 		statuses = call->reply[1];
 		ret = yfs_decode_status(call, &bp, &statuses[call->count],
-					call->count == 0 ? vnode : NULL,
-					NULL, NULL);
+					NULL, NULL, NULL);
 		if (ret < 0)
 			return ret;
 
@@ -2138,11 +2136,6 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		bp = call->buffer;
 		callbacks = call->reply[2];
 		xdr_decode_YFSCallBack_raw(call, &callbacks[call->count], &bp);
-		statuses = call->reply[1];
-		if (call->count == 0 && vnode && statuses[0].abort_code == 0) {
-			bp = call->buffer;
-			xdr_decode_YFSCallBack(call, vnode, &bp);
-		}
 		call->count++;
 		if (call->count < call->count2)
 			goto more_cbs;
@@ -2210,7 +2203,6 @@ int yfs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	}
 
 	call->key = fc->key;
-	call->reply[0] = NULL; /* vnode for fid[0] */
 	call->reply[1] = statuses;
 	call->reply[2] = callbacks;
 	call->reply[3] = volsync;

