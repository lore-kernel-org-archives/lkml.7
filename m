Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B23C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DB224679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TyYw57o7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLSOlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:41:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26518 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726797AbfLSOlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:41:46 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJEaUs1014020;
        Thu, 19 Dec 2019 15:41:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=dvDHlMKXIT3mKaoz1fvmQkfLjyvErJdO/1Lw3VdRWng=;
 b=TyYw57o7h/qRs/RT2N469j/oU12+YyQpKx3Vu/j7wCJJlY3xps85rdE01xjC58dEt0Mf
 5l9qj3QH54Sil3Tr3GXJn81cyYvnmbQsvqO2O8GhxXRrX5zZPgfO7XFB2rhMcC/+KbE/
 dceugvYdqCPWuEp5AohO5gCNM1FG094LLwh+7lswWgsHeQdBebCcKYhtZ05kZyI/3f7X
 U4mjtxLHQlb2+IW4lEvikar/zMPDPdD2+SEsehbKwyJFq+Vh2eRz1y+5X4tVK0pGIbcc
 b+DutMHjlDCMQ8oWA8SU/ujCycoxmU21k10wuNQ3vC+JEWy0rxbha4g60LzvqCY+SNbi 6Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp37a8h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:41:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA692100039;
        Thu, 19 Dec 2019 15:41:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B6452C6B5E;
        Thu, 19 Dec 2019 15:41:19 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Dec 2019 15:41:18
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/3] Convert STM32 ROMEM to json-schema
Date:   Thu, 19 Dec 2019 15:41:14 +0100
Message-ID: <20191219144117.21527-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert STM32 ROMEM to json-schema and fix the issues detected on stm32 dtsi
files.
Note that stm32mp1 patch should be applied on top of the stm32-next tree.

Benjamin Gaignard (3):
  dt-bindings: nvmem: Convert STM32 ROMEM to json-schema
  ARM: dts: stm32: change nvmem node name on stm32f429
  ARM: dts: stm32: change nvmem node name on stm32mp1

 .../devicetree/bindings/nvmem/st,stm32-romem.txt   | 31 ---------------
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  | 46 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32f429.dtsi                   |  2 +-
 arch/arm/boot/dts/stm32mp151.dtsi                  |  2 +-
 4 files changed, 48 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml

-- 
2.15.0

