Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B00C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7FD2341C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102564;
	bh=3LAmf5iuO2TGOiJ96bwKJ56XKMm78CvAPwSFPJtHAMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2oZiS4+y6+zWO32fqu47xR4dRKZyvuzrX5+hfKUBkfjiIQGIkyjmgGNutmL0DEsW
	 949sDOywpW1fqlFqW6vBb0hFAG+l+SI0mvBUgWo9TQ52GZAsloQYJG9U6QKFFzgm65
	 c/z2mJxJl6JTV3V1RBwWX5l+ib/5BySvOYM2fUJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfH2SQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbfH2SQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ECE02339E;
        Thu, 29 Aug 2019 18:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102560;
        bh=3LAmf5iuO2TGOiJ96bwKJ56XKMm78CvAPwSFPJtHAMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhgHb1J9rIydioefoA+Xc5cX/tw38sk4OhZ/jCkrDtDTBjjRH8Ymzw74u63Z5iTlB
         DkB1drDpHii+GyzFVz62VBVV40R7qiYRYQ0Gm91Ksu7PY/qEoWFNMLIHTIvEdOFQpJ
         adpFfA2Tda3HU6V3L1KZT/f9X8Kk78LB5GrnNLx8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabian Henneke <fabian.henneke@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/45] Bluetooth: hidp: Let hidp_send_message return number of queued bytes
Date:   Thu, 29 Aug 2019 14:15:08 -0400
Message-Id: <20190829181547.8280-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabian Henneke <fabian.henneke@gmail.com>

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

