Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522D2C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49322CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfICLgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48187 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfICLgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:53 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D4A881F13
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:36:52 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id c1so10255888wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsyL7og31crqN7mW+zNo/EDQhj9gbNoC++NWMLJEmWs=;
        b=AXRTRT/+TYoahA+4N7iRQ+UsezXzRQMVyf3QvI0f6np6UKyOWdf9/K2jWiVH5sjfeK
         j8HTvTzdkJCWlzq+oldeOdozP1cubdOXW3APmnOKxXQ1NFavklBzVMIqGiyDLGDcm6P0
         8u82BRIItzJ4epCRkBApf63KeN9Jud1AgMPRx0cCFu2kGq/Wbb0k/5n9HVIRWukbf0Bl
         mKPhjKE5hSwRNjHGZ+xeFjU5zWZKTNgqd4Umed5NAaOPrMZEZqc3ImC+D/VNdixcbPIJ
         X4tot3lliA4hRLX1T07k3QxrddnykRoFOeGHl5jbM1EN6/fzG4gajbRFLs8GOOoFQiCW
         2Yag==
X-Gm-Message-State: APjAAAX3EoT7i+iVBpD2rDNbXLlzZKpG1hPaVOAuTGnNzpuZK2lfXJC3
        UARyBnsk25vdJikQ91Z2Wja/Y7avs+1/MuurOldWyavV8qQHQM0VUSXvZV5GOt6fRsZdxIjmhQg
        nGOKDM0/QcMCnygCa7+6g5kY0
X-Received: by 2002:a5d:6a49:: with SMTP id t9mr8078607wrw.134.1567510610259;
        Tue, 03 Sep 2019 04:36:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwocwl2439SugQ27Vg4mzi8kOHuxJ+dSwBGojgwUcuGQuWd35PES6B2Iq8drLurJeiwa0hwcw==
X-Received: by 2002:a5d:6a49:: with SMTP id t9mr8078567wrw.134.1567510609935;
        Tue, 03 Sep 2019 04:36:49 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v186sm40446906wmb.5.2019.09.03.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:36:49 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 04/16] fuse: export fuse_end_request()
Date:   Tue,  3 Sep 2019 13:36:28 +0200
Message-Id: <20190903113640.7984-5-mszeredi@redhat.com>
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

virtio-fs will need to complete requests from outside fs/fuse/dev.c.  Make
the symbol visible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 19 ++++++++++---------
 fs/fuse/fuse_i.h |  5 +++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fdb85895737b..137b3de511ac 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -427,7 +427,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
  * the 'end' callback is called if given, else the reference to the
  * request is released
  */
-static void request_end(struct fuse_conn *fc, struct fuse_req *req)
+void fuse_request_end(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
@@ -480,6 +480,7 @@ static void request_end(struct fuse_conn *fc, struct fuse_req *req)
 put_request:
 	fuse_put_request(fc, req);
 }
+EXPORT_SYMBOL_GPL(fuse_request_end);
 
 static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
@@ -567,12 +568,12 @@ static void __fuse_request_send(struct fuse_conn *fc, struct fuse_req *req)
 		req->in.h.unique = fuse_get_unique(fiq);
 		queue_request(fiq, req);
 		/* acquire extra reference, since request is still needed
-		   after request_end() */
+		   after fuse_request_end() */
 		__fuse_get_request(req);
 		spin_unlock(&fiq->waitq.lock);
 
 		request_wait_answer(fc, req);
-		/* Pairs with smp_wmb() in request_end() */
+		/* Pairs with smp_wmb() in fuse_request_end() */
 		smp_rmb();
 	}
 }
@@ -1302,7 +1303,7 @@ __releases(fiq->waitq.lock)
  * the pending list and copies request data to userspace buffer.  If
  * no reply is needed (FORGET) or request has been aborted or there
  * was an error during the copying then it's finished by calling
- * request_end().  Otherwise add it to the processing list, and set
+ * fuse_request_end().  Otherwise add it to the processing list, and set
  * the 'sent' flag.
  */
 static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
@@ -1380,7 +1381,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 		/* SETXATTR is special, since it may contain too large data */
 		if (in->h.opcode == FUSE_SETXATTR)
 			req->out.h.error = -E2BIG;
-		request_end(fc, req);
+		fuse_request_end(fc, req);
 		goto restart;
 	}
 	spin_lock(&fpq->lock);
@@ -1423,7 +1424,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	if (!test_bit(FR_PRIVATE, &req->flags))
 		list_del_init(&req->list);
 	spin_unlock(&fpq->lock);
-	request_end(fc, req);
+	fuse_request_end(fc, req);
 	return err;
 
  err_unlock:
@@ -1931,7 +1932,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_out *out,
  * the write buffer.  The request is then searched on the processing
  * list by the unique ID found in the header.  If found, then remove
  * it from the list and copy the rest of the buffer to the request.
- * The request is finished by calling request_end()
+ * The request is finished by calling fuse_request_end().
  */
 static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 				 struct fuse_copy_state *cs, size_t nbytes)
@@ -2018,7 +2019,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		list_del_init(&req->list);
 	spin_unlock(&fpq->lock);
 
-	request_end(fc, req);
+	fuse_request_end(fc, req);
 out:
 	return err ? err : nbytes;
 
@@ -2158,7 +2159,7 @@ static void end_requests(struct fuse_conn *fc, struct list_head *head)
 		req->out.h.error = -ECONNABORTED;
 		clear_bit(FR_SENT, &req->flags);
 		list_del_init(&req->list);
-		request_end(fc, req);
+		fuse_request_end(fc, req);
 	}
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24dbca777775..67521103d3b2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -956,6 +956,11 @@ ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *args);
 void fuse_request_send_background(struct fuse_conn *fc, struct fuse_req *req);
 bool fuse_request_queue_background(struct fuse_conn *fc, struct fuse_req *req);
 
+/**
+ * End a finished request
+ */
+void fuse_request_end(struct fuse_conn *fc, struct fuse_req *req);
+
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
 void fuse_wait_aborted(struct fuse_conn *fc);
-- 
2.21.0

