Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD173CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC320684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxrmw1bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJXUOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:14:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37741 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfJXUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:14:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id q130so3653965wme.2;
        Thu, 24 Oct 2019 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0EJBLcVaxO20ievCKQMdrfQYhGLJzUvVM7Sr/xv2sbI=;
        b=Nxrmw1bgQn4EKcMU5lgVjre/4937BYB1kLzxodwIDsbj/2QkEm4LnYABrlKBJQgFmF
         uCwcU3BSGTCF63Buf/+lJrdOgfO28tX+0OzQ9oJtfYkQTDjWcAUH22LnVA619AKeNk4j
         OgN9xE2jgyXvJUie2ioTS7/ZgFzWKaF8lvq8EANYZx2AZQ1gNKBCQkqwo1zHkK4s4J05
         ONs3GQD9SUvv2HNKQpvdHtFzLFhBKIOuHvI6QwOdZ5kXIIioSYIrE2vWlWko2Pi6f7UT
         Q7jMLaDzV5jureGpMuYn3Vae4s2J5XqSdxlk7GGeWwAQMW/UaAPxRw32viEX0fZyBtNa
         NtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0EJBLcVaxO20ievCKQMdrfQYhGLJzUvVM7Sr/xv2sbI=;
        b=cbMLpgiAhlNbo6jt2LttggvTOr9X1ox8JXiIm9mizWGrsQy/aSNgbca0X+3rKZYBig
         X7h9cWrlqA7TwBexT9LJaflUVxI1nCa6V3gA1/i9FX9DRxuCN2Cm6adrUjsgyFMnXUAo
         rJKUkgrzOpZbJU1Dg1RHZ/hNTyX3qEuHHFlY3d7A8ZL9GHk31zN5B6PMxW3NqRndt4a5
         W0yPgxTW/RgvCuUzYs5+kk+beWVrvvKMvqwk4wSYKZm9KP0THBSrMIs5voQJlvygoPT2
         v/n+5pegfOQ9U+LQMyGG5Q1RG1M13dWInHBW51KzFIsFU4VoDtlEbxhny4pywQTgXwvA
         8BVg==
X-Gm-Message-State: APjAAAWxQwcI817CfF+P3IKs4nKqvJPrFMpxPQxrKzBMWd4EO1ABYynl
        +wj9Zmh2dvgEZw2LK7tFOVf7XpXl
X-Google-Smtp-Source: APXvYqwKuM/JCZjbCC5QWOg82IPxIi96oCJABnrF8tRG1t76AYkoDs+kap8Ebyj7mSsvJ2erG9/tpA==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr146972wmj.126.1571948075189;
        Thu, 24 Oct 2019 13:14:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u21sm4788536wmu.27.2019.10.24.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:14:34 -0700 (PDT)
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
Subject: [PATCH v3 4/5] dt-bindings: Document brcm,int-fwd-mask property for bcm7038-l1-intc
Date:   Thu, 24 Oct 2019 13:14:14 -0700
Message-Id: <20191024201415.23454-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024201415.23454-1-f.fainelli@gmail.com>
References: <20191024201415.23454-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indicate that the brcm,int-fwd-mask property is optional and can be set
on platforms which require to leave specific interrupts unmanaged by
Linux and need to retain the firmware configuration.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
index 4eb043270f5b..5ddef1dc0c1a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
@@ -36,6 +36,12 @@ Optional properties:
 - brcm,irq-can-wake: If present, this means the L1 controller can be used as a
   wakeup source for system suspend/resume.
 
+Optional properties:
+
+- brcm,int-fwd-mask: if present, a bit mask to indicate which interrupts
+  have already been configured by the firmware and should be left unmanaged.
+  This should have one 32-bit word per status/set/clear/mask group.
+
 If multiple reg ranges and interrupt-parent entries are present on an SMP
 system, the driver will allow IRQ SMP affinity to be set up through the
 /proc/irq/ interface.  In the simplest possible configuration, only one
-- 
2.17.1

