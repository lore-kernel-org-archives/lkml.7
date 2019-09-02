Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734CEC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A8321881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xQJP7fGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfIBQBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:01:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18146 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbfIBQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:01:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82FugXt018639;
        Mon, 2 Sep 2019 18:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=gtUWzIm1qMISzYpgxl9wo61I8N3CwkggXpn2L8jhTyA=;
 b=xQJP7fGr9yQGbdEhj9FQruEssxqIEzxWXxkH7tjvMh8l+s/zf8KGBcx+nKr5aEHZCZU7
 C6ktme0sPdW01kTE2HFcKlBL9z5D1Px7tTLHvOdvXDYYUXRcYZqU3l1UiDTJZ6ChK080
 +1aZH0fz7gd4FcqhxrwX+0W1k+Uv0jvvp0jxRw5z3KoXfQ1uZrt1BAZyswd3YEccluLd
 QaGr0Q37V4N3d9Tm6F3tMr1vEaN6ROKj6RakMerm1u0QUdALTGpNgS6ZPzk2eskpjP5/
 RxUR5+FmMv142li1slJEgryOObnJeUTUY8xvvFQmlrAuOvQsbQseo+JOCERS3dEf5Z5n cA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uqe19dt3x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 02 Sep 2019 18:01:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DEA8A50;
        Mon,  2 Sep 2019 16:01:01 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 496502B92D4;
        Mon,  2 Sep 2019 18:01:01 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 2 Sep 2019
 18:01:01 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 2 Sep 2019 18:01:00
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <alexandre.torgue@st.com>, <olof@lixom.net>,
        <horms+renesas@verge.net.au>, <arnd@arndb.de>, <krzk@kernel.org>,
        <yannick.fertre@st.com>, <tony@atomide.com>,
        <m.szyprowski@samsung.com>, <fabrice.gasnier@st.com>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     <olivier.moysan@st.com>
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: enable stm32 sai support
Date:   Mon, 2 Sep 2019 18:00:38 +0200
Message-ID: <1567440041-19220-2-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567440041-19220-1-git-send-email-olivier.moysan@st.com>
References: <1567440041-19220-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-02_06:2019-08-29,2019-09-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for SAI on STM32MP1.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c5d37dfafe98..929d13842171 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -699,6 +699,7 @@ CONFIG_SND_SOC_ODROID=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_STI=m
+CONFIG_SND_SOC_STM32_SAI=m
 CONFIG_SND_SUN4I_CODEC=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA20_I2S=m
-- 
2.7.4

