Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4AAC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618262085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3aWBB0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgACSTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgACSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so23861636pfs.6;
        Fri, 03 Jan 2020 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/bkVpKLcARihH63b9lhuj6u+KHSXhqLrTec8GSi2HiQ=;
        b=U3aWBB0eAPUe5/1UmDixtix7tccIYAwaS17+7kxEE/IPIq1dTHL4znhs+SfRfybZ+3
         GV3s0wALIainuvKZqN6MlT0jug76jR1lo/R4e++MEmgSTJ7qhU3VcsDC3rsB7myoGjjb
         kWiBDQxKsYtAQGHqscCgLdcTdbGv1GSrAELRwmzyj47s9WdqcL6qOZrEcweQL/k9SCiV
         7Lrj/y/qIqJa4XIUx+7JpEnUOXK4Hx+Pwc0qbsktlPvrETHhpFmyROOE+6juFjchrJ98
         07kWC6B/RR0Eu4BCizRJ+ET24shStGA4Jj2yMSJ0y5nL1jUyeaI5e5FJ21AVm0+wI1h6
         ZRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/bkVpKLcARihH63b9lhuj6u+KHSXhqLrTec8GSi2HiQ=;
        b=KobQPiM0EIWfpVQaaunf99tfjTiGHYXASieCxgqEXX00+qWBZKHEsaS64/ADpTtiSs
         yi8ok/jcirkwsEJF8u8X2Uj+XrvH55Ly6N3sB7iLja8EoOqmcszpmfVp0QCmrtCUc2Bs
         LXzTbiUjlDIie1NQtsPK0wKtmm+NtLEki9vsya5Kwv3MGeS3PSo4vWML48sCgsmbVcTi
         RCgkTlMVB+zZd34RHw3Ca4Jg/oeKrSfkK/yBj5uQ2h1MfKcUDvq9KYmbTHvnrwhmh/R6
         FvnuoX8XanfUw1+eUdzddTONJ1UWdFWiQytv3cxGXHBr38xg8zpm+43fsh5NNWUg5Xci
         6oWw==
X-Gm-Message-State: APjAAAUL285XhJTUuUxiUldv+70jQU4NdBzxAMbbS+NW/xgTVVJJSbtB
        cXuhRF6B/4CQeK0EvpdB8SP/1/HQ2sE=
X-Google-Smtp-Source: APXvYqwAf9b3wmXwzbSi1jvr+9Q5jQiDl+xXarqGzrWNzpwlxn5PP+a7oVWcFRe1BR53uq/8uLsjJw==
X-Received: by 2002:aa7:9829:: with SMTP id q9mr88211919pfl.231.1578075562347;
        Fri, 03 Jan 2020 10:19:22 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:21 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Srinath Mannam <srinath.mannam@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v4 00/13] phy: usb: Updates to Broadcom STB USB PHY driver
Date:   Fri,  3 Jan 2020 13:17:58 -0500
Message-Id: <20200103181811.22939-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains various updates to the Broadcom STB USB Driver.
The updates include:
- Add support for 7216 and 7211 Broadcom SoCs which use the new
  Synopsys USB Controller.
- Add support for USB Wake
- Add various bug fixes.


v4 - Fix mispelling, change Synopsis to Synopsys. Also add
     "Reviewed-by: Rob Herring" to bindings patch. There are no
     functional code changes in v4.

v3 - Rebase to v5.5-rc1

v2 - Changes based on review feedback
   - Add vendor prefix to DT property "syscon-piarbctl"
   - Use standard "wakeup" instead of "wake" for DT "interrupt-names"

Al Cooper (13):
  phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
  phy: usb: Get all drivers that use USB clks using correct
    enable/disable
  phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
  phy: usb: Add "wake on" functionality
  phy: usb: Restructure in preparation for adding 7216 USB support
  dt-bindings: Add Broadcom STB USB PHY binding document
  phy: usb: Add support for new Synopsys USB controller on the 7216
  phy: usb: Add support for new Synopsys USB controller on the 7211b0
  phy: usb: fix driver to defer on clk_get defer
  phy: usb: PHY's MDIO registers not accessible without device installed
  phy: usb: bdc: Fix occasional failure with BDC on 7211
  phy: usb: USB driver is crashing during S3 resume on 7216
  phy: usb: Add support for wake and USB low power mode for 7211 S2/S5

 .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  69 ++-
 drivers/phy/broadcom/Makefile                 |   2 +-
 .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 414 ++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.c      | 226 +++++-----
 drivers/phy/broadcom/phy-brcm-usb-init.h      | 148 ++++++-
 drivers/phy/broadcom/phy-brcm-usb.c           | 269 ++++++++++--
 6 files changed, 943 insertions(+), 185 deletions(-)
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c

-- 
2.17.1

