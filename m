Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E28C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1562087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCHOtV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:49:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfCHOtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:49:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 022695D61E;
        Fri,  8 Mar 2019 14:49:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC67692B7;
        Fri,  8 Mar 2019 14:49:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org> <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org> <10106.1551892803@warthog.procyon.org.uk>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17154.1552056554.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 08 Mar 2019 14:49:14 +0000
Message-ID: <17155.1552056554@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 08 Mar 2019 14:49:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <lists@nerdbynature.de> wrote:

> $ mount | grep nfs4
> nfs:/usr/local/src on /usr/local/src type nfs4 (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.56.139,local_lock=none,addr=192.168.0.115)
> 
> ...so FS-Cache ("fsc") isn't even used here.

Interesting.  Can you do:

	cat /proc/fs/nfsfs/volumes

See the attached for a patch that helps with certain kinds of collision,
though I can't see that it should help with what you're seeing since the
RELINQUISHED flag isn't set on the old cookie (fl=222, but 0x10 isn't in
there).  You can monitor the number of waits by looking in
/proc/fs/fscache/stats for the:

	Acquire: n=289166 nul=0 noc=0 ok=286331 nbf=2 oom=0 wrq=23748

line.  See the wrq= value.

David
---
commit abe600bc6e5022e14c0ce135fa3d9ceaafa3cb46
Author: David Howells <dhowells@redhat.com>
Date:   Fri Mar 8 13:14:36 2019 +0000

    fscache: Fix cookie collision
    
    When adding a new cookie, a collision can sometimes occur because an old
    cookie with the same key is still in the process of being asynchronously
    relinquished, leading to something like the following being emitted into
    the kernel log:
    
       FS-Cache: Duplicate cookie detected
       FS-Cache: O-cookie c=00000000db33ad59 [p=000000004bc53500 fl=218 nc=0 na=0]
       FS-Cache: O-cookie d=          (null) n=          (null)
       FS-Cache: O-cookie o=000000006cf6db4f
       FS-Cache: O-key=[16] '0100010101000000e51fc6000323ae02'
       FS-Cache: N-cookie c=00000000791c49d0 [p=000000004bc53500 fl=2 nc=0 na=1]
       FS-Cache: N-cookie d=00000000e220fe14 n=00000000d4484489
       FS-Cache: N-key=[16] '0100010101000000e51fc6000323ae02'
    
    with the old cookie (O- lines) showing no cookie def or netfs data and
    showing flags ACQUIRED, RELINQUISHED and INVALIDATING (fl=218).
    
    Fix this by:
    
     (1) Setting FSCACHE_COOKIE_RELINQUISHING on the cookie we're about to tear
         dispose of.
    
     (2) Making fscache_hash_cookie() sleep on RELINQUISHING if there's a
         collision with a cookie that has RELINQUISHED set.
    
     (3) Clearing RELINQUISHING upon having unhashed the cookie and waking up
         anyone waiting for it to transition to unset.
    
    Fixes: ec0328e46d6e ("fscache: Maintain a catalogue of allocated cookies")
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/Documentation/filesystems/caching/fscache.txt b/Documentation/filesystems/caching/fscache.txt
index 50f0a5757f48..f304bda88bb1 100644
--- a/Documentation/filesystems/caching/fscache.txt
+++ b/Documentation/filesystems/caching/fscache.txt
@@ -231,6 +231,7 @@ proc files.
 		ok=N	Number of acq reqs succeeded
 		nbf=N	Number of acq reqs rejected due to error
 		oom=N	Number of acq reqs failed on ENOMEM
+		wrq=N	Number of waits for relinquishment of conflicting old cookies.
 	Lookups	n=N	Number of lookup calls made on cache backends
 		neg=N	Number of negative lookups made
 		pos=N	Number of positive lookups made
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index c550512ce335..75d0ffd36ac0 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -202,7 +202,9 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 	struct hlist_bl_head *h;
 	struct hlist_bl_node *p;
 	unsigned int bucket;
+	int ret;
 
+retry:
 	bucket = candidate->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
 	h = &fscache_cookie_hash[bucket];
 
@@ -220,19 +222,37 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 	return candidate;
 
 collision:
