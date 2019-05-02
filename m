Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A36BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3935020675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gtqhfvIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEBILP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:11:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbfEBIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:10:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42860sX006127;
        Thu, 2 May 2019 10:10:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qsRqvviEBACZshMNCC3W3q/ZdBJX0rfci2XIVx7jSmI=;
 b=gtqhfvIFelmsDDXXiKo+qWnGfPERQFXm5QUB+bxBUrKSZlqNZAJBbJaeivuxIDYFo/hG
 gmMFFBsI4fvBeanBlap4vbwGi/OU5xjvV3WYRf2v0c79YzdShdQgOH6Lr48RWKNcIVKP
 Ja/lE4wan/zEDCkeMglLfZCxd6EZJwbOSJj1NQqO6PJZVlsG87CbEFvJp8sdCBs4RijF
 pLiioChEh1TST6BKJ2BzRUoYcI2CEoopfieKB6Phy6YybWp/joJM3bT8XInc5hNyqmWh
 arPegyuncEohWfkCDILU1pwXpKO273nVIvnM608O/cTF4H/bxUmjabNBzS5x29OVqAS4 Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s6xgcq494-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 May 2019 10:10:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 046A831;
        Thu,  2 May 2019 08:10:17 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D060BEDE;
        Thu,  2 May 2019 08:10:17 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 2 May 2019
 10:10:17 +0200
Received: from localhost (10.129.4.86) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 2 May 2019 10:10:17 +0200
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
Subject: [PATCH v3 1/8] dt-bindings: stm32: add bindings for ML-AHB interconnect
Date:   Thu, 2 May 2019 10:09:59 +0200
Message-ID: <1556784606-3016-2-git-send-email-fabien.dessenne@st.com>
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

Document the ML-AHB interconnect for stm32 SoCs.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 .../devicetree/bindings/arm/stm32/mlahb.txt        | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt

diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
new file mode 100644
index 0000000..3f5b779
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
@@ -0,0 +1,37 @@
+ML-AHB interconnect bindings
+
+These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
+a Cortex-M subsystem with dedicated memories.
+The MCU SRAM and RETRAM memory parts can be accessed through different addresses
+(see "RAM aliases" in [1]) using different buses (see [2]) : balancing the
+Cortex-M firmware accesses among those ports allows to tune the system
+performance.
+
+[1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
+[2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
+
+Required properties:
+- compatible: should be "simple-bus"
+- dma-ranges: describes memory addresses translation between the local CPU and
+	   the remote Cortex-M processor. Each memory region, is declared with
+	   3 parameters:
+		 - param 1: device base address (Cortex-M processor address)
+		 - param 2: physical base address (local CPU address)
+		 - param 3: size of the memory region.
+
+The Cortex-M remote processor accessed via the mlahb interconnect is described
+by a child node.
+
+Example:
+mlahb {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	dma-ranges = <0x00000000 0x38000000 0x10000>,
+		     <0x10000000 0x10000000 0x60000>,
+		     <0x30000000 0x30000000 0x60000>;
+
+	m4_rproc: m4@38000000 {
+		...
+	};
+};
-- 
2.7.4

