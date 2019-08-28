Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ACC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90521883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="In1ofVVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1IzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:55:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33848 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfH1IzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:55:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so1109335pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZLhox3MGYU3vCPS8rU4RE1IvC0ssD0tDNzjTJYofQ/w=;
        b=In1ofVVkExdB/56av3bUTO7avmdkFk/Pqr0JvQXtiAgUAfC2H8Rx0juj7UBNDrFfF7
         mkpDwsuMPI+mgcWm4y66DB3z3GDqQXCk/goKJbknEzXrWSQnyL9lwR3wHQ79x7Q51a27
         GXz2PmbWzsZvywqAGjIKFzooojw8P1cChYuMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZLhox3MGYU3vCPS8rU4RE1IvC0ssD0tDNzjTJYofQ/w=;
        b=hl4I6ZVQxp1+eQZOgXm6XSGSu2M5tBGgnHXH6BxPWcdbbMsE2QJ8zqH9uQ1UYzcfj+
         D1A2V1s2L/4gQu4U2fz0Hy1ozsT+ugHeJHv/eEb8qXQf+9WfbbaswD/YfF+RKVptalAp
         twk4CGib2RpqTnSlqAF16HLMDqEjDoLSbt33gEyQe6ncsE/bTbPaxha/r9FjTOaO42Xn
         Ww3XSXFHzYXNxnWLOSJyRMIedIRBYksN4eLlS7flnJafHQs9MC7UX9zsxWV26v7zaPIb
         zgZ6v5ZE+W0UjQTXfm8vlja9M1tFJBtL/VuiErWtBoui4WzlVQV4stxDJbs35UyuQ7H6
         jwUQ==
X-Gm-Message-State: APjAAAUJdmcwsgq0tmtH4kmfvp4B6olX+mvyMkyxa6LJxSk0LEXGinDW
        04bHg/Z6UV7ZelvQ/hv0gjmK/Q==
X-Google-Smtp-Source: APXvYqytDZtQ/1TFhyJ4wMqNxJBsNjny0aOoAimJi3RhZ1BROAWcLL8bfzDNHGtwKRyViN7YtxaPaw==
X-Received: by 2002:a17:90a:fe0e:: with SMTP id ck14mr3113158pjb.78.1566982502193;
        Wed, 28 Aug 2019 01:55:02 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z189sm2431386pfb.137.2019.08.28.01.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 01:55:01 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 0/6] PAXB INTx support with proper model
Date:   Wed, 28 Aug 2019 14:24:42 +0530
Message-Id: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PCIe legacy interrupt (INTx) support to the iProc
PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
INTB, INTC, INTD share the same interrupt line connected to the GIC
in the system. This is now modeled by using its own IRQ domain.

Also update all relevant devicetree files to adapt to the new model.

This patch set is based on Linux-5.2-rc4.

Changes from v1:
  - Addressed Rob, Lorenzo, Arnd's comments
    - Used child node for interrupt controller.
  - Addressed Andy Shevchenko's comments
    - Replaced while loop with do-while.

Ray Jui (6):
  dt-bindings: pci: Update iProc PCI binding for INTx support
  PCI: iproc: Add INTx support with better modeling
  arm: dts: Change PCIe INTx mapping for Cygnus
  arm: dts: Change PCIe INTx mapping for NSP
  arm: dts: Change PCIe INTx mapping for HR2
  arm64: dts: Change PCIe INTx mapping for NS2

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  48 ++++++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  30 ++++++-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |  30 ++++++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  45 ++++++++--
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  28 +++++-
 drivers/pci/controller/pcie-iproc.c                | 100 ++++++++++++++++++++-
 drivers/pci/controller/pcie-iproc.h                |   6 ++
 7 files changed, 260 insertions(+), 27 deletions(-)

-- 
2.7.4

