Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE14CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE348218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Lt3fYGgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfDYJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:18:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23376 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbfDYJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:17:56 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P91RM6023615;
        Thu, 25 Apr 2019 11:17:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0/wuEmKjJOSd230MuGusU1DgsuWoQ281XaTZzSew2DI=;
 b=Lt3fYGgMEf3AZV4wmvBC7J/cXQ/kQYjVqDw2uMA8HXAY/uZiRq4ESubcSaxHabMMTqL9
 M7j6abAy7U7GvkdkAaZhDR1OWYn9b1BopV+Ac/bjVYJngo8laVU7d7UjE2wdw29Vlqfh
 HVJ7ox5Bje7wFTLdahtqRDPMJSRkeSIrrbQ5HNIe/5tO3crXQU9nX+ouoUHtWD67OnW9
 /b+tU15K9HXwfoxsae0/uryyrjgm87ukjEhAKy+EA5MfmnRWqs7ifS6uH82pGn+XnD3L
 y/YCGfM2/n06JDp/14ZUfi0KFExVuFwNTiiEe1tBQonCu5wXF4CbmSzbBx0lq6iqxMQT dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rys6s2m2w-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 11:17:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02F443F;
        Thu, 25 Apr 2019 09:17:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8C7D1615;
        Thu, 25 Apr 2019 09:17:35 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 25 Apr
 2019 11:17:35 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr 2019 11:17:35
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 5/6] ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
Date:   Thu, 25 Apr 2019 11:17:22 +0200
Message-ID: <1556183843-28033-6-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
References: <1556183843-28033-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a hwspinlock to be used by the irq controller driver and the
syscon driver.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 824d7e1..417bdf7 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -921,6 +921,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			hwlocks = <&hsem 1 1>;
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.7.4

