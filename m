Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A88C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6449020881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEOQ0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:26:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfEOQ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:26:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36471300271C;
        Wed, 15 May 2019 16:26:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C93A1001DD7;
        Wed, 15 May 2019 16:26:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/15] afs: Fix afs_cell records to always have a VL server
 list record
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:26:13 +0100
Message-ID: <155793757357.31671.12303183157450866360.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 15 May 2019 16:26:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix it such that afs_cell records always have a VL server list record
attached, even if it's a dummy one, so that various checks can be removed.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c      |   19 +++++++++++--------
 fs/afs/proc.c      |    8 ++++----
 fs/afs/vl_list.c   |   20 +++++++++-----------
 fs/afs/vl_rotate.c |    2 +-
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9ca075e11239..47f96be05163 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -123,6 +123,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 				       const char *name, unsigned int namelen,
 				       const char *addresses)
 {
+	struct afs_vlserver_list *vllist;
 	struct afs_cell *cell;
 	int i, ret;
 
@@ -157,12 +158,10 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	rwlock_init(&cell->proc_lock);
 	rwlock_init(&cell->vl_servers_lock);
 
-	/* Fill in the VL server list if we were given a list of addresses to
-	 * use.
+	/* Provide a VL server list, filling it in if we were given a list of
+	 * addresses to use.
 	 */
 	if (addresses) {
-		struct afs_vlserver_list *vllist;
-
 		vllist = afs_parse_text_addrs(net,
 					      addresses, strlen(addresses), ':',
 					      VL_SERVICE, AFS_VL_PORT);
@@ -171,19 +170,24 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 			goto parse_failed;
 		}
 
-		rcu_assign_pointer(cell->vl_servers, vllist);
 		cell->dns_expiry = TIME64_MAX;
-		__clear_bit(AFS_CELL_FL_NO_LOOKUP_YET, &cell->flags);
 	} else {
+		ret = -ENOMEM;
+		vllist = afs_alloc_vlserver_list(0);
+		if (!vllist)
+			goto error;
 		cell->dns_expiry = ktime_get_real_seconds();
 	}
 
+	rcu_assign_pointer(cell->vl_servers, vllist);
+
 	_leave(" = %p", cell);
 	return cell;
 
 parse_failed:
 	if (ret == -EINVAL)
 		printk(KERN_ERR "kAFS: bad VL server IP address\n");
+error:
 	kfree(cell);
 	_leave(" = %d", ret);
 	return ERR_PTR(ret);
@@ -410,8 +414,7 @@ static void afs_update_cell(struct afs_cell *cell)
 		cell->dns_expiry = expiry;
 		write_unlock(&cell->vl_servers_lock);
 
-		if (old)
-			afs_put_vlserverlist(cell->net, old);
+		afs_put_vlserverlist(cell->net, old);
 	}
 
 	if (test_and_clear_bit(AFS_CELL_FL_NO_LOOKUP_YET, &cell->flags))
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index be2ee3bbd0a9..371501d28e08 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -53,7 +53,7 @@ static int afs_proc_cells_show(struct seq_file *m, void *v)
 	seq_printf(m, "%3u %6lld %2u %s\n",
 		   atomic_read(&cell->usage),
 		   cell->dns_expiry - ktime_get_real_seconds(),
-		   vllist ? vllist->nr_servers : 0,
+		   vllist->nr_servers,
 		   cell->name);
 	return 0;
 }
@@ -296,8 +296,8 @@ static int afs_proc_cell_vlservers_show(struct seq_file *m, void *v)
 
 	if (v == SEQ_START_TOKEN) {
 		seq_printf(m, "# source %s, status %s\n",
-			   dns_record_sources[vllist->source],
-			   dns_lookup_statuses[vllist->status]);
+			   dns_record_sources[vllist ? vllist->source : 0],
+			   dns_lookup_statuses[vllist ? vllist->status : 0]);
 		return 0;
 	}
 
@@ -336,7 +336,7 @@ static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
 	if (pos == 0)
 		return SEQ_START_TOKEN;
 
-	if (!vllist || pos - 1 >= vllist->nr_servers)
+	if (pos - 1 >= vllist->nr_servers)
 		return NULL;
 
 	return &vllist->servers[pos - 1];
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index b4f1a84519b9..61e25010ff33 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -232,18 +232,16 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 		if (bs.status > NR__dns_lookup_status)
 			bs.status = NR__dns_lookup_status;
 
+		/* See if we can update an old server record */
 		server = NULL;
-		if (previous) {
-			/* See if we can update an old server record */
-			for (i = 0; i < previous->nr_servers; i++) {
-				struct afs_vlserver *p = previous->servers[i].server;
-
-				if (p->name_len == bs.name_len &&
-				    p->port == bs.port &&
-				    strncasecmp(b, p->name, bs.name_len) == 0) {
-					server = afs_get_vlserver(p);
-					break;
-				}
+		for (i = 0; i < previous->nr_servers; i++) {
+			struct afs_vlserver *p = previous->servers[i].server;
+
+			if (p->name_len == bs.name_len &&
+			    p->port == bs.port &&
+			    strncasecmp(b, p->name, bs.name_len) == 0) {
+				server = afs_get_vlserver(p);
+				break;
 			}
 		}
 
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 7adde83a0648..65629d73ad9d 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -55,7 +55,7 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 		rcu_dereference_protected(cell->vl_servers,
 					  lockdep_is_held(&cell->vl_servers_lock)));
 	read_unlock(&cell->vl_servers_lock);
-	if (!vc->server_list || !vc->server_list->nr_servers)
+	if (!vc->server_list->nr_servers)
 		return false;
 
 	vc->untried = (1UL << vc->server_list->nr_servers) - 1;

