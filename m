Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77604C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CE62077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDFNbiRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLJUBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:01:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43332 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLJUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:01:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so21492705wre.10;
        Tue, 10 Dec 2019 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Po2VpYcFa8arMmQElIzg8ts/l2BOi8KtBQ9ifjUcxhc=;
        b=GDFNbiRDmc/Dx0anO4WL3fjzLKs4732xpj4XHB1kaCfw7QsLKpI10VoQDGfsh8nYqQ
         wVjdpXxOYoAzgmBUZ7qUpXK9DgZUl3bLqEL+pAXpJGN7YT1im/AoyqxEtD3ZSVFVKVnK
         ilvtCk704/3OakKf0M6cB8BX/qe17kuJ4WrGZtOH2gZF3thtRkp9hj6r2Gx4VSGAOvB5
         mCy2ry3zZYZG4JyRoOawymXy1CHXIGnzK/DwTK2bFVZsjwFOIlLxJdUbfj4UbXvfan8k
         pRuWw0NpEcV/lbv2SAfQXORb2keGKJHFF/drxsM9kcquS5ZeV4kFhJ1FpMF+BlvD5pxK
         JDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Po2VpYcFa8arMmQElIzg8ts/l2BOi8KtBQ9ifjUcxhc=;
        b=S9DGKAhk9p1zOIMgQwvC9QI5MbjsEzO9XzdHIR7urtLcZEsAk9q5Ok/L34dtX8TbQ5
         qRLiXIlP3sXdMAAs6Yi+MsQTpFMV6G3gzCw/RDQQvGlu6YL8lbEon40uLASjshiipmBF
         ORdpanvPjTXFWPWRe0vFPk9ILKlldf5sLaC7WOLnNAZbx4cODLVKCYOkrWZjHAOWPNKT
         lHUxL4yYrnkw1n1pC4Y7nay/ADvot47ERRQk3MnbdoBtdrsk/QWhZX5Bhx7mXylCePJf
         8nOL+KsmY1V0yrb33Nl/ja5vxrV0CRuRiQFem6vM+7QY659KGXO2Ee7VT5zVXP1w13j5
         9LUQ==
X-Gm-Message-State: APjAAAVwKoWDHCw4I8Hy5mBI/V/K6YHVvL9TZKTAV9bv4gReytUGxZDN
        2o55cxVzgwLMIkRrCthXhwW100xF
X-Google-Smtp-Source: APXvYqzHTERxcshg/vkN601hSQ1Og9RLmRmiJZXYHOg0oIRC+4FLYahrnRQMGu9ST/L2H0XnpS9jwg==
X-Received: by 2002:adf:e812:: with SMTP id o18mr5050154wrm.127.1576008096684;
        Tue, 10 Dec 2019 12:01:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z6sm4352255wmz.12.2019.12.10.12.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:01:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 0/2] reset: Add Broadcom STB RESCAL reset controller
Date:   Tue, 10 Dec 2019 11:59:01 -0800
Message-Id: <20191210195903.24127-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

This patch series adds support for the BCM7216 RESCAL reset controller
which is necessary to initialize SATA and PCIe0/1 on that chip.

Please let us know if you have any comments. Thanks!

Jim Quinlan (2):
  dt-bindings: reset: Document BCM7216 RESCAL reset controller
  reset: Add Broadcom STB RESCAL reset controller

 .../reset/brcm,bcm7216-pcie-sata-rescal.txt   |  26 ++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-brcmstb-rescal.c          | 124 ++++++++++++++++++
 4 files changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.txt
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c

-- 
2.17.1

