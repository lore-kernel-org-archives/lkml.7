Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C001FC4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902AA21924
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946842;
	bh=BwTFiW9WT49zM91gkveS8EQjGrYoW+0H3KfR9rONbiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c7+Q0/cJhd8gXAo7ztX8iOfTbm5cnTDfXpAa3LaizLAISv7BkcBp8ny3yufQzZDNl
	 Ci6V5QBihZvPrPPAlkh89gXNUAe7ZxBxbnxpm/eOIeFrChJpBoKUi4Ec+kwW9hFQG/
	 hJsB+p0W60t3yCunuJPqtsXkCILdhU5V8nAP2+84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfIHMrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbfIHMrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:47:17 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC45218AC;
        Sun,  8 Sep 2019 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946836;
        bh=BwTFiW9WT49zM91gkveS8EQjGrYoW+0H3KfR9rONbiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKnbQtUEO/p9XabdJyAU+LQND7C1wg7nroKyojxr3ZtG34LkQvX+Ljq0QmTahXaEA
         TR1nm/ub2AwdqVRhXsId1sU48riI5H7A88ubkH3TLTU35m8NvvksZZvPnfHUybC5ZS
         17WeOo4Ukgi35DITXzPcWQArOY56RNjhPh06WaqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabian Henneke <fabian.henneke@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/57] Bluetooth: hidp: Let hidp_send_message return number of queued bytes
Date:   Sun,  8 Sep 2019 13:41:43 +0100
Message-Id: <20190908121132.859238319@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 48d9cc9d85dde37c87abb7ac9bbec6598ba44b56 ]

Let hidp_send_message return the number of successfully queued bytes
instead of an unconditional 0.

With the return value fixed to 0, other drivers relying on hidp, such as
hidraw, can not return meaningful values from their respective
implementations of write(). In particular, with the current behavior, a
hidraw device's write() will have different return values depending on
whether the device is connected via USB or Bluetooth, which makes it
harder to abstract away the transport layer.

Signed-off-by: Fabian Henneke <fabian.henneke@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hidp/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 253975cce943e..7a31aec0c4a36 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -101,6 +101,7 @@ static int hidp_send_message(struct hidp_session *session, struct socket *sock,
 {
 	struct sk_buff *skb;
 	struct sock *sk = sock->sk;
+	int ret;
 
 	BT_DBG("session %p data %p size %d", session, data, size);
 
@@ -114,13 +115,17 @@ static int hidp_send_message(struct hidp_session *session, struct socket *sock,
 	}
 
 	skb_put_u8(skb, hdr);
-	if (data && size > 0)
+	if (data && size > 0) {
 		skb_put_data(skb, data, size);
+		ret = size;
+	} else {
+		ret = 0;
+	}
 
 	skb_queue_tail(transmit, skb);
 	wake_up_interruptible(sk_sleep(sk));
 
-	return 0;
+	return ret;
 }
 
 static int hidp_send_ctrl_message(struct hidp_session *session,
-- 
2.20.1



