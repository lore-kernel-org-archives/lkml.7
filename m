Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7622C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20B2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4t2Dq/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfJIKWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:22:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37620 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfJIKWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:22:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so1927379wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sstpw1xzoTcys4bTI2z5iT/eq7Z/Z/zzCvHhmA4A8rU=;
        b=X4t2Dq/uhpHhMBk6MlJ5LGM/9j59VfzyXMcipbRZXLDmuFaszNoIi7uuNObDq9DKVI
         DZDbdXUxdsdQed/9mO21N71hPS9dduzZQKaflkEV+tTaQzsJD7Jdruo0u76ZHW2d0/xz
         rDTK/jP8jQL7cbpBPpdy8M/6R6ZTRV7cvjqkoK52SseFeXi5/hhmRyikwRLXZzK0tFg/
         aORskQ7zGOeMH36xr6NrI311cxs6oCR5SHTjsC1y8uN6ZyjAXZsBjmOfvDgkyC17adAq
         BuzrR368owE+VkR/zaqNESXB5Gokxx9bv+2GsZD1T67/y4W6k9amHdySCvP66sER4K5j
         isUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sstpw1xzoTcys4bTI2z5iT/eq7Z/Z/zzCvHhmA4A8rU=;
        b=pTY72Bwib2+FIrG4OYu8EfULEBBCeL2H5lgPoIeV4Ks3cPxVYOcwJz1+G6p+A/Yeps
         D6Rfh9QVVVfv7szoReGO2E15hATNJtMXdqELEnSOAIdWR15fY5Lnkb9BQfg0wuiesp6d
         LAtDXjydRnXqLLH5ZiMwopN0cumo+/i+HKaF4xd3KieH6omA5H2vFbhRDITxWcB3UnTE
         OEBOdriQig9Ek+v4spelTSx91XL0Ki15sUo0uOWpn76g1bj5OvWsdNXp/Y23hrwzbr6D
         uMdpnuyciX4VpIIQVTYvau7UiRQU6IrQXTGQCAjQNxDn0Rei/h3Ta+syuqzOeulTszSP
         m3Qw==
X-Gm-Message-State: APjAAAWDrKw6nhfqJW6JiaZ2T747ZdJeflm6lSzvF3GNL7EzRddlrVZB
        YqeFE9X6Uog4RD4a7ZY3WGXv8w==
X-Google-Smtp-Source: APXvYqySTdm1+ZynCCZE5I6c+aQVO46sCHFw7En9hCntPJymIhkKXfobUTWKUmKX2Hfeo1ALaRjGrA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr2036135wms.166.1570616556682;
        Wed, 09 Oct 2019 03:22:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q22sm1657407wmj.5.2019.10.09.03.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:22:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        vkoul@kernel.org, bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] ASoC: soc-dapm: Invalidate DAPM path during dapm addition of routes
Date:   Wed,  9 Oct 2019 11:21:27 +0100
Message-Id: <20191009102127.7860-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudheer Papothi <spapothi@codeaurora.org>

During sound card registration, dapm adds routes of
codec and other component paths, but the invalidation of
the widgets in these paths will happen only when the
sound card is instantiated. As these routes are added
before sound card instantiation, these widgets are
not invalidated until a playback or recording usecase
is started.

Audio playback or recording usecase is not started in
the case of codec loopback. So, if codec loopback is
performed just after soundcard registration, then the
widgets are not powered up as those widgets are not
invalidated, results into codec loopback failure.

Change is to remove the sound card instantiation check
condition in dapm add paths, so widgets get invalidated
whenever they are added.

Signed-off-by: Sudheer Papothi <spapothi@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-dapm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b6378f025836..13544f7c850b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2862,8 +2862,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 		dapm_mark_dirty(widgets[dir], "Route added");
 	}
 
-	if (dapm->card->instantiated && path->connect)
-		dapm_path_invalidate(path);
+	dapm_path_invalidate(path);
 
 	return 0;
 err:
-- 
2.21.0

