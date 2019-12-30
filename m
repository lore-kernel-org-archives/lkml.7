Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A1C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EDF20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg1kpMTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfL3FFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:05:04 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:34055 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfL3FFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:05:03 -0500
Received: by mail-pg1-f173.google.com with SMTP id r11so17466717pgf.1;
        Sun, 29 Dec 2019 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHyB/HrIPhnwvT/YxRviUgKQLDplshHlpTxW24GYsOc=;
        b=eg1kpMTiQtomAdmgU5lC952uek2TGW/I8+IMpAxIrrRglNrp1ZWMiflPeCclKuJgT6
         xvzoedRdqiTmlCh0k8FthuwOgwDqSMOjMIb8tCtrihnV3ZFyQtN8fkU5aB69I3a2D4ci
         5WCvimMgWE9hPd7LUwolXxCSdtzy82KQKq3HX7TqhhNniByHeIXqGhT8eI2rX8GYl+R7
         Yn+sgDPxm6QgChTdJcMrF3Q442wlaavD/NCoxHyOsBqwLQBYIDuKuXXzQKQFs7hxPJZ6
         y3cIilpv+vGtP/igg8yuEmpgHMQZ8xu3O2U3UXSYDofgYxYe4QKfTg5fDgxvZSOKPKEY
         5Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHyB/HrIPhnwvT/YxRviUgKQLDplshHlpTxW24GYsOc=;
        b=e1VN2cwDwGsB7D4HqZTDQQfDReIdkIsQMALZMZkGkIFoOMtvAzeyn0byMs0O590nH4
         7/abUSNsqmGnCUn6cnzhHcqTTIjyHRYy/UtgFGxAKETUtO7ONt028czfygQpxqbaFV6C
         63TlRfVS0BIOYniBpe6gvbcG2kOr59BOqMwNKC9JSEkq6DJjZjfy5CfFa3mMyHKnpOsU
         3ParP7BpKXDEZrJqR8tlYQuteRsYVta8RUj2WFhFsRMJAo3faz0AAfbHD2VIPI4o7QGx
         jao1loksJ3lSLC0ZR1mKBZM6pJNt8h+QCIZ5gDb3rGs5UfZzqPET58HxP6wYprGia4S/
         olcw==
X-Gm-Message-State: APjAAAX6jrWvaxXpqLOpcYYgP648q5qbGJdP3lVFDf/Vd9+XgBfcikaj
        zAwnNbo8ma3SIoYJf+p5HjA=
X-Google-Smtp-Source: APXvYqyDoFEYICpBPkmoWkTVOVUWZ2vWqjJoL7iQtPDixKVqGG86d1XkQ097MQL4+zQkLw/+3IMmKQ==
X-Received: by 2002:a65:644b:: with SMTP id s11mr70339567pgv.332.1577682302353;
        Sun, 29 Dec 2019 21:05:02 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id r2sm45054727pgv.16.2019.12.29.21.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 21:05:02 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/5] Documentation: nfs: rpc-cache: convert to ReST
Date:   Mon, 30 Dec 2019 02:04:44 -0300
Message-Id: <d156463868b83fb6f6eb5466b1012511bc582acf.1577681894.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577681894.git.dwlsalmeida@gmail.com>
References: <cover.1577681894.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert rpc-cache.txt to ReST. Changes aim to improve presentation
but the content itself remains mostly the same.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/filesystems/nfs/index.rst       |   1 +
 .../nfs/{rpc-cache.txt => rpc-cache.rst}      | 136 ++++++++++--------
 2 files changed, 78 insertions(+), 59 deletions(-)
 rename Documentation/filesystems/nfs/{rpc-cache.txt => rpc-cache.rst} (66%)

diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
index d19ba592779a..52f4956e7770 100644
--- a/Documentation/filesystems/nfs/index.rst
+++ b/Documentation/filesystems/nfs/index.rst
@@ -7,3 +7,4 @@ NFS
    :maxdepth: 1
 
    pnfs
