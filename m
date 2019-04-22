Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69FDC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85596204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963537;
	bh=FcBVi5etLftjLI+XPqWTppR/Qu7dpfJ50tAQv9jIIpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZBKXQmk+yd1HwtwcQdCzL77wtLPH0KvO4yuWtJG7M3NTu6GGPkOkLSoIa+bkNMHO
	 lATv8ahZZfBaLt+inIbynAyUsbFjcJJXoG5S/k30o3JRTABdqwEJe+tjdttTB8+IWD
	 AgqSmRBrAqr+QRsUK6ZO/VfBmkGLiAjOpYuG2cR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfDVUFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbfDVTo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0247921900;
        Mon, 22 Apr 2019 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962296;
        bh=FcBVi5etLftjLI+XPqWTppR/Qu7dpfJ50tAQv9jIIpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rf/jeX7wJuA7ex/41MhJPlX/0b8aWyZcl68VD9NaWo/JllXMgEkaQH7O6H6FtKLun
         E/n89TwNz0Cu5yKs9gCmZ2pBU3ncORVI8jxobITZzwe/1NDTQ3J4M/S4dR/tm5xYVB
         eiwxeYCM3HcD0NGSFbuZy+Z8bqvGBalwBbNXcDlI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 89/98] nvmet: fix building bvec from sg list
Date:   Mon, 22 Apr 2019 15:41:56 -0400
Message-Id: <20190422194205.10404-89-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 02db99548d3608a625cf481cff2bb7b626829b3f ]

There are two mistakes for building bvec from sg list for file
backed ns:

- use request data length to compute number of io vector, this way
doesn't consider sg->offset, and the result may be smaller than required
io vectors

- bvec->bv_len isn't capped by sg->length

This patch fixes this issue by building bvec from sg directly, given
the whole IO stack is ready for multi-page bvec.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 517522305e5c..9a0fa3943ca7 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -75,11 +75,11 @@ err:
 	return ret;
 }
 
-static void nvmet_file_init_bvec(struct bio_vec *bv, struct sg_page_iter *iter)
+static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
 {
-	bv->bv_page = sg_page_iter_page(iter);
-	bv->bv_offset = iter->sg->offset;
-	bv->bv_len = PAGE_SIZE - iter->sg->offset;
+	bv->bv_page = sg_page(sg);
+	bv->bv_offset = sg->offset;
+	bv->bv_len = sg->length;
 }
 
 static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
@@ -128,14 +128,14 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
 
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
-	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
-	struct sg_page_iter sg_pg_iter;
+	ssize_t nr_bvec = req->sg_cnt;
 	unsigned long bv_cnt = 0;
 	bool is_sync = false;
 	size_t len = 0, total_len = 0;
 	ssize_t ret = 0;
 	loff_t pos;
-
+	int i;
+	struct scatterlist *sg;
 
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
@@ -147,8 +147,8 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	}
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
-	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
-		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], &sg_pg_iter);
+	for_each_sg(req->sg, sg, req->sg_cnt, i) {
+		nvmet_file_init_bvec(&req->f.bvec[bv_cnt], sg);
 		len += req->f.bvec[bv_cnt].bv_len;
 		total_len += req->f.bvec[bv_cnt].bv_len;
 		bv_cnt++;
@@ -225,7 +225,7 @@ static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
 
 static void nvmet_file_execute_rw(struct nvmet_req *req)
 {
-	ssize_t nr_bvec = DIV_ROUND_UP(req->data_len, PAGE_SIZE);
+	ssize_t nr_bvec = req->sg_cnt;
 
 	if (!req->sg_cnt || !nr_bvec) {
 		nvmet_req_complete(req, 0);
-- 
2.19.1

