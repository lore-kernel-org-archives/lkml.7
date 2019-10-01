Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7A6ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420D121D7B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl8xAjeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfJAWs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:48:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40908 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJAWs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:48:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so5275916pgl.7;
        Tue, 01 Oct 2019 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oVtuzVl6ZjuJjeRxwc0/jxd04my4e+lydovEVmuMVYs=;
        b=Bl8xAjeE3EtYICbGBQRBv+POzG3Qaf+rm2W53Xabjh7OTZrjeBiWX7hShF0T5daf9V
         jluZ/4xeOEaHpHU4h8qK5p9pqWhdqxOWw8BnZMb5ATmvaqbk81GqC5QlSnDyeeENuxze
         Hm8hvavGFtH472/aD81H5ZffdglIpMqSU3wU2b8m3c8OW+78UVMr4TWRNDFNbaPGXU8w
         oWLY6Kl99uQf/p900Q/UapnSlyLClmR1pne6HwsTEz9SL9ETCKR3JUSxk8T7fROIGhsI
         NiySa70k6m6sipKMnhBFwW/B25+vldYj4FvBhwuhuLK4ydaZ08ah0lFQQ8SbNwj3Ca4t
         jf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oVtuzVl6ZjuJjeRxwc0/jxd04my4e+lydovEVmuMVYs=;
        b=DNqVYF6zcKy+nOdS4QqZuTGjBl/goU16ID+HNqClOmrAZKwI+qonLbVREi39QFCkVO
         1rxWf8lxCS4wwvcUZNnHqrq/p/nMocSw9si82l2ZEB5cKO7Iu0gog+tNTBwaTpa9DNq4
         BslXfZgzE3S5nUpP/AokIXhQ0aZLpsMW9ukKWVN2twLmxQL76WGGQakrGYghV9Yn5HkK
         qwod3tX2qNkhOCA3nheq0K0yky+17BCqRFy04Zu8NivrKF8nTUbbYLaBiK+kxQ3ONzrD
         HNNaxBANcqSoxVzokFucJ5mncNvXe8c4A7kYAoEDoLcQn/hwLFF3ZxNaamOs2JW/5SRV
         2veQ==
X-Gm-Message-State: APjAAAW8UeKmp/h7wYW+KQWrNxjhnZADtXLtOkj5Q/pEJn3sw+gZCtCR
        G2Zi7nP3suO7xEZYKimfL0IN415q
X-Google-Smtp-Source: APXvYqzli23oNviMyvGn+Gp3uJ37fGRBFmEjnh33GzKxgmnZUVWdib9kqCkXJ2MQo2afcOBWhnK7zw==
X-Received: by 2002:a17:90a:c8a:: with SMTP id v10mr694468pja.4.1569970135129;
        Tue, 01 Oct 2019 15:48:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:48:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH 0/7] irqchip/irq-bcm283x update for BCM7211
Date:   Tue,  1 Oct 2019 15:48:35 -0700
Message-Id: <20191001224842.9382-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Jason, Thomas,

This patch series updates the BCM2835 and BCM2836 interrupt controller
drivers to support BCM7211 which can make use of those drivers in some
configurations where the ARM GIC is muxed out and the legacy ARM
interrupt controller is used instead.

Thank you!

Florian Fainelli (7):
  irqchip: Introduce Kconfig symbol to build irq-bcm283x.c
  dt-bindings: interrupt-controller: Add brcm,bcm7211-armctrl-ic binding
  irqchip/irq-bcm2835: Add support for 7211 interrupt controller
  dt-bindings: interrupt-controller: Add brcm,bcm7211-l1-intc binding
  irqchip/irq-bcm2836: Add support for the 7211 interrupt controller
  irqchip: Build BCM283X_IRQ for ARCH_BRCMSTB
  irqchip/irq-bcm283x: Add registration prints

 .../brcm,bcm2835-armctrl-ic.txt               |  6 +-
 .../brcm,bcm2836-l1-intc.txt                  |  4 +-
 drivers/irqchip/Kconfig                       |  5 +
 drivers/irqchip/Makefile                      |  4 +-
 drivers/irqchip/irq-bcm2835.c                 | 95 ++++++++++++++++---
 drivers/irqchip/irq-bcm2836.c                 | 27 +++++-
 6 files changed, 119 insertions(+), 22 deletions(-)

-- 
2.17.1

