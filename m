Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37499C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13962133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZWOVFFsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfDJKCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:02:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14014 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726556AbfDJKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:02:45 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3A9pE2n021997;
        Wed, 10 Apr 2019 12:02:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=uSLvWJ3dEGW9QdGxFgJ/sUFT5ymEF6rJMqGW79HtTfo=;
 b=ZWOVFFsBCWYVb04wAkS7b873PJ7lASHO2KaWGKEC3rhQkjhBDUUHCxJPqMRw0n87rEr7
 Qi9roAmdgjBJQZYTKb273GEkxTrqZ+TkCK2ZrX60dCFIp8gZedrdc47rGubzV76qJl1X
 cMB6HntjR7lcdJgJbfQCt4U5MZsj8bcAGFfPQGVxu0JQudKJ0wpkj3PNYqPdWGEoMi42
 svfav30Ocv5TfVOCGG3NZ6KvrVQXfNJ29xcYkAgXWRCKKzH46R7fZMYYjFe1l0Kim36C
 BcZoYqTOOkW75lca6uj97dPwIC8OjMriugW491P+F8pNVsHS3ekTLkwCMBhdiQC8Av95 Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcp64t2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 12:02:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA69B31;
        Wed, 10 Apr 2019 10:02:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 879571393;
        Wed, 10 Apr 2019 10:02:30 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr 2019 12:02:30
 +0200
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 0/3] Add Vivante GPU support on STM32MP157c
Date:   Wed, 10 Apr 2019 12:02:25 +0200
Message-ID: <1554890548-24448-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and enable Vivante GPU on stm32mp157c for ED1, DK1 and DK2 boards.
---
  Version history:
    v2:
       * move GPU reserved memeory out of bottom DDR to let free this area for
         U-Boot
    v1:
       * Initial
---
Pierre-Yves MORDRET (3):
  ARM: dts: stm32: Add Vivante GPU support on STM32MP157c
  ARM: dts: stm32: enable Vivante GPU support on stm32mp157c-ed1 board
  ARM: dts: stm32: enable Vivante GPU support on stm32mp157a-dk1 board

 arch/arm/boot/dts/stm32mp157a-dk1.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi    | 10 ++++++++++
 3 files changed, 42 insertions(+)

-- 
2.7.4

