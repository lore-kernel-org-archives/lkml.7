Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E0C33CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936C02072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431691;
	bh=u8nBtxr5Vk8ZYc+pl37NvtifH+6EGTSzMPS+Y/gMMQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0igfGfuS4hweFhMF0y9wTv74Sb3QyC4meKPjz57y7tv64z5hj8VOI4+vFNu9PPh8M
	 xpHh9yArFH1Q239tiSMQM/WuUmaV9sv3dMjUKOipN8WkZ0JNA9SAqCQ4CqKEL4RBfo
	 swsxEy/mmtyP4G0qTywW/y/l9iceJpEkvTqS+/eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgAGVJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbgAGVIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:08:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E255B20678;
        Tue,  7 Jan 2020 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431328;
        bh=u8nBtxr5Vk8ZYc+pl37NvtifH+6EGTSzMPS+Y/gMMQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5K73ArqI9H8UGmGm8V7Z7vjKXdn4t8L7QcS/MXQKi9bJXQkiIvbis4QFiQ9d3koq
         ZHC7bUJJ64bDD7hsEy0tsidg9edSKvpYWgiPi8uvAr8TnyNBa62pIaFURkvXvyAdje
         K9vsqZnCF5sQhlPoCncSWuFaQbqUekBYCEQqejV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/74] net: make socket read/write_iter() honor IOCB_NOWAIT
Date:   Tue,  7 Jan 2020 21:54:37 +0100
Message-Id: <20200107205143.809489508@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index aab65277314d..5b134a6b6216 100644
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



