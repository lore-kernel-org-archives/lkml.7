Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C37C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8488924679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN1H8LBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLFHxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:53:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35480 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLFHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:53:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id w23so2410809pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QO+ulCytfHgL7qVYv09QqcQL+hLC3saTPny9UiLdvA=;
        b=qN1H8LBYbMmKIwNlI9yzqDRW2TyamGui3efbW/hiY6qegMZI6tvwZsels63TUNqDov
         ky6rAXJvi3QSSPnrul01cUfqF4sZ1EsVtg4L9+2Pdb7ZFuxVWaC8d73ezcr9Hrd8HkHG
         hW6zIFeDgEuxBWuYxYSqVkJWySSRbst0ZJIkdPyTo/NKNuzjhRJvK4A2KQoxf6IdJozY
         ee5KlI8s4ccDDP/OnlUDWkZ/Nxr49cFZZDaRdxxU9FL+9BpPuJQXedzcXL3sMqzhIeWV
         gKL4O/IY2wSfy5HAizvO7JByJiaNqqFIHP6bE7e88PeEUK5hVmCodAsiNNCWZIudtCRa
         juEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QO+ulCytfHgL7qVYv09QqcQL+hLC3saTPny9UiLdvA=;
        b=XnwZ0O5O1S7qi6aWtf1BNJdHFgFme8sqx+0VI4RxrwYUWWyiJEhKlpRqrDXGkqMDeE
         tB324PwSqmI+x+I2a6UOm0t9PeYe3s1pRbpUwbJqsnuVrixVRucthlWlVtFch9fI72Kz
         l+bYk9lkhB/kSo7CGCLsm3vipwdXMd4UKqvY/yg54e6fcZsYHL23cC4JfSkS1BeaeaB1
         4ZQW0Oi4IcdIFk5uCQqeWAlekA22WSPQTbpFNY96i1mCdpvS2KOojG6NHH7WoF/bZ1xY
         CmBYsVp7o31S62D5ywzv9ayMfyt1zvvUkSzoTE1OEio98TznnwMrvDq3OeVBJQuoWMbi
         rkAg==
X-Gm-Message-State: APjAAAWws5b9CxSH5ey0JqtqYifchcN9VgPjzm7Gr6D5zp3vbVzp5KqQ
        64iUt7OMKhIJ1Zc3R/pGh5k=
X-Google-Smtp-Source: APXvYqzUWI9hR0utwQQmr4dSL+uVpikqVFuARQHqDsWtZnT0kqMol7jeccCmFX6CmDqhW41doA88Cw==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr13035545plp.336.1575618791691;
        Thu, 05 Dec 2019 23:53:11 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id h68sm15999256pfe.162.2019.12.05.23.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:53:11 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: wm5100: add missed regulator_bulk_disable
Date:   Fri,  6 Dec 2019 15:53:00 +0800
Message-Id: <20191206075300.18182-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call regulator_bulk_disable() in remove like that
in probe failure.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/wm5100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 91cc63c5a51f..d985b2061169 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2653,6 +2653,8 @@ static int wm5100_i2c_remove(struct i2c_client *i2c)
 		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
 		gpio_free(wm5100->pdata.ldo_ena);
 	}
+	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
+			       wm5100->core_supplies);
 
 	return 0;
 }
-- 
2.24.0

