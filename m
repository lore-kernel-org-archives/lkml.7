Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ED3C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5E22146E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329278;
	bh=4I64z/QoDH38doAQd0PCrHDbLM/yKjzvon4cotLSWGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qcgsZ252eeJJKYcXtAZoqL47673kFrEwhhYL4flgSC5JdzICwsHaqi1w3ybXZOaL5
	 Bm37W7x04HTlCG8vUIvn4r9sbqoWCdLQC0D957vS+XAmg8t1GHVcUCR96U1WqGhCiG
	 91DXS1mijYMWxEioBH/1TyZHvAg580TzX9+rYUbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfD0BlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfD0BlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7C8208CB;
        Sat, 27 Apr 2019 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329270;
        bh=4I64z/QoDH38doAQd0PCrHDbLM/yKjzvon4cotLSWGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxWR0R/XVN1NdwBwcCwqitE41zmxrcLYAO8aZru2nmATi+CyitDxqqvtJ1Lcmblfp
         PuY+1kVU7GMYjANlwbu9CSDEm7RpAGEhq+BBtfDhlMAnSTGeh7RiD5XBQcKBdU6G+m
         9Z9pzlIuofem4W+X8qT8lLM0IUA+YE2iFuua3IyA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.19 12/53] ASoC: wm_adsp: Add locking to wm_adsp2_bus_error
Date:   Fri, 26 Apr 2019 21:40:09 -0400
Message-Id: <20190427014051.7522-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
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
index 4d3ec295679d..2716022c6bc3 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3819,11 +3819,13 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
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
@@ -3842,7 +3844,7 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 			adsp_err(dsp,
 				 "Failed to read Bus Err Addr register: %d\n",
 				 ret);
-			return IRQ_HANDLED;
+			goto error;
 		}
 
 		adsp_err(dsp, "bus error address = 0x%x\n",
@@ -3855,7 +3857,7 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 			adsp_err(dsp,
 				 "Failed to read Pmem Xmem Err Addr register: %d\n",
 				 ret);
-			return IRQ_HANDLED;
+			goto error;
 		}
 
 		adsp_err(dsp, "xmem error address = 0x%x\n",
@@ -3868,6 +3870,9 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
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

