Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE454C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B832465C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077302;
	bh=MQ8u2nAzTaS09fIn+NYPYndpuXCzEbpCAK/92eCdwzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9kksdecsd3nX4AEzv59rqJGr22uSFbncu4g8/6GUQgAnKd1yqgGqd9Iai1n3u7Mp
	 iB4XWryQ6M4bR2qJMxvi2foYQmvoITx1lwX6nz86JwXoVHnZP2GPcGnqetodliD+FT
	 hqkv366HGImGKEFfs7yvhobKhR3PV6iJCxLpanks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfLKPPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731407AbfLKPN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FF72467F;
        Wed, 11 Dec 2019 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077237;
        bh=MQ8u2nAzTaS09fIn+NYPYndpuXCzEbpCAK/92eCdwzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EioR8lnP1qTW4sTmBmU0JIbFw0J+8sawt04IzY/9hMKSN//e0FPAM4jM3+QI0MUee
         YVO4bMlAsjhcBWTMzzzobei497LMS8h5A+8bsvgL7QRoaWFOSX4kCyxNxHcOK/HsAo
         RcoSxnnchouAt6HLaCuIZbio4DpuHkZOfa3w0zEQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 115/134] io_uring: io_allocate_scq_urings() should return a sane state
Date:   Wed, 11 Dec 2019 10:11:31 -0500
Message-Id: <20191211151150.19073-115-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit eb065d301e8c83643367bdb0898becc364046bda ]

We currently rely on the ring destroy on cleaning things up in case of
failure, but io_allocate_scq_urings() can leave things half initialized
if only parts of it fails.

Be nice and return with either everything setup in success, or return an
error with things nicely cleaned up.

Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index cbe8dabb6479c..7e900bfd24718 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3756,12 +3756,18 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	ctx->cq_entries = rings->cq_ring_entries;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
-	if (size == SIZE_MAX)
+	if (size == SIZE_MAX) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -EOVERFLOW;
+	}
 
 	ctx->sq_sqes = io_mem_alloc(size);
-	if (!ctx->sq_sqes)
+	if (!ctx->sq_sqes) {
+		io_mem_free(ctx->rings);
+		ctx->rings = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.20.1

