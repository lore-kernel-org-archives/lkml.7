Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67AB2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="05MQJKg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfDPO6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:58:55 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28150 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfDPO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:58:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3GEuLp3007177;
        Tue, 16 Apr 2019 16:58:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=mSy4siWAizfgGjB9diApebndiE8iTckODadKgfNYPpM=;
 b=05MQJKg4vniooo5yQkK/z9P7yzNFzT4aehAgTx5VDIBy/MP/2bo7lfOEu/6HaO5YZq/B
 yQtLZfFjTbpjGQJuzGEhDoRNiRr95bCKiUW/iQPMtDT2nGh9lKJx2/IKdO3+LNF5c8Sl
 Xio4QdLM2idCK/lYeJoe06AgvluVAW+Ac1e1PJ6Ct/tNE36sAf6gEQH/gl2Dp5cyPWzm
 qS+kCMkBYkUzC4KDZyEkFVz64mTruD4r6JVpQsCSsyr98+j+vvAkUgAtY88Ycc+TUqW1
 hFckKFG4R5+BkuKA7b/iZIP7irLMez9zkMl32p6ujxjhqSM+dG6yVFsNcRsq6fQCXgI+ 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ru5800uhg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 16 Apr 2019 16:58:41 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A671C31;
        Tue, 16 Apr 2019 14:58:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 899E6269B;
        Tue, 16 Apr 2019 14:58:40 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Apr
 2019 16:58:40 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Apr 2019 16:58:40
 +0200
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
Subject: [PATCH v2 6/8] ARM: dts: stm32: enable m4 coprocessor support on STM32MP157c-ed1
Date:   Tue, 16 Apr 2019 16:58:17 +0200
Message-ID: <1555426699-5340-7-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555426699-5340-1-git-send-email-fabien.dessenne@st.com>
References: <1555426699-5340-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-16_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable m4 coprocessor for STM32MP157c-ed1 board.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index acfc5cd..e5a6f40 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -134,6 +134,16 @@
 	status = "okay";
 };
 
+&m4_rproc {
+	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
+			<&vdev0vring1>, <&vdev0buffer>;
+	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
+	mbox-names = "vq0", "vq1", "shutdown";
+	interrupt-parent = <&exti>;
+	interrupts = <68 1>;
+	status = "okay";
+};
+
 &rng1 {
 	status = "okay";
 };
-- 
2.7.4

