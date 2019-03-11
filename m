Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7F420857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfCKOvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfCKOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:51:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 386A3B082F;
        Mon, 11 Mar 2019 14:51:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF5F6100194A;
        Mon, 11 Mar 2019 14:51:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] fscache: Print cookie debugging information
From:   David Howells <dhowells@redhat.com>
To:     lists@nerdbynature.de
Cc:     linux-kernel@vger.kernel.org, anna.schumaker@netapp.com,
        steved@redhat.com, dhowells@redhat.com
Date:   Mon, 11 Mar 2019 14:50:59 +0000
Message-ID: <155231585903.2992.5354568923277050240.stgit@warthog.procyon.org.uk>
In-Reply-To: <2827.1552315718@warthog.procyon.org.uk>
References: <2827.1552315718@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 11 Mar 2019 14:51:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


---

 fs/afs/cache.c          |   11 +++++++++++
 fs/fscache/cookie.c     |    7 +++++--
 fs/nfs/fscache-index.c  |   11 +++++++++++
 include/linux/fscache.h |    2 ++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cache.c b/fs/afs/cache.c
index f6d0a21e8052..c16b10dcf895 100644
--- a/fs/afs/cache.c
+++ b/fs/afs/cache.c
@@ -32,10 +32,21 @@ struct fscache_cookie_def afs_volume_cache_index_def = {
 	.type		= FSCACHE_COOKIE_TYPE_INDEX,
 };
 
+static void afs_vnode_print_cookie(void *cookie_netfs_data, char prefix)
+{
+	struct afs_vnode *vnode = cookie_netfs_data;
+
+	pr_err("kAFS    : %c-vnode %llx:%llx:%x\n",
+	       prefix, vnode->fid.vid, vnode->fid.vnode, vnode->fid.unique);
+	pr_err("kAFS    : %c-vol v=%p %llx\n",
+	       prefix, vnode->volume, vnode->volume->vid);
+}
+
 struct fscache_cookie_def afs_vnode_cache_index_def = {
 	.name		= "AFS.vnode",
 	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
 	.check_aux	= afs_vnode_cache_check_aux,
+	.print		= afs_vnode_print_cookie,
 };
 
 /*
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 6931e45b7d59..50db256e6593 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -41,8 +41,9 @@ static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 	       prefix, cookie, cookie->parent, cookie->flags,
 	       atomic_read(&cookie->n_children),
 	       atomic_read(&cookie->n_active));
-	pr_err("%c-cookie d=%p n=%p\n",
-	       prefix, cookie->def, cookie->netfs_data);
+	pr_err("%c-cookie d=%p n=%p [%s]\n",
+	       prefix, cookie->def, cookie->netfs_data,
+	       cookie->def ? cookie->def->name : "");
 
 	object = READ_ONCE(cookie->backing_objects.first);
 	if (object)
@@ -55,6 +56,8 @@ static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 	for (loop = 0; loop < cookie->key_len; loop++)
 		pr_cont("%02x", k[loop]);
 	pr_cont("'\n");
+	if (cookie->def && cookie->def->print)
+		cookie->def->print(cookie->netfs_data, prefix);
 }
 
 void fscache_free_cookie(struct fscache_cookie *cookie)
diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index 666415d13d52..bba6753cdfb7 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -124,6 +124,16 @@ static void nfs_fh_put_context(void *cookie_netfs_data, void *context)
 		put_nfs_open_context(context);
 }
 
+static void nfs_inode_print_cookie(void *cookie_netfs_data, char prefix)
+{
+	struct nfs_inode *nfsi = cookie_netfs_data;
+	struct inode *i = &nfsi->vfs_inode;
+
+	pr_err("NFS     : %c-nfs fl=%lx cv=%lx ii=%lx if=%x sb=%p sf=%lx\n",
+	       prefix, nfsi->flags, nfsi->cache_validity,
+	       i->i_ino, i->i_flags, i->i_sb, i->i_sb->s_flags);
+}
+
 /*
  * Define the inode object for FS-Cache.  This is used to describe an inode
  * object to fscache_acquire_cookie().  It is keyed by the NFS file handle for
@@ -139,4 +149,5 @@ const struct fscache_cookie_def nfs_fscache_inode_object_def = {
 	.check_aux	= nfs_fscache_inode_check_aux,
 	.get_context	= nfs_fh_get_context,
 	.put_context	= nfs_fh_put_context,
+	.print		= nfs_inode_print_cookie,
 };
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 84b90a79d75a..84525722522e 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -114,6 +114,8 @@ struct fscache_cookie_def {
 	void (*mark_page_cached)(void *cookie_netfs_data,
 				 struct address_space *mapping,
 				 struct page *page);
+
+	void (*print)(void *cookie_netfs_data, char prefix);
 };
 
 /*

