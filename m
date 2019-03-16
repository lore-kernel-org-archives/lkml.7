Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6DCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745CE218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCPDx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:53:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfCPDxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:53:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09943468F62BDD498B35;
        Sat, 16 Mar 2019 11:53:52 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 16 Mar 2019 11:53:45 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH v4 01/12] dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
Date:   Sat, 16 Mar 2019 11:53:31 +0800
Message-ID: <20190316035342.77998-2-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190316035342.77998-1-chenyu56@huawei.com>
References: <20190316035342.77998-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding documentation for supporting the hi3660 usb
phy on boards like the HiKey960.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
v1:
* Fix some format error as suggested by Rob.
v2:
* Change hi3660 usb PHY to hi3660 USB PHY
v3:
* Make device node a subnode of usb3_otg_bc register.
v4:
* Remove "hisilicon,usb3-otg-bc-syscon" property
---
---
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
new file mode 100644
index 000000000000..e88ba7d92dcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
@@ -0,0 +1,26 @@
+Hisilicon hi3660 USB PHY
+-----------------------
+
+Required properties:
+- compatible: should be "hisilicon,hi3660-usb-phy"
+- #phy-cells: must be 0
+- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
+- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
+- hisilicon,eye-diagram-param: parameter set for phy
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+This is a subnode of usb3_otg_bc register node.
+
+Example:
+	usb3_otg_bc: usb3_otg_bc@ff200000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0xff200000 0x0 0x1000>;
+
+		usb-phy {
+			compatible = "hisilicon,hi3660-usb-phy";
+			#phy-cells = <0>;
+			hisilicon,pericrg-syscon = <&crg_ctrl>;
+			hisilicon,pctrl-syscon = <&pctrl>;
+			hisilicon,eye-diagram-param = <0x22466e4>;
+		};
+	};
-- 
2.15.0-rc2

