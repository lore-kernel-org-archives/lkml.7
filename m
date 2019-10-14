Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE4EECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629DB20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfJNJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:24:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730677AbfJNJX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:23:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 170999F73C384615EB6A;
        Mon, 14 Oct 2019 17:23:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 17:23:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>,
        <jaska.uimonen@linux.intel.com>, <yuehaibing@huawei.com>,
        <yang.jie@linux.intel.com>, <yung-chuan.liao@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: SOF: Fix randbuild error
Date:   Mon, 14 Oct 2019 17:13:08 +0800
Message-ID: <20191014091308.23688-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LEDS_TRIGGER_AUDIO is m and SND_SOC_SOF is y,

sound/soc/sof/control.o: In function `snd_sof_switch_put':
control.c:(.text+0x587): undefined reference to `ledtrig_audio_set'
control.c:(.text+0x593): undefined reference to `ledtrig_audio_set'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5d43001ae436 ("ASoC: SOF: acpi led support for switch controls")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 41551e8..2c4abd4 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -36,10 +36,12 @@ static void update_mute_led(struct snd_sof_control *scontrol,
 
 	scontrol->led_ctl.led_value = temp;
 
+#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
 	if (!scontrol->led_ctl.direction)
 		ledtrig_audio_set(LED_AUDIO_MUTE, temp ? LED_OFF : LED_ON);
 	else
 		ledtrig_audio_set(LED_AUDIO_MICMUTE, temp ? LED_OFF : LED_ON);
+#endif
 }
 
 static inline u32 mixer_to_ipc(unsigned int value, u32 *volume_map, int size)
-- 
2.7.4


