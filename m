Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620ED21783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406565AbfHILDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:03:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406470AbfHILDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:03:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 40E64786FB91D940B113;
        Fri,  9 Aug 2019 19:03:48 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 19:03:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.intel.com>,
        <yang.jie@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] ASoC: SOF: Intel: Add missing include file hdac_hda.h
Date:   Fri, 9 Aug 2019 19:01:00 +0800
Message-ID: <20190809110100.71236-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190809095550.71040-1-yuehaibing@huawei.com>
References: <20190809095550.71040-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with SND_SOC_SOF_HDA_AUDIO_CODEC fails:

sound/soc/sof/intel/hda-bus.c: In function sof_hda_bus_init:
sound/soc/sof/intel/hda-bus.c:16:25: error: implicit declaration of function
 snd_soc_hdac_hda_get_ops; did you mean snd_soc_jack_add_gpiods? [-Werror=implicit-function-declaration]
 #define sof_hda_ext_ops snd_soc_hdac_hda_get_ops()

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Fixes: d4ff1b3917a5 ('ASoC: SOF: Intel: Initialize hdaudio bus properly")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unused include from hda.c
---
 sound/soc/sof/intel/hda-bus.c | 1 +
 sound/soc/sof/intel/hda.c     | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
index 0caec3a..1d2babd 100644
--- a/sound/soc/sof/intel/hda-bus.c
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -13,6 +13,7 @@
 #include "hda.h"
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+#include "../../codecs/hdac_hda.h"
 #define sof_hda_ext_ops	snd_soc_hdac_hda_get_ops()
 #else
 #define sof_hda_ext_ops	NULL
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 368254b..ebf2777 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -23,9 +23,6 @@
 #include <sound/sof/xtensa.h>
 #include "../ops.h"
 #include "hda.h"
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
-#include "../../codecs/hdac_hda.h"
-#endif
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 #include <sound/soc-acpi-intel-match.h>
-- 
2.7.4


