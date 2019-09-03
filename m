Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F7A2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfICLmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53903 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfICLmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:07 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5975C85365
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:06 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n2so2030695wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vn/jz2gcH9WzFmEVn9PNqatEbrLnybKVejt0ugjCIsw=;
        b=XzqF+AK5XI+JwXIM+4emdndkN202/LBePLSwXvnROPfMJmg4dP2nsyMnC3dcchwXbB
         ERZVOt60u7Sb1vnv4DOD5zfeDD+WmpvMQ9SbDgYpmdrnT65HMe0OF+eFfSMdnNbkIra+
         yQ3tkti4VS3s79esw40c1yhTGMrB4/zHT2kt8/XEaUGvCLc8tRVhUPi2I84oOWPRFjmp
         fDLw1wCmjHSVR6Lw0PVVPmo9poqUh+LXR7msk7yBvYkHrCtQYemUnJR0sOzP0wV8BLVB
         z50tp9HF6Tgma/9lX4oKGPjEE9A7B2EAxMoNVYdHYqVD8YOgpZWd/BQv4FtbUHELJXpm
         RIPg==
X-Gm-Message-State: APjAAAWz0xwdq+gRCFAjVGrFdiyB7BI1CMjgTbPmNEH0Sdu03aoGmfmO
        3jZBhxZ0gFc+euEC+j0Y/K0UwYViOU0ZMVQ7hku48BZY0rbw1Xd7gllIahZNeVji4+4FUX51nwT
        jHXyY3HNg5IazorINevOEByGi
X-Received: by 2002:adf:cd02:: with SMTP id w2mr24310191wrm.327.1567510925176;
        Tue, 03 Sep 2019 04:42:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYOxWV68FVlLb8fgvNxM4Wpgmp33Vrksyfgrwh2b6mFu7usl4RaqMBglgZaRcAZYU+InCz9w==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr24310173wrm.327.1567510925032;
        Tue, 03 Sep 2019 04:42:05 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:04 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 06/16] fuse: export fuse_send_init_request()
Date:   Tue,  3 Sep 2019 13:41:53 +0200
Message-Id: <20190903114203.8278-1-mszeredi@redhat.com>
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

This will be used by virtio-fs to send init request to fuse server after
initialization of virt queues.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 1 +
 fs/fuse/fuse_i.h | 1 +
 fs/fuse/inode.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 985654560d1a..bd2e5958d2f9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -139,6 +139,7 @@ void fuse_request_free(struct fuse_req *req)
 	fuse_req_pages_free(req);
 	kmem_cache_free(fuse_req_cachep, req);
 }
+EXPORT_SYMBOL_GPL(fuse_request_free);
 
 void __fuse_get_request(struct fuse_req *req)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 81e436c9620a..8ced5e74e5a8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -994,6 +994,7 @@ void fuse_conn_put(struct fuse_conn *fc);
 
 struct fuse_dev *fuse_dev_alloc(struct fuse_conn *fc);
 void fuse_dev_free(struct fuse_dev *fud);
+void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req);
 
 /**
  * Add connection to control filesystem
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e3375ce8e97f..31cf0c47da13 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -962,7 +962,7 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_req *req)
 	wake_up_all(&fc->blocked_waitq);
 }
 
-static void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
+void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct fuse_init_in *arg = &req->misc.init_in;
 
@@ -992,6 +992,7 @@ static void fuse_send_init(struct fuse_conn *fc, struct fuse_req *req)
 	req->end = process_init_reply;
 	fuse_request_send_background(fc, req);
 }
+EXPORT_SYMBOL_GPL(fuse_send_init);
 
 static void fuse_free_conn(struct fuse_conn *fc)
 {
-- 
2.21.0

