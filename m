Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE82C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5812082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfCEI35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:29:57 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33169 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725835AbfCEI34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:29:56 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x258RWka002770;
        Tue, 5 Mar 2019 09:29:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhkn06av-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Mar 2019 09:29:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1FAD634;
        Tue,  5 Mar 2019 08:29:35 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA109166E;
        Tue,  5 Mar 2019 08:29:34 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 09:29:34 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019 09:29:34
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH V3 0/6] stmmac: add some fixes for stm32
Date:   Tue, 5 Mar 2019 09:29:22 +0100
Message-ID: <1551774568-11732-1-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For common stmmac:
	- Add support to set CSR Clock range selection in DT
For stm32mpu:
	- Glue codes to support magic packet
	- Glue codes to support all PHY config :
		PHY_MODE (MII,GMII, RMII, RGMII) and in normal,
		PHY wo crystal (25Mhz),
		PHY wo crystal (50Mhz), No 125Mhz from PHY config
For stm32mcu:
	- Add Ethernet support for stm32h7

Changes in V3:
	- Reverse for syscfg management because it is manage by these patches
	  https://lkml.org/lkml/2018/12/12/133
	  https://lkml.org/lkml/2018/12/12/134
	  https://lkml.org/lkml/2018/12/12/131
	  https://lkml.org/lkml/2018/12/12/132


Christophe Roullier (6):
  net: ethernet: stmmac: manage Ethernet WoL for stm32mp157c.
  net: ethernet: stmmac: update to support all PHY config for
    stm32mp157c.
  dt-bindings: net: stmmac: add phys config properties
  net: ethernet: stmmac: add management of clk_csr property
  dt-bindings: net: stmmac: remove syscfg clock property
  ARM: dts: stm32: Add Ethernet support on stm32h7 SOC and activate it
    for eval and disco boards

 .../devicetree/bindings/net/stm32-dwmac.txt        |   9 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  15 +++
 arch/arm/boot/dts/stm32h743.dtsi                   |  13 ++
 arch/arm/boot/dts/stm32h743i-disco.dts             |  17 +++
 arch/arm/boot/dts/stm32h743i-eval.dts              |  17 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 135 +++++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +
 7 files changed, 183 insertions(+), 26 deletions(-)

-- 
2.7.4

