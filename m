Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDDECA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3237920684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FisStM4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfJXUO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:14:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46223 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfJXUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:14:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so16670168wrw.13;
        Thu, 24 Oct 2019 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yngxj6Nhm0QtPDM2fcJZwY2LBQt6q8gsqQNI+1Hz2dI=;
        b=FisStM4ycetrLzGaMOrX7uAsM04Fn3wkGOnjVxiIJQWWiMx5rZp5dvu7x4kctl1U8d
         ie5HopsYlzSgEeXyFLtnHgQTvpPf/jll0l8y/jnceLXpj3ZlrPn1bfhOunUs2LIYaO9b
         uBWTIibk1oJKZhPzDJC3OxHLgTPKTzQl1pejgIedtzUrvqoRKHuER0Nrvqff/4HUPnEN
         EyohRc6EZminOLaLAlaDDYNmlzmhIfiOJ9qzKkbNQh/c4oF9kooAV+ARIlqrYTG+jkzs
         n8iDJ7tKQ8nBjAXCPbEw85atol9FV53iayFfPrGQTOjbSf0n89FxzJQwax07tsjvd+tJ
         jJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yngxj6Nhm0QtPDM2fcJZwY2LBQt6q8gsqQNI+1Hz2dI=;
        b=KU0n3sqUA1R6e6WgAKciZ5jcBnyU2G06R94kMrWZrDEBj4Gz6SbJWVtY82CKWhn5eJ
         p+0YBg7ZknD5d2/CiCsacCiA/NvGYj2akilt6KU88ihM8DQFwRKr8Bv9vaGI5/o8uzyC
         fdcIXnVGkj5PZYr2zkv19S0i8OvZl/7N0Tvi6Ah7MyEAf1Uiyptt8Yb1KsWcD8E+lI4Z
         D7C6TYfBMBBWH9l+jgZzLR2zU3wLvsUUpjV8rPimTHMIR+DKM4botc+vpdBzA0Q3ggEn
         irJSQKVzWcmb8BX800IcEY3/pZs4BB79MQ7v2SQCL/Bpsrv+cic2IaFAd2yiekbzPtcp
         ExFQ==
X-Gm-Message-State: APjAAAW+zT9HZgG0X09PfayGUpzZ+5ZI6zqjAF9O1B+WNcmtGHhQ7FsC
        3J9CBMgAU8VWjt0NR4rYnQdDHvxO
X-Google-Smtp-Source: APXvYqyNsu7h5PqWiL8z6FS/qqVVgN60qgeYjMDK0wuaW92hmxafLodk36LwL2TzLwyZFV+66o0pDg==
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr5405676wrx.30.1571948063666;
        Thu, 24 Oct 2019 13:14:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u21sm4788536wmu.27.2019.10.24.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:14:23 -0700 (PDT)
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
Subject: [PATCH v3 0/5] irqchip/irq-bcm7038-l1 updates
Date:   Thu, 24 Oct 2019 13:14:10 -0700
Message-Id: <20191024201415.23454-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Jason, Thomas,

This patch series contains some updates from our internal tree to
support power management and allow configuring specific instances of the
brcm,bcm7038-l1-intc to leave some interrupts untouched and how the
firmware might have configured them.

Changes in v3:

- added Rob's Acked-by to dt-bindings patches
- avoid registering syscore_ops() unconditionally, do this the first we
  register a controller instance
- added locking around the list handling of the controller
- ensure that irq_fwd_mask gets writtent properly to the hardware during
  initial configuration and suspend/resume
- simplified logic around use of irq_fwd_mask
- added check to refuse mapping of interrupts assigned to firmware

Changes in v2:

- dropped the accidental fixup patch that made it to the list and squash
  it with patch #1 as it should have

Florian Fainelli (4):
  dt-bindings: Document brcm,irq-can-wake for brcm,bcm7038-l1-intc.txt
  irqchip/irq-bcm7038-l1: Enable parent IRQ if necessary
  dt-bindings: Document brcm,int-fwd-mask property for bcm7038-l1-intc
  irqchip/irq-bcm7038-l1: Support brcm,int-fwd-mask

Justin Chen (1):
  irqchip/irq-bcm7038-l1: Add PM support

 .../brcm,bcm7038-l1-intc.txt                  |  11 ++
 drivers/irqchip/irq-bcm7038-l1.c              | 119 +++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

-- 
2.17.1

