Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFE62085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCOXJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCOXJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:09:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BB723089ED5;
        Fri, 15 Mar 2019 23:00:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 781CA19C57;
        Fri, 15 Mar 2019 23:00:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/10] afs: Add directory reload tracepoint
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 23:00:21 +0000
Message-ID: <155269082170.8537.8590577690754637263.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 23:00:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint (afs_reload_dir) to indicate when a directory is being
reloaded.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c               |    1 +
 include/trace/events/afs.h |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 378a96a1116e..be5d2f932b77 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -309,6 +309,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 		goto error;
 
 	if (!test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
+		trace_afs_reload_dir(dvnode);
 		ret = afs_fetch_data(dvnode, key, req);
 		if (ret < 0)
 			goto error_unlock;
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 21b896fabb2f..8da9dd5bc2b6 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -947,6 +947,23 @@ TRACE_EVENT(afs_flock_op,
 		      __entry->from, __entry->len, __entry->flags)
 	    );
 
+TRACE_EVENT(afs_reload_dir,
+	    TP_PROTO(struct afs_vnode *vnode),
+
+	    TP_ARGS(vnode),
+
+	    TP_STRUCT__entry(
+		    __field_struct(struct afs_fid,	fid		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->fid = vnode->fid;
+			   ),
+
+	    TP_printk("%llx:%llx:%x",
+		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */

