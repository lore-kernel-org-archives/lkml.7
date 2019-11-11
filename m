Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F601C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7641821783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R/yJgmMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfKKTAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:00:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37607 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfKKTAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:00:03 -0500
Received: by mail-io1-f67.google.com with SMTP id 1so15768771iou.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhEAgVLm+P8rhHN9pusEhxB3Gpt3621f2Po3YU/UUwo=;
        b=R/yJgmMr/2S7qSD+K9pcSjScnfyRn6UWrOGejP5RiTxt/sNQOdTM9B7OWOhMcaVt3t
         ibSB3lJvNB9oH7L1lQXQXctQaCpH8w2ezad/xezedla+04zMgzjaqnnoLjqQ5H4LZOAd
         1ZLJTdcQDIGD2vMlaigxFc7VKzsuHhhYBLkts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhEAgVLm+P8rhHN9pusEhxB3Gpt3621f2Po3YU/UUwo=;
        b=AloyMOXZ2741ulUt8eKEmAyR0NAECrEaFi9J+xltJUZTlH8CQuGjsHXtY41SXpOeRa
         OwKLX28CvLa936KzNL+pBOTUaa5wCwXC7DESprT50QEMzi7muV3QwymNC3lwd8QdMKYg
         EqzmovEyfAbCKUSPuU1vssp2kBmmsphqZ8EsC+aEmMuDCuMigKJiRlQA46lgjTSpqOMx
         DX21Nr4lQ0ehEe6ZY3+epExh/YjbXCXAyzqu9G7XroxM+cws3z4UNZoSw2s/jEZmS/ek
         SuYp9trEKgobOullDkSL+Hym1sjVbQOt4bPqWKGwasaGcVT7eRjiRwwLw6fs+iZR+PnM
         7nUQ==
X-Gm-Message-State: APjAAAXtpjnf7bKYmzNOMHWTX9ow882D+Ax+Q05WwG5C+yhN3AS3ONM1
        YwoMDbREj3dETocKZnfL6k9KSKhruDo=
X-Google-Smtp-Source: APXvYqyo7Q8K6RUwlo+CnztZm/Qp3lpGAcUrFfmId6PKdeVpoM18mw46U6gGH8wpeQSUmLq+L20G1A==
X-Received: by 2002:a5d:9c02:: with SMTP id 2mr25977293ioe.52.1573498802092;
        Mon, 11 Nov 2019 11:00:02 -0800 (PST)
Received: from localhost ([2620:15c:183:200:2bde:b0e1:a0d8:ffc6])
        by smtp.gmail.com with ESMTPSA id f9sm1394497ioq.80.2019.11.11.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:00:01 -0800 (PST)
From:   Jacob Rasmussen <jacobraz@chromium.org>
X-Google-Original-From: Jacob Rasmussen <jacobraz@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jacob Rasmussen <jacobraz@google.com>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH] ASoC: rt5645: Fixed buddy jack support.
Date:   Mon, 11 Nov 2019 11:59:57 -0700
Message-Id: <20191111185957.217244-1-jacobraz@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headphone jack on buddy was broken with the following commit:
commit 6b5da66322c5 ("ASoC: rt5645: read jd1_1 status for jd
detection").
This changes the jd_mode for buddy to 4 so buddy can read from the same
register that was used in the working version of this driver without
affecting any other devices that might use this, since no other device uses
jd_mode = 4. To test this I plugged and uplugged the headphone jack, verifying
audio works.

Signed-off-by: Jacob Rasmussen <jacobraz@google.com>
---
 sound/soc/codecs/rt5645.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a15e4ecd2a24..046f339a9f00 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3270,6 +3270,9 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		snd_soc_jack_report(rt5645->mic_jack,
 				    report, SND_JACK_MICROPHONE);
 		return;
+	case 4:
+		val = snd_soc_component_read32(rt5645->component, RT5645_A_JD_CTRL1) & 0x002;
+		break;
 	default: /* read rt5645 jd1_1 status */
 		val = snd_soc_component_read32(rt5645->component, RT5645_INT_IRQ_ST) & 0x1000;
 		break;
@@ -3603,7 +3606,7 @@ static const struct rt5645_platform_data intel_braswell_platform_data = {
 static const struct rt5645_platform_data buddy_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
-	.jd_mode = 3,
+	.jd_mode = 4,
 	.level_trigger_irq = true,
 };
 
@@ -4012,6 +4015,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 					   RT5645_JD1_MODE_1);
 			break;
 		case 3:
+		case 4:
 			regmap_update_bits(rt5645->regmap, RT5645_A_JD_CTRL1,
 					   RT5645_JD1_MODE_MASK,
 					   RT5645_JD1_MODE_2);
-- 
2.24.0.432.g9d3f5f5b63-goog

