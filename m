Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C267C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CF920830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Psj4wxyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfCYIJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:09:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47926 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfCYIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:09:15 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P89DR9091474;
        Mon, 25 Mar 2019 03:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553501353;
        bh=oUfur7Dh5WwdUELYllZejC2ZQ68HLchmGXW59YNN6Co=;
        h=From:To:CC:Subject:Date;
        b=Psj4wxyZDHcRWKMHgHAJRIHFdy4ta+oUGNFgiegI90qL6cCQ3CJeYnsC2BdYX45s7
         Kirph7fy2agUckuxSN9x1WnipXHxKPH7YnF+PLXhxKbg80YfayIC3NwgYh1NUxfQja
         uRevHdvFgiCN/AT8Yr7xTW9h9RaYA8ofpFfEVizw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P89DYG053823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:09:13 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:09:13 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:09:13 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P89AkW019470;
        Mon, 25 Mar 2019 03:09:11 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/5] PHY: Add support for SERDES in TI's AM654 platform
Date:   Mon, 25 Mar 2019 13:38:10 +0530
Message-ID: <20190325080815.6056-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series
  *) adds support for SERDES module in am654
  *) modifies phy_reset API to invoke pm_runtime_get/pm_runtime_put since
the reset callback can access registers.
  *) Add *release* phy_ops to be invoked when the consumer relinquishes
PHY

Changes from v2:
  *) Fix typos pointed out by rOGER
  *) Add dt-binding Documentation in a new file ti,phy-am654-serdes.txt
  *) Add Roger's patch to support all CLKSEL values.

Changes from v1:
  *) Add *release* phy ops
  *) Populate release phy_ops in phy-am654-serdes to cleanup
initializations done in of_xlate

Kishon Vijay Abraham I (4):
  phy: core: Add *release* phy_ops invoked when the consumer
    relinquishes PHY
  phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking
    reset callback
  dt-bindings: phy: ti: Add dt binding documentation for SERDES in
    AM654x SoC
  phy: ti: Add a new SERDES driver for TI's AM654x SoC

Roger Quadros (1):
  phy: ti: am654-serdes: Support all clksel values

 .../bindings/phy/ti,phy-am654-serdes.txt      |  81 +++
 drivers/phy/phy-core.c                        |  11 +
 drivers/phy/ti/Kconfig                        |  12 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-am654-serdes.c             | 573 ++++++++++++++++++
 include/dt-bindings/phy/phy-am654-serdes.h    |  13 +
 include/linux/phy/phy.h                       |   2 +
 7 files changed, 693 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h

-- 
2.17.1

