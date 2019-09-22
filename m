Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3A7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D61320882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179611;
	bh=SJoa6ch7YWT88IzJRbD/Ujj7hZoK2RBN31oGU40WAAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6/BahY+QNEsqOzDEBkMlWXXghcfoULXqM/iuuuCNgdUMIMZE2RHWkDh7RPbDtVZt
	 MsZQdfBUt43jxojlf/rA3ulNULEkGV91jOQsdPGHrISQ5qvEkH4qK1zXX+YOJl0Gdn
	 qqZse4Vymv3igvC32IHnR78kZnBxUS91OoGyWD9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394861AbfIVS5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394823AbfIVS51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32EA214D9;
        Sun, 22 Sep 2019 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178646;
        bh=SJoa6ch7YWT88IzJRbD/Ujj7hZoK2RBN31oGU40WAAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5zyDQOpGUaLmF74egoNCP7KuuV7xh1ntP7tZ9XYosCfZ/SeyibkJeg0uvMFFKUcT
         NZlgWR8lJKtZPJ/RPRfcqCVSBHQCDeVddcl09oJrisqKwjVIF+bpo3mAlCJusLYH2C
         dWOiWFICPX0m3o2YJKQXDgGQHP3gYWU/+4Z5hjbA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 03/89] ASoC: sgtl5000: Fix charge pump source assignment
Date:   Sun, 22 Sep 2019 14:55:51 -0400
Message-Id: <20190922185717.3412-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

[ Upstream commit b6319b061ba279577fd7030a9848fbd6a17151e3 ]

If VDDA != VDDIO and any of them is greater than 3.1V, charge pump
source can be assigned automatically [1].

[1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/r/20190719100524.23300-7-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 0b11a2e01b2fc..b649675d190d2 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1084,12 +1084,17 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 					SGTL5000_INT_OSC_EN);
 		/* Enable VDDC charge pump */
 		ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP;
-	} else if (vddio >= 3100 && vdda >= 3100) {
+	} else {
 		ana_pwr &= ~SGTL5000_VDDC_CHRGPMP_POWERUP;
-		/* VDDC use VDDIO rail */
-		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
-		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		/*
+		 * if vddio == vdda the source of charge pump should be
+		 * assigned manually to VDDIO
+		 */
+		if (vddio == vdda) {
+			lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
+			lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
+				    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		}
 	}
 
 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
-- 
2.20.1

