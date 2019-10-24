Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B51CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F98520650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rfrmgTXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409714AbfJXPld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:41:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3204 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409615AbfJXPlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:41:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OFeiOd016236;
        Thu, 24 Oct 2019 17:41:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=5GqthLgqhaAzShH8zaBmjjPSD+4duGM3kB0LVJm2wdM=;
 b=rfrmgTXYSKrNqGmBMBo2Ndrn3pWz45+X8NieyZZEei24nzJU0TzAtOoaf2jQx9RhxS9K
 ITc0oW8vh+l1O/Rp9etoBmcL+SehcgsDWRvLONBVDlsj0Wmyv97SDctWu/Nfpeoar7CZ
 HF2OnMe4AHe7bTb1XdKUhmZhM4FTN7VOK425id0LYPqIBZbPDdR2R22igdbx78PwTyMB
 KkDunPSmGe2ecVaVjXij6q16Kz3vLeTzNSJy7nC4T3svZO5nQgLc1ADksGzmMvDtoVK5
 PqU0vgEQWk/kWE75wIkVYkwbVXBinzK/Ug+GnjJwx5jPAdNRXcDgV8WKUNuIpbaMj1m8 zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vt9s1tp5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 17:41:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC59110002A;
        Thu, 24 Oct 2019 17:41:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B16C92C6E5F;
        Thu, 24 Oct 2019 17:41:25 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 24 Oct 2019 17:41:24
 +0200
From:   Pascal Paillet <p.paillet@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.paillet@st.com>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/1] regulator: stm32_pwr: Enable driver for stm32mp157
Date:   Thu, 24 Oct 2019 17:41:21 +0200
Message-ID: <20191024154121.8503-2-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024154121.8503-1-p.paillet@st.com>
References: <20191024154121.8503-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_09:2019-10-23,2019-10-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable stm32 pwr regulators for stm32mp157 machine.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 3ee63531f6d5..ed10f4f46fdf 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -875,6 +875,7 @@ config REGULATOR_STM32_VREFBUF
 config REGULATOR_STM32_PWR
 	bool "STMicroelectronics STM32 PWR"
 	depends on ARCH_STM32 || COMPILE_TEST
+	default MACH_STM32MP157
 	help
 	  This driver supports internal regulators (1V1, 1V8, 3V3) in the
 	  STMicroelectronics STM32 chips.
-- 
2.17.1

