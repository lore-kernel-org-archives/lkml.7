Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462A1C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC2F206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzOOSYax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfLJSzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:55:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41811 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfLJSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so21329432wrw.8;
        Tue, 10 Dec 2019 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gRtOZdgRT/ANVUaDFwM1DFPPZAUHxCMR/8XqEYr9qfk=;
        b=mzOOSYaxLUFfQr5wR6FevwJm4qw5wbakB9bwQ+j9HakAuf4lMSDpq0ief8wTekxS0R
         C9tohH2wZBPnsoFkc9QCHDg0miAOA4Jo2C9AHdXk7PKv2ZcYtYbZ4HJkrGdFcC0oJ9ol
         uxU6wi6Zoz7SU98JhEqNEHopQ9ZZXOD7UvRZNtUWLLuWFEha0/+w0d+VNxDSyg2tmAZO
         KVnHOarv9I/45PpvY/eC1A0phRRYL5eYoa3/VM4nCrlLKU9zfaLPr0uL1mAr6qSsk2vg
         bcipxoOHxIQS2hkKd1UKKkc8Yg8doo5gT6qf8pyy/ACy0JoUX6g1FuAG0P+ocTUDvLTD
         hbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gRtOZdgRT/ANVUaDFwM1DFPPZAUHxCMR/8XqEYr9qfk=;
        b=FWpiDTphWfvX/kojKky1Bi8/TqwmWxcsOYH/HQuPvBS1DHSSSWHJ2x7xlq/oEyFHBO
         2QqhlsyTPrZAlqSiuqsi8hhWcBqsnZsBhFOqwnCrcsVYFmuibLjSkELPD0WuJUEJmHJM
         9RL8NnckfztJaR7qcdflBJLeGAMAyxUpDrSLAA9UW0hZo98RAuDTIeUg0A3LUf5jqiHD
         xpjJW30rmvoOooJgGyS2VBqRk+/eS5kV90pKVmaw5yqcVB2wZHLma1NxQFqpoKJ/l+wi
         V0whXakqKOa+m2T5qbkxDyH1dnseb28hQRmCOBiq3AMRZlARf1vspsIAEoWonq+Y05G7
         /0uQ==
X-Gm-Message-State: APjAAAU9XQ4yNtuum5MTndjKS+RbmPdkn2cEV+jfLwROphPSsnxB37k/
        4jUa5YpQUDSeJNy5pBnJ0arY7XoF
X-Google-Smtp-Source: APXvYqyT+IZZBXlEJY9YdUaBpm1PovK7SsMJmVHMvmSMlo93jKNUo+dnd9ki65HQQpu2LlHM6eCTOw==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr5224945wrv.79.1576004109818;
        Tue, 10 Dec 2019 10:55:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:09 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 0/8] ata: ahci_brcm: Fixes and new device support
Date:   Tue, 10 Dec 2019 10:53:43 -0800
Message-Id: <20191210185351.14825-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

The first 4 patches are fixes and should ideally be queued up/picked up
by stable. The last 4 patches add support for BCM7216 which is one of
our latest devices supported by this driver.

Patch #2 does a few things, but it was pretty badly broken before and it
is hard not to fix all call sites (probe, suspend, resume) in one shot.

Please let me know if you have any comments.

Thanks!

Florian Fainelli (8):
  ata: libahci_platform: Export again ahci_platform_<en/dis>able_phys()
  ata: ahci_brcm: Fix AHCI resources management
  ata: ahci_brcm: BCM7425 AHCI requires AHCI_HFLAG_DELAY_ENGINE
  ata: ahci_brcm: Add missing clock management during recovery
  ata: ahci_brcm: Manage reset line during suspend/resume
  ata: ahci_brcm: Add a shutdown callback
  dt-bindings: ata: Document BCM7216 AHCI controller compatible
  ata: ahci_brcm: Support BCM7216 reset controller name

 .../bindings/ata/brcm,sata-brcm.txt           |   7 +
 drivers/ata/ahci_brcm.c                       | 167 ++++++++++++++----
 drivers/ata/libahci_platform.c                |   6 +-
 include/linux/ahci_platform.h                 |   2 +
 4 files changed, 141 insertions(+), 41 deletions(-)

-- 
2.17.1

