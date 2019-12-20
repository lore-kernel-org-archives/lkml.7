Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8A0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96B021D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852306;
	bh=5fQWw3Pf9jDvzny+heHuY3ldUi2oJPZL7MGzXD+p5rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o4gGirXnGY/5LQNsJwP5aWsvmOTDcSLDsdSLmWtfshg5gwJ93G3Sh5I2WHDzu9/r4
	 +YyRfqV0kFdPBB7nTD41+ANrJErEKSfVZ1+QqL25Kl0LgZ6NkHBz90e8oGGKwxcazE
	 Vlro3i4IobtdnVHXAJcfk4FH9wepk7iqC8Ldsfv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfLTObE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:31:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfLTOat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D41124684;
        Fri, 20 Dec 2019 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852248;
        bh=5fQWw3Pf9jDvzny+heHuY3ldUi2oJPZL7MGzXD+p5rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgQ1rOyi74lvu6O2Kh2AaIEcIvKHLG2zCLz024PmyLoKtZN4EViGQKZMOrSqIhuTc
         zN/g9TZD0Gpch+ViABW0ZpU3MaadvJW6P6fjOSUnPbmxIpGtBetgiuFq3eGNYf6+wc
         KGk1Zlqfc2lNdbkCHrRwHzut7tswr7gnWo5gQKcg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 40/52] net: make socket read/write_iter() honor IOCB_NOWAIT
Date:   Fri, 20 Dec 2019 09:29:42 -0500
Message-Id: <20191220142954.9500-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
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
index d7a106028f0e0..ca8de9e1582d9 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -955,7 +955,7 @@ static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			     .msg_iocb = iocb};
 	ssize_t res;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (file->f_flags & O_NONBLOCK || (iocb->ki_flags & IOCB_NOWAIT))
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (iocb->ki_pos != 0)
@@ -980,7 +980,7 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_pos != 0)
 		return -ESPIPE;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (file->f_flags & O_NONBLOCK || (iocb->ki_flags & IOCB_NOWAIT))
 		msg.msg_flags = MSG_DONTWAIT;
 
 	if (sock->type == SOCK_SEQPACKET)
-- 
2.20.1

