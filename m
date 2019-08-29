Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AA3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE36421726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103595;
	bh=/APi8MhdMaI1X9POkFVoeegdl5V7Rfg/wP5JWu/pxf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T4s2yZ2UBeF7fuGdwJxiwck7qOj4SanCrGvP15JwaKZbxw7C8ZNfISItxcmTABaye
	 zmCz56D1wGK8uJ8hpG1vBLnb41GIbKjuhoVrHHisIYGEQrondZ15qgAGUhYOKQ8iHM
	 krutdglKJjk0sfHyJ/zSJpJ0O0dWa27eEiwmItT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfH2SNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728503AbfH2SNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D082339E;
        Thu, 29 Aug 2019 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102426;
        bh=/APi8MhdMaI1X9POkFVoeegdl5V7Rfg/wP5JWu/pxf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEf62xWtvGCcmfYsfNa0m7sONMphArwetnyjj65+bjWY66RQERfqzLV+CrjEUWdB+
         WmgpOYFMrOtQEjR3V5un8yMoX+yBzlTIJnjMR5WB67lMI8kCPbF3IfrySN6Q2o55h/
         MQWm772AM5EC2frpRd3SY+zQRh/wWIXRIfuNKX04=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.2 17/76] net: tc35815: Explicitly check NET_IP_ALIGN is not zero in tc35815_rx
Date:   Thu, 29 Aug 2019 14:12:12 -0400
Message-Id: <20190829181311.7562-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 125b7e0949d4e72b15c2b1a1590f8cece985a918 ]

clang warns:

drivers/net/ethernet/toshiba/tc35815.c:1507:30: warning: use of logical
'&&' with constant operand [-Wconstant-logical-operand]
                        if (!HAVE_DMA_RXALIGN(lp) && NET_IP_ALIGN)
                                                  ^  ~~~~~~~~~~~~
drivers/net/ethernet/toshiba/tc35815.c:1507:30: note: use '&' for a
bitwise operation
                        if (!HAVE_DMA_RXALIGN(lp) && NET_IP_ALIGN)
                                                  ^~
                                                  &
drivers/net/ethernet/toshiba/tc35815.c:1507:30: note: remove constant to
silence this warning
                        if (!HAVE_DMA_RXALIGN(lp) && NET_IP_ALIGN)
                                                 ~^~~~~~~~~~~~~~~
1 warning generated.

Explicitly check that NET_IP_ALIGN is not zero, which matches how this
is checked in other parts of the tree. Because NET_IP_ALIGN is a build
time constant, this check will be constant folded away during
optimization.

Fixes: 82a9928db560 ("tc35815: Enable StripCRC feature")
Link: https://github.com/ClangBuiltLinux/linux/issues/608
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/toshiba/tc35815.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index c50a9772f4aff..3b5a26b05295f 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -1504,7 +1504,7 @@ tc35815_rx(struct net_device *dev, int limit)
 			pci_unmap_single(lp->pci_dev,
 					 lp->rx_skbs[cur_bd].skb_dma,
 					 RX_BUF_SIZE, PCI_DMA_FROMDEVICE);
-			if (!HAVE_DMA_RXALIGN(lp) && NET_IP_ALIGN)
+			if (!HAVE_DMA_RXALIGN(lp) && NET_IP_ALIGN != 0)
 				memmove(skb->data, skb->data - NET_IP_ALIGN,
 					pkt_len);
 			data = skb_put(skb, pkt_len);
-- 
2.20.1

