Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A264C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BD22087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="JOvsdfrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfD0TNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:13:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39384 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD0TNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:13:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id n187so5495017oih.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=72QnkVeZl7BGBdu2NJ1aFkR+mDly/cwA9f117/+WG0c=;
        b=JOvsdfrLGx0Z/mfrolVdvjMD2RzCD1EcNkwvFBrR7Gj5V91Yg2TiQEJjbGYcV6K1F7
         bXCIHfqsSe4SE55RivmoKL7NeBQ/tBk6O1YXCMbF3F9ZbltBRmk3I8BiJVRptv1l6o/F
         Q1FFYbuQFwVigg7Gilr6q3kjrO1IqCzfXR/q5EDs1xqQMj9btcTweyM1dUm0492lLpjj
         uswDJ0FpzNyz7bzuTd1XXqkcDLamerUFO5Bd5fnuUh3UXg73n0IBmgsC7echL3DB099G
         imbUp/QPkvFZQq88fWPwReQyT1sqCl7Vau2/xfdSCSDtzewfp0rlkzhs/1pOeRLfjAKj
         Dlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=72QnkVeZl7BGBdu2NJ1aFkR+mDly/cwA9f117/+WG0c=;
        b=criUNUBs2QLShU9OLkTpPv0zp+sTqleWHNxymp/usCoA0ksPdg7JmTjAsQPC72BdbR
         /lkwFL8D3i2BzoLh9IYiRsuPrfr7tubAe/54RbLU+7RvVCKJjGDLORw4LavaiQlhNeGL
         qUKcFNecAhm96VjO7fgTZTK/1XH5UgVHXeU2SL5a/1i93relh5WrQJmPMNuFljLYOQ5x
         lM36dRwjtaMUf91q3A+VnMr7osWUlQiyNWh7d2T3UcLyInMPt6O+LsY1pm36lMsDyDtb
         p3Q1eVG7bsREGs3G87ihUX9wuka6JadIQxwVQ1StB4u5/LfMl/Ldk9jFa/XD3nCwAu4N
         kU4A==
X-Gm-Message-State: APjAAAU1EWDaRZQdTI7pSz8q5Cta8Qr2PlfP5UDGxTrmwu8VPifAW7HD
        SfBeVwRFxdRuFAStAtz4LB3iIQ==
X-Google-Smtp-Source: APXvYqytY1MBFt8L0ldKkuSzlceSWGuMYehjsfVSwHqCLLcOLvRtWODpjdApDIgV5tLzaYnwVQxZaw==
X-Received: by 2002:aca:df44:: with SMTP id w65mr10517932oig.66.1556392398832;
        Sat, 27 Apr 2019 12:13:18 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:3d43:9acc:6ecc:a72c])
        by smtp.gmail.com with ESMTPSA id w2sm11373096otk.73.2019.04.27.12.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 12:13:18 -0700 (PDT)
From:   fred@fredlawl.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 3/4] PCI: pciehp: Remove unused macro definitions
Date:   Sat, 27 Apr 2019 14:13:03 -0500
Message-Id: <20190427191304.32502-4-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427191304.32502-1-fred@fredlawl.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Now that all uses for the ctrl_*() printk wrappers are removed from
files and replaces with pci_*() or pr_*() printk wrappers, remove the
unused macro definitions. In addition to that, remove the MY_NAME macro.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/hotplug/pciehp.h     | 27 ---------------------------
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 2 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 506e1d923a1f..7d3a32a1504a 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -25,37 +25,10 @@
 
 #include "../pcie/portdrv.h"
 
-#define MY_NAME	"pciehp"
-
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
 
-#define dbg(format, arg...)						\
-do {									\
-	if (pciehp_debug)						\
-		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
-} while (0)
-#define err(format, arg...)						\
-	printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
-#define info(format, arg...)						\
-	printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
-#define warn(format, arg...)						\
-	printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
-
-#define ctrl_dbg(ctrl, format, arg...)					\
-	do {								\
-		if (pciehp_debug)					\
-			dev_printk(KERN_DEBUG, &ctrl->pcie->device,	\
-					format, ## arg);		\
-	} while (0)
-#define ctrl_err(ctrl, format, arg...)					\
-	dev_err(&ctrl->pcie->device, format, ## arg)
-#define ctrl_info(ctrl, format, arg...)					\
-	dev_info(&ctrl->pcie->device, format, ## arg)
-#define ctrl_warn(ctrl, format, arg...)					\
-	dev_warn(&ctrl->pcie->device, format, ## arg)
-
 #define SLOT_NAME_SIZE 10
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5e5631fd0171..28a132a0d9db 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -47,7 +47,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 
 	/* Installs the interrupt handler */
 	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
-				      IRQF_SHARED, MY_NAME, ctrl);
+				      IRQF_SHARED, "pciehp", ctrl);
 	if (retval)
 		pci_err(pdev, "Cannot get irq %d for the hotplug controller\n",
 			irq);
-- 
2.17.1

