Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA0C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4364120659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520653;
	bh=L7CXI+xo7ES4DhQ3F7635D6a/g88+0+Xx0Fty0LNODw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8jqDUJucISlmNWnav5FJqTuLr3jIyY54S+DG4nYuoH7UKex6HmOy8jO/udMTZ63N
	 Y03MS9eyjhCgxUAf7Id5GCxZV70tJnTbR15+KNwmTFy9C2yGHCB6P39Ifnvx4+/9V6
	 gGMv+as6pV6tAXlRrJ5CNn1la9SLs2Z9nYYAne2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfFZDoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfFZDoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:44:10 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-98.mobile.att.net [107.77.172.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB5020659;
        Wed, 26 Jun 2019 03:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520649;
        bh=L7CXI+xo7ES4DhQ3F7635D6a/g88+0+Xx0Fty0LNODw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=io0XUkpfnNoVvTkEi0DI7Bg4aUilOLN7hj28E3tF8XFHvb0ddX+eYlhBLaG1INxVh
         faAoA4WlfLedktT9qjo7dtGB8zyiVpxiWs57phzmpX/JBSRVlZ6WtJATYanye/iZS5
         5uLTOsz7V8TYm1pXx3CRRo3PPVBfxLRZf8zJW+es=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcus Cooper <codekipper@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/34] ASoC: sun4i-i2s: Fix sun8i tx channel offset mask
Date:   Tue, 25 Jun 2019 23:43:15 -0400
Message-Id: <20190626034335.23767-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034335.23767-1-sashal@kernel.org>
References: <20190626034335.23767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

[ Upstream commit 7e46169a5f35762f335898a75d1b8a242f2ae0f5 ]

Although not causing any noticeable issues, the mask for the
channel offset is covering too many bits.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a4aa931ebfae..5750738b6ac0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -110,7 +110,7 @@
 
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
-#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 11)
+#define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
 #define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
-- 
2.20.1

