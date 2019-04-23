Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91610C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBF320843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EHgRrK7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfDWIvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:51:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38961 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfDWIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:51:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so17717550wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxcOBoVoCEyqdET5OW32wKLb2a2q/DXbMFqOTJqKm+g=;
        b=EHgRrK7f6Fkpzc7BY/skKQOuSMaCMXYDMM48lBKgDAEpc6OTz1+plpoQrMYKHvilm6
         95ZqHWyUrsEhvhErNJ5Qo2Gt2ZIaK/UhD6T4TibH8JiXA90bg+VDub++TmjvxwR+77Qf
         9oLJabIjIfUvGxLzG2EqglWiSQrRFKvnHJdVR1WEiBG8lyxp25lmxha4hZ1MXiuEPV0y
         fH7fg4pSmivG2gxBpSveAXzGNHp7Qs5JOkHvk1Bn+5Cay0I9lXBSBUJnFjpYItzkCft3
         N2+xJPcRshMP+GhP2H4hjS//ZRZMJKa6FjpI1qDDJlrRtvLPsoRbaLlRq4Ewyvhj1q3w
         i0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxcOBoVoCEyqdET5OW32wKLb2a2q/DXbMFqOTJqKm+g=;
        b=a+6j8ytHkU8xMNBRrVcqYPhdYp/rORu1R9ohmNGTn6tgndzOKqG8zs1dR5PRJj3JzD
         95doh9W+TNrs5yRNS6Eg7FkdHTJ+fA1C3OVR0KSbkc5X08/S2QcY0O8kYCr/+pC00qz8
         J9RDjUkZrhQ4JiRDI6ghRJWKMKwEAz8Dl5CrJp+phBzyaUwXyNl/6H596u96Qrtbx88A
         iTFo7nUue94dLZ9ytbxnX7dK5A1grxP3s4A/AwpR26ii5UUjKY+TMe0zfxUOJrEMqcfL
         H8AosAB2sW/S480oRqiGyKlIarqoTZ38C9Sn0qY4cCj/0aNF2vQoZZyaNpASntYFWjCM
         VkWw==
X-Gm-Message-State: APjAAAVBJG7wHBJmdyHKrX4SjKJ4+1Si2Xl3cmSfGhYIHdKzN8TgY/Ej
        7iIdOt9pP345u2kgsQQYwflmQQ==
X-Google-Smtp-Source: APXvYqwWJ5RO1Go7EZGD3n/BLLiBj0PrbDoq+zJVIZWGTdNSJZ71OpNBeAEBv5SMArCfRfZChFIkhA==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr1433791wmk.103.1556009490768;
        Tue, 23 Apr 2019 01:51:30 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b8sm12515566wrr.64.2019.04.23.01.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 01:51:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, chunfeng.yun@mediatek.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] arm64: meson: Add support for USB on Amlogic G12A
Date:   Tue, 23 Apr 2019 10:51:23 +0200
Message-Id: <20190423085127.3863-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
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

Changes since v5 at [4]:
- Dropped already applied PHY patches
- Added patch 3 ack by Minas

Changes since v4 at [3]:
- remove remaining phy_put/clk_put() of patch 8
- handled phy_power_off/on() in suspend/resume
- Collected review tag on patch 8

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

[0] https://lkml.kernel.org/r/20190212151413.24632-1-narmstrong@baylibre.com
[1] https://lkml.kernel.org/r/20190304103846.2060-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20190318101153.7531-1-narmstrong@baylibre.com
[3] https://lkml.kernel.org/r/20190318132655.30040-1-narmstrong@baylibre.com
[4] https://lkml.kernel.org/r/20190325093943.29138-1-narmstrong@baylibre.com

Neil Armstrong (4):
  dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
  dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
  usb: dwc2: Add Amlogic G12A DWC2 Params
  usb: dwc3: Add Amlogic G12A DWC3 glue

 .../devicetree/bindings/usb/amlogic,dwc3.txt  |  88 +++
 .../devicetree/bindings/usb/dwc2.txt          |   1 +
 drivers/usb/dwc2/params.c                     |  12 +
 drivers/usb/dwc3/Kconfig                      |  10 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 604 ++++++++++++++++++
 6 files changed, 716 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c

-- 
2.21.0

