Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF9BC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E56208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfDXQOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:14:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731026AbfDXQOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:14:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE9D130A9DDC;
        Wed, 24 Apr 2019 16:14:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FF851A92E;
        Wed, 24 Apr 2019 16:14:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/11] keys: Cache the hash value to avoid lots of
 recalculation
From:   David Howells <dhowells@redhat.com>
To:     ebiederm@xmission.com
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwalsh@redhat.com, vgoyal@redhat.com
Date:   Wed, 24 Apr 2019 17:14:03 +0100
Message-ID: <155612244324.8564.2078461476666774356.stgit@warthog.procyon.org.uk>
In-Reply-To: <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk>
References: <155612240208.8564.13865046977065545591.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Apr 2019 16:14:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the hash of the key's type and description in the index key so that
we're not recalculating it every time we look at a key during a search.
The hash function does a bunch of multiplications, so evading those is
probably worthwhile - especially as this is done for every key examined
during a search.

This also allows the methods used by assoc_array to get chunks of index-key
to be simplified.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h      |    3 +++
 security/keys/internal.h |    8 +-------
 security/keys/key.c      |    2 +-
 security/keys/keyring.c  |   28 ++++++++++++++++++++--------
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 33d87cb2d469..b39f5876b66d 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -86,6 +86,8 @@ struct keyring_list;
 struct keyring_name;
 
 struct keyring_index_key {
+	/* [!] If this structure is altered, the union in struct key must change too! */
+	unsigned long		hash;			/* Hash value */
 	union {
 		struct {
 #ifdef __LITTLE_ENDIAN /* Put desc_len at the LSB of x */
@@ -213,6 +215,7 @@ struct key {
 	union {
 		struct keyring_index_key index_key;
 		struct {
+			unsigned long	hash;
 			unsigned long	len_desc;
 			struct key_type	*type;		/* type of key */
 			char		*description;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 02592d24f13a..3154ba59a2f0 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -89,13 +89,7 @@ extern spinlock_t key_serial_lock;
 extern struct mutex key_construction_mutex;
 extern wait_queue_head_t request_key_conswq;
 
-
-static inline void key_set_index_key(struct keyring_index_key *index_key)
-{
-	size_t n = min_t(size_t, index_key->desc_len, sizeof(index_key->desc));
-	memcpy(index_key->desc, index_key->description, n);
-}
-
+extern void key_set_index_key(struct keyring_index_key *index_key);
 extern struct key_type *key_type_lookup(const char *type);
 extern void key_type_put(struct key_type *ktype);
 
diff --git a/security/keys/key.c b/security/keys/key.c
index 1d0250a8990e..1568b0028ba4 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -285,12 +285,12 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->index_key.description = kmemdup(desc, desclen + 1, GFP_KERNEL);
 	if (!key->index_key.description)
 		goto no_memory_3;
+	key->index_key.type = type;
 	key_set_index_key(&key->index_key);
 
 	refcount_set(&key->usage, 1);
 	init_rwsem(&key->sem);
 	lockdep_set_class(&key->sem, &type->lock_class);
-	key->index_key.type = type;
 	key->user = user;
 	key->quotalen = quotalen;
 	key->datalen = type->def_datalen;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7bb1f499996c..7f5f8d76dd7d 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -168,7 +168,7 @@ static u64 mult_64x32_and_fold(u64 x, u32 y)
 /*
  * Hash a key type and description.
  */
-static unsigned long hash_key_type_and_desc(const struct keyring_index_key *index_key)
+static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
 	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
 	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
@@ -206,10 +206,22 @@ static unsigned long hash_key_type_and_desc(const struct keyring_index_key *inde
 	 * zero for keyrings and non-zero otherwise.
 	 */
 	if (index_key->type != &key_type_keyring && (hash & fan_mask) == 0)
-		return hash | (hash >> (ASSOC_ARRAY_KEY_CHUNK_SIZE - level_shift)) | 1;
-	if (index_key->type == &key_type_keyring && (hash & fan_mask) != 0)
-		return (hash + (hash << level_shift)) & ~fan_mask;
-	return hash;
+		hash |= (hash >> (ASSOC_ARRAY_KEY_CHUNK_SIZE - level_shift)) | 1;
+	else if (index_key->type == &key_type_keyring && (hash & fan_mask) != 0)
+		hash = (hash + (hash << level_shift)) & ~fan_mask;
+	index_key->hash = hash;
+}
+
+/*
+ * Finalise an index key to include a part of the description actually in the
+ * index key and to add in the hash too.
+ */
+void key_set_index_key(struct keyring_index_key *index_key)
+{
+	size_t n = min_t(size_t, index_key->desc_len, sizeof(index_key->desc));
+	memcpy(index_key->desc, index_key->description, n);
+
+	hash_key_type_and_desc(index_key);
 }
 
 /*
@@ -227,7 +239,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
 	case 0:
-		return hash_key_type_and_desc(index_key);
+		return index_key->hash;
 	case 1:
 		return index_key->x;
 	case 2:
@@ -280,8 +292,8 @@ static int keyring_diff_objects(const void *object, const void *data)
 	int level, i;
 
 	level = 0;
-	seg_a = hash_key_type_and_desc(a);
-	seg_b = hash_key_type_and_desc(b);
+	seg_a = a->hash;
+	seg_b = b->hash;
 	if ((seg_a ^ seg_b) != 0)
 		goto differ;
 	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;

