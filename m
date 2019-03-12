Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A810C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A432173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ks+xRz4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCLJEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:04:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52054 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfCLJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:04:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2C94Q1Z082090;
        Tue, 12 Mar 2019 04:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552381466;
        bh=mdvQ/ctR3/KaNppYogpQqNVu/tPgSJ8Ehxm5hPM8S/U=;
        h=From:To:CC:Subject:Date;
        b=Ks+xRz4M7hscsy9oTmScdcsxQg3IE39eZSayEaNwJSPPCghjaOyBHOTv1nMSte9AL
         rWKsku4YcO71i8Hw9xCVUAH4G37Okd9Fn9J2rQooQ4+FkfaytjW4CJwrCVLfyQctmI
         1IfEhXmU/ZDkveQQJcBMwXLSPCqrTrElWuFQV6ck=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2C94QGP047173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 04:04:26 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 04:04:25 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 04:04:25 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2C94Lfq016945;
        Tue, 12 Mar 2019 04:04:22 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] clk: keystone: Add new driver to handle syscon based clock
Date:   Tue, 12 Mar 2019 14:35:16 +0530
Message-ID: <20190312090518.28666-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TI's K2 and K3 SoCs, certain clocks can be gated/ungated by setting a
single bit in SoC's System Control registers. Sometime more than
one clock control can be in the same register. But these registers might
also have bits to control other SoC functionalities.
For example, Time Base clock(tbclk) enable bits for various EPWM IPs are
all in EPWM_CTRL Syscon registers on K2G SoC.

This series adds a new clk driver to support such clocks. Registers
which control clocks will be grouped into a syscon DT node, thus
enabling sharing of register across clk drivers and other drivers.
Each clock node will be child of the syscon node describing offset and
bit within the regmap that controls the clock output.


Vignesh Raghavendra (2):
  dt-bindings: clock: Add binding documentation for TI syscon gate clock
  clk: keystone: Add new driver to handle syscon based clock

 .../bindings/clock/ti,syscon-gate-clock.txt   |  35 +++++
 drivers/clk/keystone/Kconfig                  |   8 +
 drivers/clk/keystone/Makefile                 |   1 +
 drivers/clk/keystone/syscon-clk.c             | 143 ++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
 create mode 100644 drivers/clk/keystone/syscon-clk.c

-- 
2.21.0

