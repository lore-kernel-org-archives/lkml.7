Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01828ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D1A206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RZB1+1Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfJKNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:07:16 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:54945 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbfJKNHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:07:16 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BD6lwL021879;
        Fri, 11 Oct 2019 15:07:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=klfGUH5dxwRvx6PXzWgeW52/ZQWuSqdDdFx4SGnAlS4=;
 b=RZB1+1VtH8UvSPqj7nDzvpZlumAZiVIzoig/VFcxT54qxXkZWDZON8vjwBaTLhl5PlGJ
 WDWaMKcgESwxdVae5WLci4JjHy5lB8wUTumrgkEHc1xRJ3PWE+r4tmjPxckHkIUuhYf9
 5TK0GxjGBS912OgSj9qSUli+xSB2IyM5KMpRghBRfIkNw5XRDJBuBciZzdjbe3TNUspc
 GUKxKsMMGusLEhzzc8obDfM6Gz7l0Qr3pA612YQ24qYXwo9JFTxJwc4ktPl53anyEyLw
 BouNE3Oxaiq/wF87KVUr3WZOonHy5YInEJVYit9LFLJe7C+tepsJtPs07FwqgjPxgTaI WQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxw9x0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 15:07:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B3D7100034;
        Fri, 11 Oct 2019 15:07:01 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 781192BE25F;
        Fri, 11 Oct 2019 15:07:01 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 15:07:01 +0200
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct 2019 15:07:00
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: dts: stm32f469: remove useless interrupt from dsi node
Date:   Fri, 11 Oct 2019 15:06:58 +0200
Message-ID: <20191011130658.23670-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI driver doesn't use interrupt, remove it from the node since it
breaks yaml check.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f469.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f469.dtsi b/arch/arm/boot/dts/stm32f469.dtsi
index 5ae5213f68cb..be002e8a78ac 100644
--- a/arch/arm/boot/dts/stm32f469.dtsi
+++ b/arch/arm/boot/dts/stm32f469.dtsi
@@ -8,7 +8,6 @@
 		dsi: dsi@40016c00 {
 			compatible = "st,stm32-dsi";
 			reg = <0x40016c00 0x800>;
-			interrupts = <92>;
 			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
 			reset-names = "apb";
 			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
-- 
2.15.0

