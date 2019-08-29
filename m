Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847AAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D202173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iKOn7hOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfH2Ewq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 00:52:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35579 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfH2Ewo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 00:52:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so923540pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCLG1kPIx0rd7IagBsMwUhjowBuwlFvCVnng2CH8svk=;
        b=iKOn7hOCaIVZcrOHWCkfmLWfviTEu1RKAsOiFZfxyMt/vMfup9dOzSqBWboJpzURDo
         kvaWv0lM7jAHKqbx1S+8dPVj3zbhb0WZjyRS7LxTvU6JJcTAebPqVozuPKBtEoqsPhyO
         aKn2Pz2LEIxU3otPcQUqJA2Bne5qs9MPMo7NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCLG1kPIx0rd7IagBsMwUhjowBuwlFvCVnng2CH8svk=;
        b=DR7dKDqplMxOLztK85eMxWa184Er+kTAY/SOeMJ0S4oEi2WZJF6NUGXJCqQFeoqqU6
         uH6eDKyOqhiIrkBeZ8Uvi5VfA+YQ0iakkj4PX8UyU7V8nYsujVBE7dq9SJCi9740Jv0R
         B+AA1ZY2MoXEjQvp4zmLsJ5dwb/1VLt5cntYKf1vW5G3pdR8opzYsZc7iEdfnGQAju1Q
         RDpL33aqnS8WCyHO//ypI3Hxht+N6eh9uoHZ98EhfWIEN9kjO1cDj1MuEsQNnAZiAAEY
         oKACX+U4EGRzx08LDmcBI+OU5oB97ZU/rWVyZ7hw8hvv3Xz263VZ8cVfipnTUVgkVzTf
         MptQ==
X-Gm-Message-State: APjAAAUF0smvfgSDrtVTsmbf9u9l49JdYnu9ryyjvuQSlcopDc+w4c61
        j0XA8AsWaYeSpGxqSpi8axRJlQ==
X-Google-Smtp-Source: APXvYqyxQlRKRlCbsPkEMA0E+QjPu7/dCEJkZn515O5MtBCgQcoVOkdpI/NmCIYx7StMQBqgclFALg==
X-Received: by 2002:a62:3644:: with SMTP id d65mr9034834pfa.128.1567054363603;
        Wed, 28 Aug 2019 21:52:43 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j1sm1131440pfh.174.2019.08.28.21.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 21:52:42 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li Jin <li.jin@broadcom.com>
Subject: [PATCH 1/2] gpio: iproc-gpio: Fix incorrect pinconf configurations
Date:   Thu, 29 Aug 2019 10:22:27 +0530
Message-Id: <1567054348-19685-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
References: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jin <li.jin@broadcom.com>

Fix drive strength for AON/CRMU controller; fix pull-up/down setting
for CCM/CDRU controller.

Fixes: 616043d58a89 ("pinctrl: Rename gpio driver from cygnus to iproc")
Signed-off-by: Li Jin <li.jin@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 96 +++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index b70058c..20b9864 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -54,8 +54,12 @@
 /* drive strength control for ASIU GPIO */
 #define IPROC_GPIO_ASIU_DRV0_CTRL_OFFSET 0x58
 
-/* drive strength control for CCM/CRMU (AON) GPIO */
-#define IPROC_GPIO_DRV0_CTRL_OFFSET  0x00
+/* pinconf for CCM GPIO */
+#define IPROC_GPIO_PULL_DN_OFFSET   0x10
+#define IPROC_GPIO_PULL_UP_OFFSET   0x14
+
+/* pinconf for CRMU(aon) GPIO and CCM GPIO*/
+#define IPROC_GPIO_DRV_CTRL_OFFSET  0x00
 
 #define GPIO_BANK_SIZE 0x200
 #define NGPIOS_PER_BANK 32
@@ -76,6 +80,12 @@ enum iproc_pinconf_param {
 	IPROC_PINCON_MAX,
 };
 
