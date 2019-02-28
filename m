Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C77C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B5E214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbfB1OOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:14:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727773AbfB1ON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:13:59 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 62A53BE6DA68D04EEF05;
        Thu, 28 Feb 2019 22:13:57 +0800 (CST)
Received: from HSH1000045364.huawei.com (10.177.181.43) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Thu, 28 Feb 2019 22:13:49 +0800
From:   Pengcheng Li <lipengcheng8@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <john.stultz@linaro.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <lipengcheng8@huawei.com>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liyuequan@hisilicon.com>,
        <cash.qianli@hisilicon.com>, <huangli295@hisilicon.com>,
        <hantanglei@huawei.com>, <wangyoulin1@hisilicon.com>,
        <ninggaoyu@hisilicon.com>, <xuwei5@huawei.com>
Subject: [PATCH 2/3] ASoC: add hikey960-i2s DT bindings
Date:   Thu, 28 Feb 2019 21:57:41 +0800
Message-ID: <1551362261-99422-1-git-send-email-lipengcheng8@huawei.com>
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

Adds DT bindings documentation for
the hikey960-i2s driver and audio card device.

Signed-off-by: Youlin Wang <wangyoulin1@hisilicon.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: Guangke Ji <jiguangke@huawei.com>
Signed-off-by: Feng Chen <puck.chen@hisilicon.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
Signed-off-by: Jun Chen <chenjun14@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Yiping Xu <xuyiping@hisilicon.com>
Signed-off-by: Pengcheng Li <lipengcheng8@huawei.com>
---
 .../bindings/sound/hisilicon,hi3660-i2s.txt        | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt b/Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt
new file mode 100644
index 0000000..654c234
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt
@@ -0,0 +1,49 @@
+* Hisilicon 6210 i2s controller
+
+Required properties:
+
+- compatible: should be one of the following:
+   - "hisilicon,hi3660-i2s-1.0"
+- reg: physical base address of the i2s controller unit and length of
+   memory mapped region.
+- interrupts: should contain the i2s interrupt.
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain following:
+   - "dacodec"
+   - "i2s-base"
+- dmas: DMA specifiers for tx dma. See the DMA client binding,
+  Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should be "tx" and "rx"
+- hisilicon,sysctrl-syscon: phandle to sysctrl syscon
+- #sound-dai-cells: Should be set to 1 (for multi-dai)
+
+Example for the hi3660 i2s controller:
+
+	i2s2: hisi_i2s {
+		compatible = "hisilicon,hi3660-i2s-1.0";
+		reg = <0x0 0xe804f800 0x0 0x400>,
+			  <0x0 0xe804e000 0x0 0x400>;
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
-- 
2.8.0