+   rpc-cache
diff --git a/Documentation/filesystems/nfs/rpc-cache.txt b/Documentation/filesystems/nfs/rpc-cache.rst
similarity index 66%
rename from Documentation/filesystems/nfs/rpc-cache.txt
rename to Documentation/filesystems/nfs/rpc-cache.rst
index c4dac829db0f..fee430bcd31f 100644
--- a/Documentation/filesystems/nfs/rpc-cache.txt
+++ b/Documentation/filesystems/nfs/rpc-cache.rst
@@ -1,9 +1,14 @@
-	This document gives a brief introduction to the caching
+=========
+RPC Cache
+=========
+
+This document gives a brief introduction to the caching
 mechanisms in the sunrpc layer that is used, in particular,
 for NFS authentication.
 
-CACHES
+Caches
 ======
+
 The caching replaces the old exports table and allows for
 a wide variety of values to be caches.
 
@@ -12,6 +17,7 @@ quite possibly very different in content and use.  There is a corpus
 of common code for managing these caches.
 
 Examples of caches that are likely to be needed are:
+
   - mapping from IP address to client name
   - mapping from client name and filesystem to export options
   - mapping from UID to list of GIDs, to work around NFS's limitation
@@ -21,6 +27,7 @@ Examples of caches that are likely to be needed are:
   - mapping from network identify to public key for crypto authentication.
 
 The common code handles such things as:
+
    - general cache lookup with correct locking
    - supporting 'NEGATIVE' as well as positive entries
    - allowing an EXPIRED time on cache items, and removing
@@ -35,60 +42,66 @@ The common code handles such things as:
 Creating a Cache
 ----------------
 
-1/ A cache needs a datum to store.  This is in the form of a
-   structure definition that must contain a
-     struct cache_head
+#. A cache needs a datum to store.  This is in the form of a
+   structure definition that must contain a struct cache_head
    as an element, usually the first.
    It will also contain a key and some content.
    Each cache element is reference counted and contains
    expiry and update times for use in cache management.
-2/ A cache needs a "cache_detail" structure that
+#. A cache needs a "cache_detail" structure that
    describes the cache.  This stores the hash table, some
    parameters for cache management, and some operations detailing how
    to work with particular cache items.
-   The operations requires are:
-   	struct cache_head *alloc(void)
-		This simply allocates appropriate memory and returns
-   		a pointer to the cache_detail embedded within the
-		structure
-	void cache_put(struct kref *)
-		This is called when the last reference to an item is
-		dropped.  The pointer passed is to the 'ref' field
-		in the cache_head.  cache_put should release any
-		references create by 'cache_init' and, if CACHE_VALID
-		is set, any references created by cache_update.
-		It should then release the memory allocated by
-   		'alloc'.
-        int match(struct cache_head *orig, struct cache_head *new)
-		test if the keys in the two structures match.  Return
-		1 if they do, 0 if they don't.
-	void init(struct cache_head *orig, struct cache_head *new)
-		Set the 'key' fields in 'new' from 'orig'.  This may
-		include taking references to shared objects.
-	void update(struct cache_head *orig, struct cache_head *new)
-		Set the 'content' fileds in 'new' from 'orig'.
-	int cache_show(struct seq_file *m, struct cache_detail *cd,
-			struct cache_head *h)
-		Optional.  Used to provide a /proc file that lists the
-		contents of a cache.  This should show one item,
-   		usually on just one line.
-	int cache_request(struct cache_detail *cd, struct cache_head *h,
-   		char **bpp, int *blen)
-		Format a request to be send to user-space for an item
-   		to be instantiated.  *bpp is a buffer of size *blen.
-		bpp should be moved forward over the encoded message,
-		and  *blen should be reduced to show how much free
-		space remains.  Return 0 on success or <0 if not
-		enough room or other problem.
-	int cache_parse(struct cache_detail *cd, char *buf, int len)
-		A message from user space has arrived to fill out a
-		cache entry.  It is in 'buf' of length 'len'.
-		cache_parse should parse this, find the item in the
-		cache with sunrpc_cache_lookup_rcu, and update the item
-		with sunrpc_cache_update.
-
-
-3/ A cache needs to be registered using cache_register().  This
+
+   The operations are:
+
+    struct cache_head \*alloc(void)
+      This simply allocates appropriate memory and returns
+      a pointer to the cache_detail embedded within the
+      structure
+
+    void cache_put(struct kref \*)
+      This is called when the last reference to an item is
+      dropped.  The pointer passed is to the 'ref' field
+      in the cache_head.  cache_put should release any
+      references create by 'cache_init' and, if CACHE_VALID
+      is set, any references created by cache_update.
+      It should then release the memory allocated by
+      'alloc'.
+
+    int match(struct cache_head \*orig, struct cache_head \*new)
+      test if the keys in the two structures match.  Return
+      1 if they do, 0 if they don't.
+
+    void init(struct cache_head \*orig, struct cache_head \*new)
+      Set the 'key' fields in 'new' from 'orig'.  This may
+      include taking references to shared objects.
+
+    void update(struct cache_head \*orig, struct cache_head \*new)
+      Set the 'content' fileds in 'new' from 'orig'.
+
+    int cache_show(struct seq_file \*m, struct cache_detail \*cd, struct cache_head \*h)
+      Optional.  Used to provide a /proc file that lists the
+      contents of a cache.  This should show one item,
+      usually on just one line.
+
+    int cache_request(struct cache_detail \*cd, struct cache_head \*h, char \*\*bpp, int \*blen)
+      Format a request to be send to user-space for an item
+      to be instantiated.  \*bpp is a buffer of size \*blen.
+      bpp should be moved forward over the encoded message,
+      and  \*blen should be reduced to show how much free
+      space remains.  Return 0 on success or <0 if not
+      enough room or other problem.
+
+    int cache_parse(struct cache_detail \*cd, char \*buf, int len)
+      A message from user space has arrived to fill out a
+      cache entry.  It is in 'buf' of length 'len'.
+      cache_parse should parse this, find the item in the
+      cache with sunrpc_cache_lookup_rcu, and update the item
+      with sunrpc_cache_update.
+
+
+#. A cache needs to be registered using cache_register().  This
    includes it on a list of caches that will be regularly
    cleaned to discard old data.
 
