Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAF4C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A667021670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfD3Jps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:45:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38423 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727137AbfD3Jpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:45:32 -0400
X-UUID: fe62b11d42db49ebbc20b3b0dfc61aae-20190430
X-UUID: fe62b11d42db49ebbc20b3b0dfc61aae-20190430
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 409421780; Tue, 30 Apr 2019 17:45:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Apr 2019 17:45:18 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Apr 2019 17:45:19 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC V2 01/11] dt-bindings: soc: Add dvfsrc driver bindings
Date:   Tue, 30 Apr 2019 16:50:55 +0800
Message-ID: <1556614265-12745-2-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for enabling dvfsrc on MediaTek SoC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 23 ++++++++++++++++++++++
 include/dt-bindings/soc/mtk,dvfsrc.h               | 14 +++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
 create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h

diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
new file mode 100644
index 0000000..7f43499
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
@@ -0,0 +1,23 @@
+MediaTek DVFSRC
+
+The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
+HW module which is used to collect all the requests from both software and
+hardware and turn into the decision of minimum operating voltage and minimum
+DRAM frequency to fulfill those requests.
+
+Required Properties:
+- compatible: Should be one of the following
+	- "mediatek,mt8183-dvfsrc": For MT8183 SoC
+- reg: Address range of the DVFSRC unit
+- clock-names: Must include the following entries:
+	"dvfsrc": DVFSRC module clock
+- clocks: Must contain an entry for each entry in clock-names.
+
+Example:
+
+	dvfsrc@10012000 {
+		compatible = "mediatek,mt8183-dvfsrc";
+		reg = <0 0x10012000 0 0x1000>;
+		clocks = <&infracfg CLK_INFRA_DVFSRC>;
+		clock-names = "dvfsrc";
+	};
diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
new file mode 100644
index 0000000..a522488
--- /dev/null
+++ b/include/dt-bindings/soc/mtk,dvfsrc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
+#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
+
+#define MT8183_DVFSRC_LEVEL_1	1
+#define MT8183_DVFSRC_LEVEL_2	2
+#define MT8183_DVFSRC_LEVEL_3	3
+#define MT8183_DVFSRC_LEVEL_4	4
+
+#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
-- 
1.9.1

