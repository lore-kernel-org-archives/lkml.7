Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C29FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D702221537
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199736;
	bh=5KpwBiolgatbtUkN/plbwqIBH7FRPYA+Rb8GfzJyAIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjPm2VMPMBDBAXwDcswrfGMY90LjKsm0k5oRkfG0BFqiHW9p2EzxLugef8RxvLmRV
	 XRr1IQG3tscwB7YuFcvsQVsderZswJVbaRkNXwe4p7Y7TDk0VIwxBJA6Cp68Y2UISH
	 g/VPIKhbJ4leJ+bGzd4rOqt/S6nklyhxG4zx7uHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbfGOOIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388601AbfGOOIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:08:53 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB4A206B8;
        Mon, 15 Jul 2019 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199733;
        bh=5KpwBiolgatbtUkN/plbwqIBH7FRPYA+Rb8GfzJyAIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6jKx/McLJmqFNphOt07cZg3HGaldw4lawm+uK0UEF/kjB4sdAQCJbqwMeZIhcuF+
         mUkgXRjzjNgYbNZvAeUBca6JYi2BqVzPbYT0B7dPgt3rzKOBf+bokP5r6wG0AhuWK6
         fPL78CeHPc3sInJXY6pDTUqPfql01PKcZTu9K4EQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.1 088/219] ASoC: meson: axg-tdm: fix sample clock inversion
Date:   Mon, 15 Jul 2019 10:01:29 -0400
Message-Id: <20190715140341.6443-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit cb36ff785e868992e96e8b9e5a0c2822b680a9e2 ]

The content of SND_SOC_DAIFMT_FORMAT_MASK is a number, not a bitfield,
so the test to check if the format is i2s is wrong. Because of this the
clock setting may be wrong. For example, the sample clock gets inverted
in DSP B mode, when it should not.

Fix the lrclk invert helper function

Fixes: 1a11d88f499c ("ASoC: meson: add tdm formatter base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
index e578b6f40a07..5774ce0916d4 100644
--- a/sound/soc/meson/axg-tdm.h
+++ b/sound/soc/meson/axg-tdm.h
@@ -40,7 +40,7 @@ struct axg_tdm_iface {
 
 static inline bool axg_tdm_lrclk_invert(unsigned int fmt)
 {
-	return (fmt & SND_SOC_DAIFMT_I2S) ^
+	return ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S) ^
 		!!(fmt & (SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_NB_IF));
 }
 
-- 
2.20.1

