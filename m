Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9FEC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9991B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2OQZovN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391652AbfGRXK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:10:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36372 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfGRXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:10:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so13291148pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4Bh3i6WETjmo2gyscMLqDfoKBlO0O1C7LBrFVC3WzwM=;
        b=A2OQZovNRceZTr0qvqRWA+vvSU0W8aBl7wly3yLkbkIHZUeYJAtJQTzRAPjfB0QiP7
         BLkaNNWPXS38CuOrGw7tP/rIX2i/CahcuukE3O/+iiFAUg+tNY431SacXuFB3Z0NqQxv
         Qt/x6dIoS+nu0xB2FIOh0Leo/ZlL3/JJTE1ff84W2a1l/BUsslte3rSOxOh6yy4fI52E
         fYbcMoaWmQayMWjLXTaR+OqTe/GUawChy0OTfdcdZ5dFGXkR8e7QocydqMkoK71VfJ73
         u6of+gYDyfkxe60FwCZOoNQnHg907/TdQdliWws+9Pc28mWdRcIvQxPAYrwlQ7Lu/1uD
         oLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Bh3i6WETjmo2gyscMLqDfoKBlO0O1C7LBrFVC3WzwM=;
        b=rBWHcC4NqPXoPFRnhxclan8B3BWTV+TnojDj/BgUPe2KvADE+jYhHpoxVGuvxP11A2
         3utnmD/QhdRYHnm4lRu9GERTeCKPNt/4cJsZ8tKOG0MYOZB/uw9g5IdKn9Bm5JPQWgq3
         aukVfdkQt/se3+FYHQEA5ltGMoM+19GuJiJNZinHBEwHJf+LntltJZgF4rK8adYpfUyP
         KRICdRzTzYv/xDyw6qZEvqB9AanOXFVpnJHIYuUqafOM4r3OntYsAL7KiBoNqk/rK9md
         mjakl4Libm0cxPXYJC7Wt7pyIeMOYlLYWkZvmVLuXN2wIUQsplr298jZlrhxzPgzY65c
         mPpg==
X-Gm-Message-State: APjAAAUOXyg28BwRXv8S1gV3v+qHd1+wDMHTSJDZHplTr+ndln48M/T1
        MJ9VXzMN6L3Dr4bPwHwBF1iAwA==
X-Google-Smtp-Source: APXvYqw/bJd5fIdOZX8VM/Gc828lajZHC2R/8+xosrp/+5HCYJ+Mwj3/LYfDYZc5xg/XWCxPKMcZeg==
X-Received: by 2002:a65:4844:: with SMTP id i4mr51178039pgs.113.1563491458290;
        Thu, 18 Jul 2019 16:10:58 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w14sm32502763pfn.47.2019.07.18.16.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 16:10:57 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] aio: Support read/write with non-iter file-ops
Date:   Thu, 18 Jul 2019 16:10:54 -0700
Message-Id: <20190718231054.8175-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a wrapper for aio_read()/write() to allow async IO on files
not implementing the iter version of read/write, such as sysfs. This
mimics how readv/writev uses non-iter ops in do_loop_readv_writev().

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 fs/aio.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f9f441b59966..0137a1a9bef1 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1514,12 +1514,44 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
+static ssize_t aio_iter_readv_writev(struct file *file, struct kiocb *req,
+				     struct iov_iter *iter, int type)
+{
+	ssize_t ret = 0;
+	ssize_t nr;
+
+	while (iov_iter_count(iter)) {
+		struct iovec iovec = iov_iter_iovec(iter);
+
+		if (type == READ) {
+			nr = file->f_op->read(file, iovec.iov_base,
+					      iovec.iov_len, &req->ki_pos);
+		} else {
+			nr = file->f_op->write(file, iovec.iov_base,
+					       iovec.iov_len, &req->ki_pos);
+		}
+
+		if (nr < 0) {
+			ret = nr;
+			break;
+		}
+
+		ret += nr;
+		if (nr != iovec.iov_len)
+			break;
+		iov_iter_advance(iter, nr);
+	}
+
+	return ret;
+}
+
 static int aio_read(struct kiocb *req, const struct iocb *iocb,
 			bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
 	struct file *file;
+	ssize_t count;
 	int ret;
 
 	ret = aio_prep_rw(req, iocb);
@@ -1529,15 +1561,18 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
 	ret = -EINVAL;
-	if (unlikely(!file->f_op->read_iter))
-		return -EINVAL;
 
 	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
-	if (!ret)
-		aio_rw_done(req, call_read_iter(file, req, &iter));
+	if (!ret) {
+		if (likely(file->f_op->read_iter))
+			count = call_read_iter(file, req, &iter);
+		else
+			count = aio_iter_readv_writev(file, req, &iter, READ);
+		aio_rw_done(req, count);
+	}
 	kfree(iovec);
 	return ret;
 }
@@ -1548,6 +1583,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
 	struct file *file;
+	ssize_t count;
 	int ret;
 
 	ret = aio_prep_rw(req, iocb);
@@ -1557,8 +1593,6 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 
 	if (unlikely(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
-	if (unlikely(!file->f_op->write_iter))
-		return -EINVAL;
 
 	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
 	if (ret < 0)
@@ -1577,7 +1611,11 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
 		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, call_write_iter(file, req, &iter));
+		if (likely(file->f_op->write_iter))
+			count = call_write_iter(file, req, &iter);
+		else
+			count = aio_iter_readv_writev(file, req, &iter, WRITE);
+		aio_rw_done(req, count);
 	}
 	kfree(iovec);
 	return ret;
-- 
2.18.0

