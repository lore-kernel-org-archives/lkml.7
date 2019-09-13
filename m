Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC8C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9BF2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPz3tW4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbfIMTKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:10:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35436 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbfIMTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:10:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so18665141pfw.2;
        Fri, 13 Sep 2019 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=52dr8qatRQLADbgLjvJtKFDILDVDIhY+4/06nquh468=;
        b=nPz3tW4qoi5HnmP98xfj1kSrj3sha1ABx497Kmj4jQRBIpWtlTctWT7YqDGYOjX8B6
         FJ5JTdfEQDXUcLTcV7tbnQQ/VjQgAHYHYrxnKPMekGXE4XZsyVWJyY2RR4bsDzJUsgfv
         /EcyWPmb/sADi5EsrIyWfPi0+32fVGKGyB4OxCS0R3ffeR+J4TX8vUYo8i5ouIEuGFAz
         JDxfrPma7RBsOyJzL5d6Zhr8UJtRdMOLhVC8vJ0PzfHqQyUVGufdBodRfZdhTonao7iI
         qIZm7CrBsFPtCBv7RqVPP1x62PfcvIfoKmVXDKRR7FYM4TXzKfWTnjPMncGn0gieS5zQ
         K9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=52dr8qatRQLADbgLjvJtKFDILDVDIhY+4/06nquh468=;
        b=DysDme8Cigmh9Xs6ENpknDxhVRP5q0bPXmX3QBrMlUgVeUWK/4JwwWmU6kj/OTIIKL
         F2Cz9HUaAHjmnFTnQbDp7O1WuvNGPkg7RIMl+SY6YPU45+8YzFThTHbX6Xo171Or6kiC
         AxdnLLbWKg/u7Y680zSNVVkRjeOcYe+R37vEwjxX0HailVMlxutR+FNaez7nWC3HJTgD
         TPFKM6aV+heSEAN2H2+92wXbWAX2etzP2CcLRpN25P2TmYSZKaLFafxx56lWr4mKjCB+
         P0KSXbqRg55V2KDkW9KPNOZUATBA7www0E6x+tKhzWcXoup/OHe689N1AD7Q0glZp9Np
         rGxw==
X-Gm-Message-State: APjAAAV9V6y3pWDvbYsT1IwZwYRym84Y5F0FZfYc+/AM0n6XC8Bt3XRO
        NDIFDZL21k4XsDxpcAGkvXQsor512vU=
X-Google-Smtp-Source: APXvYqxqR/TzT50mDL3/6MR0Yms0OQkm4wIHlKEHIMITDKqcUSrr3CHMxgugyGlui1PyebpzoowadA==
X-Received: by 2002:a17:90a:8987:: with SMTP id v7mr7088657pjn.115.1568401836877;
        Fri, 13 Sep 2019 12:10:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r18sm27273779pfc.3.2019.09.13.12.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 12:10:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM BMIPS MIPS
        ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE)
Subject: [PATCH 6/6] fixup! irqchip/irq-bcm7038-l1: Add PM support
Date:   Fri, 13 Sep 2019 12:10:26 -0700
Message-Id: <20190913191026.8801-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913191026.8801-1-f.fainelli@gmail.com>
References: <20190913191026.8801-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/irqchip/irq-bcm7038-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 5e8f0fbc5f20..811a34201dd4 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -397,7 +397,7 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 #ifdef CONFIG_SMP
 	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
 #endif
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 	.irq_set_wake		= bcm7038_l1_set_wake,
 #endif
 };
-- 
2.17.1

