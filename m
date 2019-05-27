Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A01C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5ED20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="IFxJuXuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfE0L2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:28:20 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:45346 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfE0L2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:28:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 82E4841911;
        Mon, 27 May 2019 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1558956495; x=
        1560770896; bh=hXOGDL4taCvP1ithY6ztG6O+TLXxq3fYLx4Y5rx99Wc=; b=I
        FxJuXuZ3B761O2ZaPsK9sTEUtpSCGEkqp35iClcQ67KEZaJjPncOeUJLHnSnwTI4
        gcK60qmn8gFJd8h0QB5PYt+qat+QlSHvj7UjX+P+n95cwb78YRkmtaaCK0CzJT/V
        TSOhH4hY++ZiQXWBFu360g08/WCWv+5U5PmlGMy2Xc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mzR7FsWWSxkt; Mon, 27 May 2019 14:28:15 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8B78A404CB;
        Mon, 27 May 2019 14:28:13 +0300 (MSK)
Received: from bbwork.com (172.17.14.115) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 May 2019 14:28:13 +0300
From:   Alexander Filippov <a.filippov@yadro.com>
To:     <linux-aspeed@lists.ozlabs.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Filippov <a.filippov@yadro.com>
Subject: [PATCH] ARM: dts: aspeed: g4: add video engine support
Date:   Mon, 27 May 2019 14:27:53 +0300
Message-ID: <20190527112753.1681-1-a.filippov@yadro.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.14.115]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node to describe the video engine and VGA scratch registers on
AST2400.

These changes were copied from aspeed-g5.dtsi

Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 62 ++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 6011692df15a..adc1804918df 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -168,6 +168,10 @@
 					compatible = "aspeed,g4-pinctrl";
 				};
 
+				vga_scratch: scratch {
+					compatible = "aspeed,bmc-misc";
+				};
+
 				p2a: p2a-control {
 					compatible = "aspeed,ast2400-p2a-ctrl";
 					status = "disabled";
@@ -195,6 +199,16 @@
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
 
+			video: video@1e700000 {
+				compatible = "aspeed,ast2400-video-engine";
+				reg = <0x1e700000 0x1000>;
+				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
+					 <&syscon ASPEED_CLK_GATE_ECLK>;
+				clock-names = "vclk", "eclk";
+				interrupts = <7>;
+				status = "disabled";
+			};
+
 			gpio: gpio@1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
@@ -1408,6 +1422,54 @@
 	};
 };
 
+&vga_scratch {
+	dac_mux {
+		offset = <0x2c>;
+		bit-mask = <0x3>;
+		bit-shift = <16>;
+	};
+	vga0 {
+		offset = <0x50>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+	vga1 {
+		offset = <0x54>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+	vga2 {
+		offset = <0x58>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+	vga3 {
+		offset = <0x5c>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+	vga4 {
+		offset = <0x60>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+	vga5 {
+		offset = <0x64>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+	vga6 {
+		offset = <0x68>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+	vga7 {
+		offset = <0x6c>;
+		bit-mask = <0xffffffff>;
+		bit-shift = <0>;
+	};
+};
+
 &sio_regs {
 	sio_2b {
 		offset = <0xf0>;
-- 
2.20.1

