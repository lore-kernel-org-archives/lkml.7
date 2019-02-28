Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D19421850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbfB1KWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:22:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5582 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732285AbfB1KWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:22:38 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SADbNd026440;
        Thu, 28 Feb 2019 11:20:06 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6d4spr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 11:20:06 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 48B733A;
        Thu, 28 Feb 2019 10:20:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CBFD64E45;
        Thu, 28 Feb 2019 10:20:03 +0000 (GMT)
Received: from localhost (10.75.127.51) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Feb 2019 11:20:03
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <lionel.debieve@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] Add nvmem support on STM32
Date:   Thu, 28 Feb 2019 11:19:50 +0100
Message-ID: <1551349196-8956-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non volatile memory area is available on STM32. It contains various
factory programmed information such as unique device ID, analog calibration...
This patchset adds:
- NVMEM support to access stm32 data cells
- helper to read 16 bits cells.

---
Changes in v2:
- update "st,stm32f4-otp" compatible as discussed with Rob
- add stm32f429 dts
- add core helper to read 16 bits cells

Fabrice Gasnier (6):
  dt-bindings: nvmem: Add STM32 factory-programmed romem
  nvmem: Add driver for STM32 factory-programmed read only mem
  nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
  nvmem: core: add nvmem_cell_read_u16
  ARM: dts: stm32: Add romem and temperature calibration on stm32mp157c
  ARM: dts: stm32: Add romem and temperature calibration on stm32f429

 .../devicetree/bindings/nvmem/st,stm32-romem.txt   |  31 ++++
 arch/arm/boot/dts/stm32f429.dtsi                   |  13 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  13 ++
 drivers/nvmem/Kconfig                              |  10 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/core.c                               |  37 ++++
 drivers/nvmem/stm32-romem.c                        | 202 +++++++++++++++++++++
 include/linux/nvmem-consumer.h                     |   7 +
 8 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
 create mode 100644 drivers/nvmem/stm32-romem.c

-- 
2.7.4

