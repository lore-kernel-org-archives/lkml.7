Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A30C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6CD21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tc8HivKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfIBQBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:01:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38236 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfIBQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:01:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x82G1NEh013661;
        Mon, 2 Sep 2019 18:01:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=n/9J04bMASd91Yvy3ukzh2dvhlV4FPmYy3RQUpNIw6g=;
 b=tc8HivKwomhriFxrWx2/yMRi933JjZQRofezTwsFF4HKT3Q2Y/yXzPc/RaBolmt3R+20
 UeWPxSHZH9Yh91ix/A6VJZAIMleeIMHsoKskMMxvC7lMomfYOGuNgg182Te/KrdODZ8u
 +dN2oSp7/v8a8oWE2ee6D36KS2ND2jFgCbwayyO7XaCciLzmxwykMF+WNWHZwNyuMz3R
 fL1T8+eOSm3VHwI3Ay/Vg8lSMvKrCoaERHa2JAw045lZg/cGhpZIwrBIaxI7xX1xy5/G
 NhXyiV+0nHPezHDP+ViJChofBt/w3JQ+shRWqw8FRSG8DKFajBGrxiJ72zk3v9l21s66 mA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqec2ngs8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 02 Sep 2019 18:01:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3784F23;
        Mon,  2 Sep 2019 16:01:11 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9596C2CF15F;
        Mon,  2 Sep 2019 18:01:10 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 2 Sep 2019
 18:01:04 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 2 Sep 2019 18:01:04
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
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: enable audio graph card support
Date:   Mon, 2 Sep 2019 18:00:41 +0200
Message-ID: <1567440041-19220-5-git-send-email-olivier.moysan@st.com>
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

Enable audio graph card support for stm32mp157a-dk1 board.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03a4d93df8c4..c7104a1c1687 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -719,6 +719,7 @@ CONFIG_SND_SOC_SGTL5000=m
 CONFIG_SND_SOC_SPDIF=m
 CONFIG_SND_SOC_STI_SAS=m
 CONFIG_SND_SOC_WM8978=m
+CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.7.4

