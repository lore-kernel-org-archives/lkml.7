Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6EBC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397EC20640
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947653;
	bh=JeZlGSUgsbC9kaxSnvIl1RuUMyQZlH7dsU6CQCcexzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P8b8tVShpbnC+/vhnJs6gu8DxmYIZmteylapZ7ghFp4+2rjzf8M59N0p0BmlEhCgX
	 IHLLx+jg+RtspDjE+NXJbDT4C7Gpol2kRfOKKu+mSe2xY2gltZ/DANjcXQcq0O55yO
	 0x2/iOmT6pu2lkQ8UwzkpnexWbOqtr3WD6OgRbz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfIHMn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbfIHMnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:43:55 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B66218AE;
        Sun,  8 Sep 2019 12:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946633;
        bh=JeZlGSUgsbC9kaxSnvIl1RuUMyQZlH7dsU6CQCcexzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HNZW9yAuPDbMRIl9+Um69UlcvwtwCqthxho+JCi/fQ8jbFjx3+zPD+eOVKpaEI+9U
         EG/12jGKTfXrcfYd7yNn/m2cBmJshJfT/lzzQrjSwU9m3qbioevwlEff0vOczv2aeS
         NfyJ22G3ZiTv0ZildmgcOd5kzLkkVhszhr+JiJDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/26] net: tundra: tsi108: use spin_lock_irqsave instead of spin_lock_irq in IRQ context
Date:   Sun,  8 Sep 2019 13:41:40 +0100
Message-Id: <20190908121057.476170936@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c25d0887a8bd0e1ca2074ac0c6dff173787a83b ]

As spin_unlock_irq will enable interrupts.
Function tsi108_stat_carry is called from interrupt handler tsi108_irq.
Interrupts are enabled in interrupt handler.
Use spin_lock_irqsave/spin_unlock_irqrestore instead of spin_(un)lock_irq
in IRQ context to avoid this.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/tundra/tsi108_eth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index 8fd131207ee10..499abe9108fa6 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -381,9 +381,10 @@ tsi108_stat_carry_one(int carry, int carry_bit, int carry_shift,
 static void tsi108_stat_carry(struct net_device *dev)
 {
 	struct tsi108_prv_data *data = netdev_priv(dev);
+	unsigned long flags;
 	u32 carry1, carry2;
 
-	spin_lock_irq(&data->misclock);
+	spin_lock_irqsave(&data->misclock, flags);
 
 	carry1 = TSI_READ(TSI108_STAT_CARRY1);
 	carry2 = TSI_READ(TSI108_STAT_CARRY2);
@@ -451,7 +452,7 @@ static void tsi108_stat_carry(struct net_device *dev)
 			      TSI108_STAT_TXPAUSEDROP_CARRY,
 			      &data->tx_pause_drop);
 
-	spin_unlock_irq(&data->misclock);
+	spin_unlock_irqrestore(&data->misclock, flags);
 }
 
 /* Read a stat counter atomically with respect to carries.
-- 
2.20.1



