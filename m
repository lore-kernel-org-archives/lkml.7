Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21BFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8052D2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560807477;
	bh=SCld0zSsIOCbRLLWcUjRzOClR/Ij2Y1Q73j4IBFa4Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ubkfySGxlG7o0NGtoPObAPc0X/nlQQmgLExr2Iw4UgZ//8ceeUrj8LADztxgnCytj
	 q2b9aoyvXMPd1nkMT5iOy1+gt1oy3Ad4FiZwBHTLZDQMjCLlYPXJLlSHPXgFqEBact
	 v8Y26ut6V2xhfuUTj443downKKIfcxOM3w9XE/MU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfFQVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfFQVTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:19:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CEA208E4;
        Mon, 17 Jun 2019 21:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806349;
        bh=SCld0zSsIOCbRLLWcUjRzOClR/Ij2Y1Q73j4IBFa4Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ngsD5aXxoZZ6BNXv5APmhL5CvXryR5VkJeseoi9BYBkKCOi4dWv1WNnlwVK+fOY5Z
         NUxJF9dRlM7ByipXQ0TylkN1TynZTgaU2LNwaJI0wsYAG8PX0V2wHLAEOXNsyGYTRs
         UpoTTx22S8Ft77BwUtLczPbLpawAHBAy/5UxyrRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+111cb28d9f583693aefa@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.1 021/115] io_uring: fix memory leak of UNIX domain socket inode
Date:   Mon, 17 Jun 2019 23:08:41 +0200
Message-Id: <20190617210800.989101879@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 355e8d26f719c207aa2e00e6f3cfab3acf21769b upstream.

Opening and closing an io_uring instance leaks a UNIX domain socket
inode.  This is because the ->file of the io_uring instance's internal
UNIX domain socket is set to point to the io_uring file, but then
sock_release() sees the non-NULL ->file and assumes the inode reference
is held by the file so doesn't call iput().  That's not the case here,
since the reference is still meant to be held by the socket; the actual
inode of the io_uring file is different.

Fix this leak by NULL-ing out ->file before releasing the socket.

Reported-by: syzbot+111cb28d9f583693aefa@syzkaller.appspotmail.com
Fixes: 2b188cc1bb85 ("Add io_uring IO interface")
Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2633,8 +2633,10 @@ static void io_ring_ctx_free(struct io_r
 	io_sqe_files_unregister(ctx);
 
 #if defined(CONFIG_UNIX)
-	if (ctx->ring_sock)
+	if (ctx->ring_sock) {
+		ctx->ring_sock->file = NULL; /* so that iput() is called */
 		sock_release(ctx->ring_sock);
+	}
 #endif
 
 	io_mem_free(ctx->sq_ring);


