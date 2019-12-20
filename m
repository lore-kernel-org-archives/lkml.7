Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994DDC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6460824682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852728;
	bh=Ga1t74zu3ZcZd9+WWTuiAieeUhQURloJ+zzCSvUioZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CGfW9y0xEzvX2wIJ3Ovx+iPONS7KmSGXNqMforRAcRGx5FlFs3+XniFaJ4YJu5b16
	 kWSCuSCqqFxFuTi+PbQnJZX/zkav7WAgRyPtExW9KwgkN8jfuI7jEaM6MB5iCcGs9R
	 suh+EcEh8A4bLwz0CIvFfy0073wYgCUOt/sIYLnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfLTOir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbfLTOh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:37:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43E424689;
        Fri, 20 Dec 2019 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852677;
        bh=Ga1t74zu3ZcZd9+WWTuiAieeUhQURloJ+zzCSvUioZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8M8WFjNDsoqTIoucsIVluIesbl7mmtlkof5/SxNKVknP/S+2Awvf+XaOw+VaGUcN
         kugf4UcX+hLNwUg4iEVu/EGb1UTo+BxhB85ByA4urRLqShVGOriA3zBwcat7VGfT5t
         pe269t79gSYNZZaOox4xwnZyS6cFPw/MKPrJp8dM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 12/19] net: make socket read/write_iter() honor IOCB_NOWAIT
Date:   Fri, 20 Dec 2019 09:37:33 -0500
Message-Id: <20191220143741.10220-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220143741.10220-1-sashal@kernel.org>
References: <20191220143741.10220-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit ebfcd8955c0b52eb793bcbc9e71140e3d0cdb228 ]

The socket read/write helpers only look at the file O_NONBLOCK. not
the iocb IOCB_NOWAIT flag. This breaks users like preadv2/pwritev2
and io_uring that rely on not having the file itself marked nonblocking,
but rather the iocb itself.

Cc: netdev@vger.kernel.org
Acked-by: David Miller <davem@davemloft.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index aab65277314d9..5b134a6b6216f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -891,7 +891,7 @@ static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			     .msg_iocb = iocb};
 	ssize_t res;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (file->f_flags & O_NONBLOCK || (iocb->ki_flags & IOCB_NOWAIT))
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (iocb->ki_pos != 0)
@@ -916,7 +916,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos != 0)
 		return -ESPIPE;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (file->f_flags & O_NONBLOCK || (iocb->ki_flags & IOCB_NOWAIT))
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (sock->type == SOCK_SEQPACKET)
-- 
2.20.1

