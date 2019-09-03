Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C40DC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D892087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfICLm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfICLmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:19 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A20A8665D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:18 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j10so10261764wrb.16
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlGDqhpnQu80aWT3+UQ4GXKsIMYAlSnKZ+dv4gHC3Hc=;
        b=R/8apl7iOBPGLTqJFkpTydDNV7l0SX6QwJYvD3NVIm0h1rNZ7hNg6eClNPwGk6lXJY
         cAgSXATEEtVKertEtsyl3l2yfSp/VpORE1s2miEqWzxvMTU15b0ZmgxgE7/jLhrnoLO9
         1t+CBq8RD9mmycXIowawBMHHKHqJMLHnc3M3Jqp/czdzHLJOD1Jogli2WANQ91Pqq7I1
         Q5Pl/G1HjF10Rkay2cNmLXwm3t+sOHomILC97LKxR3vE+HtpUpV45SaajhMbocLt81mz
         qdpujp+unip28a5JQ+UxuPLsuXssvjcEXHzlsUDarWjXNu3w91KC6DVIjKho3lW3dPVn
         1RgA==
X-Gm-Message-State: APjAAAU7z9PcwLKJT0jyT6CvoUZ08EA0mH1XLVZdp2Le01odo9oFxdLx
        LrAmE6j6N+aeOle7OZucNDzNwZNmFNEM9d+j/VgtSvVQsA6P607KyQBJBPfjlvOEJmvF9Vg0+kI
        rAx+/ZFVQFsxq74INRWI+IXUI
X-Received: by 2002:a7b:c752:: with SMTP id w18mr10357392wmk.129.1567510937102;
        Tue, 03 Sep 2019 04:42:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzU2BTrZTlmeXjb6Rl/UKS2g/56C1DRNK25So4DEu1TK7UZmTfX7tCIR5Sxym/zDabm2IfCdA==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr10357369wmk.129.1567510936895;
        Tue, 03 Sep 2019 04:42:16 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:16 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 14/16] fuse: allow skipping control interface and forced unmount
Date:   Tue,  3 Sep 2019 13:42:01 +0200
Message-Id: <20190903114203.8278-9-mszeredi@redhat.com>
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

virtio-fs does not support aborting requests which are being
processed. That is requests which have been sent to fuse daemon on host.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_i.h | 8 ++++++++
 fs/fuse/inode.c  | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 48a3db6870ae..dbf73e5d5b38 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -556,6 +556,8 @@ struct fuse_fs_context {
 	bool default_permissions:1;
 	bool allow_other:1;
 	bool destroy:1;
+	bool no_control:1;
+	bool no_force_umount:1;
 	unsigned int max_read;
 	unsigned int blksize;
 	const char *subtype;
@@ -784,6 +786,12 @@ struct fuse_conn {
 	/* Delete dentries that have gone stale */
 	unsigned int delete_stale:1;
 
+	/** Do not create entry in fusectl fs */
+	unsigned int no_control:1;
+
+	/** Do not allow MNT_FORCE umount */
+	unsigned int no_force_umount:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 10b777ece3b8..7fa0dcc6f565 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -364,7 +364,10 @@ void fuse_unlock_inode(struct inode *inode, bool locked)
 
 static void fuse_umount_begin(struct super_block *sb)
 {
-	fuse_abort_conn(get_fuse_conn_super(sb));
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+
+	if (!fc->no_force_umount)
+		fuse_abort_conn(fc);
 }
 
 static void fuse_send_destroy(struct fuse_conn *fc)
@@ -1153,6 +1156,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;
 	fc->max_read = max_t(unsigned, 4096, ctx->max_read);
+	fc->no_control = ctx->no_control;
+	fc->no_force_umount = ctx->no_force_umount;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-- 
2.21.0

