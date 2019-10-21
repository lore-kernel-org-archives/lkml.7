Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD843CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58A520873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lAenIlR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfJUTuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:50:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48702 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730212AbfJUTuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:50:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LJns9s010232
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:50:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Ratwrh803U9NlsleGXlBzy0pKrtxbkdE3srfUyIxsZA=;
 b=lAenIlR8ss2MRtYvtGJ28PV0+5w8AwY6/Im5bZXZ7JDvWFJ00tBYsBsRAzAxR/ToepGj
 WMtyEggTn5Suuak8gIseW5G98SrtG0Y7yAJenUP8Dt4umuqPDybtqlvX7ytbgnKtAHhP
 YdPqldN0mt23o5f4XUQXOWotzQ93LUSm8ZY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vr07prb6c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:50:18 -0700
Received: from 2401:db00:2120:80d4:face:0:39:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 21 Oct 2019 12:49:23 -0700
Received: by devvm1794.vll1.facebook.com (Postfix, from userid 150176)
        id F1F1C64C3CB4; Mon, 21 Oct 2019 12:49:19 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm1794.vll1.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: vll1c12
Subject: [PATCH 1/4] ARM: dts: aspeed: add dtsi for Facebook AST2500 Network BMCs
Date:   Mon, 21 Oct 2019 12:48:17 -0700
Message-ID: <20191021194820.293556-2-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021194820.293556-1-taoren@fb.com>
References: <20191021194820.293556-1-taoren@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_05:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210190
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce "facebook-netbmc-ast2500-common.dtsi" which is included by all
Facebook AST2500 Network BMC platforms. The major purpose is to minimize
duplicated device entries cross Facebook Network BMC dts files.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 .../dts/facebook-netbmc-ast2500-common.dtsi   | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi

diff --git a/arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi b/arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi
new file mode 100644
index 000000000000..7a395ba56512
--- /dev/null
+++ b/arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2019 Facebook Inc.
+
+#include "aspeed-g5.dtsi"
+
+/ {
+	memory@80000000 {
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+/*
+ * Update reset type to "system" (full chip) to fix warm reboot hang issue
+ * when reset type is set to default ("soc", gated by reset mask registers).
+ */
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+&wdt2 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+		     &pinctrl_rxd3_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	fmc_flash0: flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.0";
+
+#include "facebook-bmc-flash-layout.dtsi"
+	};
+
+	fmc_flash1: flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.1";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash1@0 {
+				reg = <0x0 0x2000000>;
+				label = "flash1";
+			};
+		};
+	};
+};
+
+&mac1 {
+	status = "okay";
+	no-hw-checksum;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&sdmmc {
+	status = "okay";
+};
+
+&sdhci1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sd2_default>;
+};
-- 
2.17.1

