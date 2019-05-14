Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF4020675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RbfAZWNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfENI1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:27:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59152 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbfENI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:27:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E8Q8xp029562;
        Tue, 14 May 2019 10:27:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=cSw7dbXcAbS5Q/0FeaUhUZjqh7E4PIut1NGw2jFxHQc=;
 b=RbfAZWNaTw7ekn4Qvx6XDaQ9kqvaprs9BUC9VSJL84SFK4sSm4IYGB51dn7AVuELdKoP
 JSLiGo8Fmqbtkb59Zu0MpxjzII8Uvb6kOpnhQnrURRAMdVfldmCuTLq+IdVrZkk1eDgv
 gcWXN1t+8q2Bs9CVPZ2C7eIGkBEZnSfZEPbP5eDejPJeEuWjC2uT5p2GFDtUUyDHvBFQ
 20//UDlxX1gc5+EWb3v/UiVhVHOhGayDDMnxANEaOvvpz+sYlUclC0+XaQPUSH0W9JS6
 XA6upeebVf4E7YerIPeavihghI6g1hWcVEekqpgFqlBZ2R84MtOZV7lznn3YJb8dip9A sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdkuyqnmk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 14 May 2019 10:27:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B86A434;
        Tue, 14 May 2019 08:27:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E2C81551;
        Tue, 14 May 2019 08:27:07 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May
 2019 10:27:07 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May 2019 10:27:06
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 0/8] stm32 m4 remoteproc on STM32MP157c
Date:   Tue, 14 May 2019 10:26:55 +0200
Message-ID: <1557822423-22658-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STMicrolectronics STM32MP157 MPU are based on a Dual Arm Cortex-A7 core and a
Cortex-M4.
This patchset adds the support of the stm32_rproc driver allowing to control
the M4 remote processor.

Changes since v3:
-Replaced "st,auto_boot" with "st,auto-boot"
-Update m4 reg values and align with unit-address

Changes since v2:
- Clarified "reg" description
- Change m4 unit adress to 38000000
- Renamed "auto_boot" in "st,auto-boot"

Changes since v1:
- Gave details about the memory mapping (in bindings).
- Used 'dma-ranges' instead of 'ranges'.
- Updated the 'compatible' property.
- Remove the 'recovery', 'reset-names' and 'interrupt-names' properties.
- Clarified why / when mailboxes are optional.

Fabien Dessenne (8):
  dt-bindings: stm32: add bindings for ML-AHB interconnect
  dt-bindings: remoteproc: add bindings for stm32 remote processor
    driver
  remoteproc: stm32: add an ST stm32_rproc driver
  ARM: dts: stm32: add m4 remoteproc support on STM32MP157c
  ARM: dts: stm32: declare copro reserved memories on STM32MP157c-ed1
  ARM: dts: stm32: enable m4 coprocessor support on STM32MP157c-ed1
  ARM: dts: stm32: declare copro reserved memories on STM32MP157a-dk1
  ARM: dts: stm32: enable m4 coprocessor support on STM32MP157a-dk1

 .../devicetree/bindings/arm/stm32/mlahb.txt        |  37 ++
 .../devicetree/bindings/remoteproc/stm32-rproc.txt |  63 +++
 arch/arm/boot/dts/stm32mp157a-dk1.dts              |  52 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |  52 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  20 +
 drivers/remoteproc/Kconfig                         |  15 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/stm32_rproc.c                   | 628 +++++++++++++++++++++
 8 files changed, 868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
 create mode 100644 drivers/remoteproc/stm32_rproc.c

-- 
2.7.4

