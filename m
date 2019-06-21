Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8820EC48BE5
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BA92089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LIaIcJCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFUOvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:51:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45237 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbfFUOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:51:16 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LEbDMY025341;
        Fri, 21 Jun 2019 16:51:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=63y160HFJfBAkQYPLcAgcAmZ5AQpL6Dt+zlImmifyE4=;
 b=LIaIcJCZC0zT5KKJM2srtwt0K7M6fBkSQJyLhKcNawrX3sRFSO3vI8X936Tc4rHvKWis
 RZ6p9eYX5pRL/lSB6iezHw9fmLlEcg7hxxB/blFi/VXiHKSDUEL3pTTvtSfWMtakQW+p
 N1FdaZXoVxlJRn70/JjCvqfnIR9CT6zcKeepcmy3tSnZK8sgad8J0CAXnqSfuiq6OItE
 5lWnVs3PQaB1zUcDcd9DgxDYAtvGdoBJ4G/QO1WPqDpUVhxnJHHCzrglXN6bgG+Vtk94
 Et08lwVnKukV0pxEmurJ7q7s/5q03u90o9nM7QQrcdrT7/xSFMoKI3LiA0XbGHoYqjU+ Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7wxssp1j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Jun 2019 16:51:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B3EA31;
        Fri, 21 Jun 2019 14:51:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FF542BE2;
        Fri, 21 Jun 2019 14:51:04 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Jun 2019 16:51:03
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <linux@armlinux.org.uk>,
        <olof@lixom.net>, <arnd@arndb.de>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: add FMC2 NAND  controller support
Date:   Fri, 21 Jun 2019 16:49:50 +0200
Message-ID: <1561128590-14621-5-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
References: <1561128590-14621-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FMC2 NAND controller support used by STM32MP SOCs.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e386f35..092255c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -197,6 +197,7 @@ CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
+CONFIG_MTD_NAND_STM32_FMC2=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
-- 
1.9.1

