Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FDECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DF520854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ExuPmFlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfJOMbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:31:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32700 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726430AbfJOMbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:31:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9FCG5YL004950;
        Tue, 15 Oct 2019 14:31:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=+GjgENcAkDTPR2yM3bgmWF3aAKS3dbofBQg0yNbTFkc=;
 b=ExuPmFlPOX1rNbfPHOuK+LXPbeoDHm5YfR6qwbcsoWg9B5MrUD4QBkYUC/flMmdgHkLO
 nLFy5NxEitnXVJzVQOefdwBEPEY3xc+e9FduxbqQ66yQQH3M0FPeOQBLSoqpMLkGg2wR
 GCO7DNFyQ/WMVH+NmdsqvMYpLlybn77f3p76gBdk5r8flP3JL2LLOeGI5KWnlB+5+zn4
 V8BJikIW/vq7s/lWx5RjG8jJMg4idXpOWoOp6gbqNs65Y+0/PRxUVEV1aOn6TcoZdOrM
 pJxRjcJ55dm+MRXfyVgpzPxIpL+167KXdKJ/XXQlGW/wbkWMfra2jokSsfh4K83mB6xM yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vk3y9rhh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 14:31:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5275100034;
        Tue, 15 Oct 2019 14:31:06 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D611E2C7EAA;
        Tue, 15 Oct 2019 14:31:06 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct
 2019 14:31:06 +0200
Received: from localhost (10.129.4.186) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct 2019 14:31:06
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: dts: stm32f469: remove useless dma-ranges property
Date:   Tue, 15 Oct 2019 14:30:58 +0200
Message-ID: <20191015123058.14669-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191015123058.14669-1-benjamin.gaignard@st.com>
References: <20191015123058.14669-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.186]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_05:2019-10-15,2019-10-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dma-ranges from ltdc node since it is already set
on bus node.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index a3ff04940aec..c928126d5b7e 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -166,7 +166,6 @@
 };
 
 &ltdc {
-	dma-ranges;
 	status = "okay";
 
 	port {
-- 
2.15.0

