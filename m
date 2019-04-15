Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0361EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A187720674
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="0Q9czuXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfDOFyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:54:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38046 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOFyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:54:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so8000847plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 22:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tmRKARuvQC07weyJBgcu/aLZ7pp1eDVPtMWmqheidpU=;
        b=0Q9czuXBWAR6VIZgerejIg50icRS65ssyiVh8lYinMDBM7qPaV63jf7YWV5RA+N9Su
         Rx6HfVtEcYR4ZbaC8hYTmGIh6BwILsOLu0ypqYp3tU9B8q0aU22BQK0uQHBsP+MWFzJM
         x2jE61gXMrHZrzdq+aJC1GRJWOisyQwBZgnTghKaIqJs5qyXtH8TRIEBh6FTd6OCQ/Jd
         suCjRCvSIeTSz1Ncy/ADmw8wCnS1mltMwPw8/la8pPKiVC9V9vaeTR2pMrbcUChAoNpY
         8nP2ZNBju6/KQ3LHGe+UkdC0NYZm6thuoMmZ3m5iLOwYL1IISPakNY41p5hB8tstilOO
         RuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tmRKARuvQC07weyJBgcu/aLZ7pp1eDVPtMWmqheidpU=;
        b=I/BGGTe5TPrrh7v2K+Nh58G1qgHn6IS5eHb3wNIaTr6bedNThDTyeLN5CL6Feubkrl
         vCIgK5bgGfyxWywI8sWMz5tSqPg8NvasnqaRFy/RQcVaZ+zO7VJhtnB4f/IgZqny2F0o
         gr4PvMPI22tDdeCmhBqgX6A24BCepCNFZBDbmP22upytwukeyz7uoAZ0ZfnR7NSbp799
         3rVTtaeO34Spuu79hXn50vzCuKzUUSwohaP/hd/8Z9fGYnHLrY56DsJ6smM+myZIBUCD
         0hhySDsihQhVBpNp875foG9Yc6ff9V6MOIPgaxMQyhVqRBLI+Z6jVo07T2Bc1HqcJrDx
         cbmA==
X-Gm-Message-State: APjAAAXIbqslp51YZhGh0wMDsmSgvDxG250NcCDyq+YeRgt58JYeURmX
        L73Fx7yywU4vmVbG9GCI9MS5ZQ==
X-Google-Smtp-Source: APXvYqwM/k6U9AOVhwhoYYNs8lWNFSJBZ/PEXWZRqWBwbi6ykLknyfo2700HOc7iSnWxsvtTvgxO0A==
X-Received: by 2002:a17:902:bb0d:: with SMTP id l13mr71014348pls.141.1555307648637;
        Sun, 14 Apr 2019 22:54:08 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-232.HINET-IP.hinet.net. [220.133.8.232])
        by smtp.gmail.com with ESMTPSA id d15sm67298082pfo.34.2019.04.14.22.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Apr 2019 22:54:07 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     andriy.shevchenko@intel.com, mika.westerberg@linux.intel.com,
        heikki.krogerus@linux.intel.com
Cc:     drake@endlessm.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH v3] pinctrl:intel: Retain HOSTSW_OWN for requested gpio pin
Date:   Mon, 15 Apr 2019 13:53:58 +0800
Message-Id: <20190415055358.9269-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchpad of the ASUS laptops E403NA, X540NA, X541NA are not
responsive after suspend/resume. The following error message
shows after resume.
 i2c_hid i2c-ELAN1200:00: failed to reset device.

On these laptops, the touchpad interrupt is connected via a GPIO
pin which is controlled by Intel pinctrl. After system resumes,
the GPIO is in ACPI mode and no longer works as an IRQ.

This commit saves the HOSTSW_OWN value during suspend, make sure
the HOSTSW_OWN mode remains the same after resume.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---

Note:
v2: update hostown and show pr_info only when the host mode
    change on requsted GPIO is not expected.
v3: change return type of intel_gpio_update_pad_mode() from
    void to u32 and use dev_warn instead of pr_info.

 drivers/pinctrl/intel/pinctrl-intel.c | 56 ++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 8cda7b535b02..5337289c550b 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -81,6 +81,7 @@ struct intel_pad_context {
 
 struct intel_community_context {
 	u32 *intmask;
+	u32 *hostown;
 };
 
 struct intel_pinctrl_context {
@@ -1284,7 +1285,7 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
 
 	for (i = 0; i < pctrl->ncommunities; i++) {
 		struct intel_community *community = &pctrl->communities[i];
-		u32 *intmask;
+		u32 *intmask, *hostown;
 
 		intmask = devm_kcalloc(pctrl->dev, community->ngpps,
 				       sizeof(*intmask), GFP_KERNEL);
@@ -1292,6 +1293,13 @@ static int intel_pinctrl_pm_init(struct intel_pinctrl *pctrl)
 			return -ENOMEM;
 
 		communities[i].intmask = intmask;
+
+		hostown = devm_kcalloc(pctrl->dev, community->ngpps,
+				       sizeof(*hostown), GFP_KERNEL);
+		if (!hostown)
+			return -ENOMEM;
+
+		communities[i].hostown = hostown;
 	}
 
 	pctrl->context.pads = pads;
@@ -1503,6 +1511,10 @@ int intel_pinctrl_suspend(struct device *dev)
 		base = community->regs + community->ie_offset;
 		for (gpp = 0; gpp < community->ngpps; gpp++)
 			communities[i].intmask[gpp] = readl(base + gpp * 4);
+
+		base = community->regs + community->hostown_offset;
+		for (gpp = 0; gpp < community->ngpps; gpp++)
+			communities[i].hostown[gpp] = readl(base + gpp * 4);
 	}
 
 	return 0;
@@ -1529,6 +1541,29 @@ static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
 	}
 }
 
+static u32
+intel_gpio_is_requested(struct gpio_chip *chip, int base, unsigned int size)
+{
+	u32 requested = 0;
+	unsigned int i;
+
+	for (i = 0; i < size; i++)
+		if (gpiochip_is_requested(chip, base + i))
+			requested |= BIT(i);
+
+	return requested;
+}
+
+static u32
+intel_gpio_update_pad_mode(void __iomem *hostown, u32 mask, u32 value)
+{
+	u32 curr = readl(hostown);
+	u32 updated = (curr & ~mask) | (value & mask);
+
+	writel(updated, hostown);
+	return curr;
+}
+
 int intel_pinctrl_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1588,6 +1623,25 @@ int intel_pinctrl_resume(struct device *dev)
 			dev_dbg(dev, "restored mask %d/%u %#08x\n", i, gpp,
 				readl(base + gpp * 4));
 		}
+
+		base = community->regs + community->hostown_offset;
+		for (gpp = 0; gpp < community->ngpps; gpp++) {
+			const struct intel_padgroup *padgrp = &community->gpps[gpp];
+			u32 requested = 0, value = 0;
+			u32 saved = communities[i].hostown[gpp];
+
+			if (padgrp->gpio_base < 0)
+				continue;
+
+			requested = intel_gpio_is_requested(&pctrl->chip,
+					padgrp->gpio_base, padgrp->size);
+			value = intel_gpio_update_pad_mode(base + gpp * 4,
+					requested, saved);
+			if ((value ^ saved) & requested) {
+				dev_warn(dev, "restore hostown %d/%u %#8x->%#8x\n",
+					i, gpp, value, saved);
+			}
+		}
 	}
 
 	return 0;
-- 
2.21.0

