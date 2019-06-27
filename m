Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE4C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF792080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q1ldMIaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF0MJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:09:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38202 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbfF0MJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:09:36 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RC978P027890;
        Thu, 27 Jun 2019 14:09:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=YhbGT74N+NBt7diBF1bSd0/WlzOVPJg/StbhMe0pCCw=;
 b=q1ldMIaPhSmX9byvqp4QjPhafsAc0jBnCLQFu9stlJliO/Td13SvJLIUUniXG9EHj3CZ
 9FPZV/Ar7YAXvuL+6rusfmbFvory1CaV5/cMKMyeatIWVpR4lrTxcSJFH5M9p4WYO2gx
 M1Gz9qYpctH25Gp40FGgB69z1K9yF3cPIdyBwHxUUItx5DC+q+DfAnBy+NMQFKRCRfiB
 fQNt965WFpbhky6Hr1M0dRlSbNgIHh7ytbirl2OFQuxxL6enhebbN8ohh5pQ0Bkc9rdm
 vJHx21hn79dGR4pAIb3oGqFi7DkC13bP+ZS59qcbmsl4xIIg15RIhUDxcCBfCySY3pnQ iQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t9d2jy4j5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 27 Jun 2019 14:09:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44D5B49;
        Thu, 27 Jun 2019 12:09:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 19A7F272F;
        Thu, 27 Jun 2019 12:09:23 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 14:09:23 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 14:09:22 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH] ARM: dts: stm32: activate dma for qspi on stm32mp157
Date:   Thu, 27 Jun 2019 14:09:05 +0200
Message-ID: <1561637345-31441-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch activates dma for qspi on stm32mp157.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 2afeee6..205ea1d 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -1074,6 +1074,9 @@
 			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
 			reg-names = "qspi", "qspi_mm";
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&mdma1 22 0x10 0x100002 0x0 0x0>,
+			       <&mdma1 22 0x10 0x100008 0x0 0x0>;
+			dma-names = "tx", "rx";
 			clocks = <&rcc QSPI_K>;
 			resets = <&rcc QSPI_R>;
 			status = "disabled";
-- 
2.7.4

