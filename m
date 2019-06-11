Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93DC4321B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3941320665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391605AbfFKOFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:42 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55715 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389869AbfFKOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:01 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOQ-0003vU-Hc; Tue, 11 Jun 2019 15:04:54 +0100
From:   Michael Drake <michael.drake@codethink.co.uk>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Drake <michael.drake@codethink.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: [PATCH v1 00/11] Add ti948 and ti949 display bridge drivers
Date:   Tue, 11 Jun 2019 15:04:01 +0100
Message-Id: <20190611140412.32151-1-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the ti948 and ti949 display
bridge devices.  They are both regmap i2c device drivers.

The ti949 converts HDMI video signals to FPD-Link III.
The ti948 converts FPD-Link III video signals to OpenLDI.

The drivers support PM suspend/resume, and rely on device tree /
ACPI nodes to set up any device dependency chain.  (ACPI requiring
the special DT namespace link device ID, PRP0001.)  The unified
device properties API is used to get board-specific config from
device tree / ACPI.

Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>

Michael Drake (11):
  dt-bindings: display/bridge: Add bindings for ti948
  ti948: i2c device driver for TI DS90UB948-Q1
  dt-bindings: display/bridge: Add config property for ti948
  ti948: Add support for configuration via device properties
  ti948: Add alive check function using schedule_delayed_work()
  ti948: Reconfigure in the alive check when device returns
  ti948: Add sysfs node for alive attribute
  dt-bindings: display/bridge: Add bindings for ti949
  ti949: i2c device driver for TI DS90UB949-Q1
  dt-bindings: display/bridge: Add config property for ti949
  ti949: Add support for configuration via device properties

 .../bindings/display/bridge/ti,ds90ub948.txt  |  45 ++
 .../bindings/display/bridge/ti,ds90ub949.txt  |  37 +
 drivers/gpu/drm/bridge/Kconfig                |  16 +
 drivers/gpu/drm/bridge/Makefile               |   2 +
 drivers/gpu/drm/bridge/ti948.c                | 689 ++++++++++++++++++
 drivers/gpu/drm/bridge/ti949.c                | 631 ++++++++++++++++
 6 files changed, 1420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub949.txt
 create mode 100644 drivers/gpu/drm/bridge/ti948.c
 create mode 100644 drivers/gpu/drm/bridge/ti949.c

-- 
2.20.1

