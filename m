Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1FAC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B3E218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCOXAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:00:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCOXAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C05B63082E02;
        Fri, 15 Mar 2019 23:00:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87CAD5D6A6;
        Fri, 15 Mar 2019 23:00:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/10] afs: Add more tracepoints
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 23:00:35 +0000
Message-ID: <155269083574.8537.11535293878983059321.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 15 Mar 2019 23:00:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add four more tracepoints:

 (1) afs_make_fs_call1 - Split from afs_make_fs_call but takes a filename
     to log also.

 (2) afs_make_fs_call2 - Like the above but takes two filenames to log.

 (3) afs_lookup - Log the result of doing a successful lookup, including a
     negative result (fid 0:0).

 (4) afs_get_tree - Log the set up of a volume for mounting.

It also extends the name buffer on the afs_edit_dir tracepoint to 24 chars
and puts quotes around the filename in the text representation.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c               |    6 ++
 fs/afs/fsclient.c          |   10 ++-
 fs/afs/super.c             |    1 
 fs/afs/yfsclient.c         |   14 ++--
 include/trace/events/afs.h |  146 +++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 161 insertions(+), 16 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 6c8523501639..8e3be31f94ce 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -908,8 +908,12 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 			(void *)(unsigned long)dvnode->status.data_version;
 	}
 	d = d_splice_alias(inode, dentry);
-	if (!IS_ERR_OR_NULL(d))
+	if (!IS_ERR_OR_NULL(d)) {
 		d->d_fsdata = dentry->d_fsdata;
+		trace_afs_lookup(dvnode, &d->d_name, inode ? AFS_FS_I(inode) : 0);
+	} else {
+		trace_afs_lookup(dvnode, &dentry->d_name, inode ? AFS_FS_I(inode) : 0);
+	}
 	return d;
 }
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index b9cf9dc1a9b7..b61ac50ed04a 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -830,7 +830,7 @@ int afs_fs_create(struct afs_fs_cursor *fc,
 	*bp++ = 0; /* segment size */
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &vnode->fid);
+	trace_afs_make_fs_call1(call, &vnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -926,7 +926,7 @@ int afs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 	}
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &dvnode->fid);
+	trace_afs_make_fs_call1(call, &dvnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -1019,7 +1019,7 @@ int afs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 	*bp++ = htonl(vnode->fid.unique);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &vnode->fid);
+	trace_afs_make_fs_call1(call, &vnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -1134,7 +1134,7 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 	*bp++ = 0; /* segment size */
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &vnode->fid);
+	trace_afs_make_fs_call1(call, &vnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -1253,7 +1253,7 @@ int afs_fs_rename(struct afs_fs_cursor *fc,
 	}
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &orig_dvnode->fid);
+	trace_afs_make_fs_call2(call, &orig_dvnode->fid, orig_name, new_name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 6438849a75c4..ce85ae61f12d 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -550,6 +550,7 @@ static int afs_get_tree(struct fs_context *fc)
 	}
 
 	fc->root = dget(sb->s_root);
+	trace_afs_get_tree(as->cell, as->volume);
 	_leave(" = 0 [%p]", sb);
 	return 0;
 
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 41afc53a7df7..0f2c6b915cbe 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -809,7 +809,7 @@ int yfs_fs_create_file(struct afs_fs_cursor *fc,
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &vnode->fid);
+	trace_afs_make_fs_call1(call, &vnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -873,7 +873,7 @@ int yfs_fs_make_dir(struct afs_fs_cursor *fc,
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &vnode->fid);
+	trace_afs_make_fs_call1(call, &vnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -964,7 +964,7 @@ int yfs_fs_remove_file2(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &dvnode->fid);
+	trace_afs_make_fs_call1(call, &dvnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -1052,7 +1052,7 @@ int yfs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &dvnode->fid);
+	trace_afs_make_fs_call1(call, &dvnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -1138,7 +1138,7 @@ int yfs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &vnode->fid);
+	trace_afs_make_fs_call1(call, &vnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -1235,7 +1235,7 @@ int yfs_fs_symlink(struct afs_fs_cursor *fc,
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &dvnode->fid);
+	trace_afs_make_fs_call1(call, &dvnode->fid, name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
@@ -1334,7 +1334,7 @@ int yfs_fs_rename(struct afs_fs_cursor *fc,
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);
-	trace_afs_make_fs_call(call, &orig_dvnode->fid);
+	trace_afs_make_fs_call2(call, &orig_dvnode->fid, orig_name, new_name);
 	afs_make_call(&fc->ac, call, GFP_NOFS);
 	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index f67815ebb1b9..e81d6a50781f 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -539,6 +539,88 @@ TRACE_EVENT(afs_make_fs_call,
 		      __print_symbolic(__entry->op, afs_fs_operations))
 	    );
 
+TRACE_EVENT(afs_make_fs_call1,
+	    TP_PROTO(struct afs_call *call, const struct afs_fid *fid,
+		     const char *name),
+
+	    TP_ARGS(call, fid, name),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call		)
+		    __field(enum afs_fs_operation,	op		)
+		    __field_struct(struct afs_fid,	fid		)
+		    __array(char,			name, 24	)
+			     ),
+
+	    TP_fast_assign(
+		    int __len = strlen(name);
+		    __len = min(__len, 23);
+		    __entry->call = call->debug_id;
+		    __entry->op = call->operation_ID;
+		    if (fid) {
+			    __entry->fid = *fid;
+		    } else {
+			    __entry->fid.vid = 0;
+			    __entry->fid.vnode = 0;
+			    __entry->fid.unique = 0;
+		    }
+		    memcpy(__entry->name, name, __len);
+		    __entry->name[__len] = 0;
+			   ),
+
+	    TP_printk("c=%08x %06llx:%06llx:%06x %s \"%s\"",
+		      __entry->call,
+		      __entry->fid.vid,
+		      __entry->fid.vnode,
+		      __entry->fid.unique,
+		      __print_symbolic(__entry->op, afs_fs_operations),
+		      __entry->name)
+	    );
+
+TRACE_EVENT(afs_make_fs_call2,
+	    TP_PROTO(struct afs_call *call, const struct afs_fid *fid,
+		     const char *name, const char *name2),
+
+	    TP_ARGS(call, fid, name, name2),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call		)
+		    __field(enum afs_fs_operation,	op		)
+		    __field_struct(struct afs_fid,	fid		)
+		    __array(char,			name, 24	)
+		    __array(char,			name2, 24	)
+			     ),
+
+	    TP_fast_assign(
+		    int __len = strlen(name);
+		    int __len2 = strlen(name2);
+		    __len = min(__len, 23);
+		    __len2 = min(__len2, 23);
+		    __entry->call = call->debug_id;
+		    __entry->op = call->operation_ID;
+		    if (fid) {
+			    __entry->fid = *fid;
+		    } else {
+			    __entry->fid.vid = 0;
+			    __entry->fid.vnode = 0;
+			    __entry->fid.unique = 0;
+		    }
+		    memcpy(__entry->name, name, __len);
+		    __entry->name[__len] = 0;
+		    memcpy(__entry->name2, name2, __len2);
+		    __entry->name2[__len2] = 0;
+			   ),
+
+	    TP_printk("c=%08x %06llx:%06llx:%06x %s \"%s\" \"%s\"",
+		      __entry->call,
+		      __entry->fid.vid,
+		      __entry->fid.vnode,
+		      __entry->fid.unique,
+		      __print_symbolic(__entry->op, afs_fs_operations),
+		      __entry->name,
+		      __entry->name2)
+	    );
+
 TRACE_EVENT(afs_make_vl_call,
 	    TP_PROTO(struct afs_call *call),
 
@@ -736,6 +818,38 @@ TRACE_EVENT(afs_call_state,
 		      __entry->ret, __entry->abort)
 	    );
 
