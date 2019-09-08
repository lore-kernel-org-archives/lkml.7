Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E5CC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF882067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947638;
	bh=yIjUwWTE+8HeBHbU8BkBrH+sJ9x9dxAyFoOxpRaGfV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+BsArQdB7MxDIJ0tXe2i/yCc2iO9lEzLNwHLVN8WnR6oVuFrJo6sNR5CtY+UWKSk
	 7oY1oFmOqv2jmJzHH4sb8HcnVdV5DnERUmFm+EHwJUPiw1s1hC5krcVo9iOBBdm13Z
	 E04YVbaz+MJRbPC1VKshbEHi4UwydnKdEKDIahIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfIHNAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbfIHMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:23 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E9021920;
        Sun,  8 Sep 2019 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946662;
        bh=yIjUwWTE+8HeBHbU8BkBrH+sJ9x9dxAyFoOxpRaGfV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7mDNN45DAqdgFI4buuEkUwrTXq7JgzyfUUXe3cY1viiwJlqBZzjaZwgZuOXsuRN5
         sa2FnXhb49MjbYSwmfq2lynWh2UPAAgTm0L/nXQLCDeVCKo1LGTS5SnAfPwepHTqLl
         fVhw03IiEtSrS+qCbMvVehsxQqM/1z37SdAcaTbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 02/26] net: tc35815: Explicitly check NET_IP_ALIGN is not zero in tc35815_rx
Date:   Sun,  8 Sep 2019 13:41:41 +0100
Message-Id: <20190908121058.021055200@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 5b01b3fa9fec9..47ebac456ae57 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -1498,7 +1498,7 @@ tc35815_rx(struct net_device *dev, int limit)
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



