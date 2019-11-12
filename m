Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FAAC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE99720818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yzipd2q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKLOuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:50:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43580 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLOuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:50:50 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEokmx052146;
        Tue, 12 Nov 2019 08:50:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573570246;
        bh=y7yAvlEcZ9kCszpDn4fA00UstE2MHBmCEn1h47AUC1w=;
        h=From:To:CC:Subject:Date;
        b=Yzipd2q3QXpCsJf0kNMwsJ1+7FjV40Poj+BJtutrQ/JQmKGD9jpwARO6BHIsHq4LD
         xwvTZDtzTruxf/J8G5Q+rjlW0mL1hGNzIte24qBbO4XK3e5CpnEC4ZelCs39orPkBe
         JrfSM4J0yAXPLxq89wfEMzkbrBuimHMNPMn70OzE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACEokB3058673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:50:46 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:50:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:50:29 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEokek068428;
        Tue, 12 Nov 2019 08:50:46 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
Subject: [RESEND Patch v3 00/20] media: ti-vpe: cal: maintenance
Date:   Tue, 12 Nov 2019 08:53:27 -0600
Message-ID: <20191112145347.23519-1-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I had missed Rob and linux-media mailing list on the original
post, so resending.


This a collection of backlog patches I have been carrying for the CAL
driver.

- Add support for SoC variants.

- Switches to syscon/regmap to access a system controller register for
the DPHY configuration. This register has different bit layout depending
on the SoC version.

- It adds supports for pre ES2.0 silicon errata.

- Reworked the DPHY initialization sequence to match the technical
reference manual and provide a more robust restartability.

- Adds the missing ability to power subdevice.

- Update the devicetree binding and then converts it to dt-schema 

Changes since v2:
- Added a patch which converts all BIT_MASK() into BIT().
- Constify stuct cal_data.
- Remove blank line.
- Fix to use BIT() instead of BIT_MASK() in "add CSI2 PHY LDO errata
  support" patch
- Fix commit description related to v4l2 power management:
- Add missing binding update from v2
- Merge dt-binding and maintainer patch

Changes since v1:
- Removed unneeded "items/max/min".
- Add a ref for ti,camerrx-control type
- Move compatible description as comment in the schemas
- Simplify 'endpoint' syntax
- Removed clocks description
- Added ti,cal.yaml to MAINTAINERS as a separate patch.
- Added Rob's ack
- Remove 'inline' from cal_runtime_get()
- Switch to use of_device_get_match_data
- Reworked the syscon_regmap_lookup_by_phandle() section
- Updated the binding to use ti,camerrx-control instead of sycon_camerrx
- Updated the binding to use ti,camerrx-control instead of sycon_camerrx

Benoit Parrot (19):
  dt-bindings: media: cal: update binding to use syscon
  dt-bindings: media: cal: update binding example
  media: ti-vpe: cal: switch BIT_MASK to BIT
  media: ti-vpe: cal: Add per platform data support
  media: ti-vpe: cal: Enable DMABUF export
  dt-bindings: media: cal: update binding to add PHY LDO errata support
  media: ti-vpe: cal: add CSI2 PHY LDO errata support
  media: ti-vpe: cal: Fix ths_term/ths_settle parameters
  media: ti-vpe: cal: Fix pixel processing parameters
  media: ti-vpe: cal: Align DPHY init sequence with docs
  dt-bindings: media: cal: update binding to add DRA76x support
  media: ti-vpe: cal: Add DRA76x support
  dt-bindings: media: cal: update binding to add AM654 support
  media: ti-vpe: cal: Add AM654 support
  media: ti-vpe: cal: Add subdev s_power hooks
  media: ti-vpe: cal: Properly calculate max resolution boundary
  media: ti-vpe: cal: Fix a WARN issued when start streaming fails
  media: ti-vpe: cal: fix enum_mbus_code/frame_size subdev arguments
  dt-bindings: media: cal: convert binding to yaml

Nikhil Devshatwar (1):
  media: ti-vpe: cal: Restrict DMA to avoid memory corruption

 .../devicetree/bindings/media/ti,cal.yaml     | 202 +++++
 .../devicetree/bindings/media/ti-cal.txt      |  72 --
 MAINTAINERS                                   |   1 +
 drivers/media/platform/Kconfig                |   2 +-
 drivers/media/platform/ti-vpe/cal.c           | 773 ++++++++++++++----
 drivers/media/platform/ti-vpe/cal_regs.h      | 221 ++---
 6 files changed, 937 insertions(+), 334 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,cal.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/ti-cal.txt

-- 
2.17.1

