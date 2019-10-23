Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF81CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99FB21783
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhTu4zFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfJWAGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:06:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40653 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfJWAGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:06:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so17753030wmj.5;
        Tue, 22 Oct 2019 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UHr4crB3Dlo9CDtDYw06eX2hUAeMInOCDregffY1R94=;
        b=ZhTu4zFIDCC2d1bvNTmeamTKakpEcalGy9udhPKNt1cQUWiJ+rCzQz82XXyMQHDqJv
         UJCZz6zd/i8PE6urMg1yTNfDt7SOlIR+WYCdOSj5dMkAuw1Cq8q44MXqVdDyAMsM7vnW
         Y/ZT6Z8/37dK/26p0vThbdaC3LW+M66H2xH+613Thh6apkUETaEyRll8JGmwjWp/NJ4q
         7Qh741sIjHHV2WKEeo5q9V1IFlANaqYvuxusUFEm2WHg5qVvYwBSD5CvNNkGzIttvA75
         1iGlIOw6dchx6RvOwcVvUu1fmbgiaSPI78cR6N7yzjryreDTeGnZqDd4tFZH3Y9E3fEC
         64Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UHr4crB3Dlo9CDtDYw06eX2hUAeMInOCDregffY1R94=;
        b=jI7cRrd46wz/CAtFzmcMjXxeVYwN3HE0mZJoAXSYetHlItrzJap+XI+PJUO6uZa3Sy
         SHRECp2OMb+qU7JL4vrqNjov9dPURXX81sQq99MFoOvylmlFgFjqIeOlOCzymCpY3S+U
         78kJXL2wDHhhhKlBaI8pKFL+s/tZZs42/xKvI8fCet/DFxI0uDBWPJoks1MCW5KVFKJ5
         ZpJUlACZuR6yMM2fglxpA5gAppCGavRVvtw47kUmudzDl4sqUhoon3Bot/656LuvSjER
         4e5Qww0zjGZdc9VjDfJcGmC7iDAfw9Ua1TMmYIyvV/w1W9GRO8zEuSfXwVGPPq7r71a7
         49DQ==
X-Gm-Message-State: APjAAAVBaHut9P+nLcxtqYVv+uaiOPQcLgIyNAdXyLE2TRTFQ4X65DRD
        ksJ7vZ9S7QPUIynFauSO2LTA3Uv1
X-Google-Smtp-Source: APXvYqx6vZAry8wKP1UL4roFWw7F2MAgBNgEr3xVlLLYA/CUqWDSAVYx61bir8gN0n5++tH8pFd/rQ==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr5396848wmj.6.1571789161462;
        Tue, 22 Oct 2019 17:06:01 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v10sm18500272wmg.48.2019.10.22.17.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:06:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: [PATCH RFC 2/2] irqchip/gic: Allow the use of SGI interrupts
Date:   Tue, 22 Oct 2019 17:05:47 -0700
Message-Id: <20191023000547.7831-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023000547.7831-1-f.fainelli@gmail.com>
References: <20191023000547.7831-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGI interrupts are a convenient way for trusted firmware to target a
specific set of CPUs. Update the ARM GIC code to allow the translation
and mapping of SGI interrupts.

Since the kernel already uses SGIs for various inter-processor interrupt
activities, we specifically make sure that we do not let users of the
IRQ API to even try to map those.

Internal IPIs remain dispatched through handle_IPI() while public SGIs
get promoted to a normal interrupt flow management.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-gic.c | 41 +++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30ab623343d3..dcfdbaacdd64 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -385,7 +385,10 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 			 * Pairs with the write barrier in gic_raise_softirq
 			 */
 			smp_rmb();
-			handle_IPI(irqnr, regs);
+			if (irqnr < NR_IPI)
+				handle_IPI(irqnr, regs);
+			else
+				handle_domain_irq(gic->domain, irqnr, regs);
 #endif
 			continue;
 		}
@@ -1005,20 +1008,34 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		if (fwspec->param_count < 3)
 			return -EINVAL;
 
-		/* Get the interrupt number and add 16 to skip over SGIs */
-		*hwirq = fwspec->param[1] + 16;
-
-		/*
-		 * For SPIs, we need to add 16 more to get the GIC irq
-		 * ID number
-		 */
-		if (!fwspec->param[0])
+		*hwirq = fwspec->param[1];
+		switch (fwspec->param[0]) {
+		case 0:
+			/*
+			 * For SPIs, we need to add 16 more to get the GIC irq
+			 * ID number
+			 */
+			*hwirq += 16;
+			/* fall through */
+		case 1:
+			/* Add 16 to skip over SGIs */
 			*hwirq += 16;
+			*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 
-		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+			/* Make it clear that broken DTs are... broken */
+			WARN_ON(*type == IRQ_TYPE_NONE);
+			break;
+		case 2:
+			/* Refuse to map internal IPIs */
+			if (*hwirq < NR_IPI)
+				return -EPERM;
+
+			*type = IRQ_TYPE_NONE;
+			break;
+		default:
+			break;
+		}
 
-		/* Make it clear that broken DTs are... broken */
-		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
-- 
2.17.1

