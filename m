Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7382BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE762084F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329667;
	bh=PkVDekx8eUsmbOODox79+S5igdMCYIWtoxFC6qo4G0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHPt6kLVnM7DhNmszmUTnJouqepw0FncG4IvGpq8C86t0CrsZoEiYlNgVcsHENSLe
	 ACD7MD0R3CN7Y2QW49u5FIrOvaAQeNxT6MPe0QeFepHqvBwD62OUpK9INsgYCqBIzE
	 cbFbDQdijdD3h+7cw1c6lH4Gpio+pmBvwIRhH2pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfD0Bmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfD0Bmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E262053B;
        Sat, 27 Apr 2019 01:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329357;
        bh=PkVDekx8eUsmbOODox79+S5igdMCYIWtoxFC6qo4G0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxTkgRqIYNubH2K+T3MVjehh71W64vfn0S13tA2TO+lOLpUkvO/zglojXvyiwsWF/
         Bz1m4fAzzFxmIGe+F2e7gXUoWlXFil02E3vBUkQgwhMZ0oeeSD9Br5tubeX7aPs9YV
         MdTZM7GGtMOYpMRXZspE7e3uwmlKHPl+D3EvZ8ns=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.14 07/32] ASoC: wm_adsp: Add locking to wm_adsp2_bus_error
Date:   Fri, 26 Apr 2019 21:41:58 -0400
Message-Id: <20190427014224.8274-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit a2225a6d155fcb247fe4c6d87f7c91807462966d ]

Best to lock across handling the bus error to ensure the DSP doesn't
change power state as we are reading the status registers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 67330b6ab204..d632a0511d62 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3711,11 +3711,13 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 	struct regmap *regmap = dsp->regmap;
 	int ret = 0;
 
+	mutex_lock(&dsp->pwr_lock);
+
 	ret = regmap_read(regmap, dsp->base + ADSP2_LOCK_REGION_CTRL, &val);
 	if (ret) {
 		adsp_err(dsp,
 			"Failed to read Region Lock Ctrl register: %d\n", ret);
-		return IRQ_HANDLED;
+		goto error;
 	}
 
 	if (val & ADSP2_WDT_TIMEOUT_STS_MASK) {
@@ -3734,7 +3736,7 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 			adsp_err(dsp,
 				 "Failed to read Bus Err Addr register: %d\n",
 				 ret);
-			return IRQ_HANDLED;
+			goto error;
 		}
 
 		adsp_err(dsp, "bus error address = 0x%x\n",
@@ -3747,7 +3749,7 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 			adsp_err(dsp,
 				 "Failed to read Pmem Xmem Err Addr register: %d\n",
 				 ret);
-			return IRQ_HANDLED;
+			goto error;
 		}
 
 		adsp_err(dsp, "xmem error address = 0x%x\n",
@@ -3760,6 +3762,9 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 	regmap_update_bits(regmap, dsp->base + ADSP2_LOCK_REGION_CTRL,
 			   ADSP2_CTRL_ERR_EINT, ADSP2_CTRL_ERR_EINT);
 
+error:
+	mutex_unlock(&dsp->pwr_lock);
+
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_bus_error);
-- 
2.19.1

