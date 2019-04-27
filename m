Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B193C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CA4214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329291;
	bh=h8OPelavcBE4oZDXTaPgCZCU7mi0JlrLwpgj2Egumho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S0tVnIRISQMD6Chs+rAuRtHLDu5N+INJhGwwLWWz3+0z10ooirISOazlbrWUtsF8Z
	 AoF120Fj1wlwZl2dXxBau/M2NMNxeuuZzPWcMPBek6lWNzB51jMwsoJQssLIh170b/
	 eiJmsru37U8C543zM5xM7SnuoIAgpTQOaT8hvU4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfD0Bl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbfD0Bl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9F0208CB;
        Sat, 27 Apr 2019 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329286;
        bh=h8OPelavcBE4oZDXTaPgCZCU7mi0JlrLwpgj2Egumho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWZCtL+Xcb92yIq9DX8YjqQ5fKKwBfc7YHpTQsbXp8UI7AJ8FSzsjahuaVQt3DqC4
         EcKMSMv7oOMT2+AL5ftPBWMhuz86qvH9pnbU6JjZnGjkNd1RBD3IRK5TmygsPkNlf1
         eGi/FONvChaclJRPt3r9T+2wJUhwDc+OX9+Z4Qec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Annaliese McDermond <nh6z@nh6z.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 22/53] ASoC: tlv320aic32x4: Fix Common Pins
Date:   Fri, 26 Apr 2019 21:40:19 -0400
Message-Id: <20190427014051.7522-22-sashal@kernel.org>
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

From: Annaliese McDermond <nh6z@nh6z.net>

[ Upstream commit c63adb28f6d913310430f14c69f0a2ea55eed0cc ]

The common pins were mistakenly not added to the DAPM graph.
Adding these pins will allow valid graphs to be created.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index f03195d2ab2e..45d9f4a09044 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -462,6 +462,8 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN2_R"),
 	SND_SOC_DAPM_INPUT("IN3_L"),
 	SND_SOC_DAPM_INPUT("IN3_R"),
+	SND_SOC_DAPM_INPUT("CM_L"),
+	SND_SOC_DAPM_INPUT("CM_R"),
 };
 
 static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
-- 
2.19.1

