Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD56CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BD621A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdI9CBo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfJXUOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:14:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54319 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfJXUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:14:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id g7so4186338wmk.4;
        Thu, 24 Oct 2019 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MxFvyutT3TeFv9tuYgjWUXMmMJVTn8dALM+g0eVelPM=;
        b=QdI9CBo+X3LUGiOOarfRIMRoq2d0UEbzIKkPRidHPHuATjOrDAp1Cc9P59zxqPyVk1
         +uHrHz5C2konAMC6RmntdYQbCDGcmhyFNO9uNYMqb7BEIKujCGrH1wQ8JnzXHISjPa82
         EBwczDq6hUEypGCchTG7LNMJcRJ1GCYqc8A3A2W5RqtY2nz4PU1tdwIKxZWP5JMQtm/K
         HpqR31IFn1yEozVoKLek4XlZ9MDUYqW+ji+VKDw7zK9uyChTHYixNMlag88At4Mr3GAE
         VRPiMPy5UBz4Vehksda8NyfBxIc+H4bANFvsoDVDSppATcfOOQPi19wvxgKHDzhx8ugr
         XEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MxFvyutT3TeFv9tuYgjWUXMmMJVTn8dALM+g0eVelPM=;
        b=QhpiCojcXaJorR23SDt0nD1azk22Rfzu3rwsokGxtKdCYtxDKSNUxnALzWihnpY2mq
         UnT4g33pn7HFLsl03u5A7CPaU35bYfjdMVI3qADopacBU06EiJvzFFxX86Gxr6g4Cqkb
         GHqh0w0FeHPJRyIcflH+W4RHjbeq3JOdVwnG6qewxQ0UP0CyreY8qVtvL3zv8EK+HKqn
         FThrAQMyIApkXquKcSQaPQIaznBhIkxx9KNNZb5Y2GXds4iHGTW9UeWQH05lX2lEifb1
         5HvksLTJZiUHlmzE/ByRkqrbGlkzj3kIKpXWgL8vC3lMBVyMc6PHlavzv3jLhUHPlV2f
         JozQ==
X-Gm-Message-State: APjAAAUyQ2PZzG+fEtvShkduZ26m/l5I92HJQzWPPYb8IKlbCaBYCv86
        yT2uWiYaUPqqxM50U0ze/S4CpNKg
X-Google-Smtp-Source: APXvYqyhSCLxWJYmS/l2UlSbZ8O72LLkwjqVf7Bxc6RIqRSE5mZrgfoLL9O4u9579TOgwUabK+FJ+A==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr137363wmi.67.1571948069688;
        Thu, 24 Oct 2019 13:14:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u21sm4788536wmu.27.2019.10.24.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:14:29 -0700 (PDT)
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
        ARM ARCHITECTURE)
Subject: [PATCH v3 2/5] dt-bindings: Document brcm,irq-can-wake for brcm,bcm7038-l1-intc.txt
Date:   Thu, 24 Oct 2019 13:14:12 -0700
Message-Id: <20191024201415.23454-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024201415.23454-1-f.fainelli@gmail.com>
References: <20191024201415.23454-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM7038 L1 interrupt controller can be used as a wake-up interrupt
controller on MIPS and ARM-based systems, document the brcm,irq-can-wake
which has been "standardized" across Broadcom interrupt controllers.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
index 2117d4ac1ae5..4eb043270f5b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
@@ -31,6 +31,11 @@ Required properties:
 - interrupts: specifies the interrupt line(s) in the interrupt-parent controller
   node; valid values depend on the type of parent interrupt controller
 
+Optional properties:
+
+- brcm,irq-can-wake: If present, this means the L1 controller can be used as a
+  wakeup source for system suspend/resume.
+
 If multiple reg ranges and interrupt-parent entries are present on an SMP
 system, the driver will allow IRQ SMP affinity to be set up through the
 /proc/irq/ interface.  In the simplest possible configuration, only one
-- 
2.17.1

