Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC091C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9373B20870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfHXVg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:36:27 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:28362 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfHXVg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:36:27 -0400
X-Greylist: delayed 1894 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Aug 2019 17:36:27 EDT
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7OL4Uwt036514;
        Sun, 25 Aug 2019 06:04:31 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sun, 25 Aug 2019 06:04:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7OL4RX5036503
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 25 Aug 2019 06:04:30 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] ASoC: es8316: limit headphone mixer volume
Date:   Sun, 25 Aug 2019 06:04:26 +0900
Message-Id: <20190824210426.16218-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch limits Headphone mixer volume to 4 from 7.
Because output sound suddenly becomes very loudly with many noise if
set volume over 4.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 8dfb5dbeebbf..bc4141e1eb7f 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -91,7 +91,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 	SOC_DOUBLE_TLV("Headphone Playback Volume", ES8316_CPHP_ICAL_VOL,
 		       4, 0, 3, 1, hpout_vol_tlv),
 	SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
-		       0, 4, 7, 0, hpmixer_gain_tlv),
+		       0, 4, 4, 0, hpmixer_gain_tlv),
 
 	SOC_ENUM("Playback Polarity", dacpol),
 	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL,
-- 
2.23.0.rc1

