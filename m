Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F77CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D960214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 20:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LP2Z6pw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfKDUjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 15:39:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56008 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 15:38:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA4Kcmj7023287;
        Mon, 4 Nov 2019 14:38:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572899928;
        bh=wOGtAgD+a9YB/ahSqTx17XsHon9bxHEeCeNXPP5UdVE=;
        h=From:To:CC:Subject:Date;
        b=LP2Z6pw26tCxpi2FnvMam22v2vQgRGrmXudStXxrnzWmLZqLw2C4XuqoSCImXq+pc
         AME8Vpd5W2I3edMAX5pIWlj3rGIYTpN41Kr3x+AQC/N4zCOSsIlErJRUom+tLpVKdV
         tpXCvVwYhdeI1Eyf1apI6piKUcj1xFgqkymR8otk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA4KcmHA121271;
        Mon, 4 Nov 2019 14:38:48 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 4 Nov
 2019 14:38:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 4 Nov 2019 14:38:33 -0600
Received: from ula0869644.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA4Kcl4l020670;
        Mon, 4 Nov 2019 14:38:47 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v2 0/5] ARM: dts: dra7: add vpe nodes 
Date:   Mon, 4 Nov 2019 14:38:36 -0600
Message-ID: <20191104203841.3628-1-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the needed clkctrl and ty-sysc nodes for VPE module.
We also document the VPE DT bindings.

Changes since v1:
- Added a patch to update the compatible in the driver
- Removed unnededed #cell #size properties
- Updated the compatible in dtsi to match binding
- Split off the clk code into its own patch
- Added device specific prefix
- Converted binding to dt schema

Benoit Parrot (5):
  dt-bindings: media: ti-vpe: Document VPE driver
  clk: ti: dra7: add vpe clkctrl data
  ARM: dts: dra7: add vpe clkctrl node
  ARM: dts: dra7: Add ti-sysc node for VPE
  media: ti-vpe: vpe: fix compatible to match bindings

 .../devicetree/bindings/media/ti,vpe.yaml     | 64 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/dra7-l4.dtsi                | 28 +++++++-
 arch/arm/boot/dts/dra7xx-clocks.dtsi          | 18 +++++-
 drivers/clk/ti/clk-7xx.c                      |  6 ++
 drivers/media/platform/ti-vpe/vpe.c           |  2 +-
 include/dt-bindings/clock/dra7.h              | 10 +++
 7 files changed, 123 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/ti,vpe.yaml

-- 
2.17.1

