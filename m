Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF570C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 15:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24A020748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 15:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgHR3+f5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfL2PFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 10:05:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36260 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfL2PFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 10:05:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so31110606ljg.3;
        Sun, 29 Dec 2019 07:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJFIpVK2l7JXb5O04n2/M1EaQnjqMlSNsPUjZ7jwbQg=;
        b=HgHR3+f5o25GXaOkOvlHmxuo1Bpvp6kkFLcbq666Z3/HlmCnCYnZzNCqKTxrMEzedU
         2VY8KPlckXzrh1PWs3kjkvEFSHkDjb3pp0FeuahToE+h6nA+u0D/AeYwX+L5Xxg7RHne
         5MObwlJrqutFM9qqw+fte556N7rci3/oKYmYljMf30u216eWu1VhEO+5DYnDh+qluQPj
         V0Y3iR9VrGrSoEmyKNf72sPOKCBF/8BfJKokB0AIRJWEbgeiu/Nt/vixARJDNwvXLl8z
         HpKoJNg6Vjn/WWEQMzfchTsJfRL7bjddFrwpsH9q4mkIV66/EV4ufWyf1zOOWkCUCsNY
         2nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RJFIpVK2l7JXb5O04n2/M1EaQnjqMlSNsPUjZ7jwbQg=;
        b=i3YSR91YtI7CXLsBwhLV2kRYkKiBUpX2PW23YNHGIi4EgIs3aGbpFasPArjXKGbEse
         Os4B9jje39glIvS/T22++62Q1d8DddDuvWY4zQYAcjt2UyLCZmIlwhMt9BgBSqSIGFur
         teLAbgVZHqeEIhki7/n5oLBfNpT7GeaAh4APQdm3C4cD9vCL6yPiWkZV+rCt0NmBX6jF
         fL8O0D2aqIpd6GxsK6BgyAT0wL6XACsEZp/+2LGm246xpVRPrnrzCGd3mFe2gmgDKrMn
         wCoWtnytwQ9v3LEmO0xkOhsjSGWFViNh7r2nZktcIF0GqODCm9mao01Pr7ggxSjThITu
         ed/w==
X-Gm-Message-State: APjAAAXhCkefaTxmwwjIC1nVA6xVPXDAFFzaGVPLEqbjcuj+WygvN7d5
        jF0uWH3SITs5Pxmwk0/BodQ=
X-Google-Smtp-Source: APXvYqxUYqdjm3+Kq4VoxnGBV1ftdbjy1Hm09N0pSP0z+s/IcVyFV6uvWfnNZngH3u5evG0k3D6ifQ==
X-Received: by 2002:a2e:844e:: with SMTP id u14mr34903503ljh.183.1577631946992;
        Sun, 29 Dec 2019 07:05:46 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d24sm16169472lja.82.2019.12.29.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 07:05:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: rt5640: Fix NULL dereference on module unload
Date:   Sun, 29 Dec 2019 18:04:54 +0300
Message-Id: <20191229150454.2127-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5640->jack is NULL if jack is already disabled at the time of
driver's module unloading.

 Unable to handle kernel NULL pointer dereference at virtual address 00000024
 ...
 (rt5640_set_jack [snd_soc_rt5640]) from [<bf86f7ed>] (snd_soc_component_set_jack+0x11/0x1c [snd_soc_core])
 (snd_soc_component_set_jack [snd_soc_core]) from [<bf8675cf>] (soc_remove_component+0x1b/0x54 [snd_soc_core])
 (soc_remove_component [snd_soc_core]) from [<bf868859>] (soc_cleanup_card_resources+0xad/0x1cc [snd_soc_core])
 (soc_cleanup_card_resources [snd_soc_core]) from [<bf86945f>] (snd_soc_unregister_card+0x47/0x78 [snd_soc_core])
 (snd_soc_unregister_card [snd_soc_core]) from [<bf8b4013>] (tegra_rt5640_remove+0x13/0x1c [snd_soc_tegra_rt5640])
 (tegra_rt5640_remove [snd_soc_tegra_rt5640]) from [<c0516d2f>] (platform_drv_remove+0x17/0x24)
 (platform_drv_remove) from [<c0515aed>] (device_release_driver_internal+0x95/0x114)
 (device_release_driver_internal) from [<c0515bd9>] (driver_detach+0x4d/0x90)
 (driver_detach) from [<c0514d59>] (bus_remove_driver+0x31/0x70)
 (bus_remove_driver) from [<bf8b4215>] (tegra_rt5640_driver_exit+0x9/0xdf4 [snd_soc_tegra_rt5640])
 (tegra_rt5640_driver_exit [snd_soc_tegra_rt5640]) from [<c019336f>] (sys_delete_module+0xe7/0x184)
 (sys_delete_module) from [<c0101001>] (ret_fast_syscall+0x1/0x28)

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/codecs/rt5640.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index adbae1f36a8a..b245c44cafbc 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2432,16 +2432,22 @@ static void rt5640_disable_jack_detect(struct snd_soc_component *component)
 {
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
-	disable_irq(rt5640->irq);
-	rt5640_cancel_work(rt5640);
+	/*
+	 * soc_remove_component() force-disables jack and thus rt5640->jack
+	 * could be NULL at the time of driver's module unloading.
+	 */
+	if (rt5640->jack) {
+		disable_irq(rt5640->irq);
+		rt5640_cancel_work(rt5640);
 
-	if (rt5640->jack->status & SND_JACK_MICROPHONE) {
-		rt5640_disable_micbias1_ovcd_irq(component);
-		rt5640_disable_micbias1_for_ovcd(component);
-		snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
-	}
+		if (rt5640->jack->status & SND_JACK_MICROPHONE) {
+			rt5640_disable_micbias1_ovcd_irq(component);
+			rt5640_disable_micbias1_for_ovcd(component);
+			snd_soc_jack_report(rt5640->jack, 0, SND_JACK_BTN_0);
+		}
 
-	rt5640->jack = NULL;
+		rt5640->jack = NULL;
+	}
 }
 
 static int rt5640_set_jack(struct snd_soc_component *component,
-- 
2.24.0

