Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC3C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755B62183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054726;
	bh=ijfRFNudNt6gcC/ZB42/IFRdWJsCcN6ooB7nGYSw32k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rOpqOuKrWhkvY5NlIcmEo8D57Ktt5A8GI/Idpriwj+0dqlcebQeO+Em/EonIHKlG4
	 znq+f/toKgDt2t2bBM6aGaCLJGPAyynvYz8ryjP32TQxnEaDyUnnnF5LLGPgEbSi+i
	 ITmhDllnqxsQs4tNDt9GT/lFeYcmI7lAmeTOO40E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfGBIFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfGBIFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:05:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238AE2186A;
        Tue,  2 Jul 2019 08:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054722;
        bh=ijfRFNudNt6gcC/ZB42/IFRdWJsCcN6ooB7nGYSw32k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyrBrbk70HURHqMpk4LcwtOIjyZ/9YeP1sodXYMbVx7vJyKYjHzEMrAclIOkY+kXz
         w5ozZYjksIDMgqNPwyZaSptWgQWN45tdic6ADzeiWiECbYmiebYIj0uenoB2ku0zYj
         mW+/PWCLFnqsQ5TxGmJ0s9edRdEcWAUsK5elfmdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/72] 9p/rdma: do not disconnect on down_interruptible EAGAIN
Date:   Tue,  2 Jul 2019 10:01:14 +0200
Message-Id: <20190702080125.280686495@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8b894adb2b7e1d1e64b8954569c761eaf3d51ab5 ]

9p/rdma would sometimes drop the connection and display errors in
recv_done when the user does ^C.
The errors were caused by recv buffers that were posted at the time
of disconnect, and we just do not want to disconnect when
down_interruptible is... interrupted.

Link: http://lkml.kernel.org/r/1535625307-18019-1-git-send-email-asmadeus@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 9cc9b3a19ee7..9719bc4d9424 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -477,7 +477,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 
 	err = post_recv(client, rpl_context);
 	if (err) {
-		p9_debug(P9_DEBUG_FCALL, "POST RECV failed\n");
+		p9_debug(P9_DEBUG_ERROR, "POST RECV failed: %d\n", err);
 		goto recv_error;
 	}
 	/* remove posted receive buffer from request structure */
@@ -546,7 +546,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
  recv_error:
 	kfree(rpl_context);
 	spin_lock_irqsave(&rdma->req_lock, flags);
-	if (rdma->state < P9_RDMA_CLOSING) {
+	if (err != -EINTR && rdma->state < P9_RDMA_CLOSING) {
 		rdma->state = P9_RDMA_CLOSING;
 		spin_unlock_irqrestore(&rdma->req_lock, flags);
 		rdma_disconnect(rdma->cm_id);
-- 
2.20.1



