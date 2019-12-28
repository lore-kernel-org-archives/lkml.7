Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A740C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219A22173E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7T3UBya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfL1UgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:36:02 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:46823 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL1UgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:02 -0500
Received: by mail-lf1-f51.google.com with SMTP id f15so22875962lfl.13;
        Sat, 28 Dec 2019 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeV7E+EYDWs4lq2iVlZPCzJ38DjzSSsol4SHG8SoacQ=;
        b=S7T3UByacx1Dqe422Ikbb4QTM1TwT8AHJyM4GLVuOXjS87dRXLO0AxDCgXJ+ILNS25
         pJmk8DSKmjmmCZ3tBJ0K79jK/6UtZR+YTaWcApFFVOx0ea4YfeiN2JSWVoyIljdrVYXC
         aeDdwzIbCWOdR5SwhpzOX0zQDXbvfAQDMIxbetAbLSdzyRYJKJXpYTAOhs0J6yCNwpKC
         03E9ewUn0iHQGUedQd+7zrKyPwnUiO+WzEBFK2h3pz/NphwbAD700KtoRBCXYkoW3EIk
         E/7GEq0Gg/YFvCSvv1hg38OGlgH4RXbz+yDLODsDHhGdrEEBF5/T6oD5UYy6jPU82ao1
         3OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeV7E+EYDWs4lq2iVlZPCzJ38DjzSSsol4SHG8SoacQ=;
        b=r6MBJcPADtimpT7ortzL7gDy54p0n600E+I5UMnyZqFLBaNcbfQBeGFzxrobmiYjAX
         edcwu4tb05Xa1V0MEBMD+iTb32QPy/FDH4XXC6CuOuQpWDsJ4457buopEnOstedcAP5v
         /TMfrEHtq71TqkIZsnGJKQ6qWq5lgtI08wDe2iS//x5/MDJ9zdOVaotyPtTUQpIRarSt
         bkPnk1o2uLZgshsZ+DcvL0Kqxbu8Bps0xOmq3lunZT4tWSFrIC7wcFfZxpaTbI7j2H4z
         EpgfvmYCb/jMPQfAyORqWSOSsrttSKbwCbGRWsEjA8tSPDCZ2o2BVO/fR17ceyaiE5RW
         YY2g==
X-Gm-Message-State: APjAAAWjhHnziUnEGAx9Y5Ue/gI1BW62XGc2eFF7a+xQM2yiJKrEPfOb
        hUNyuMSthl8p/w5wtxfk2cLdQJ6x
X-Google-Smtp-Source: APXvYqyHBn5GX9uV3b14BH2E9cbCG+5m3RTlsPwzBzvfSrkEbdRkwN+/HE1dIC6nFaSZ4dKmpodNRQ==
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr32408017lfm.29.1577565359228;
        Sat, 28 Dec 2019 12:35:59 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:35:58 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/16] NVIDIA Tegra USB2 drivers clean up
Date:   Sat, 28 Dec 2019 23:33:42 +0300
Message-Id: <20191228203358.23490-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series brings the NVIDIA Tegra USB2 PHY driver into a better
shape by refactoring code to match upstream standards, the ChipIdea/Tegra UDC
driver also gets a minor update. Please review and apply, thanks in advance!

Changelog:

v3: - The "Perform general clean up of the code" patch now cleans up couple
      more minor crumbs.

    - Added more "clean up" patches:

        usb: phy: tegra: Disable VBUS regulator on tegra_usb_phy_init failure
        usb: phy: tegra: Move utmip_pad_count checking under lock
        usb: phy: tegra: Keep CPU interrupts enabled
        usb: host: ehci-tegra: Remove unused fields from tegra_ehci_hcd

    - I noticed that ULPI's reset is getting erroneously deasserted on
      PHY's shutdown, this is fixed in these new patches:

        usb: phy: tegra: Assert reset on ULPI close instead of deasserting it
        usb: phy: tegra: Use device-tree notion of reset-GPIO's active-state

v2: - The "usb: phy: tegra: Hook up init/shutdown callbacks" patch was
      updated and now it does a better job in regards to checking whether
      PHY is initialized before it is started to be used and whether there
      is a double init/shutdown. This allows to factor out the ChipIdea's
      driver change into a separate patch, which was requested by Peter Chen
      in a review comment to v1. In a result there is this new patch:

        usb: chipidea: tegra: Stop managing PHY's power

    - Added few more new patches:

        usb: phy: tegra: Use generic stub for a missing VBUS regulator

      I noticed that VBUS regulator usage could be cleaned up a tad as well.

        usb: ulpi: Add resource-managed variant of otg_ulpi_create()
        usb: phy: tegra: Use devm_otg_ulpi_create()
        usb: phy: tegra: Use u32 for hardware register variables

      These patches are made in response to review comments that were made
      by Thierry Reding to v1.

      I also noticed that phy_tegra_usb isn't getting auto-loaded while it
      should be. This is fixed in this new patch:

        usb: chipidea: tegra: Add USB_TEGRA_PHY to driver's dependencies

Dmitry Osipenko (16):
  dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
  usb: phy: tegra: Hook up init/shutdown callbacks
  usb: phy: tegra: Perform general clean up of the code
  usb: phy: tegra: Use relaxed versions of readl/writel
  usb: phy: tegra: Use generic stub for a missing VBUS regulator
  usb: ulpi: Add resource-managed variant of otg_ulpi_create()
  usb: phy: tegra: Use devm_otg_ulpi_create()
  usb: phy: tegra: Use u32 for hardware register variables
  usb: phy: tegra: Assert reset on ULPI close instead of deasserting it
  usb: phy: tegra: Use device-tree notion of reset-GPIO's active-state
  usb: phy: tegra: Disable VBUS regulator on tegra_usb_phy_init failure
  usb: phy: tegra: Move utmip_pad_count checking under lock
  usb: phy: tegra: Keep CPU interrupts enabled
  usb: chipidea: tegra: Stop managing PHY's power
  usb: chipidea: tegra: Add USB_TEGRA_PHY to driver's dependencies
  usb: host: ehci-tegra: Remove unused fields from tegra_ehci_hcd

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  |   4 +
 drivers/usb/chipidea/Kconfig                  |   1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c          |  15 +-
 drivers/usb/host/ehci-tegra.c                 |   2 -
 drivers/usb/phy/phy-tegra-usb.c               | 830 +++++++++---------
 drivers/usb/phy/phy-ulpi.c                    |  48 +-
 include/linux/usb/tegra_usb_phy.h             |   3 +-
 include/linux/usb/ulpi.h                      |  11 +
 8 files changed, 496 insertions(+), 418 deletions(-)

-- 
2.24.0

