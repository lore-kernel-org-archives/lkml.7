Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920BDC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DEB2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469068;
	bh=R9T1roOG9U3+aD1yPt52pLF+w7mQCmZcfvR9EUSyiu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mq40QlfH0IkjJubZghL6wXdTDPMdv7eNh+/QxfcsjuaMV/CAlAgbFrFcXgiDFMNVZ
	 lEoHWUrFKL9utVu0YoTinI4pIfhSOS3C35gwkXpMxXx/3TBnEMT5b7O+tl/zBv0tmp
	 SujVqWw+LhFYtSXgscr8gLm09/TGiPQB97HThsJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfL0RvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:51:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbfL0Rn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87096222C4;
        Fri, 27 Dec 2019 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468636;
        bh=R9T1roOG9U3+aD1yPt52pLF+w7mQCmZcfvR9EUSyiu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcMOn5hxpv8DMmwc0lvY+GNgnnOR7NKupNYIupq3bN/D/pm6eDmYz8yCEAO5hKlp2
         1Oly8Y4+l39IqcY4ht0c6VhQMPXoAOp3QztVGcz8yhFo/K2jjGtElLqTtqTiut6KHo
         6ihSiqRQ0b7WfP6KrqPOBM22TVH7Tq0r545Lf9gY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 03/84] ASoC: max98090: exit workaround earlier if PLL is locked
Date:   Fri, 27 Dec 2019 12:42:31 -0500
Message-Id: <20191227174352.6264-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzung-Bi Shih <tzungbi@google.com>

[ Upstream commit 6f49919d11690a9b5614445ba30fde18083fdd63 ]

According to the datasheet, PLL lock time typically takes 2 msec and
at most takes 7 msec.

Check the lock status every 1 msec and exit the workaround if PLL is
locked.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Link: https://lore.kernel.org/r/20191122073114.219945-3-tzungbi@google.com
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98090.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f8c8b9decab6..172a48d42479 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2126,6 +2126,8 @@ static void max98090_pll_work(struct work_struct *work)
 	struct max98090_priv *max98090 =
 		container_of(work, struct max98090_priv, pll_work);
 	struct snd_soc_component *component = max98090->component;
+	unsigned int pll;
+	int i;
 
 	if (!snd_soc_component_is_active(component))
 		return;
@@ -2145,8 +2147,16 @@ static void max98090_pll_work(struct work_struct *work)
 	snd_soc_component_update_bits(component, M98090_REG_DEVICE_SHUTDOWN,
 			    M98090_SHDNN_MASK, M98090_SHDNN_MASK);
 
-	/* Give PLL time to lock */
-	msleep(10);
+	for (i = 0; i < 10; ++i) {
+		/* Give PLL time to lock */
+		usleep_range(1000, 1200);
+
+		/* Check lock status */
+		pll = snd_soc_component_read32(
+				component, M98090_REG_DEVICE_STATUS);
+		if (!(pll & M98090_ULK_MASK))
+			break;
+	}
 }
 
 static void max98090_jack_work(struct work_struct *work)
-- 
2.20.1

