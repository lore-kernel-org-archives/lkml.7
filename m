Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7555BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4946021871
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887916;
	bh=by66fafWIkFfkatStvHYRKlIhFEru2T56686wGJEHj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z6p24o3Tae5PZRThCEz2eIEcIRewbyFa/rtFA9rspM6ZB8Jt+qXQDCW1O+qIZm1nR
	 KKWQit6HtFYzlwuKzshTOy6nDNTO0AoSr5tc/RtC5MLovJ7u+th8U5wkdTW6F+FGXa
	 psEJx96gMyQl1ASxPkGaPZZrRwrnUST36vwVf51Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfK0Uvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbfK0Uvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:51:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3988B21871;
        Wed, 27 Nov 2019 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887908;
        bh=by66fafWIkFfkatStvHYRKlIhFEru2T56686wGJEHj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0XxXbDeFnHpQm3Yr1y3JgWSudMY/vRnkB+ZQ/s+DLDoq4TFiPM/SbDLD9bRGQyLj
         rW6cch3B1Ptp1zsCKY86DtQliSNM1C3l5p6h2hLPy2R8KO9Y0g22yDSw+SZO3Ty5n+
         BNbBlIjLuCFxxzNyFWyodOBzKNOvwCvfsI9zXKKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 100/211] i2c: uniphier-f: fix race condition when IRQ is cleared
Date:   Wed, 27 Nov 2019 21:30:33 +0100
Message-Id: <20191127203103.134044152@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit eaba68785c2d24ebf1f0d46c24e11b79cc2f94c7 ]

The current IRQ handler clears all the IRQ status bits when it bails
out. This is dangerous because it might clear away the status bits
that have just been set while processing the current handler. If this
happens, the IRQ event for the latest transfer is lost forever.

The IRQ status bits must be cleared *before* the next transfer is
kicked.

Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-uniphier-f.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index bbd5b137aa216..928ea9930d17e 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -143,9 +143,10 @@ static void uniphier_fi2c_set_irqs(struct uniphier_fi2c_priv *priv)
 	writel(priv->enabled_irqs, priv->membase + UNIPHIER_FI2C_IE);
 }
 
-static void uniphier_fi2c_clear_irqs(struct uniphier_fi2c_priv *priv)
+static void uniphier_fi2c_clear_irqs(struct uniphier_fi2c_priv *priv,
+				     u32 mask)
 {
-	writel(-1, priv->membase + UNIPHIER_FI2C_IC);
+	writel(mask, priv->membase + UNIPHIER_FI2C_IC);
 }
 
 static void uniphier_fi2c_stop(struct uniphier_fi2c_priv *priv)
@@ -172,6 +173,8 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 		"interrupt: enabled_irqs=%04x, irq_status=%04x\n",
 		priv->enabled_irqs, irq_status);
 
+	uniphier_fi2c_clear_irqs(priv, irq_status);
+
 	if (irq_status & UNIPHIER_FI2C_INT_STOP)
 		goto complete;
 
@@ -250,8 +253,6 @@ static irqreturn_t uniphier_fi2c_interrupt(int irq, void *dev_id)
 	}
 
 handled:
-	uniphier_fi2c_clear_irqs(priv);
-
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
@@ -340,7 +341,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
 		priv->flags |= UNIPHIER_FI2C_STOP;
 
 	reinit_completion(&priv->comp);
-	uniphier_fi2c_clear_irqs(priv);
+	uniphier_fi2c_clear_irqs(priv, U32_MAX);
 	writel(UNIPHIER_FI2C_RST_TBRST | UNIPHIER_FI2C_RST_RBRST,
 	       priv->membase + UNIPHIER_FI2C_RST);	/* reset TX/RX FIFO */
 
-- 
2.20.1



