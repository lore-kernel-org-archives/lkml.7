Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215F0C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA7D26A72
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEaO0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:26:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbfEaO0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:26:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7962C4FA4D3972CA4A7C;
        Fri, 31 May 2019 22:25:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 22:25:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>,
        <yingjiang.zhu@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ASoC: SOF: Intel: hda: Fix COMPILE_TEST build error
Date:   Fri, 31 May 2019 22:25:26 +0800
Message-ID: <20190531142526.12712-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while building without PCI:

sound/soc/sof/intel/hda.o: In function `hda_dsp_probe':
hda.c:(.text+0x79c): undefined reference to `pci_ioremap_bar'
hda.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'
hda.c:(.text+0x7c4): undefined reference to `pci_ioremap_bar'
hda.c:(.text+0x7c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e13ef82a9ab8 ("ASoC: SOF: add COMPILE_TEST for PCI options")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/intel/hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 68db2ac..c1703c4 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -231,7 +231,9 @@ static int hda_init(struct snd_sof_dev *sdev)
 
 	/* initialise hdac bus */
 	bus->addr = pci_resource_start(pci, 0);
+#if IS_ENABLED(CONFIG_PCI)
 	bus->remap_addr = pci_ioremap_bar(pci, 0);
+#endif
 	if (!bus->remap_addr) {
 		dev_err(bus->dev, "error: ioremap error\n");
 		return -ENXIO;
@@ -458,7 +460,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		goto hdac_bus_unmap;
 
 	/* DSP base */
+#if IS_ENABLED(CONFIG_PCI)
 	sdev->bar[HDA_DSP_BAR] = pci_ioremap_bar(pci, HDA_DSP_BAR);
+#endif
 	if (!sdev->bar[HDA_DSP_BAR]) {
 		dev_err(sdev->dev, "error: ioremap error\n");
 		ret = -ENXIO;
-- 
2.7.4


