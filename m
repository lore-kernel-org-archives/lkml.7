Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0159CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48912083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565787134;
	bh=2iQ9SSdWg+pUEq8xTNo80FcOSqZBNd6pLFEMFHpSn6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RJhyK9akfHMaHIfmFTF6hLxSgps6zSb/SJI25+PdYfX6EhzOrp4HcWlab3qH2FikD
	 ddijpMEBlTbV6v7DAGflpq4K7o/F90hLgnpMwR7UVXM/Gmw46t58oZXfxB57A5mjQv
	 /lQQdHRy28rXh37Ra3HAkHCff33IeVxIQtuYaEsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfHNMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHNMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:52:10 -0400
Received: from localhost.localdomain (unknown [171.76.115.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24E020679;
        Wed, 14 Aug 2019 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787129;
        bh=2iQ9SSdWg+pUEq8xTNo80FcOSqZBNd6pLFEMFHpSn6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOt1NBmqYsTEM8Hm5a80Nq+IARMynVYiIXPeGkxbtlXmE5sX6CQlemG820VBOnu9g
         F3DuysdJ2DjYwaDebdZQtKzNKK45zvB53Bm+dI7lWVNhGqTH5HXoM+81Ztc33OrYJw
         xH9hRbMkast0+JHU8KG2nFr6mbozwkVrgh03Z9Z8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/22] arm64: dts: qcom: pm8150: Add Base DTS file
Date:   Wed, 14 Aug 2019 18:19:56 +0530
Message-Id: <20190814125012.8700-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814125012.8700-1-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add base DTS file for pm8150 along with GPIOs

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
new file mode 100644
index 000000000000..b533e254a203
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+// Copyright (c) 2019, Linaro Limited
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pm8150_0: pm8150@0 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8150_gpios: gpio@c000 {
+			compatible = "qcom,pm8150-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
+				     <0 0xc1 0 IRQ_TYPE_NONE>,
+				     <0 0xc2 0 IRQ_TYPE_NONE>,
+				     <0 0xc3 0 IRQ_TYPE_NONE>,
+				     <0 0xc4 0 IRQ_TYPE_NONE>,
+				     <0 0xc5 0 IRQ_TYPE_NONE>,
+				     <0 0xc6 0 IRQ_TYPE_NONE>,
+				     <0 0xc7 0 IRQ_TYPE_NONE>,
+				     <0 0xc8 0 IRQ_TYPE_NONE>,
+				     <0 0xc9 0 IRQ_TYPE_NONE>,
+				     <0 0xca 0 IRQ_TYPE_NONE>,
+				     <0 0xcb 0 IRQ_TYPE_NONE>;
+		};
+	};
+
+	qcom,pm8150@1 {
+		compatible ="qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.20.1

