Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C4DC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAB120673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122655;
	bh=PO6/JpMM8870A6I/uwuOSfPrmhKU+aElITomc83RwyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z+LConKM89l4uow/g9U94PKoQyOpwCL6KZ9TpDfIZjX3U8RNzyDbUG9uxUM0aWiQ5
	 3aXO9OLpOd6/SJ+qhEffaJJvy1pexNNWvpBrR9tkWXF68DByimUk6bVGFNTkK2szmP
	 R3sdJPyKiOqltegELrXDiWDONk/8HfZCzoJRHg48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391096AbfJCQcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391903AbfJCQcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:32:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4FB215EA;
        Thu,  3 Oct 2019 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120341;
        bh=PO6/JpMM8870A6I/uwuOSfPrmhKU+aElITomc83RwyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7ChofLcCuyIvEvAIuuRtfox4T4gIsTnOqgsvM2VhYp3aKPHeKqitKA+qZkmMmh41
         r2xtismJgGAGB9PmYYTW2fAbfiA2X7TRFyEZvv1VwUDRSEyxzKbO3YOYQ3UHeMCdUy
         +1O47idurCYf9y8pd0vmy0HtN7xlz9SglQLb+40I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 186/313] io_uring: fix wrong sequence setting logic
Date:   Thu,  3 Oct 2019 17:52:44 +0200
Message-Id: <20191003154551.305735543@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

[ Upstream commit 8776f3fa15a5cd213c4dfab7ddaf557983374ea6 ]

Sqo_thread will get sqring in batches, which will cause
ctx->cached_sq_head to be added in batches. if one of these
sqes is set with the DRAIN flag, then he will never get a
chance to process, and finally sqo_thread will not exit.

Fixes: de0617e4671 ("io_uring: add support for marking commands as draining")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 03cd8f5bba850..701936f2bde39 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -288,6 +288,7 @@ struct io_ring_ctx {
 struct sqe_submit {
 	const struct io_uring_sqe	*sqe;
 	unsigned short			index;
+	u32				sequence;
 	bool				has_user;
 	bool				needs_lock;
 	bool				needs_fixed_file;
@@ -1894,7 +1895,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 
 	if (flags & IOSQE_IO_DRAIN) {
 		req->flags |= REQ_F_IO_DRAIN;
-		req->sequence = ctx->cached_sq_head - 1;
+		req->sequence = s->sequence;
 	}
 
 	if (!io_op_needs_file(s->sqe))
@@ -2050,6 +2051,7 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	if (head < ctx->sq_entries) {
 		s->index = head;
 		s->sqe = &ctx->sq_sqes[head];
+		s->sequence = ctx->cached_sq_head;
 		ctx->cached_sq_head++;
 		return true;
 	}
-- 
2.20.1



