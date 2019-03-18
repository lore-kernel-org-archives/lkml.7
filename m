Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85187C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A54217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dMAoexiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfCRN1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:27:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38805 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfCRN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:27:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so17052166wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ru6OOQvD1PRf0eN1OL77FtwXrU5QdpTqPkddolVvl5I=;
        b=dMAoexiWzY5+AUKI9gWSmIBzG9poEt5+C+xpUYhRVkdNxfwPd9M0VPBlYDHSFwxXQZ
         DT8FJyawGB0sfgkE0gOBOu32cJLgvZ+tOI03oFmcqeXhPitpMq12AE3xH8bFzaSn7DTa
         uMYQnkDY4QSLj0pipQwYHtNnPzsgMuNwx6Y9Th1+++yccRKTci4S+GqfhZB80EoCBECp
         aGgBX2cDG6UHe/6W+AuJg9i/7aPMfwmmkWmVXern1nAGEfQQRvnKYLR4JpxqzRQQB6bV
         11jR++RbYb5mVQy0jrWlfYtbcw0Ivh8UPHJMt9XOfJ3rSnpZfYuGi1pBMOfSKo1N8DH6
         ecQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ru6OOQvD1PRf0eN1OL77FtwXrU5QdpTqPkddolVvl5I=;
        b=YqKBCtqt+fvQ7qFVXD+PQ886IaX2ab7iZ0JFVhQcS1NnOcgPi35Oum8WAIwgUfXsMB
         /9aPkHeGwJDbicxDcG9QnFOEtBwiORavXumgnS4u1dFqznh5VI8/plmV0gsFaNX2uSfI
         ZoJMu36OJqE8l7m/rSGprWCPxFIgf22nObnPQzE+DQazb3n/zGnc8ZCKOEYS67hFQvXR
         ruIZTlllI/DifJbrV43+gzK8yFIPmz0zh+noZahWLYvo8DdRcbB46SFxggib9yFnOnS2
         BbLklVWC4bfH+IbjRndwAE+fkGU38azD+ze0+gbjVmSB4XSvdYwtC3cGPM+oA3wIpKIm
         aaHw==
X-Gm-Message-State: APjAAAVy0jS+ONPbsQQYNV4ip4rHkrwrVU2zB0wyDMRg+GVAeJ4ttgCT
        dfhkXp+k17sB4UsGMYPs8OQN9Q==
X-Google-Smtp-Source: APXvYqw7uRmY3RmMVnXLYqJVKmXgwZFr9OBt1ATxvTVUumK2KslekD2kktmNAIDJ0DnVKHMXg97VsQ==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr11495424wrv.137.1552915617734;
        Mon, 18 Mar 2019 06:26:57 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j128sm10421601wmb.43.2019.03.18.06.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 06:26:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] arm64: meson: Add support for USB on Amlogic G12A
Date:   Mon, 18 Mar 2019 14:26:47 +0100
Message-Id: <20190318132655.30040-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB on Amlogic G12A SoCs.

This patchset is composed with :
- bindings of the PHYs
- bindings of the USB Control Glue
- PHY Drivers
- USB Control Glue driver

Device Tree nodes will be added in a separate patchset.

The Amlogic G12A USB Complex is composed of :
- 2 USB Controllers :
 * DWC3 for USB2 and USB3 Host functionality
 * DWC2 for USB2 Peripheral functionality
- 2 USB2 OTG PHYs, only a single one will be routed to either DWC2 to DWC3
- 1 USB3 PHY shared with PCIE funcionnality
- A Glue to control PHY routing, setup and OTG detection

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

This drivers supports the on-probe setup of the OTG mode, and manually
via the USB Role interface. The IRQ mode change detect is yet to be added
in a future patchset, mainly due to lack of hardware to validate on.

Changes since v3 at [2]:
- Documented and replaced magic values in USB2 PHY driver

Changes since v2 at [1]:
- Collected review tags
- Removed syscon.h in usb2 phy driver
- Added comment on the USB3/PCIe switch
- Renamed dwc3_meson_g12a_usb_init_mode in glue driver
- Changed indentation in dwc3_meson_g12a_role_set
- Switched to of_get_compatible_child in glue code
- Added devm_add_action_or_reset() to disable clock in case of probe failure
- Checks priv->vbus before enabling regulator
- Switched phy_init/phy_power_on
- Removed priv->phys[i] NULL checks in suspend code
- Removed clk_disable_unprepare/clk_put in remove code

Changes since v1 at [0]:
 - USB2 PHY Bindings: collected tags and updated commit log
 - USB3/PCIE PHY Bindings: collected tag and updated reset list
 - DWC2 Compatible: collected tags
 - DWC3 Glue Bindings:
   - removed clock-names and reset-names for single entries
   - removed ports graph for PHYs and replaced by phys list with phy-names
   - added dr_mode and optional vbus-supply
   - fixed example
 - USB2 PHY Driver: removed USB_SUPPORT and otg.h include
 - USB3/PCIE PHY Driver: removed USB_SUPPORT, fixed comment and unused reg variable
 - USB Glue Driver:
   - Moved debugfs I/F to USB_ROLE_SWITCH framework
   - Integrated USB Glue Control Registers offset
   - Removed of graph parsing to use devm_phy_optional_get()
   - Fixed PHY mode handling and OTG switching
   - Simplified PHY calls by removing the NULL test
   - Added optional vbus regulator handling

[1] https://lkml.kernel.org/r/20190212151413.24632-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20190304103846.2060-1-narmstrong@baylibre.com
[3] https://lkml.kernel.org/r/20190318101153.7531-1-narmstrong@baylibre.com

Neil Armstrong (8):
  dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
  dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
  dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
  dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
  phy: amlogic: add Amlogic G12A USB2 PHY Driver
  phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver
  usb: dwc2: Add Amlogic G12A DWC2 Params
  usb: dwc3: Add Amlogic G12A DWC3 glue

 .../bindings/phy/meson-g12a-usb2-phy.txt      |  22 +
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt |  22 +
 .../devicetree/bindings/usb/amlogic,dwc3.txt  |  88 +++
 .../devicetree/bindings/usb/dwc2.txt          |   1 +
 drivers/phy/amlogic/Kconfig                   |  22 +
 drivers/phy/amlogic/Makefile                  |   2 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c     | 341 ++++++++++
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 413 ++++++++++++
 drivers/usb/dwc2/params.c                     |  12 +
 drivers/usb/dwc3/Kconfig                      |  10 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 602 ++++++++++++++++++
 12 files changed, 1536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c

-- 
2.20.1

