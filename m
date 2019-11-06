Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F204C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E517D217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W1LAcRBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbfKFUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:24:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53120 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbfKFUYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:24:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA6KNswV047032;
        Wed, 6 Nov 2019 14:23:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573071834;
        bh=h17DwjMjACihpzGQQpzvviAQl9+USvbZ27dLSxqFdPs=;
        h=From:To:CC:Subject:Date;
        b=W1LAcRBrtCFpAhaaLQgLT4su0gm1EBaij3r6tRYP9yVxogPlimA23AVNA7h7I5YoX
         YBq6VWF58nlFf4+CHgpGlACRk1ys+UtYyPPGq6wAZjgO72ALHbm/ROcvFn1KpKG79N
         gVCAdnGFqpAUBzsn1OtIqlkpRCgKeDFYiDBgbuJM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA6KNsTR015435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 14:23:54 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 14:23:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 14:23:39 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA6KNsir119124;
        Wed, 6 Nov 2019 14:23:54 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 0/5] ARM: dts: dra7: add vpe nodes 
Date:   Wed, 6 Nov 2019 14:26:17 -0600
Message-ID: <20191106202622.2648-1-bparrot@ti.com>
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

Changes since v2:
- Fix binding spdx license
- Added Rob's ack 

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

