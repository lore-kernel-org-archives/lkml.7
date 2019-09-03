Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39240C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6CE2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfICLmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfICLmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:18 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F2FF8665D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:17 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n11so2727863wmc.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeZXCfnYvmL3y3gF4qCUZLrYhq10GC1ogANcUKKc3zk=;
        b=i2JUhEgOEZXleqslhKV1MhHPyQG/oV5JV+08081KUs2zITGajNLRJYz+64dWoVLdqi
         r25G5er1iDQztsuzJ+UVFENLPEzP7kDngUqDI3lKoQbt7cEQuX7n5JJHAM440d6VAC9z
         XGlUqpGX48kHozBKFeZfguO3aVW+w/sfSWHUl9mJGDU/5fEy4F31Eu91dSYYUh1CDdt5
         iX7BiV3yUqkG34+m4946VMc7SvjBAXeKbQoJQj/ijf9H+0M/xFzsqzYZiPV/M6zNUweW
         lsE9keSqprtng+4CNc+9MkqsueKYr1xMuFRcDufBFJzBUH1jl6DqY26p/O73vx9ayYPN
         SmcA==
X-Gm-Message-State: APjAAAXGOkghJG75Ag6iaHiO2Bzem2C2HEIpx11Nea20uBKGPIKneKmZ
        /QaG6IMXkLJd/kTKgvyldPCGLA6cCY1bNyV+Yl6rqXyj75ZyapSvezp4GcSEJKBOxR3HMJM+KtN
        BesjNHXzb4v7U3B7C7dAIbKG6
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr20015962wmf.70.1567510935724;
        Tue, 03 Sep 2019 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwpjkys4EiML6E3To64LiM+3315c/lCCOaiy0eibK4IHfM1xEUpIcGX6kcye/99fsIBFRb8ow==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr20015943wmf.70.1567510935555;
        Tue, 03 Sep 2019 04:42:15 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:15 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 13/16] fuse: dissociate DESTROY from fuseblk
Date:   Tue,  3 Sep 2019 13:42:00 +0200
Message-Id: <20190903114203.8278-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow virtio-fs to also send DESTROY request.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h |  9 +++++++++
 fs/fuse/inode.c  | 12 ++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 700df42520ec..48a3db6870ae 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -555,6 +555,7 @@ struct fuse_fs_context {
 	bool group_id_present:1;
 	bool default_permissions:1;
 	bool allow_other:1;
+	bool destroy:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -1072,6 +1073,13 @@ void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req);
  */
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
 
+/**
+ * Disassociate fuse connection from superblock and kill the superblock
+ *
+ * Calls kill_anon_super(), do not use with bdev mounts.
+ */
+void fuse_kill_sb_anon(struct super_block *sb);
+
 /**
  * Add connection to control filesystem
  */
@@ -1184,5 +1192,6 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
  * Get the next unique ID for a request
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
+void fuse_free_conn(struct fuse_conn *fc);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index a9e5b106e315..10b777ece3b8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -982,11 +982,12 @@ void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 }
 EXPORT_SYMBOL_GPL(fuse_send_init);
 
-static void fuse_free_conn(struct fuse_conn *fc)
+void fuse_free_conn(struct fuse_conn *fc)
 {
 	WARN_ON(!list_empty(&fc->devices));
 	kfree_rcu(fc, rcu);
 }
+EXPORT_SYMBOL_GPL(fuse_free_conn);
 
 static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 {
@@ -1162,7 +1163,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	/* Root dentry doesn't have .d_revalidate */
 	sb->s_d_op = &fuse_dentry_operations;
 
-	if (ctx->is_bdev) {
+	if (ctx->destroy) {
 		fc->destroy_req = fuse_request_alloc(0);
 		if (!fc->destroy_req)
 			goto err_put_root;
@@ -1291,8 +1292,10 @@ static int fuse_init_fs_context(struct fs_context *fc)
 	ctx->blksize = FUSE_DEFAULT_BLKSIZE;
 
 #ifdef CONFIG_BLOCK
-	if (fc->fs_type == &fuseblk_fs_type)
+	if (fc->fs_type == &fuseblk_fs_type) {
 		ctx->is_bdev = true;
+		ctx->destroy = true;
+	}
 #endif
 
 	fc->fs_private = ctx;
@@ -1316,11 +1319,12 @@ static void fuse_sb_destroy(struct super_block *sb)
 	}
 }
 
-static void fuse_kill_sb_anon(struct super_block *sb)
+void fuse_kill_sb_anon(struct super_block *sb)
 {
 	fuse_sb_destroy(sb);
 	kill_anon_super(sb);
 }
+EXPORT_SYMBOL_GPL(fuse_kill_sb_anon);
 
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
-- 
2.21.0

