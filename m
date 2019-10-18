Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5ECCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C0821852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fGkAhBIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410594AbfJRPcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:32:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40648 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410487AbfJRPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:32:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9IFW2H1002558;
        Fri, 18 Oct 2019 10:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571412722;
        bh=/YKNqD/6ZGTEd6vo7678PvL+PAspt5iQ6uoWMMZXLTI=;
        h=From:To:CC:Subject:Date;
        b=fGkAhBIEXOSEtrhMaII1nKgPsMipkBxkNpgwDk2MkYXcemLFIqT1yVYzq59W7audu
         xUItnBiV5HoV/mF13iIEgnUWRjFhJdmOn8U8UobKzar7FZwVCo6wIQd1/ozQ9n1RvG
         uq6E9YBO7tr8eu7T+tMlQGxJnLr4DzAznnvNPWMk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9IFW15D084478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Oct 2019 10:32:02 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 18
 Oct 2019 10:31:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 18 Oct 2019 10:31:53 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9IFW15E080266;
        Fri, 18 Oct 2019 10:32:01 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch 00/19] media: ti-vpe: cal: maintenance
Date:   Fri, 18 Oct 2019 10:34:18 -0500
Message-ID: <20191018153437.20614-1-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Benoit Parrot (18):
  dt-bindings: media: cal: update binding to use syscon
  dt-bindings: media: cal: update binding example
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

 .../devicetree/bindings/media/ti,cal.yaml     | 186 +++++
 .../devicetree/bindings/media/ti-cal.txt      |  72 --
 drivers/media/platform/Kconfig                |   2 +-
 drivers/media/platform/ti-vpe/cal.c           | 775 ++++++++++++++----
 drivers/media/platform/ti-vpe/cal_regs.h      |  27 +
 5 files changed, 830 insertions(+), 232 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,cal.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/ti-cal.txt

-- 
2.17.1