@@ -107,7 +120,7 @@ cache_check will return -ENOENT in the entry is negative or if an up
 call is needed but not possible, -EAGAIN if an upcall is pending,
 or 0 if the data is valid;
 
-cache_check can be passed a "struct cache_req *".  This structure is
+cache_check can be passed a "struct cache_req\*".  This structure is
 typically embedded in the actual request and can be used to create a
 deferred copy of the request (struct cache_deferred_req).  This is
 done when the found cache item is not uptodate, but the is reason to
@@ -139,9 +152,11 @@ The 'channel' works a bit like a datagram socket. Each 'write' is
 passed as a whole to the cache for parsing and interpretation.
 Each cache can treat the write requests differently, but it is
 expected that a message written will contain:
+
   - a key
   - an expiry time
   - a content.
+
 with the intention that an item in the cache with the give key
 should be create or updated to have the given content, and the
 expiry time should be set on that item.
@@ -156,7 +171,8 @@ If there are no more requests to return, read will return EOF, but a
 select or poll for read will block waiting for another request to be
 added.
 
-Thus a user-space helper is likely to:
+Thus a user-space helper is likely to::
+
   open the channel.
     select for readable
     read a request
@@ -175,12 +191,13 @@ Each cache should also define a "cache_request" method which
 takes a cache item and encodes a request into the buffer
 provided.
 
-Note: If a cache has no active readers on the channel, and has had not
-active readers for more than 60 seconds, further requests will not be
-added to the channel but instead all lookups that do not find a valid
-entry will fail.  This is partly for backward compatibility: The
-previous nfs exports table was deemed to be authoritative and a
-failed lookup meant a definite 'no'.
+.. note::
+  If a cache has no active readers on the channel, and has had not
+  active readers for more than 60 seconds, further requests will not be
+  added to the channel but instead all lookups that do not find a valid
+  entry will fail.  This is partly for backward compatibility: The
+  previous nfs exports table was deemed to be authoritative and a
+  failed lookup meant a definite 'no'.
 
 request/response format
 -----------------------
@@ -193,10 +210,11 @@ with precisely one newline character which should be at the end.
 Fields within the record should be separated by spaces, normally one.
 If spaces, newlines, or nul characters are needed in a field they
 much be quoted.  two mechanisms are available:
-1/ If a field begins '\x' then it must contain an even number of
+
+#. If a field begins '\x' then it must contain an even number of
    hex digits, and pairs of these digits provide the bytes in the
    field.
-2/ otherwise a \ in the field must be followed by 3 octal digits
+#. otherwise a \ in the field must be followed by 3 octal digits
    which give the code for a byte.  Other characters are treated
    as them selves.  At the very least, space, newline, nul, and
    '\' must be quoted in this way.
-- 
2.24.1

