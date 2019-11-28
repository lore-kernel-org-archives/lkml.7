Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46740C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2821852
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wx+K86Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfK1QuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40653 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id i187so9204048pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4A+UA0S3l+ls0zS2Gq9BFaj9JODH97JG2yHCpwCb+s=;
        b=Wx+K86GxA+4smpBpiOHAUU4+1Q2OkAURYY7uZaNtD0cSSiGuNbCLz8fajRC7wmZ7DU
         rsdklNwN1J1GqRb/PAmQ/dqp42ravrSDKYRfy8b145fzDNOFjMFzq1kFiZnjo7xqN9fn
         Jz0KRWdykjc1YY6lrHhFY9J9VvKxdIcUIKihIImElhcWco9EODzGGIeieUieUmhPXkgX
         rdLSL1uLi8lCNEbNnElgBaV/BmBJKlg8iMYAJTKXFiGXg5DC1jLwD36gHhHy4GodjD9a
         9dRXiDvOg86GKf5nPK2NEnYEYM+z72ORSvlPE0v4bFbBuJqnGEBykAMJLiolwfZBJ0hg
         gyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4A+UA0S3l+ls0zS2Gq9BFaj9JODH97JG2yHCpwCb+s=;
        b=j1ERSTOXrz/eavXvUSYO7G4B2nOOBXk1Ptl+J3Gxr0jm1g3VlTtgNUJRfpOJp8cGzO
         pVx2TLGst4jkMMryUfrLs1/N/8d8Bw2j9tBH0iHSmboTspQUTuhCoN+eFLT0S1OWSzNe
         ZAKtSCy3vvqOxVAho2pXa5YzakMP4jzndtJ2ITXwg74j7pNYL6MV4qUVBjfxHGn5qd6S
         oUeTDYvma36vaF4cnO5OAkyeT+EKNALVNe8OENRJVZrQeIqiS/tVcuSkPwYtowT0SeMf
         sLqTXF60VkGNlzSH6f+nSy9sytv02t86IL/JhURywfA7fceKU3lJXmIvnnhXCcAXAfBk
         Wtyg==
X-Gm-Message-State: APjAAAVHJPzH2Kz947PyjC0Ze5Y1Q6cmQ1V5MxoLIxVLLLD7Dis3ftuM
        Hi0JCnKoku4+iAulpQUzyamN/fxmmUQ=
X-Google-Smtp-Source: APXvYqySksv89mq7ZXiuB7jRWQXMsodrA1Fn5AXVdxQeQ0hmfOmPumNTFWUfdW/n9qVFY/Xf8muSig==
X-Received: by 2002:a63:fc13:: with SMTP id j19mr11884281pgi.327.1574959805234;
        Thu, 28 Nov 2019 08:50:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:04 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 01/17] mailbox: stm32_ipcc: add spinlock to fix channels concurrent access
Date:   Thu, 28 Nov 2019 09:49:46 -0700
Message-Id: <20191128165002.6234-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

commit dba9a3dfe912dc47c9dbc9ba1f5f65adbf9aea0f upstream

Add spinlock protection on IPCC register update to avoid race condition.
Without this fix, stm32_ipcc_set_bits and stm32_ipcc_clr_bits can be
called in parallel for different channels. This results in register
corruptions.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/mailbox/stm32-ipcc.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index ca1f993c0de3..e31322225e93 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -50,6 +50,7 @@ struct stm32_ipcc {
 	void __iomem *reg_base;
 	void __iomem *reg_proc;
 	struct clk *clk;
+	spinlock_t lock; /* protect access to IPCC registers */
 	int irqs[IPCC_IRQ_NUM];
 	int wkp;
 	u32 proc_id;
@@ -58,14 +59,24 @@ struct stm32_ipcc {
 	u32 xmr;
 };
 
-static inline void stm32_ipcc_set_bits(void __iomem *reg, u32 mask)
+static inline void stm32_ipcc_set_bits(spinlock_t *lock, void __iomem *reg,
+				       u32 mask)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(lock, flags);
 	writel_relaxed(readl_relaxed(reg) | mask, reg);
+	spin_unlock_irqrestore(lock, flags);
 }
 
