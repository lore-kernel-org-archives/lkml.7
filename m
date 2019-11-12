Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAB1C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573F020578
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sJuIshYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfKLOcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:32:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37710 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKLOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:32:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEVn6X014751;
        Tue, 12 Nov 2019 08:31:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573569109;
        bh=eqDXkdRx3Q6H+gxxdh7mbTefYiQt+16uNQd/29L6a4I=;
        h=From:To:CC:Subject:Date;
        b=sJuIshYzqq2XN/e/aiIRPZF7ZyxYeryYwBVtp9dJtLL4qGOELhSmzajvQ9QASzgl6
         DFy8i6P1AdviQFf7/W8Vz5gXg8zyVheDN3hPnxYbVZMzz9o0RpaO4pffWpO4SoNY2j
         8vGFJKwHLsmnWHaz9144VGrub2Gy6U7xQNag48Wg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACEVnMf127633
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:31:49 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:31:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:31:31 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEVjUJ050451;
        Tue, 12 Nov 2019 08:31:46 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9] arm64: dts: ti: UDMAP and McASP support
Date:   Tue, 12 Nov 2019 16:32:52 +0200
Message-ID: <20191112143301.3168-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series will enable DMA and adds the McASP nodes for am654 and j721e.

The DT bindings for DMA is not expected to change much anymore:
v5 of the UDMAP bindings patch is:
https://lore.kernel.org/lkml/20191111135330.8235-9-peter.ujfalusi@ti.com/

While adding the DMA support I have noticed few issues which is also fixed by
this series.

I have included the McASP nodes as well to have examples for other peripherals
on how he binding should be used.

I have been using this set on top of linux-next (the series is generated on top
of next-20191112) with audio on am654-evm and j721e evm + ivi card.

Regards,
Peter
---
Peter Ujfalusi (9):
  arm64: dts: ti: k3-am65-main: Correct main NAVSS representation
  arm64: dts: ti: k3-am65-main: Move secure proxy under cbass_main_navss
  arm64: dts: ti: k3-am65: DMA support
  arm64: dts: ti: k3-am654-main: Add McASP nodes
  arm64: dts: ti: k3-j721e: Correct the address for MAIN NAVSS
  arm64: dts: ti: k3-j721e-main: Correct main NAVSS representation
  arm64: dts: ti: k3-j721e-main: Move secure proxy and smmu under
    main_navss
  arm64: dts: ti: k3-j721e: DMA support
  arm64: dts: ti: k3-j721e-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 122 ++++++-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  46 +++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 312 ++++++++++++++++--
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  45 +++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   2 +-
 5 files changed, 491 insertions(+), 36 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

