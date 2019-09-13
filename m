Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DA7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0087820830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUbJwqY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404231AbfIMXWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:22:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37384 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbfIMXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so8286235pgg.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oVtuzVl6ZjuJjeRxwc0/jxd04my4e+lydovEVmuMVYs=;
        b=WUbJwqY8cbcP+cSD0l4Soj1jenXI6cy/cJhJtu3xaoaUJoYAcp6CpwCObYSjdlhRIY
         UtxzC70l4RVHQjfM2fqb2EwlVHvOcKc010Fcuqb8fPPOCLFXnXcMauoAXpGx5azy+th6
         O1+mw3GZ9RU+vON9vnmqexqg+7NNHVgUsTrm4ZVTP49ofQEtGeGteUlWH1kxl3A+YmNM
         4ziVD64J2VnVejWoN7gl7eJ0j63WLRbpm7FWHXSH68mAzQVWApkFqvub9gHhMeSQ/bFH
         CGzklGp9HSrfPBjL0eJdC0ITbh37GIROyJpV/jvJSIo595b8cjrcB/W1hV1fk9i3Ifww
         FYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oVtuzVl6ZjuJjeRxwc0/jxd04my4e+lydovEVmuMVYs=;
        b=MHXXx2tVAZqfhBqE+YtARqObhJpCm1XkQ/oFKZFL5dUqY2dI9sxYG4vzqkZke819zh
         alGFaJ3nA2fdit+8WmWqs99zOPxmcDar2mvupWRqpzxUzlD11cKSlX2pDtOqaS71CrWm
         fc4F9QZA6UeWNvMPmfkgrM5BJGv3upPPJUxKZJFstH3BtXFI3NQ9exDe79uIjk2zdNhu
         Yt/G88Ab57lexE/wUH+fJP5sqlJfcWTMXY6pzJALe0EIMDfvW2BqgL7z9LeBqGDz8bOj
         mboWaxaaMkDgXsfj/eNLiFPpEIM3kFPU6By7dsKTjPxL4qbm+MEYvk3+Pe5zr6VB7jxk
         AZUg==
X-Gm-Message-State: APjAAAWQ2N0E6ym6INNb3XYl7Gv6OUqD6plfCXthjVTGXrOywujKu5as
        3euCzT7t5WPfIHFd4N48Y4IAjDftoSk=
X-Google-Smtp-Source: APXvYqyFlSVqZBzCC+pbzXJRzE4CDAAi6ewl3rB7PYrswTJGtv5Kl3zAb8rNMNhxMUmrw0yMpJlFwA==
X-Received: by 2002:a62:cf82:: with SMTP id b124mr58103428pfg.159.1568416964810;
        Fri, 13 Sep 2019 16:22:44 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/7] irqchip/irq-bcm283x update for BCM7211
Date:   Fri, 13 Sep 2019 16:22:29 -0700
Message-Id: <20190913232236.10200-1-f.fainelli@gmail.com>
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

