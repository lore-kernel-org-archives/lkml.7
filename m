Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA502C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84243214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NKc1suqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbfIMOfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:35:12 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13310 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387600AbfIMOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:35:12 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DEV2DB017906;
        Fri, 13 Sep 2019 16:35:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=DFTucAlvurnxrOQhU2WCHuTw7pQSUYy9Sj83fGtCSFA=;
 b=NKc1suqt82um1oIkCpYkoW8cXCseTWaAfh5xIqcQ7WPCRcT6wYEPa35c6mhsqXmnDsCW
 8DiVmB1iW4QTYZFGuHHHIqwU30QTCzmDhUUgJc+TaEu2Qz8g57itsLw1TUDLyTW5IvZz
 XPcENx+tfPJo33219I6UCeLif6Ul0uYmkyL8VjWoePLKoNlHtisNjqZB7PH3/7jdd6E6
 MBOT5f8FABWfDLBkseVejJ0DYQ74mostrs3VCNC7FqVPVrKNrnspmmGeA511969gH4/4
 +S64vj6SaDKb4IsjFrs2LCiuM5aUjMs/ByHlQXpDuukarD2I6ifnD402H+qkWiuXWT3a 2w== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uytdx5n83-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Sep 2019 16:35:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 086594C;
        Fri, 13 Sep 2019 14:34:59 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BB532C86B2;
        Fri, 13 Sep 2019 16:34:58 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep
 2019 16:34:58 +0200
Received: from localhost (10.48.1.232) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 13 Sep 2019 16:34:57 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: Enable VREFBUF on stm32mp157a-dk1
Date:   Fri, 13 Sep 2019 16:34:38 +0200
Message-ID: <1568385280-2633-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568385280-2633-1-git-send-email-fabrice.gasnier@st.com>
References: <1568385280-2633-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.1.232]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_07:2019-09-11,2019-09-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable VREFBUF as ADC/DAC uses it on stm32mp157a-dk1 board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 0615d1c..ebd9f33 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -449,3 +449,10 @@
 	pinctrl-0 = <&uart4_pins_a>;
 	status = "okay";
 };
+
+&vrefbuf {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	vdda-supply = <&vdd>;
+	status = "okay";
+};
-- 
2.7.4

