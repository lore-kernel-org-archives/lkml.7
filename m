Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7186C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9498922DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfICLmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfICLmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:16 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D4CC5AFD9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:15 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t16so10331178wro.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kfQ4yDR8IW4hcJwhws0bc8ZuR6GN0FcetPuWp0WccA=;
        b=jMhEmg0Dgkei+YIpzePnLVY64dEq+xgdHzHIl7CBpFx+awXSThbgZyccde/1+eL5cl
         42g1XPKnsdGvfWlFnSir+Y3lEldvzv2JfKtRxXXxDIFGegd8EGVzYEJJ/2ibkCBKU/ZR
         4qGX/nYfHJyjl6lSkEUpFHOsDIr3RLJ484rRx3NHIdy1a4CAkiH50Lut9GXwqBQ9y2/f
         LMdRFidnXnLEhEgre1sbYbbR5kxi8cwDZVRuLRlDQIJMsdZubjg47rqmW19+DoJ0x4JI
         fFW862FVT5dgjiMcLIxOvaMpuC8AC3vplrvQjQRf/xcM2UkBvw+h2+Jmq1osUZ2ejjlT
         WTiA==
X-Gm-Message-State: APjAAAU8RkuJgnAgBGNVwWAfCF21P81suWiyCpD5oauu681wujBuet8N
        PcWlqPPVlw89x2BRjoWpu0kvY2ordQyit194hVgMdsSb71XFFbDFBZGgOE2roPyHQzb0gTglman
        JKyopchrgJzhePGlIr/e5r4vQ
X-Received: by 2002:a05:6000:108e:: with SMTP id y14mr13758528wrw.344.1567510934411;
        Tue, 03 Sep 2019 04:42:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1AGI4xKqVz5EcYkyc5Siy5dLHuU1mFsI16346yook6s2cisfeNuvS/+WVAVRJn/E2tkzy6A==
X-Received: by 2002:a05:6000:108e:: with SMTP id y14mr13758506wrw.344.1567510934231;
        Tue, 03 Sep 2019 04:42:14 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:13 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 12/16] fuse: delete dentry if timeout is zero
Date:   Tue,  3 Sep 2019 13:41:59 +0200
Message-Id: <20190903114203.8278-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't hold onto dentry in lru list if need to re-lookup it anyway at next
access.  Only do this if explicitly enabled, otherwise it could result in
performance regression.

More advanced version of this patch would periodically flush out dentries
from the lru which have gone stale.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c    | 28 +++++++++++++++++++++++++---
 fs/fuse/fuse_i.h |  3 +++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index dd0f64f7bc06..d44f11ac22ec 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -29,12 +29,28 @@ union fuse_dentry {
 	struct rcu_head rcu;
 };
 
-static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
+static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
-	((union fuse_dentry *) entry->d_fsdata)->time = time;
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	bool delete = !time && fc->delete_stale;
+	/*
+	 * Mess with DCACHE_OP_DELETE because dput() will be faster without it.
+	 * Don't care about races, either way it's just an optimization
+	 */
+	if ((!delete && (dentry->d_flags & DCACHE_OP_DELETE)) ||
+	    (delete && !(dentry->d_flags & DCACHE_OP_DELETE))) {
+		spin_lock(&dentry->d_lock);
+		if (!delete)
+			dentry->d_flags &= ~DCACHE_OP_DELETE;
+		else
+			dentry->d_flags |= DCACHE_OP_DELETE;
+		spin_unlock(&dentry->d_lock);
+	}
+
+	((union fuse_dentry *) dentry->d_fsdata)->time = time;
 }
 
-static inline u64 fuse_dentry_time(struct dentry *entry)
+static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
 }
@@ -255,8 +271,14 @@ static void fuse_dentry_release(struct dentry *dentry)
 	kfree_rcu(fd, rcu);
 }
 
+static int fuse_dentry_delete(const struct dentry *dentry)
+{
+	return time_before64(fuse_dentry_time(dentry), get_jiffies_64());
+}
+
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
+	.d_delete	= fuse_dentry_delete,
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 };
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 21a2e86bbdf2..700df42520ec 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -780,6 +780,9 @@ struct fuse_conn {
 	/** Does the filesystem support copy_file_range? */
 	unsigned no_copy_file_range:1;
 
+	/* Delete dentries that have gone stale */
+	unsigned int delete_stale:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
-- 
2.21.0

