Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4722EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CDB21473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 09:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vx3HrLuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfENJg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 05:36:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14074 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725916AbfENJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 05:36:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E9W0r5031412;
        Tue, 14 May 2019 11:36:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=STMicroelectronics;
 bh=LzYSQmTyf5/EQ3Y2VGObHjM41SSi7kcFjXdBikk9ZQs=;
 b=vx3HrLuhnX85QMXeDgz/T1DXa6z04dnJ2EKrOm4UEz4vgiJab7dGEgdv0Lgva2qmXbGX
 3c0i9waUV0OHFrsgZfXK8Kr6wx38f0DMwHJAUAmYkRbrxVXiR34HPhJ3u9c89EzZFaT3
 x7Y3j4+RsVnXXVM7bC7TXwPqz1JWCdBdDYcX/MK0tKLnfAOvScT3hnLVhku40mJyT3Jy
 KgtmhZDIeDpAbJIzrZaJ8orwmfUHl7/cbqvQj3ZMdeTFPPSzMBbg4ugScy7OPfmi2dLz
 x8sumPvk/YOvVolGRWbOO6WEq8ehoBwotVQli88hxSaSy7yNViUppqPQqsvaIbTQ37Pq Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sek5aa5dp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 14 May 2019 11:36:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB19534;
        Tue, 14 May 2019 09:36:11 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 82D58179A;
        Tue, 14 May 2019 09:36:11 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May
 2019 11:36:11 +0200
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May 2019 11:36:10
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: display: stm32: add supply property to DSI controller
Date:   Tue, 14 May 2019 11:35:55 +0200
Message-ID: <1557826556-10079-2-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557826556-10079-1-git-send-email-yannick.fertre@st.com>
References: <1557826556-10079-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of a new property phy-dsi-supply to the
STM32 DSI controller.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
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

