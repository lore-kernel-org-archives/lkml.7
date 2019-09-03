Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F94BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360FC2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfICLku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:40:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfICLkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:40:49 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C90381F13
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:40:49 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so6875806wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=utliAxXHlzv/OkA2fKwkZhMhH80mu0eBxhklhX2mOKE=;
        b=qzBKbUV2RDNuRHBDX3MaId99DmjGV5pBqRLI7VnEDKXKbPFBnCNdrhla1Wv+Lm8Ohr
         yVRFIfon2J+traLNa/Uf5pN++je9rQE0+ZoCvsYo4iQJQ6xrk6gMxvfFy2womcjIJi/E
         tTYgL7ltUMFdX6GbYMlYTXXQPUIySUe3uAOXF0Eso8LlWs4tGqgTpbbGVAE9VKC3lXJj
         OWbQoZe5tj7ULZAFNAykN3ruatEnX2p7/x4CDVc/6+cEeZXjxBobyTUvIVmi8NJcrO/V
         FWITuoO6rgPS+nFOk91gSoQAfB0Dnr9gOEaFPnaIb5tvcZjl2r28Tb84Cudxw1acqg1h
         e2Qw==
X-Gm-Message-State: APjAAAWhfD7YBmJ/xbbAMh1xfLZ3lHQNl+iFzjfLuV8YH8Ul9vWXImcS
        hJ2OWtzuYLER/ociZJeWSlZgboy/zzyy3S52jXsPBCgn1wM7d3nFb9Fdu1hxbuJSvooWat2W7mu
        WFz5Rvk0YVG+09tSB9kA/jNlz
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr43374376wmf.176.1567510847262;
        Tue, 03 Sep 2019 04:40:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMCBM14tG/0MBT/Fvv9aOKldtm4+v9uJCHaNYSDrxbguWdlacEKZgsi+EmXgjnGTm4vUpItQ==
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr43374359wmf.176.1567510847039;
        Tue, 03 Sep 2019 04:40:47 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id b3sm9823058wrw.4.2019.09.03.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:40:46 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 05/16] fuse: export fuse_len_args()
Date:   Tue,  3 Sep 2019 13:40:33 +0200
Message-Id: <20190903114044.8201-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

virtio-fs will need to query the length of fuse_arg lists.  Make the symbol
visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 7 ++++---
 fs/fuse/fuse_i.h | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 137b3de511ac..985654560d1a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -350,7 +350,7 @@ void fuse_put_request(struct fuse_conn *fc, struct fuse_req *req)
 }
 EXPORT_SYMBOL_GPL(fuse_put_request);
 
-static unsigned len_args(unsigned numargs, struct fuse_arg *args)
+unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 {
 	unsigned nbytes = 0;
 	unsigned i;
@@ -360,6 +360,7 @@ static unsigned len_args(unsigned numargs, struct fuse_arg *args)
 
 	return nbytes;
 }
+EXPORT_SYMBOL_GPL(fuse_len_args);
 
 static u64 fuse_get_unique(struct fuse_iqueue *fiq)
 {
@@ -375,7 +376,7 @@ static unsigned int fuse_req_hash(u64 unique)
 static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
-		len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
+		fuse_len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
 	list_add_tail(&req->list, &fiq->pending);
 	wake_up_locked(&fiq->waitq);
 	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
@@ -1912,7 +1913,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
 	if (out->h.error)
 		return nbytes != reqsize ? -EINVAL : 0;
 
-	reqsize += len_args(out->numargs, out->args);
+	reqsize += fuse_len_args(out->numargs, out->args);
 
 	if (reqsize < nbytes || (reqsize > nbytes && !out->argvar))
 		return -EINVAL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 67521103d3b2..81e436c9620a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1098,4 +1098,9 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
 
+/**
+ * Return the number of bytes in an arguments list
+ */
+unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.21.0

