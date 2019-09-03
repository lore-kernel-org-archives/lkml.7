Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D21C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02B0217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfICLmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbfICLmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:42:10 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16E004E4E6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 11:42:10 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id x12so1279300wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 04:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq6DklOvXBQpcnChGI+5PjZr8M6YoeohLU7OSViViJw=;
        b=Cv8EaQufo+Da/jhXnT8X8DCx6aP8guZPBL5OQ9PtHeBlT+8CGNX048V1iFdvzuICtk
         FxSt+XMa6Hah+QobDd5+xecTu++sf5jNCCCnwWH0Ok2jWf0WmKTdMkiHenyCO7WMmGNg
         hEG5QfBKukH+0IFDFlOrOl+Vy6MBUx4A1nqUJaYqdXBmYy2nKTSaiYWmB6EWROhZbwqr
         q+P/1hTRdrMe96DbeZmibB5z+vecTOq+jgrGqBT+CzyzrY/aFIMlg7YPpUWKm8ymS8dS
         rFwk2odbPu6Cx14VsT5CezePVjSVtMTUOrHY1D1sShLcA2Hu/Y4DmBdZzC31Qd07yMz+
         gaNA==
X-Gm-Message-State: APjAAAU1w8U2JFxK+V6jmYf9N/KPiA49odgL3CYttMMKXfe3QWjfHfhO
        5+hDD95xC2KaM9mA5t1E2bMlUNNcu5CywhB6nRj9wv3Pw6liLejc9MKCFRJcpaI1402CN+M1VyD
        I82RyBaF8Ilr2enIuUYEUQGOv
X-Received: by 2002:a1c:544e:: with SMTP id p14mr15475611wmi.72.1567510928431;
        Tue, 03 Sep 2019 04:42:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAd+VVNnldowkP9l4jOCMO8pjBOGYGrhwFwSOLXZizZO/tlwztV+AmVXjYo65zGv8LUNFz4Q==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr15475591wmi.72.1567510928273;
        Tue, 03 Sep 2019 04:42:08 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x6sm2087551wmf.38.2019.09.03.04.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:42:07 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 08/16] fuse: export fuse_dequeue_forget() function
Date:   Tue,  3 Sep 2019 13:41:55 +0200
Message-Id: <20190903114203.8278-3-mszeredi@redhat.com>
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

File systems like virtio-fs need to do not have to play directly with
forget list data structures. There is a helper function use that instead.

Rename dequeue_forget() to fuse_dequeue_forget() and export it so that
stacked filesystems can use it.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c    | 13 +++++++------
 fs/fuse/fuse_i.h |  4 ++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 167f476fbe16..c0c30a225e78 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1185,9 +1185,9 @@ __releases(fiq->waitq.lock)
 	return err ? err : reqsize;
 }
 
-static struct fuse_forget_link *dequeue_forget(struct fuse_iqueue *fiq,
-					       unsigned max,
-					       unsigned *countp)
+struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
+					     unsigned int max,
+					     unsigned int *countp)
 {
 	struct fuse_forget_link *head = fiq->forget_list_head.next;
 	struct fuse_forget_link **newhead = &head;
@@ -1206,6 +1206,7 @@ static struct fuse_forget_link *dequeue_forget(struct fuse_iqueue *fiq,
 
 	return head;
 }
+EXPORT_SYMBOL(fuse_dequeue_forget);
 
 static int fuse_read_single_forget(struct fuse_iqueue *fiq,
 				   struct fuse_copy_state *cs,
@@ -1213,7 +1214,7 @@ static int fuse_read_single_forget(struct fuse_iqueue *fiq,
 __releases(fiq->waitq.lock)
 {
 	int err;
-	struct fuse_forget_link *forget = dequeue_forget(fiq, 1, NULL);
+	struct fuse_forget_link *forget = fuse_dequeue_forget(fiq, 1, NULL);
 	struct fuse_forget_in arg = {
 		.nlookup = forget->forget_one.nlookup,
 	};
@@ -1261,7 +1262,7 @@ __releases(fiq->waitq.lock)
 	}
 
 	max_forgets = (nbytes - ih.len) / sizeof(struct fuse_forget_one);
-	head = dequeue_forget(fiq, max_forgets, &count);
+	head = fuse_dequeue_forget(fiq, max_forgets, &count);
 	spin_unlock(&fiq->waitq.lock);
 
 	arg.count = count;
@@ -2249,7 +2250,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 			clear_bit(FR_PENDING, &req->flags);
 		list_splice_tail_init(&fiq->pending, &to_end);
 		while (forget_pending(fiq))
-			kfree(dequeue_forget(fiq, 1, NULL));
+			kfree(fuse_dequeue_forget(fiq, 1, NULL));
 		wake_up_all_locked(&fiq->waitq);
 		spin_unlock(&fiq->waitq.lock);
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7e19c936ece8..6533be37873f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -820,6 +820,10 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 
 struct fuse_forget_link *fuse_alloc_forget(void);
 
+struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
+					     unsigned int max,
+					     unsigned int *countp);
+
 /* Used by READDIRPLUS */
 void fuse_force_forget(struct file *file, u64 nodeid);
 
-- 
2.21.0

