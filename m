Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FA72087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfICLmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfICLmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:15 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 739053DE04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:14 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id z2so10273102wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLy7o4oLEXBqxBZZZ/NIPFUvwsqY9GjSMePza+eZVbs=;
        b=aaiB/4/+7X2Bkhmbtxokfv0j6Gd2/QsXUlfttLk9h/zbjrB0IlpUQ54Z5XitNGuuCN
         b3NHxWvEhHdRANENizgGKKqCrTZMvXovGDc/tcLuJBUFckQJDxNZhid2c9U8jx+3kiLl
         PkgceiFYPv9W+Yu6AL2QlMbFqJwNW4O8Ux+x8PqBjA5j7jCRhkVbb5DlvKJv0YniQ8VI
         Ki6gswV6qS+X13xTx94g9oy/b9bjxpDYE7Tt1yV7AFQ/7O7sGeq3DGsfOMQ9bXlmQXTQ
         QrvBTXLZvrHRjo3DirkfH393P0W0myauZ1wlFvGyTt64mEuk1+EvblhJjEgTSJTAWmSF
         dKyw==
X-Gm-Message-State: APjAAAXRQ8Yw4ugIAOUD7m7+5N4kGaRHFn4qt6y4QG/jFz9Y5Nq5e95b
        REiE7+UhbV2lNr5+9CAFqlHtC2Kbjdp98Pq2lBR8kQ1C70HJVYXJl8fcAGwBDn08AYEj+rHxlK+
        k6pa0K3/7FU4zQKMDsHYQiLV8
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr25740169wmj.7.1567510933178;
        Tue, 03 Sep 2019 04:42:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6RGSKvYd7Ei4KShEiFRuBi2/SNNfVQi80tpCiXR/UGiiN0LnD7xBpof2xYISd4cloLfmJPw==
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr25740136wmj.7.1567510932919;
        Tue, 03 Sep 2019 04:42:12 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:12 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 11/16] fuse: separate fuse device allocation and installation in fuse_conn
Date:   Tue,  3 Sep 2019 13:41:58 +0200
Message-Id: <20190903114203.8278-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

As of now fuse_dev_alloc() both allocates a fuse device and installs it in
fuse_conn list.  fuse_dev_alloc() can fail if fuse_device allocation fails.

virtio-fs needs to initialize multiple fuse devices (one per virtio queue).
It initializes one fuse device as part of call to fuse_fill_super_common()
and rest of the devices are allocated and installed after that.

But, we can't afford to fail after calling fuse_fill_super_common() as we
don't have a way to undo all the actions done by fuse_fill_super_common().
So to avoid failures after the call to fuse_fill_super_common(),
pre-allocate all fuse devices early and install them into fuse connection
later.

This patch provides two separate helpers for fuse device allocation and
fuse device installation in fuse_conn.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c   |  2 +-
 fs/fuse/dev.c    |  2 +-
 fs/fuse/fuse_i.h |  4 +++-
 fs/fuse/inode.c  | 25 +++++++++++++++++++++----
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 7bad5d428ce1..c0204e3e811f 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -505,7 +505,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 */
 	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
 
-	fud = fuse_dev_alloc(&cc->fc);
+	fud = fuse_dev_alloc_install(&cc->fc);
 	if (!fud) {
 		kfree(cc);
 		return -ENOMEM;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0bdb98a3b251..2df28ca7a654 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2337,7 +2337,7 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	if (new->private_data)
 		return -EINVAL;
 
-	fud = fuse_dev_alloc(fc);
+	fud = fuse_dev_alloc_install(fc);
 	if (!fud)
 		return -ENOMEM;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 617eca6046d2..21a2e86bbdf2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1056,7 +1056,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
  */
 void fuse_conn_put(struct fuse_conn *fc);
 
-struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc);
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
+struct fuse_dev *fuse_dev_alloc(void);
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
 void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e42e600e885b..a9e5b106e315 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1028,7 +1028,7 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	return 0;
 }
 
-struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc)
+struct fuse_dev *fuse_dev_alloc(void)
 {
 	struct fuse_dev *fud;
 	struct list_head *pq;
@@ -1044,16 +1044,33 @@ struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc)
 	}
 
 	fud->pq.processing = pq;
-	fud->fc = fuse_conn_get(fc);
 	fuse_pqueue_init(&fud->pq);
 
+	return fud;
+}
+EXPORT_SYMBOL_GPL(fuse_dev_alloc);
+
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
+{
+	fud->fc = fuse_conn_get(fc);
 	spin_lock(&fc->lock);
 	list_add_tail(&fud->entry, &fc->devices);
 	spin_unlock(&fc->lock);
+}
+EXPORT_SYMBOL_GPL(fuse_dev_install);
 
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
+{
+	struct fuse_dev *fud;
+
+	fud = fuse_dev_alloc();
+	if (!fud)
+		return NULL;
+
+	fuse_dev_install(fud, fc);
 	return fud;
 }
-EXPORT_SYMBOL_GPL(fuse_dev_alloc);
+EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
 
 void fuse_dev_free(struct fuse_dev *fud)
 {
@@ -1115,7 +1132,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_xattr = fuse_no_acl_xattr_handlers;
 
-	fud = fuse_dev_alloc(fc);
+	fud = fuse_dev_alloc_install(fc);
 	if (!fud)
 		goto err;
 
-- 
2.21.0

