Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12BEC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26822184D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PtR3FnWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfGaHWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:22:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11036 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbfGaHWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:22:31 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V7HlT6013017;
        Wed, 31 Jul 2019 09:22:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=wfkrOwgCeZzV4fJ7ha2E0UrU2pJwRZbxnCDoHpSL6Lo=;
 b=PtR3FnWCcAAbpeyAnoCzHWi/DhoQa993dRgrHHH99CBLa8+hLSi30v95lqN6pElIBl28
 c2NaVbJtikXhk0lOqYetgg83kiEXtNzh+wawiq119Z1TIH4iWnHsFTsDaDaY755mnkO7
 mfTxDCI3lFehV82UBm/J0ZFa9OrwwJzHGH9cbAPdrDJeEqj3hIpMCTx1a8kBWtISnaCp
 CuAMkzW0e+ge965SAUTVPhXAIjwm0jk/g8eF75nbXgeXq+VkKS8Qcfmln1TlzAqzX1FQ
 DHOicl2RNbJmXMpsFnejHOaQAEAB4+P+sODklBjTqIW1lqtcrKs38XMfr5CuSZ5F6jYx Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0bra31wx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 31 Jul 2019 09:22:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 483D134;
        Wed, 31 Jul 2019 07:22:16 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 275E21331;
        Wed, 31 Jul 2019 07:22:16 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 09:22:16 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul 2019 09:22:15
 +0200
From:   <patrice.chotard@st.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <soc@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Subject: ARM: multi_v7_defconfig: Enable SPI_STM32_QSPI support
Date:   Wed, 31 Jul 2019 09:22:04 +0200
Message-ID: <20190731072204.32160-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Enable support for QSPI block on STM32 SoCs.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6a40bc2ef271..78d1d93298af 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -403,6 +403,7 @@ CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SH_HSPI=y
 CONFIG_SPI_SIRF=y
 CONFIG_SPI_STM32=m
+CONFIG_SPI_STM32_QSPI=m
 CONFIG_SPI_SUN4I=y
 CONFIG_SPI_SUN6I=y
 CONFIG_SPI_TEGRA114=y
-- 
2.17.1

