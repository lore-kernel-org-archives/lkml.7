Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC861C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D702075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554946650;
	bh=J8pUOLTKBemhrk0Zj1JI1ARtgpoGFACctaNq/z2zqYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IekVDMfGiurxGVC4k8L9QzOwKKH14FwKfMT5IHeFuFGv1LyyZj3+BTYU721CQmtAY
	 Td6PQrC76N/5oBFmoZMiqrVC389grarX4CEOGBVsc0dPsZxSTM1trDX84lZyH3FYZW
	 CzJs28k3hurMrapGddy+Z2uUqJGD97tsheTsPwno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDKBh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:37:29 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56339 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfDKBh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:37:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 59C58B79A;
        Wed, 10 Apr 2019 21:37:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Apr 2019 21:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Tq6hWwswYs/S8V9g57LOLmjTNN0NoV+f6Q5VLbbSnZY=; b=2CRQThrQ
        eRsRFpQwkExGuy4vU8Wmq+XtUbO/D19tvIhEaDKMVcNYwDQ46PNrEAI8EH8/HKx7
        FTIM1nhNO2pXs4zZKFKogUkU1Z6hCDQD9Zwn4jUDztIlyNa/kBlLxB10AXVs2B9r
        /COdMWuyRClZFWnN24mFPzhXKsiV+cU9aItt0t4fyZzSfQ4e8YWiQMv8tm9xFVu+
        DXPS5uvMffVixFrAjqTvzdxbdvXap+uO7hpIIAIu+cHzXJyRdYn3Wew5OKX41vf9
        sRPV41XoTj7YNB0Tj+ixOAUbqElipOaRs0ZJSRekdMJGWlQ6nyG5gZCye3z//aPn
        2fQUbHpFdTBFkw==
X-ME-Sender: <xms:VpquXMGS26eFg6i-es3Z8Mh3hisNGC2C1S9fAsmsqMgAh3NK2gIGsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudejuddrudelrdduleegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:VpquXB8u36Lty0pKwbuPGBrpMgmuYVY9KZDjm07gm79pm7Dq4MLy_w>
    <xmx:VpquXMjiKuctTUwsZZF5d5GT0XNgcScCg-0nVv93o40zIaFVfsr_fw>
    <xmx:VpquXH_V71LveNuTW3SNdBCUpHRhEAx0GBiCvSabhy7Hw0whIyvmXg>
    <xmx:VpquXNLrgar-UUH1BZVBzzI8LezKEIfe0xO-WnSCgAqpWkQ257vaVw>
Received: from eros.localdomain (124-171-19-194.dyn.iinet.net.au [124.171.19.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A211E408B;
        Wed, 10 Apr 2019 21:37:18 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 13/15] dcache: Provide a dentry constructor
Date:   Thu, 11 Apr 2019 11:34:39 +1000
Message-Id: <20190411013441.5415-14-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411013441.5415-1-tobin@kernel.org>
References: <20190411013441.5415-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support object migration on the dentry cache we need to have
a determined object state at all times. Without a constructor the object
would have a random state after allocation.

Provide a dentry constructor.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index aac41adf4743..606cfca20d42 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1603,6 +1603,16 @@ void d_invalidate(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_invalidate);
 
+static void dcache_ctor(void *p)
+{
+	struct dentry *dentry = p;
+
+	/* Mimic lockref_mark_dead() */
+	dentry->d_lockref.count = -128;
+
+	spin_lock_init(&dentry->d_lock);
+}
+
 /**
  * __d_alloc	-	allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -1658,7 +1668,7 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 
 	dentry->d_lockref.count = 1;
 	dentry->d_flags = 0;
-	spin_lock_init(&dentry->d_lock);
+
 	seqcount_init(&dentry->d_seq);
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
@@ -3091,14 +3101,17 @@ static void __init dcache_init_early(void)
 
 static void __init dcache_init(void)
 {
-	/*
-	 * A constructor could be added for stable state like the lists,
-	 * but it is probably not worth it because of the cache nature
-	 * of the dcache.
-	 */
-	dentry_cache = KMEM_CACHE_USERCOPY(dentry,
-		SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD|SLAB_ACCOUNT,
-		d_iname);
+	slab_flags_t flags =
+		SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | SLAB_MEM_SPREAD | SLAB_ACCOUNT;
+
+	dentry_cache =
+		kmem_cache_create_usercopy("dentry",
+					   sizeof(struct dentry),
+					   __alignof__(struct dentry),
+					   flags,
+					   offsetof(struct dentry, d_iname),
+					   sizeof_field(struct dentry, d_iname),
+					   dcache_ctor);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
-- 
2.21.0

