Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3938C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28E12073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLCHgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:36:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38870 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLCHgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:36:19 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB37Zu97014079, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB37Zu97014079
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Dec 2019 15:35:56 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Dec 2019 15:35:55 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        cylee12 <cylee12@realtek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 6/6] dt-bindings: clk: realtek: add rtd1619 clock controller bindings
Date:   Tue, 3 Dec 2019 15:35:40 +0800
Message-ID: <20191203073540.9321-7-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203073540.9321-1-james.tai@realtek.com>
References: <20191203073540.9321-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cylee12 <cylee12@realtek.com>

Signed-off-by: Cheng-Yu Lee <cylee12@realtek.com>
Signed-off-by: James Tai <james.tai@realtek.com>
---
 .../bindings/clock/realtek,clocks.txt         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/realtek,clocks.txt

diff --git a/Documentation/devicetree/bindings/clock/realtek,clocks.txt b/Documentation/devicetree/bindings/clock/realtek,clocks.txt
new file mode 100644
index 000000000000..db101508ac6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/realtek,clocks.txt
@@ -0,0 +1,38 @@
+Realtek Clock/Reset Controller
+==============================
+
+Realtek CRT/ISO controller device-tree binding for Realtek Platforms.
+
+This binding uses the common clock binding[1].
+
+The controller node should be the child of a syscon node with the required
+propertise:
+
+- compatible :
+	should contain only one of the following:
+		"realtek,rtd1619-cc" for RTD1619 CRT clock controller,
+		"realtek,rtd1619-ic" for RTD1619 ISO clock controller,
+
+- #clock-cells : should be 1.
+
+- #reset-cells : should be 1.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Example:
+
+	crt@98000000 {
+		compatible = "realtek,rtd1619-crt", "simple-mfd", "syscon";
+		reg = <0x98000000 0x1000>;
+
+		cc: cc@98000000 {
+			compatible = "realtek,rtd1619-cc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+	};
+
+	consumer {
+		clocks = <&cc CC_CKE_GSPI>;
+	};
+
-- 
2.24.0

