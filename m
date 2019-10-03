Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B7C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A899E20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118919;
	bh=SJoa6ch7YWT88IzJRbD/Ujj7hZoK2RBN31oGU40WAAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ajWgYHODPVPStBAndz1tWIXllfUFgp8yRNXKeu9ClG0gRObCWrKxKdDGJSbQqulWC
	 VtmGoLjND5ijIxhXJ2z8iXh6AmGANl9VJEi8xuoltBogpA2HrjupmfsMQCGUEtg4IG
	 X5JAReAPGFOnvB2Y+I0Cax4C7OQ1CB/HOJ8TjLTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbfJCQIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733155AbfJCQI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:08:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB9420865;
        Thu,  3 Oct 2019 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118908;
        bh=SJoa6ch7YWT88IzJRbD/Ujj7hZoK2RBN31oGU40WAAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrYIfnLToqoIiUwjUIYIpObsg/4kiE+w150gRY09R+xaaX+McKXHLPzr6XgD21LSQ
         Z8fyrRCuGzWUjD6IM2kKOzcVFJfkB33CyQ2DXhg2IoBGnelPLPqZIridXC0P6UqQdg
         0fe23WICrsOc2dachQoCniTYXuG8U5Z0+zI1/VqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/185] ASoC: sgtl5000: Fix charge pump source assignment
Date:   Thu,  3 Oct 2019 17:52:13 +0200
Message-Id: <20191003154449.941253223@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