-	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags)) {
-		trace_fscache_cookie(cursor, fscache_cookie_collision,
-				     atomic_read(&cursor->usage));
-		pr_err("Duplicate cookie detected\n");
-		fscache_print_cookie(cursor, 'O');
-		fscache_print_cookie(candidate, 'N');
-		hlist_bl_unlock(h);
-		return NULL;
-	}
+	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags))
+		goto duplicate;
 
 	fscache_cookie_get(cursor, fscache_cookie_get_reacquire);
 	hlist_bl_unlock(h);
 	return cursor;
+
+duplicate:
+	if (test_bit(FSCACHE_COOKIE_RELINQUISHED, &cursor->flags))
+		goto wait_for_removal;
+
+	trace_fscache_cookie(cursor, fscache_cookie_collision,
+			     atomic_read(&cursor->usage));
+	pr_err("Duplicate cookie detected\n");
+	fscache_print_cookie(cursor, 'O');
+	fscache_print_cookie(candidate, 'N');
+	hlist_bl_unlock(h);
+	return NULL;
+
+wait_for_removal:
+	fscache_cookie_get(cursor, fscache_cookie_get_wait);
+	hlist_bl_unlock(h);
+
+	fscache_stat(&fscache_n_acquires_wait_relinq);
+	ret = wait_on_bit(&cursor->flags, FSCACHE_COOKIE_RELINQUISHING,
+			  TASK_INTERRUPTIBLE);
+
+	fscache_cookie_put(cursor, fscache_cookie_put_wait);
+	if (ret < 0)
+		return NULL;
+	goto retry;
 }
 
 /*
@@ -816,9 +836,16 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 	/* No further netfs-accessing operations on this cookie permitted */
 	if (test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags))
 		BUG();
+	set_bit(FSCACHE_COOKIE_RELINQUISHING, &cookie->flags);
 
 	__fscache_disable_cookie(cookie, aux_data, retire);
 
+	spin_lock(&cookie->lock);
+	if (test_bit(FSCACHE_COOKIE_RELINQUISHING, &cookie->flags) &&
+	    hlist_empty(&cookie->backing_objects))
+		fscache_unhash_cookie(cookie);
+	spin_unlock(&cookie->lock);
+
 	/* Clear pointers back to the netfs */
 	cookie->netfs_data	= NULL;
 	cookie->def		= NULL;
@@ -839,19 +866,24 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 EXPORT_SYMBOL(__fscache_relinquish_cookie);
 
 /*
- * Remove a cookie from the hash table.
+ * Remove a cookie from the hash table and wake up anyone waiting on this.
  */
-static void fscache_unhash_cookie(struct fscache_cookie *cookie)
+void fscache_unhash_cookie(struct fscache_cookie *cookie)
 {
 	struct hlist_bl_head *h;
 	unsigned int bucket;
 
+	_enter("%p", cookie);
+
 	bucket = cookie->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
 	h = &fscache_cookie_hash[bucket];
 
 	hlist_bl_lock(h);
-	hlist_bl_del(&cookie->hash_link);
+	hlist_bl_del_init(&cookie->hash_link);
 	hlist_bl_unlock(h);
+
+	if (test_and_clear_bit(FSCACHE_COOKIE_RELINQUISHING, &cookie->flags))
+		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_RELINQUISHING);
 }
 
 /*
@@ -873,8 +905,8 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 			return;
 		BUG_ON(usage < 0);
 
+		ASSERT(hlist_bl_unhashed(&cookie->hash_link));
 		parent = cookie->parent;
-		fscache_unhash_cookie(cookie);
 		fscache_free_cookie(cookie);
 
 		cookie = parent;
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index d6209022e965..caf0df77e1b1 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -57,6 +57,7 @@ extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
 						   const void *, size_t,
 						   void *, loff_t);
 extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
+extern void fscache_unhash_cookie(struct fscache_cookie *);
 extern void fscache_cookie_put(struct fscache_cookie *,
 			       enum fscache_cookie_trace);
 
@@ -227,6 +228,7 @@ extern atomic_t fscache_n_acquires_no_cache;
 extern atomic_t fscache_n_acquires_ok;
 extern atomic_t fscache_n_acquires_nobufs;
 extern atomic_t fscache_n_acquires_oom;
+extern atomic_t fscache_n_acquires_wait_relinq;
 
 extern atomic_t fscache_n_invalidates;
 extern atomic_t fscache_n_invalidates_run;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 6d9cb1719de5..d16737e0307a 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -706,7 +706,7 @@ static const struct fscache_state *fscache_drop_object(struct fscache_object *ob
 	struct fscache_object *parent = object->parent;
 	struct fscache_cookie *cookie = object->cookie;
 	struct fscache_cache *cache = object->cache;
-	bool awaken = false;
+	int awaken = 0;
 
 	_enter("{OBJ%x,%d},%d", object->debug_id, object->n_children, event);
 
@@ -723,13 +723,18 @@ static const struct fscache_state *fscache_drop_object(struct fscache_object *ob
 	 */
 	spin_lock(&cookie->lock);
 	hlist_del_init(&object->cookie_link);