+enum iproc_pinconf_ctrl_type {
+	IOCTRL_TYPE_AON = 1,
+	IOCTRL_TYPE_CDRU,
+	IOCTRL_TYPE_INVALID,
+};
+
 /*
  * Iproc GPIO core
  *
@@ -100,6 +110,7 @@ struct iproc_gpio {
 
 	void __iomem *base;
 	void __iomem *io_ctrl;
+	enum iproc_pinconf_ctrl_type io_ctrl_type;
 
 	raw_spinlock_t lock;
 
@@ -461,20 +472,44 @@ static const struct pinctrl_ops iproc_pctrl_ops = {
 static int iproc_gpio_set_pull(struct iproc_gpio *chip, unsigned gpio,
 				bool disable, bool pull_up)
 {
+	void __iomem *base;
 	unsigned long flags;
+	unsigned int shift;
+	u32 val_1, val_2;
 
 	raw_spin_lock_irqsave(&chip->lock, flags);
-
-	if (disable) {
-		iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio, false);
+	if (chip->io_ctrl_type == IOCTRL_TYPE_CDRU) {
+		base = chip->io_ctrl;
+		shift = IPROC_GPIO_SHIFT(gpio);
+
+		val_1 = readl(base + IPROC_GPIO_PULL_UP_OFFSET);
+		val_2 = readl(base + IPROC_GPIO_PULL_DN_OFFSET);
+		if (disable) {
+			/* no pull-up or pull-down */
+			val_1 &= ~BIT(shift);
+			val_2 &= ~BIT(shift);
+		} else if (pull_up) {
+			val_1 |= BIT(shift);
+			val_2 &= ~BIT(shift);
+		} else {
+			val_1 &= ~BIT(shift);
+			val_2 |= BIT(shift);
+		}
+		writel(val_1, base + IPROC_GPIO_PULL_UP_OFFSET);
+		writel(val_2, base + IPROC_GPIO_PULL_DN_OFFSET);
 	} else {
-		iproc_set_bit(chip, IPROC_GPIO_PAD_RES_OFFSET, gpio,
-			       pull_up);
-		iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio, true);
+		if (disable) {
+			iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio,
+				      false);
+		} else {
+			iproc_set_bit(chip, IPROC_GPIO_PAD_RES_OFFSET, gpio,
+				      pull_up);
+			iproc_set_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio,
+				      true);
+		}
 	}
 
 	raw_spin_unlock_irqrestore(&chip->lock, flags);
-
 	dev_dbg(chip->dev, "gpio:%u set pullup:%d\n", gpio, pull_up);
 
 	return 0;
@@ -483,14 +518,35 @@ static int iproc_gpio_set_pull(struct iproc_gpio *chip, unsigned gpio,
 static void iproc_gpio_get_pull(struct iproc_gpio *chip, unsigned gpio,
 				 bool *disable, bool *pull_up)
 {
+	void __iomem *base;
 	unsigned long flags;
+	unsigned int shift;
+	u32 val_1, val_2;
 
 	raw_spin_lock_irqsave(&chip->lock, flags);
-	*disable = !iproc_get_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio);
-	*pull_up = iproc_get_bit(chip, IPROC_GPIO_PAD_RES_OFFSET, gpio);
+	if (chip->io_ctrl_type == IOCTRL_TYPE_CDRU) {
+		base = chip->io_ctrl;
+		shift = IPROC_GPIO_SHIFT(gpio);
+
+		val_1 = readl(base + IPROC_GPIO_PULL_UP_OFFSET) & BIT(shift);
+		val_2 = readl(base + IPROC_GPIO_PULL_DN_OFFSET) & BIT(shift);
+
+		*pull_up = val_1 ? true : false;
+		*disable = (val_1 | val_2) ? false : true;
+
+	} else {
+		*disable = !iproc_get_bit(chip, IPROC_GPIO_RES_EN_OFFSET, gpio);
+		*pull_up = iproc_get_bit(chip, IPROC_GPIO_PAD_RES_OFFSET, gpio);
+	}
 	raw_spin_unlock_irqrestore(&chip->lock, flags);
 }
 