+TRACE_EVENT(afs_lookup,
+	    TP_PROTO(struct afs_vnode *dvnode, const struct qstr *name,
+		     struct afs_vnode *vnode),
+
+	    TP_ARGS(dvnode, name, vnode),
+
+	    TP_STRUCT__entry(
+		    __field_struct(struct afs_fid,	dfid		)
+		    __field_struct(struct afs_fid,	fid		)
+		    __array(char,			name, 24	)
+			     ),
+
+	    TP_fast_assign(
+		    int __len = min_t(int, name->len, 23);
+		    __entry->dfid = dvnode->fid;
+		    if (vnode) {
+			    __entry->fid = vnode->fid;
+		    } else {
+			    __entry->fid.vid = 0;
+			    __entry->fid.vnode = 0;
+			    __entry->fid.unique = 0;
+		    }
+		    memcpy(__entry->name, name->name, __len);
+		    __entry->name[__len] = 0;
+			   ),
+
+	    TP_printk("d=%llx:%llx:%x \"%s\" f=%llx:%x",
+		      __entry->dfid.vid, __entry->dfid.vnode, __entry->dfid.unique,
+		      __entry->name,
+		      __entry->fid.vnode, __entry->fid.unique)
+	    );
+
 TRACE_EVENT(afs_edit_dir,
 	    TP_PROTO(struct afs_vnode *dvnode,
 		     enum afs_edit_dir_reason why,
@@ -757,12 +871,12 @@ TRACE_EVENT(afs_edit_dir,
 		    __field(unsigned short,		slot		)
 		    __field(unsigned int,		f_vnode		)
 		    __field(unsigned int,		f_unique	)
-		    __array(char,			name, 18	)
+		    __array(char,			name, 24	)
 			     ),
 
 	    TP_fast_assign(
 		    int __len = strlen(name);
-		    __len = min(__len, 17);
+		    __len = min(__len, 23);
 		    __entry->vnode	= dvnode->fid.vnode;
 		    __entry->unique	= dvnode->fid.unique;
 		    __entry->why	= why;
@@ -775,7 +889,7 @@ TRACE_EVENT(afs_edit_dir,
 		    __entry->name[__len] = 0;
 			   ),
 
-	    TP_printk("d=%x:%x %s %s %u[%u] f=%x:%x %s",
+	    TP_printk("d=%x:%x %s %s %u[%u] f=%x:%x \"%s\"",
 		      __entry->vnode, __entry->unique,
 		      __print_symbolic(__entry->why, afs_edit_dir_reasons),
 		      __print_symbolic(__entry->op, afs_edit_dir_ops),
@@ -994,6 +1108,32 @@ TRACE_EVENT(afs_silly_rename,
 		      __entry->done)
 	    );
 
+TRACE_EVENT(afs_get_tree,
+	    TP_PROTO(struct afs_cell *cell, struct afs_volume *volume),
+
+	    TP_ARGS(cell, volume),
+
+	    TP_STRUCT__entry(
+		    __field(u64,			vid		)
+		    __array(char,			cell, 24	)
+		    __array(char,			volume, 24	)
+			     ),
+
+	    TP_fast_assign(
+		    int __len;
+		    __entry->vid = volume->vid;
+		    __len = min_t(int, cell->name_len, 23);
+		    memcpy(__entry->cell, cell->name, __len);
+		    __entry->cell[__len] = 0;
+		    __len = min_t(int, volume->name_len, 23);
+		    memcpy(__entry->volume, volume->name, __len);
+		    __entry->volume[__len] = 0;
+			   ),
+
+	    TP_printk("--- MOUNT %s:%s %llx",
+		      __entry->cell, __entry->volume, __entry->vid)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */

