Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D79C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1092171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbfB1OYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:24:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfB1OYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:24:31 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0DC0AF8584C9BB86314B;
        Thu, 28 Feb 2019 22:24:29 +0800 (CST)
Received: from HSH1000045364.huawei.com (10.177.181.43) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 22:24:21 +0800
From:   Pengcheng Li <lipengcheng8@huawei.com>
To:     <xuwei5@hisilicon.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <john.stultz@linaro.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <lipengcheng8@huawei.com>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liyuequan@hisilicon.com>,
        <cash.qianli@hisilicon.com>, <huangli295@hisilicon.com>,
        <hantanglei@huawei.com>, <wangyoulin1@hisilicon.com>,
        <ninggaoyu@hisilicon.com>, <xuwei5@huawei.com>
Subject: [PATCH 3/3] arm64: dts: hi3660-hikey960: Add i2s & sound device
Date:   Thu, 28 Feb 2019 22:08:13 +0800
Message-ID: <1551362893-100023-1-git-send-email-lipengcheng8@huawei.com>
X-Mailer: git-send-email 2.8.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.181.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wangyoulin1@hisilicon.com>

Signed-off-by: Youlin Wang <wangyoulin1@hisilicon.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: Guangke Ji <jiguangke@huawei.com>
Signed-off-by: Feng Chen <puck.chen@hisilicon.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
Signed-off-by: Jun Chen <chenjun14@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Yiping Xu <xuyiping@hisilicon.com>
Signed-off-by: Pengcheng Li <lipengcheng8@huawei.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 186251f..457cebc 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -27,6 +27,35 @@
 		/* rewrite this at bootloader */
 		reg = <0x0 0x0 0x0 0x0>;
 	};
+
+	i2s2: hi3660_i2s {
+		compatible = "hisilicon,hi3660-i2s-1.0";
+		reg = <0x0 0xe804f800 0x0 0x400>,
+			<0x0 0xe804e000 0x0 0x400>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
+		dmas = <&asp_dmac 18 &asp_dmac 19>;
+		dma-names = "rx", "tx";
+		#sound-dai-cells = <0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "hikey-hdmi";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		sound_master: simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&adv7533>;
+		};
+	};
+
 };
 
 &uart5 {
-- 
2.8.0

