Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C2CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1A206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MejLdAC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfG2O3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:29:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7928 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728045AbfG2O33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:29:29 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6TERLrM022428;
        Mon, 29 Jul 2019 16:29:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=/E0GksnkJiKefciHBvFyL+s1X3i9mUeBZFhV3J5bfCA=;
 b=MejLdAC5egEPFYo+PeRI2KZ59gQepBm4PjuE4dYHUmy2ipCTkYeM8cPmcIuSB5SWQNZc
 RWkDgdoUWvw3LPq0VRRbTRfja20BeoQ43YZJjo73gjX75besD6SIgzfQwDq3U6bS6jX4
 L9ELCvaiRoeRT73MTMLKzNRLuVenb8F1Kp+dQ3QMliTZWXCRQIjCAtmzQdq5k/AfDJSE
 Jcm28weMNsKgnLktPyiKeaCpGOtZrBUi0IA3MLu/DH7f+Jm0RWGCxy/j4HwaUzG1/tlU
 Sm0oYVM+dOOe63K/wy8W/kCEDgi0jnnm8h05EyWzJ4dJZfn1fAhTIaGveh3kVOEjKjcL +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u0br9n7jv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Jul 2019 16:29:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F17F34;
        Mon, 29 Jul 2019 14:29:16 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D1D6B5A7C;
        Mon, 29 Jul 2019 14:29:15 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 16:29:15 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul 2019 16:29:15
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] ARM: dts: stm32: add phy-dsi-supply property on stm32mp157c-ev1
Date:   Mon, 29 Jul 2019 16:29:08 +0200
Message-ID: <1564410548-20436-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dsi physical layer is powered by the 1v8 power controller supply.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index feb8f77..19d69d0 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -101,6 +101,7 @@
 &dsi {
 	#address-cells = <1>;
 	#size-cells = <0>;
+	phy-dsi-supply = <&reg18>;
 	status = "okay";
 
 	ports {
-- 
2.7.4

