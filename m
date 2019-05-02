Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536B3C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C612133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="F0bY/5bE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEBIKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:10:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726501AbfEBIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:10:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42828ov023662;
        Thu, 2 May 2019 10:10:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=h21dwqOXVMhoA8LO1eNpVhDbxE/SLRFLO7Ap3IdDFeI=;
 b=F0bY/5bEgMKwbETyNiz52ySJG6Msq9Vx2TPPaizePgPtl4tpTPLAFp9sqtu5f9lyyTFD
 nny2PEcAorwP0206961BnQzqBjMkV/ShE+Qn0yCsbOfN5FhtnaMG1sYxW9YBr58Naarh
 iK1HrQ9zDo9eNj2+t4UPAyM1n1mesUF1XQWPiuI4QxuWIHtFdTLzk029cDzvYIRprAcJ
 t8+d0SIHIyKCM5vhEe8stqtrYkKZw51qe4Sm72bPwFVfJ/klJL0USepFC8hq/dFtbpJk
 alHpnpjJ6xQMqbwGBZodX5mac1dU2eQnj9lFsIrDmiIjhMDKr4dPGTUJRSt7FeiOhBZs rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s6xhbf3r3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 May 2019 10:10:22 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3A2E38;
        Thu,  2 May 2019 08:10:21 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB9E1EDE;
        Thu,  2 May 2019 08:10:21 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 2 May 2019
 10:10:21 +0200
Received: from localhost (10.129.4.86) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 2 May 2019 10:10:21 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 4/8] ARM: dts: stm32: add m4 remoteproc support on STM32MP157c
Date:   Thu, 2 May 2019 10:10:02 +0200
Message-ID: <1556784606-3016-5-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556784606-3016-1-git-send-email-fabien.dessenne@st.com>
References: <1556784606-3016-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.86]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the M4 remote processor in a sub-node of the mlahb simple bus.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index c664b55..e8d3b00 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1242,4 +1242,24 @@
 			status = "disabled";
 		};
 	};
+
+	mlahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		dma-ranges = <0x00000000 0x38000000 0x10000>,
+			     <0x10000000 0x10000000 0x60000>,
+			     <0x30000000 0x30000000 0x60000>;
+
+		m4_rproc: m4@38000000 {
+			compatible = "st,stm32mp1-m4";
+			reg = <0x00000000 0x10000>,
+			      <0x10000000 0x40000>,
+			      <0x30000000 0x40000>;
+			resets = <&rcc MCU_R>;
+			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
+			st,syscfg-tz = <&rcc 0x000 0x1>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.7.4

