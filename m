Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D54AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1F22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663953;
	bh=UTCSn6C0sWaXBz/PlBMGu0fR2eDGtvOJ70SkoE/ig0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FmtT60aWQGEWJfHSirlq4dLuu5wWWexCTGDa2j/F3yGd6OE9HX95dJuJFmHRuZQUE
	 D08jJ6f4PR9MFD8R2Ah5bD0iLFU/bjykXi0uRv9QpJ3719FRzOIXYHKPHcuWb5x7QG
	 k+5WjZP1tay9BGUDvmPu7UcGL4EXqhsMa2G9TeP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbfC0FTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56459 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfC0FTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C23121F16;
        Wed, 27 Mar 2019 01:19:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=/V9EiCbEBqtmhZjnGp57UVdGbBwjsSOkOxWMeC1aoik=; b=D1hYvx32
        iRuhtHJCBJqKnUcpWAqXpD6HKA1CSf3HFuWlv8C6PHu1j2ysnAFn5en9sQUWhrV8
        byWKpXo4Iuj4zTFMOAjCK4gFv6ZmChVdaHCXew9ueIPl+f7ufloiVPAL/Bc3kWRT
        KbWbGvGmT4g5hZKjUpDfGi04EX7UDDpoe2M8z7TX7OBCa8xZfmDGBvYVoJkYVnXx
        QdWuc1Ub1qXn6/yqWeY5XU1Im5NdxDnaKBcvjvh/1vASm2xN9IZGDRVKhxORdkVT
        E1ONvboiTJm4fdpPhY2qo4ijfBk0fhNXGiZ+2nkNa/MEaplo4OjbZWusHNRNLPMD
        9WGugFLCHnZo8A==
X-ME-Sender: <xms:zAebXPYvaW2uDSRujKsoecwCUZ2uxk59o8KAulDrqRon5DQgk49-KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeple
X-ME-Proxy: <xmx:zQebXDyDkylcV2aGBDl93VggJ1BaSUNOk8Gd_lyWcSvwkzieUzoEBQ>
    <xmx:zQebXCKvM1qhq2vVNouzQj9YLEW4da2axHr_qIEUTEO3g7A3hk32Hg>
    <xmx:zQebXFqwxGnoxAzfU6e4iHbvDYNVYSrYqAMR-XfZd3qW_Djkd9e37g>
    <xmx:zQebXOjr2ZlYtBnHaYoMDZFgzCmXYOT5zHZzFvObO6m-SWRPF67pmQ>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8491E415C;
        Wed, 27 Mar 2019 01:19:05 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/24] dcache: Fix docstring comment for d_drop()
Date:   Wed, 27 Mar 2019 16:17:04 +1100
Message-Id: <20190327051717.23225-12-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the function docstring comment for d_drop() is combined for
d_drop() and __d_drop().  Also the comment includes information on
internal function ___d_drop(), this information does not need to be
exposed via the kernel docs.

Put internal documentation in a non-docstring comment above the relevant
function (___d_drop()).

Add docstring comments to both d_drop() and __d_drop() (both are
external functions).  Make d_drop() comment very simple, pointing to
__d_drop() comment.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 141ffe27e95a..8094ae9c2d1b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -429,21 +429,11 @@ static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 	list_lru_isolate_move(lru, &dentry->d_lru, list);
 }
 
-/**
- * d_drop - drop a dentry
- * @dentry: dentry to drop
- *
- * d_drop() unhashes the entry from the parent dentry hashes, so that it won't
- * be found through a VFS lookup any more. Note that this is different from
- * deleting the dentry - d_delete will try to mark the dentry negative if
- * possible, giving a successful _negative_ lookup, while d_drop will
- * just make the cache lookup fail.
- *
- * d_drop() is used mainly for stuff that wants to invalidate a dentry for some
- * reason (NFS timeouts or autofs deletes).
+/*
+ * ___d_drop() - Drop a dentry.
+ * @dentry: The dentry to drop.
  *
- * __d_drop requires dentry->d_lock
- * ___d_drop doesn't mark dentry as "unhashed"
+ * Does not mark dentry as "unhashed"
  *   (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
  */
 static void ___d_drop(struct dentry *dentry)
@@ -464,6 +454,21 @@ static void ___d_drop(struct dentry *dentry)
 	hlist_bl_unlock(b);
 }
 
+/**
+ * __d_drop() - Drop a dentry.
+ * @dentry: The dentry to drop.
+ *
+ * Unhashes the entry from the parent dentry hashes, so that it won't
+ * be found through a VFS lookup any more. Note that this is different
+ * from deleting the dentry - d_delete() will try to mark the dentry
+ * negative if possible, giving a successful _negative_ lookup, while
+ * __d_drop() will just make the cache lookup fail.
+ *
+ * __d_drop() is used mainly for stuff that wants to invalidate a dentry
+ * for some reason (NFS timeouts or autofs deletes).
+ *
+ * Context: Caller must hold the dentry->d_lock.
+ */
 void __d_drop(struct dentry *dentry)
 {
 	if (!d_unhashed(dentry)) {
@@ -474,6 +479,14 @@ void __d_drop(struct dentry *dentry)
 }
 EXPORT_SYMBOL(__d_drop);
 
+/**
+ * d_drop() - Drop a dentry.
+ * @dentry: The dentry to drop.
+ *
+ * Wrapper around __d_drop() that handles the locking.
+ *
+ * Context: Takes/drops the dentry->d_lock.
+ */
 void d_drop(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-- 
2.21.0