+#define DRV_STRENGTH_OFFSET(gpio, bit, type)  ((type) == IOCTRL_TYPE_AON ? \
+	((2 - (bit)) * 4 + IPROC_GPIO_DRV_CTRL_OFFSET) : \
+	((type) == IOCTRL_TYPE_CDRU) ? \
+	((bit) * 4 + IPROC_GPIO_DRV_CTRL_OFFSET) : \
+	((bit) * 4 + IPROC_GPIO_REG(gpio, IPROC_GPIO_ASIU_DRV0_CTRL_OFFSET)))
+
 static int iproc_gpio_set_strength(struct iproc_gpio *chip, unsigned gpio,
 				    unsigned strength)
 {
@@ -505,11 +561,8 @@ static int iproc_gpio_set_strength(struct iproc_gpio *chip, unsigned gpio,
 
 	if (chip->io_ctrl) {
 		base = chip->io_ctrl;
-		offset = IPROC_GPIO_DRV0_CTRL_OFFSET;
 	} else {
 		base = chip->base;
-		offset = IPROC_GPIO_REG(gpio,
-					 IPROC_GPIO_ASIU_DRV0_CTRL_OFFSET);
 	}
 
 	shift = IPROC_GPIO_SHIFT(gpio);
@@ -520,11 +573,11 @@ static int iproc_gpio_set_strength(struct iproc_gpio *chip, unsigned gpio,
 	raw_spin_lock_irqsave(&chip->lock, flags);
 	strength = (strength / 2) - 1;
 	for (i = 0; i < GPIO_DRV_STRENGTH_BITS; i++) {
+		offset = DRV_STRENGTH_OFFSET(gpio, i, chip->io_ctrl_type);
 		val = readl(base + offset);
 		val &= ~BIT(shift);
 		val |= ((strength >> i) & 0x1) << shift;
 		writel(val, base + offset);
-		offset += 4;
 	}
 	raw_spin_unlock_irqrestore(&chip->lock, flags);
 
@@ -541,11 +594,8 @@ static int iproc_gpio_get_strength(struct iproc_gpio *chip, unsigned gpio,
 
 	if (chip->io_ctrl) {
 		base = chip->io_ctrl;
-		offset = IPROC_GPIO_DRV0_CTRL_OFFSET;
 	} else {
 		base = chip->base;
-		offset = IPROC_GPIO_REG(gpio,
-					 IPROC_GPIO_ASIU_DRV0_CTRL_OFFSET);
 	}
 
 	shift = IPROC_GPIO_SHIFT(gpio);
@@ -553,10 +603,10 @@ static int iproc_gpio_get_strength(struct iproc_gpio *chip, unsigned gpio,
 	raw_spin_lock_irqsave(&chip->lock, flags);
 	*strength = 0;
 	for (i = 0; i < GPIO_DRV_STRENGTH_BITS; i++) {
+		offset = DRV_STRENGTH_OFFSET(gpio, i, chip->io_ctrl_type);
 		val = readl(base + offset) & BIT(shift);
 		val >>= shift;
 		*strength += (val << i);
-		offset += 4;
 	}
 
 	/* convert to mA */
@@ -734,6 +784,7 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 	u32 ngpios, pinconf_disable_mask = 0;
 	int irq, ret;
 	bool no_pinconf = false;
+	enum iproc_pinconf_ctrl_type io_ctrl_type = IOCTRL_TYPE_INVALID;
 
 	/* NSP does not support drive strength config */
 	if (of_device_is_compatible(dev->of_node, "brcm,iproc-nsp-gpio"))
@@ -764,8 +815,15 @@ static int iproc_gpio_probe(struct platform_device *pdev)
 			dev_err(dev, "unable to map I/O memory\n");
 			return PTR_ERR(chip->io_ctrl);
 		}
+		if (of_device_is_compatible(dev->of_node,
+					    "brcm,cygnus-ccm-gpio"))
+			io_ctrl_type = IOCTRL_TYPE_CDRU;
+		else
+			io_ctrl_type = IOCTRL_TYPE_AON;
 	}
 
+	chip->io_ctrl_type = io_ctrl_type;
+
 	if (of_property_read_u32(dev->of_node, "ngpios", &ngpios)) {
 		dev_err(&pdev->dev, "missing ngpios DT property\n");
 		return -ENODEV;
-- 
2.7.4

