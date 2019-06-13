Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8108DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5687221743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rCROcdPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfFMPLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:11:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48788 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732298AbfFMNui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:50:38 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DDkxMc019851;
        Thu, 13 Jun 2019 15:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=k3/ECH5XcUZOXRvixEpZeLk28W6/a2P91oQPfmM+on4=;
 b=rCROcdPucgEEK8Og12r5AdA4GASFXBx9Ick3SEOTTep/lObGdZD8wh2AaDcOwYA1dnV/
 omdUnVUwfXhtyMh8BHYL0DLkXw5VBBC/q5nOJrlFeB5EFsbiUnNgAAV3f7PWjrsjQuCJ
 0mBJwqb53dGuInbHhYdqsxO3WjtvtENXitA6y8nbBZjkCzUWz4uNTF0/oQknNcYYZqnP
 wHg/fsePpkl7PzMb9qQblCsDBe3cumvvunDsuw+1ufFoxzcx/KiMe8pyhDsJRcgkAr0m
 FGdBcgS34VBJshdEA0Q5bhDRTRdYaYBljsMLZkm1VCCcRUJCuecBuU15d6PqQUicUPh4 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t2gxec01y-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 13 Jun 2019 15:50:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9299338;
        Thu, 13 Jun 2019 13:50:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 747B12BC2;
        Thu, 13 Jun 2019 13:50:23 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 15:50:23 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun 2019 15:50:23
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        "Fabrice Gasnier" <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: [PATCH v3 09/10] ARM: dts: stm32: Update UART4 pin states on stm32mp157a-dk1
Date:   Thu, 13 Jun 2019 15:49:59 +0200
Message-ID: <1560433800-12255-10-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

Add idle and no_console_suspend states to uart4 pin configuration.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 098dbfb..b851f80 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -244,7 +244,10 @@
 };
 
 &uart4 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep", "idle", "no_console_suspend";
 	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-1 = <&uart4_sleep_pins_a>;
+	pinctrl-2 = <&uart4_idle_pins_a>;
+	pinctrl-3 = <&uart4_pins_a>;
 	status = "okay";
 };
-- 
1.9.1

