Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD48AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0BE2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="iTB6fj85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKLWgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:36:49 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:48261 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLWgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:36:49 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8E46223E5E;
        Tue, 12 Nov 2019 23:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1573598207;
        bh=ZQCAeIvVXoosI5EZ8z5kIox93/qG64eH4vjhPLAKDEU=;
        h=From:To:Cc:Subject:Date:From;
        b=iTB6fj85oF0ZhsoYtDOGYHj34i+UA5ro2SweiXUgFZck9fLcO3Pga1XqRnlRqStNB
         J4LFkgEL1XTkffZlv5EC6fHHP7Qx/uWTvbva86JOy2gJHR0WH1pi5QsgqBsiWRgtrn
         EWwoSs60a/xLq6h4p/W28ijJjslI882EOmIn/v5I=
From:   Michael Walle <michael@walle.cc>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] ASoC: wm8904: fix regcache handling
Date:   Tue, 12 Nov 2019 23:36:29 +0100
Message-Id: <20191112223629.21867-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code assumes that the power is turned off in
SND_SOC_BIAS_OFF. If there are no actual regulator the codec isn't
turned off and the registers are not reset to their default values but
the regcache is still marked as dirty. Thus a value might not be written
to the hardware if it is set to the default value. Do a software reset
before turning off the power to make sure the registers are always reset
to their default states.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 sound/soc/codecs/wm8904.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 2a7d23a5daa8..7d7ea15d73e0 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1933,6 +1933,7 @@ static int wm8904_set_bias_level(struct snd_soc_component *component,
 		snd_soc_component_update_bits(component, WM8904_BIAS_CONTROL_0,
 				    WM8904_BIAS_ENA, 0);
 
+		snd_soc_component_write(component, WM8904_SW_RESET_AND_ID, 0);
 		regcache_cache_only(wm8904->regmap, true);
 		regcache_mark_dirty(wm8904->regmap);
 
-- 
2.20.1

