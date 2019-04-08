Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9277C20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="slISdFQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDHJvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:51:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34325 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:51:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so7042171plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=w+wChlffPzgdS1t1FPeqXUQ9C8GFlEcI+jkWVqn7Lzc=;
        b=slISdFQtSiYo3p6ast9PASoEEHblVXv5uYVM1JrFsctPcPVcVGia/XUwDrHjckTKMd
         OAJFVCNWZ9y1Pq/teHZzMk9wuw0VJiP5pAoj/G8vn3y2u93bLsjiVamb2Ulf+J+3KBIt
         wPPjthQO9cVuJSRw+Dx4S3Jy6jfJxiNr6zZSXFcyd5CbO72K/XxVqUJ5498ay3s6hSEX
         JvtlVnFsG2tYBmRKZbqnBBPqnDQHx/h7Rwy9fhY9ZEW1Fqp8S6AZKuUCIsrGeXnhBBSW
         U2D7eRmqP3yJ1RjPPApjywFJixLfo/kI5cN+YBI3lBpSUt8Z4Y5Tza9sZgR8BKRw/xaj
         /qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w+wChlffPzgdS1t1FPeqXUQ9C8GFlEcI+jkWVqn7Lzc=;
        b=msvQp3mrHx7fBu49Id4K9SUeHkaXVte2Z6QmzpBsj3KjhzwOwXAvDrfb4CXF6mBce7
         KvMK/QM8x0x4+EndQAP/wNJmVgbiZPrJj7ewYBQH84xv6iv/b8lKLclDeANl6j+hwHFk
         o0pu+ajBwXkhwO45jqDDiWV1UTJ1Qlm7mxGs4/GJnkpwKOa/Gyq2pZwdsQ0DMRdj/nZA
         mHaRoUqYnFVm+mwFbMXuh6UUushA3SEzveQG3A6leZ7J+rooaQ5/zY5XQR15jTk+rzNu
         LHTY2GuSyixTlrsaQfZC+BQ4FZ7CVoI/TTbPdzGdQnr24hKtAtr9PRlcp9QXmi7MP5k0
         ukiQ==
X-Gm-Message-State: APjAAAXQ6W8HCeKi4sJ4J+SvRTGLV2OlsfJrsrNIqN5bmZytRpxFdgd8
        8LE/IXMP6Fq8I4IJjdJjl/Ld/w==
X-Google-Smtp-Source: APXvYqzf0jsj5lx01FAhRE1ipCL7LFRhoT8vToysTHKE1AXndNTNEhipgNLpUhVdacjkcgdflhSlWQ==
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11mr29148263plo.133.1554717094438;
        Mon, 08 Apr 2019 02:51:34 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-232.HINET-IP.hinet.net. [220.133.8.232])
        by smtp.gmail.com with ESMTPSA id j20sm11240858pfn.84.2019.04.08.02.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:51:33 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     andriy.shevchenko@intel.com, mika.westerberg@linux.intel.com,
        heikki.krogerus@linux.intel.com
Cc:     drake@endlessm.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH v2] pinctrl:intel: Retain HOSTSW_OWN for requested gpio pin
Date:   Mon,  8 Apr 2019 17:51:27 +0800
Message-Id: <20190408095127.6197-1-chiu@endlessm.com>
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

 drivers/pinctrl/intel/pinctrl-intel.c | 54 ++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 8cda7b535b02..f8256f030bbb 100644
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
@@ -1529,6 +1541,32 @@ static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
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
+static void
+intel_gpio_update_pad_mode(void __iomem *hostown, u32 mask, u32 value)
+{
+	u32 curr = readl(hostown);
+	u32 updated = (curr & ~mask) | (value & mask);
+
+	if (curr ^ updated) {
+		pr_info("pinctrl-intel: restore HOSTSW_OWN %#08x->%#08x\n",
+			curr, value);
+		return writel(updated, hostown);
+	}
+}
+
 int intel_pinctrl_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1588,6 +1626,20 @@ int intel_pinctrl_resume(struct device *dev)
 			dev_dbg(dev, "restored mask %d/%u %#08x\n", i, gpp,
 				readl(base + gpp * 4));
 		}
+
+		base = community->regs + community->hostown_offset;
+		for (gpp = 0; gpp < community->ngpps; gpp++) {
+			const struct intel_padgroup *padgrp = &community->gpps[gpp];
+			u32 requested = 0;
+
+			if (padgrp->gpio_base < 0)
+				continue;
+
+			requested = intel_gpio_is_requested(&pctrl->chip,
+					padgrp->gpio_base, padgrp->size);
+			intel_gpio_update_pad_mode(base + gpp * 4, requested,
+					communities[i].hostown[gpp]);
+		}
 	}
 
 	return 0;
-- 
2.21.0