-static inline void stm32_ipcc_clr_bits(void __iomem *reg, u32 mask)
+static inline void stm32_ipcc_clr_bits(spinlock_t *lock, void __iomem *reg,
+				       u32 mask)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(lock, flags);
 	writel_relaxed(readl_relaxed(reg) & ~mask, reg);
+	spin_unlock_irqrestore(lock, flags);
 }
 
 static irqreturn_t stm32_ipcc_rx_irq(int irq, void *data)
@@ -92,7 +103,7 @@ static irqreturn_t stm32_ipcc_rx_irq(int irq, void *data)
 
 		mbox_chan_received_data(&ipcc->controller.chans[chan], NULL);
 
-		stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XSCR,
+		stm32_ipcc_set_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XSCR,
 				    RX_BIT_CHAN(chan));
 
 		ret = IRQ_HANDLED;
@@ -121,7 +132,7 @@ static irqreturn_t stm32_ipcc_tx_irq(int irq, void *data)
 		dev_dbg(dev, "%s: chan:%d tx\n", __func__, chan);
 
 		/* mask 'tx channel free' interrupt */
-		stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XMR,
+		stm32_ipcc_set_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XMR,
 				    TX_BIT_CHAN(chan));
 
 		mbox_chan_txdone(&ipcc->controller.chans[chan], 0);
@@ -141,10 +152,12 @@ static int stm32_ipcc_send_data(struct mbox_chan *link, void *data)
 	dev_dbg(ipcc->controller.dev, "%s: chan:%d\n", __func__, chan);
 
 	/* set channel n occupied */
-	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XSCR, TX_BIT_CHAN(chan));
+	stm32_ipcc_set_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XSCR,
+			    TX_BIT_CHAN(chan));
 
 	/* unmask 'tx channel free' interrupt */
-	stm32_ipcc_clr_bits(ipcc->reg_proc + IPCC_XMR, TX_BIT_CHAN(chan));
+	stm32_ipcc_clr_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XMR,
+			    TX_BIT_CHAN(chan));
 
 	return 0;
 }
@@ -163,7 +176,8 @@ static int stm32_ipcc_startup(struct mbox_chan *link)
 	}
 
 	/* unmask 'rx channel occupied' interrupt */
-	stm32_ipcc_clr_bits(ipcc->reg_proc + IPCC_XMR, RX_BIT_CHAN(chan));
+	stm32_ipcc_clr_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XMR,
+			    RX_BIT_CHAN(chan));
 
 	return 0;
 }
@@ -175,7 +189,7 @@ static void stm32_ipcc_shutdown(struct mbox_chan *link)
 					       controller);
 
 	/* mask rx/tx interrupt */
-	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XMR,
+	stm32_ipcc_set_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XMR,
 			    RX_BIT_CHAN(chan) | TX_BIT_CHAN(chan));
 
 	clk_disable_unprepare(ipcc->clk);
@@ -208,6 +222,8 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	if (!ipcc)
 		return -ENOMEM;
 
+	spin_lock_init(&ipcc->lock);
+
 	/* proc_id */
 	if (of_property_read_u32(np, "st,proc-id", &ipcc->proc_id)) {
 		dev_err(dev, "Missing st,proc-id\n");
@@ -259,9 +275,10 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	}
 
 	/* mask and enable rx/tx irq */
-	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XMR,
+	stm32_ipcc_set_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XMR,
 			    RX_BIT_MASK | TX_BIT_MASK);
-	stm32_ipcc_set_bits(ipcc->reg_proc + IPCC_XCR, XCR_RXOIE | XCR_TXOIE);
+	stm32_ipcc_set_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XCR,
+			    XCR_RXOIE | XCR_TXOIE);
 
 	/* wakeup */
 	if (of_property_read_bool(np, "wakeup-source")) {
-- 
2.17.1

