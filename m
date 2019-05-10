Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E4BC04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245882177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="lBGzwU3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfEJOUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:20:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19112 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727881AbfEJOUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:20:47 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AE0wCX012866;
        Fri, 10 May 2019 16:20:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=mN2/PHpZiNuhQcjSMoqkU4gRq3eMnfuCHcp2OPqegSs=;
 b=lBGzwU3TpxFerllyyQkW2HmZVddGgsGoVoljjlza7UVeh/1qA+dUQORhrAEq08Xk3Oo8
 5lLAr4u/pQlE8DgeIAMo0cJLFlmotckoD0djh3Tp2ghNQlX9oZXiC5dBdM+XFr4qxQ3P
 hs6DUdhEUXPHl8jXENCmHmvhdEBJnurS6HYkJWoPwU2IW7Iy2FtIPoc93U0B3yrBBlfb
 0u6oCg6D6Dd2qfaYdIGNXDELDJ9f6iDoQQ/zeXPutlM+px+pwD5xbmcXKo8Gj4XPyPsb
 o7fGdg7lmFMoAD2wzs1FERzC2l16eCfL/rr72RR8gy9jtdszVqg1Mg4872N1FmqsKic4 rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2scdjp9j1u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:20:31 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F05134;
        Fri, 10 May 2019 14:20:30 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 698C8113A;
        Fri, 10 May 2019 14:20:30 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 16:20:30 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May 2019 16:20:29
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: display: stm32: add supply property to DSI controller
Date:   Fri, 10 May 2019 16:20:19 +0200
Message-ID: <1557498023-10766-2-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
References: <1557498023-10766-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of a new property phy-dsi-supply to the
STM32 DSI controller.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
index 3eb1b48..60c54da 100644
--- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
@@ -40,6 +40,8 @@ Mandatory nodes specific to STM32 DSI:
 - panel or bridge node: A node containing the panel or bridge description as
   documented in [6].
   - port: panel or bridge port node, connected to the DSI output port (port@1).
+Optional properties:
+- phy-dsi-supply: phandle of the regulator that provides the supply voltage.
 
 Note: You can find more documentation in the following references
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -101,6 +103,7 @@ Example 2: DSI panel
 			clock-names = "pclk", "ref";
 			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
 			reset-names = "apb";
+			phy-dsi-supply = <&reg18>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.7.4

