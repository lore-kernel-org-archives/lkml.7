Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9CAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CC0206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nSEa1MJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfD2Dzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 23:55:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfD2Dzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:55:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so4647864pfi.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 20:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAZlyDzGKVIdVMC388n6S7o0DOasFYjgOEfAKf4uteY=;
        b=nSEa1MJ4YGhP7t6ZTTKWFurbopRUMivjdQCEUKmamdRbDSTbxUQbmsdw/JeTlHj47P
         e9Rjsu7YKOeUFG6lZbHcj2EFQJ2rW7yuNvBuXJVi0gyadnS0GlwtOvda8IRiGsZRqzsr
         tU5oaOTdgfubtwUJH0ZWA4QUdgzfJLmwUBugM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAZlyDzGKVIdVMC388n6S7o0DOasFYjgOEfAKf4uteY=;
        b=W7wy3R45ZYdMIqUT/c3WIvmRVVncQtp6N2ntNbepmmmlgDaHpqEUKXH+sc/TEHKgNg
         8pDQFgytAo620Uez9CX850OoGtXRLcOof62Al+1cZCReiEAD8Y4RQdHaOTbjU/SlAQB4
         TeGv1URUM9XP6V+M3Mf9cz3ZGCFYOB0LF7QB82oACeJ/QZg9zqr0eomVUirbWG9HEAbQ
         QMoYqQ9sPUUQPIGIkUMqzmBg1MCpo2hkA7lleBLumrngLIBNCtbQJuXhC/MBzuulOoM0
         cOhho8k5DoKgLbm6uedmEjmODbb4h8WWRVEWunZlQxHQIAjSTTSH6a5ZDvtrq0GLO5/X
         R+6A==
X-Gm-Message-State: APjAAAV8RZZDiC5Yu9dH0XXefR2nymXTtE+6jCWb/hOM/vkpkm8YhX6K
        7W3GQaeJmqSznkZX1mhA/LWmuw==
X-Google-Smtp-Source: APXvYqx3TFhPNmuhW9pXjaa8z9fORbLQnXGmeqzBi0NVBXmBzyMccsPh3dh+KK5grUYlUW8sKt9sow==
X-Received: by 2002:a62:a219:: with SMTP id m25mr60974348pff.197.1556510131833;
        Sun, 28 Apr 2019 20:55:31 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id x128sm55433585pfx.103.2019.04.28.20.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 20:55:31 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>, evgreen@chromium.org,
        swboyd@chromium.org
Subject: [PATCH 2/2] pinctrl: mediatek: Update cur_mask in mask/mask ops
Date:   Mon, 29 Apr 2019 11:55:15 +0800
Message-Id: <20190429035515.73611-3-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190429035515.73611-1-drinkcat@chromium.org>
References: <20190429035515.73611-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend/resume, mtk_eint_mask may be called while
wake_mask is active. For example, this happens if a wake-source
with an active interrupt handler wakes the system:
irq/pm.c:irq_pm_check_wakeup would disable the interrupt, so
that it can be handled later on in the resume flow.

However, this may happen before mtk_eint_do_resume is called:
in this case, wake_mask is loaded, and cur_mask is restored
from an older copy, re-enabling the interrupt, and causing
an interrupt storm (especially for level interrupts).

Instead, we just record mask/unmask changes in cur_mask. This
also avoids the need to read the current mask in eint_do_suspend,
and we can remove mtk_eint_chip_read_mask function.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/pinctrl/mediatek/mtk-eint.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index 737385e86beb807..7e526bcf5e0b55c 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -113,6 +113,8 @@ static void mtk_eint_mask(struct irq_data *d)
 	void __iomem *reg = mtk_eint_get_offset(eint, d->hwirq,
 						eint->regs->mask_set);
 
+	eint->cur_mask[d->hwirq >> 5] &= ~mask;
+
 	writel(mask, reg);
 }
 
@@ -123,6 +125,8 @@ static void mtk_eint_unmask(struct irq_data *d)
 	void __iomem *reg = mtk_eint_get_offset(eint, d->hwirq,
 						eint->regs->mask_clr);
 
+	eint->cur_mask[d->hwirq >> 5] |= mask;
+
 	writel(mask, reg);
 
 	if (eint->dual_edge[d->hwirq])
@@ -217,19 +221,6 @@ static void mtk_eint_chip_write_mask(const struct mtk_eint *eint,
 	}
 }
 
-static void mtk_eint_chip_read_mask(const struct mtk_eint *eint,
-				    void __iomem *base, u32 *buf)
-{
-	int port;
-	void __iomem *reg;
-
-	for (port = 0; port < eint->hw->ports; port++) {
-		reg = base + eint->regs->mask + (port << 2);
-		buf[port] = ~readl_relaxed(reg);
-		/* Mask is 0 when irq is enabled, and 1 when disabled. */
-	}
-}
-
 static int mtk_eint_irq_request_resources(struct irq_data *d)
 {
 	struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
@@ -384,7 +375,6 @@ static void mtk_eint_irq_handler(struct irq_desc *desc)
 
 int mtk_eint_do_suspend(struct mtk_eint *eint)
 {
-	mtk_eint_chip_read_mask(eint, eint->base, eint->cur_mask);
 	mtk_eint_chip_write_mask(eint, eint->base, eint->wake_mask);
 
 	return 0;
-- 
2.21.0.593.g511ec345e18-goog

