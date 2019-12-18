Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70DCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A33A218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0MiYbdrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRO02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:26:28 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16668 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbfLRO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:26:27 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEOMfW015469;
        Wed, 18 Dec 2019 15:26:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=w4HnMszGdzKynqPVMRC5qZxWn0UBjfQfixyAUj2Vbxw=;
 b=0MiYbdrQcmoCziaitsKGOXGZ4rzbtB85PBP93V11bXTgdMBcrKGUNTKZuK3lA/RgSXys
 hx4oDI3WkBdJhCjDB08H/V+wXy/ZyWpEoRPEW+D0TNhzJWihKXCl3L9pZllLT3KQgbpo
 gS2L5dQf+IdZfG60sRRzy99aB/U5OZZrDLMr52JhKPSdfNCfKWADQ+7Rs1ZlziTojgJ+
 i4Z6xIvnwvAmPMEso2osaD9tFLa/V5ZUkHEUqPmohr3I16h5qV5LRGJmpAHp/l4eljSv
 cyDAeU+3VO9/LwGyp+jq0na/Y+uXpbWTo1rcQyRrXWRzhjY68M+Ehab3W/H3hhiiWHA1 CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp374vcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:26:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3982910003B;
        Wed, 18 Dec 2019 15:26:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2691F2BEAF1;
        Wed, 18 Dec 2019 15:26:15 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec 2019 15:26:14
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <khilman@baylibre.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: fix clock names
Date:   Wed, 18 Dec 2019 15:26:13 +0100
Message-ID: <20191218142613.13683-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc2 bindings require clock-names to be "otg".
Fix the example in amlogic,meson-g12a-usb-ctrl to follow this requirement.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index 4efb77b653ab..267fce165994 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -107,7 +107,7 @@ examples:
               reg = <0xff400000 0x40000>;
               interrupts = <31>;
               clocks = <&clkc_usb1>;
-              clock-names = "ddr";
+              clock-names = "otg";
               phys = <&usb2_phy1>;
               dr_mode = "peripheral";
               g-rx-fifo-size = <192>;
-- 
2.15.0

