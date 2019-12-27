Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709C8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8A9206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468789;
	bh=oJoFVykDGY1j7tELn+UKuuOMO+IZoAAhCl2pf3aTwjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JnlhE21+KX7+uPH498N1T8w/xrc0BT/Hto6pTUrW5F/mnfAEEVHASBo51z68lHrxc
	 IBsjCe+vdXOkzYCq30AO6qOx/WHGTV79DrVFki4F63qE4sgMqHytZIV7UZt1UX3jfv
	 UxbuXwpfOiemF5pA7OCf9QL0v75jA7AXA+LwyB0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfL0Rq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbfL0RpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:45:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB045222C4;
        Fri, 27 Dec 2019 17:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468713;
        bh=oJoFVykDGY1j7tELn+UKuuOMO+IZoAAhCl2pf3aTwjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htSmFXS7XbuAhg7MBc/ipCxBwHzGxA0jJNEvJvJprG4w1JYlevp5AmiBLDHSvqDi5
         U36qOuMNwkMLlqdWx0oEhDwmn0jdfd3/5Bg+Mt+I0xY2xmKvpQNrECxK+FZLSZ2yjM
         HpKQZj7B232guSf892dQgucWY7R7aIKCDHYdJb9w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 68/84] net: nfc: nci: fix a possible sleep-in-atomic-context bug in nci_uart_tty_receive()
Date:   Fri, 27 Dec 2019 12:43:36 -0500
Message-Id: <20191227174352.6264-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit b7ac893652cafadcf669f78452329727e4e255cc ]

The kernel may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

net/nfc/nci/uart.c, 349:
	nci_skb_alloc in nci_uart_default_recv_buf
net/nfc/nci/uart.c, 255:
	(FUNC_PTR)nci_uart_default_recv_buf in nci_uart_tty_receive
net/nfc/nci/uart.c, 254:
	spin_lock in nci_uart_tty_receive

nci_skb_alloc(GFP_KERNEL) can sleep at runtime.
(FUNC_PTR) means a function pointer is called.

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC for
nci_skb_alloc().

This bug is found by a static analysis tool STCheck written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index a66f102c6c01..040576dd73bb 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -348,7 +348,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
 			nu->rx_packet_len = -1;
 			nu->rx_skb = nci_skb_alloc(nu->ndev,
 						   NCI_MAX_PACKET_SIZE,
-						   GFP_KERNEL);
+						   GFP_ATOMIC);
 			if (!nu->rx_skb)
 				return -ENOMEM;
 		}
-- 
2.20.1