-	if (hlist_empty(&cookie->backing_objects) &&
-	    test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-		awaken = true;
+	if (hlist_empty(&cookie->backing_objects)) {
+		if (test_bit(FSCACHE_COOKIE_RELINQUISHING, &cookie->flags))
+			awaken = 2;
+		else if (test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
+			awaken = 1;
+	}
 	spin_unlock(&cookie->lock);
 
 	if (awaken)
 		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	if (awaken == 2)
+		fscache_unhash_cookie(cookie);
 	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
 		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
 
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 00564a1dfd76..ca53e84cb7ea 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -80,6 +80,7 @@ atomic_t fscache_n_acquires_no_cache;
 atomic_t fscache_n_acquires_ok;
 atomic_t fscache_n_acquires_nobufs;
 atomic_t fscache_n_acquires_oom;
+atomic_t fscache_n_acquires_wait_relinq;
 
 atomic_t fscache_n_invalidates;
 atomic_t fscache_n_invalidates_run;
@@ -163,13 +164,14 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_uncaches));
 
 	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
-		   " oom=%u\n",
+		   " oom=%u wrq=%u\n",
 		   atomic_read(&fscache_n_acquires),
 		   atomic_read(&fscache_n_acquires_null),
 		   atomic_read(&fscache_n_acquires_no_cache),
 		   atomic_read(&fscache_n_acquires_ok),
 		   atomic_read(&fscache_n_acquires_nobufs),
-		   atomic_read(&fscache_n_acquires_oom));
+		   atomic_read(&fscache_n_acquires_oom),
+		   atomic_read(&fscache_n_acquires_wait_relinq));
 
 	seq_printf(m, "Lookups: n=%u neg=%u pos=%u crt=%u tmo=%u\n",
 		   atomic_read(&fscache_n_object_lookups),
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 686cfe997ed2..d9a969642da7 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -30,11 +30,13 @@ enum fscache_cookie_trace {
 	fscache_cookie_get_attach_object,
 	fscache_cookie_get_reacquire,
 	fscache_cookie_get_register_netfs,
+	fscache_cookie_get_wait,
 	fscache_cookie_put_acquire_nobufs,
 	fscache_cookie_put_dup_netfs,
 	fscache_cookie_put_relinquish,
 	fscache_cookie_put_object,
 	fscache_cookie_put_parent,
+	fscache_cookie_put_wait,
 };
 
 enum fscache_page_trace {
@@ -96,11 +98,13 @@ enum fscache_page_op_trace {
 	EM(fscache_cookie_get_attach_object,	"GET obj")		\
 	EM(fscache_cookie_get_reacquire,	"GET raq")		\
 	EM(fscache_cookie_get_register_netfs,	"GET net")		\
+	EM(fscache_cookie_get_wait,		"GET wai")		\
 	EM(fscache_cookie_put_acquire_nobufs,	"PUT nbf")		\
 	EM(fscache_cookie_put_dup_netfs,	"PUT dnt")		\
 	EM(fscache_cookie_put_relinquish,	"PUT rlq")		\
 	EM(fscache_cookie_put_object,		"PUT obj")		\
-	E_(fscache_cookie_put_parent,		"PUT prn")
+	EM(fscache_cookie_put_parent,		"PUT prn")		\
+	E_(fscache_cookie_put_wait,		"PUT wai")
 
 #define fscache_page_traces						\
 	EM(fscache_page_cached,			"Cached ")		\
