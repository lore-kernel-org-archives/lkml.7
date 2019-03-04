Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B28C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687950;
	bh=ugzjylJRrkDOy1zqJeOZhJETgi2HcWvkSWrLI6rt1kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MctC6q3W8DJDcQOMjrANRAeJZivkpxVQ3kSZh0u5uWVbxWrTUtoB58LuOgkEwjqW8
	 gF40vPO6JOJruYnmwlY06GjnKBYjwsB7zwGE2b/nzQ0dstOp3vYvC4bSUeM4r3GVmd
	 PuwEakvB4WWPkdtle9zZUUW5HtEbEpJxNSOOCf1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfCDIZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfCDIZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:25:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C150A20823;
        Mon,  4 Mar 2019 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687926;
        bh=ugzjylJRrkDOy1zqJeOZhJETgi2HcWvkSWrLI6rt1kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QqszO6UXps27LVmRZ6plHOHfXdXXzTLvxX2sPaPYKKHpMIr9N/2ePopzoa2jvJ6IJ
         BYfr0sJszMxRIWPfFrzpYmY2LyqQO2Q0sibgfnsFyhUTWAL6Z7R7b+duHqt6Fy+POy
         jIp7PCwwwG2qC2z7G/7vsdlEb5iIV3R1/JKK7LAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Jan Kara <jack@suse.cz>,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/52] direct-io: allow direct writes to empty inodes
Date:   Mon,  4 Mar 2019 09:22:29 +0100
Message-Id: <20190304081618.955279776@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 40567501015f2..2c90d541f5275 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -658,6 +658,7 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
 	unsigned long fs_count;	/* Number of filesystem-sized blocks */
 	int create;
 	unsigned int i_blkbits = sdio->blkbits + sdio->blkfactor;
+	loff_t i_size;
 
 	/*
 	 * If there was a memory error and we've overwritten all the
@@ -687,8 +688,8 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
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



