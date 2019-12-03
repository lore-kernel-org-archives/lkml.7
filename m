Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B331BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708B20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414726;
	bh=zz6hc1y0Nrg95ijcrAaoxy8ZdAJ8NK04RKA1Ad7Z17U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLS81aT95nHg1hTDpY8myMQeRvwi1YxvTycmIx2a4atSu2FJ9psXtMKELesvFvDyj
	 //4fELjZoTRh3ltlzljuuFeqEb6NVRCjf1q2OvVuMDET56Ifwm31gqP4q0F+n7RgE6
	 uDdbI9GqFSThRSlIzlh5z6XJdPWgMd9bu8NUq77w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfLCXMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbfLCWkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E89C20684;
        Tue,  3 Dec 2019 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412824;
        bh=zz6hc1y0Nrg95ijcrAaoxy8ZdAJ8NK04RKA1Ad7Z17U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJri8Pv06JwoXHRGjQc9hc3+2/NNtCtMIVoQp5ttuS0cUidR97+A8JOyCKawKU0+M
         GMg4cBNDqEmm/ufVlKNgVZeLWmRRG/tp8uMWDioAGLk1n328Iwy3KXg3Q3w0b3cBpf
         SwZGac6QBoNSsp7TL+08slx9RBhjfVLy3xQD53/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 003/135] net: disallow ancillary data for __sys_{send,recv}msg_file()
Date:   Tue,  3 Dec 2019 23:34:03 +0100
Message-Id: <20191203213006.555175458@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit d69e07793f891524c6bbf1e75b9ae69db4450953 ]

Only io_uring uses (and added) these, and we want to disallow the
use of sendmsg/recvmsg for anything but regular data transfers.
Use the newly added prep helper to split the msghdr copy out from
the core function, to check for msg_control and msg_controllen
settings. If either is set, we return -EINVAL.

Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/socket.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index fbe08d7df7732..d7a106028f0e0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2357,12 +2357,27 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 /*
  *	BSD sendmsg interface
  */
-long __sys_sendmsg_sock(struct socket *sock, struct user_msghdr __user *msg,
+long __sys_sendmsg_sock(struct socket *sock, struct user_msghdr __user *umsg,
 			unsigned int flags)
 {
-	struct msghdr msg_sys;
+	struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
+	struct sockaddr_storage address;
+	struct msghdr msg = { .msg_name = &address };
+	ssize_t err;
+
+	err = sendmsg_copy_msghdr(&msg, umsg, flags, &iov);
+	if (err)
+		return err;
+	/* disallow ancillary data requests from this path */
+	if (msg.msg_control || msg.msg_controllen) {
+		err = -EINVAL;
+		goto out;
+	}
 
-	return ___sys_sendmsg(sock, msg, &msg_sys, flags, NULL, 0);
+	err = ____sys_sendmsg(sock, &msg, flags, NULL, 0);
+out:
+	kfree(iov);
+	return err;
 }
 
 long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
@@ -2561,12 +2576,28 @@ static int ___sys_recvmsg(struct socket *sock, struct user_msghdr __user *msg,
  *	BSD recvmsg interface
  */
 
-long __sys_recvmsg_sock(struct socket *sock, struct user_msghdr __user *msg,
+long __sys_recvmsg_sock(struct socket *sock, struct user_msghdr __user *umsg,
 			unsigned int flags)
 {
-	struct msghdr msg_sys;
+	struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
+	struct sockaddr_storage address;
+	struct msghdr msg = { .msg_name = &address };
+	struct sockaddr __user *uaddr;
+	ssize_t err;
 
-	return ___sys_recvmsg(sock, msg, &msg_sys, flags, 0);
+	err = recvmsg_copy_msghdr(&msg, umsg, flags, &uaddr, &iov);
+	if (err)
+		return err;
+	/* disallow ancillary data requests from this path */
+	if (msg.msg_control || msg.msg_controllen) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = ____sys_recvmsg(sock, &msg, umsg, uaddr, flags, 0);
+out:
+	kfree(iov);
+	return err;
 }
 
 long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
-- 
2.20.1



