Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71129C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4360121019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688190;
	bh=ETA4v65EPdId099ZeVbIDMPR3Dcpx5Xmm0o/j+HoEzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bcbyDkUB9cFwv3lxWJdTYBLDieuO1sP5GTGGSeVu0aCUIUZ7zbWKdRKKt0dBQEMIW
	 AWXcK+qheMWwEjxQKr2jNu3c+YfPoEiUb8c5gXbd104RMdrPoKow/g9pDknNl75buA
	 sntdEAQhETU2QU9uVt0sWSMU2STSr85+jfvzvfDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCDI3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfCDI3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:29:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1EB20823;
        Mon,  4 Mar 2019 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688186;
        bh=ETA4v65EPdId099ZeVbIDMPR3Dcpx5Xmm0o/j+HoEzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBsmFjiSrGYuHgd++LEXZ17TngRg56u2jtthCMM64l8n7DUYFaTMVAPPvODnMobVH
         ncVvb/VMyGV8qrXGZ+m+w1dVz2add0LmlDlEAgE1Z82GhHenYqLceptJ4b0WL3dXdS
         bJXNZ2nS++TqOH1ptMSYlAmBQQyk9tfV2J9NtTII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Jan Kara <jack@suse.cz>,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/78] direct-io: allow direct writes to empty inodes
Date:   Mon,  4 Mar 2019 09:22:27 +0100
Message-Id: <20190304081627.455745386@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8b9433eb4de3c26a9226c981c283f9f4896ae030 ]

On a DIO_SKIP_HOLES filesystem, the ->get_block() method is currently
not allowed to create blocks for an empty inode.  This confusion comes
from trying to bit shift a negative number, so check the size of the
inode first.

The problem is most visible for hfsplus, because the fallback to
buffered I/O doesn't happen and the write fails with EIO.  This is in
part the fault of the module, because it gives a wrong return value on
->get_block(); that will be fixed in a separate patch.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/direct-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 1991460360930..1abb7634b2d58 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -679,6 +679,7 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
 	unsigned long fs_count;	/* Number of filesystem-sized blocks */
 	int create;
 	unsigned int i_blkbits = sdio->blkbits + sdio->blkfactor;
+	loff_t i_size;
 
 	/*
 	 * If there was a memory error and we've overwritten all the
@@ -708,8 +709,8 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
 		 */
 		create = dio->op == REQ_OP_WRITE;
 		if (dio->flags & DIO_SKIP_HOLES) {
-			if (fs_startblk <= ((i_size_read(dio->inode) - 1) >>
-							i_blkbits))
+			i_size = i_size_read(dio->inode);
+			if (i_size && fs_startblk <= (i_size - 1) >> i_blkbits)
 				create = 0;
 		}
 
-- 
2.19.1



