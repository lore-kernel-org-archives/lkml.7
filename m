Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFDDFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7350820650
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214505;
	bh=TH9xCLF2rAa8rVklfhnNV7Qx4tBI5zCAyNdwfNZCEoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rh8k3QrGqyc5bXB+4zsTztljV8xh5w02juPSSKhv2NH7Khr4DiEkA/ZM9uxESI9rz
	 ZDyHGj9QLB9WNbsJq84YfULtqEVTHGA039nX7FH0BKz08QzravF/54r7FYi0MDnJdh
	 oX0rNmqQCiatkPrTidsUGzbEfxd9yO+TCPm0BFKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbfKHMBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731028AbfKHLng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC89F222CF;
        Fri,  8 Nov 2019 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213415;
        bh=TH9xCLF2rAa8rVklfhnNV7Qx4tBI5zCAyNdwfNZCEoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4DbY+5oj+SPzyQEAdChaw4+UerSDozNkPrFT++xIZUzo7Gx+d2zLHgloloxcO7M6
         nQLUwB1G0P9VRNUqGF67ET6n6a3kTro/5svdaL+bsRGFhKgwpSH5AGJjMLDIjScyDX
         uO0R5x5+nQww4D6xmCxrvWJNsDBQRZLKNEGh1js8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 018/103] ASoC: dpcm: Properly initialise hw->rate_max
Date:   Fri,  8 Nov 2019 06:41:43 -0500
Message-Id: <20191108114310.14363-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit e33ffbd9cd39da09831ce62c11025d830bf78d9e ]

If the CPU DAI does not initialise rate_max, say if using
using KNOT or CONTINUOUS, then the rate_max field will be
initialised to 0. A value of zero in the rate_max field of
the hardware runtime will cause the sound card to support no
sample rates at all. Obviously this is not desired, just a
different mechanism is being used to apply the constraints. As
such update the setting of rate_max in dpcm_init_runtime_hw
to be consistent with the non-DPCM cases and set rate_max to
UINT_MAX if nothing is defined on the CPU DAI.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 052b6294a4283..24047375c2fbb 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1578,7 +1578,7 @@ static void dpcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 				 u64 formats)
 {
 	runtime->hw.rate_min = stream->rate_min;
-	runtime->hw.rate_max = stream->rate_max;
+	runtime->hw.rate_max = min_not_zero(stream->rate_max, UINT_MAX);
 	runtime->hw.channels_min = stream->channels_min;
 	runtime->hw.channels_max = stream->channels_max;
 	if (runtime->hw.formats)
-- 
2.20.1

