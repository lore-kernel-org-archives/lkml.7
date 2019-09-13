Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5398A20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrzvUUF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390063AbfIMTPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:15:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39638 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389943AbfIMTPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:15:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so15719401pgi.6;
        Fri, 13 Sep 2019 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x/1eUyWPGFj2wULry4fSJWpBPwqBU21SfxLgwHYAjPg=;
        b=BrzvUUF5gYKFZkqIivZmB5392yuvze9AbbplQ0GK3OoiiglyzWFvtk2nrYz+Yb0TSc
         cKpsMW+oSuKcUm8ZunWjTWq0L2bvfY3HjhKUrdvOswfnIyslNjK1foQRpPCO3sR+jzY/
         seeby2arHTHMeF8pzPH765fwMrAuQAWaFwBmLENDmUJQt2DNNWHB+YNbeGMW97k/Vi3T
         reEZIK9WFDsYEh0sCcBO+zZtXnwsA6t2vcryZu5xHijF7Q92xZXCo5QcWMsF/oEkvAJs
         4fqKOGSWcf1CtJArCdyvwD3BCbgha1zh0+Q7ybYjK3fDfilNr3Hpz+iaOfHkdiS5/yZ9
         8Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x/1eUyWPGFj2wULry4fSJWpBPwqBU21SfxLgwHYAjPg=;
        b=VInYcBrNGvz5y2g1T8EaUV8P5rLESCwYKmT4MlRHp7awBRrAwt678bEsR9ADxd6Mm9
         AgOWDPZpefZqEJ/MrXX4U39eTLlbMcr2YKSrhMWurmy/O/GoP57sPLYYPf4e30+OlFaK
         8JTM5dbxX7xZG1RRF2gLf/Lw7DcQPg4m3V1IG1Vq9GucSX2+BytFEvhmU2TuKrubW4xA
         m3sUB6y3KkjxG1ie5VjCb8iL0bLphDxVihH+IlGbnh2ZuDss87mRXlJPy+SQVwN8azAU
         hJSb9sdwaiAJgungv16tolvHUeWVJu1UFF3TMxGURlNBh0qNYkfR86yKqHH7RsArxRnZ
         Bwwg==
X-Gm-Message-State: APjAAAWJZ3KQp9iUU2wWF8/KvHFVTyvr9FE2A7TWNme2DsM3LSB7fhLb
        +3RRCmqSsgt9tg8Smm/LPwmUjIoduHw=
X-Google-Smtp-Source: APXvYqzF2s/bKLuw6kiJgc+ZNlKO896um1C1U0ZeAJYaxCjGTB/uSBl2HKUw3aBwzImKCG+aOqktMw==
X-Received: by 2002:a63:bf01:: with SMTP id v1mr43807633pgf.278.1568402149873;
        Fri, 13 Sep 2019 12:15:49 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m24sm6988149pgj.71.2019.09.13.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 12:15:49 -0700 (PDT)
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
Subject: [PATCH v2 2/5] dt-bindings: Document brcm,irq-can-wake for brcm,bcm7038-l1-intc.txt
Date:   Fri, 13 Sep 2019 12:15:39 -0700
Message-Id: <20190913191542.9908-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913191542.9908-1-f.fainelli@gmail.com>
References: <20190913191542.9908-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM7038 L1 interrupt controller can be used as a wake-up interrupt
controller on MIPS and ARM-based systems, document the brcm,irq-can-wake
which has been "standardized" across Broadcom interrupt controllers.

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

