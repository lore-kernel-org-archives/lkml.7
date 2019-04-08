Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AACC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331E520879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="lcXjvX2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfDHEVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 00:21:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34713 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHEVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 00:21:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so6819574pfd.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HLyGtSvUMet/S5RgCgXDemVbE9lWzPHB3e2/ltMkfyQ=;
        b=lcXjvX2hF+Dowgl73lOMd4N+KKRbna2ZdQeEjf6Z/DWhma4V/zfzyKSGkHy6inOpoH
         1NH4hd94qOFGkl8BfyIaCzhU8G6bEKNgNBkegx2HUDwLSVZhPmRXF+IOPmwTSeqJeye/
         8hLyNW7Y+pFxowiDGASt1HkKRu8EcivB3Hqs42Tgh79fld+hnwejoC5xoYHAYSsVKKyN
         GtcH2fCrnTlrUq9FCoo2owvfsJObozsGGYA9QlK+WckmF72XKmJSDObNM0sDQi8wEpJ8
         6236sqiI0BxrrajVBpuGcxQv3RhYc+seBZt6F9LySr62JTWZf5NamcmECReDv+nxH6Wj
         +opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HLyGtSvUMet/S5RgCgXDemVbE9lWzPHB3e2/ltMkfyQ=;
        b=SPpiAlFxeP+ZBDbB6tzx0Dy14rkZN/DFtClmFGZTkwlLq36CLvPhg1xDv4mUkSANhe
         IHJDx6y5ajwqGysqabRitARe2dxXuM5kcy/jjVrZQb2NvkIlbwyoUWvBVLafH8zzCqHM
         Sy/YYKgInRGzxNLZPTgcEU4/iKIp5QXw1Ue8RylWy+urIDBf0Wy+wynhsDTj9tqcJB6w
         +sMPYt+p+qvZ9UcvZFkTZN+lg1tq43YobIahFz6+EXfHDYeBqVDnlEN0WX09sVuLZEuB
         8HySWFhtH+dLhtnsHtjr9nQx8Sry4qenQxNzM7mvD76V0c+FlHIbVQENLzK8hruue+Aw
         HYpQ==
X-Gm-Message-State: APjAAAVensqLkPEgIb6FOjRIyHMU6Py2iPfK2H6xacrtU9C1n9MsX0Im
        nwut3LQfwsje4xBPV0INF9B45g==
X-Google-Smtp-Source: APXvYqxiO8j18SUVqvPZizIqaw4Lvd66wBqmd7z4kzYiLdvzogjseb+IkAHISbZZD2pPiA8clQXgSw==
X-Received: by 2002:a63:c104:: with SMTP id w4mr26426338pgf.409.1554697273134;
        Sun, 07 Apr 2019 21:21:13 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-232.HINET-IP.hinet.net. [220.133.8.232])
        by smtp.gmail.com with ESMTPSA id x28sm24840248pgl.38.2019.04.07.21.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Apr 2019 21:21:12 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     andriy.shevchenko@intel.com, mika.westerberg@linux.intel.com,
        heikki.krogerus@linux.intel.com
Cc:     drake@endlessm.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] pinctrl:intel: Retain HOSTSW_OWN for requested gpio pin
Date:   Mon,  8 Apr 2019 12:21:03 +0800
Message-Id: <20190408042103.3804-1-chiu@endlessm.com>
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
 drivers/pinctrl/intel/pinctrl-intel.c | 50 ++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 8cda7b535b02..3930819049c4 100644
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
@@ -1529,6 +1541,28 @@ static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
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
+	return writel(updated, hostown);
+}
+
 int intel_pinctrl_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1588,6 +1622,20 @@ int intel_pinctrl_resume(struct device *dev)
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

