Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D732C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534E5208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329495;
	bh=HHNhDCoYvb/eGrIgvq/2bmDTijiRR3BKwpoPkDX4ZG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lLE4K/QGjf4ZadP01HLCrz3w2AyW/kaWt+NzUjLgBUIzZOJh2U2AtJsS4GwEDR3jD
	 xgsWuxL1ez7t0+Xsa3T4An0HCCf9844dAUV3mqidNo+4pK3HC0gE/tJ2EAhySSezNk
	 RKjBBG2kxTr9FfNemBdLEj+nCHmAdsnmqAMPYgHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfD0Boy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbfD0BoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08F6216FD;
        Sat, 27 Apr 2019 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329458;
        bh=HHNhDCoYvb/eGrIgvq/2bmDTijiRR3BKwpoPkDX4ZG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKNGKMMCAETLHoZYyuAhyvUl7Z4fBuHuHr/xTTsdP/shsJNq4m9N7d0lVCPiOlhgX
         QtaMsJE7dBuG0vVzSxiGqmvu1qKYHpYIlz8LPqB2msQL6d7WlgyxLHPKn+COythcnD
         nFpVdTHf6LmWcW9J4TKuBAiAO+23Mpr+7CaLNJSo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Annaliese McDermond <nh6z@nh6z.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 4/8] ASoC: tlv320aic32x4: Fix Common Pins
Date:   Fri, 26 Apr 2019 21:44:07 -0400
Message-Id: <20190427014412.9091-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014412.9091-1-sashal@kernel.org>
References: <20190427014412.9091-1-sashal@kernel.org>
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
index 6ea662db2410..fdce75d5c675 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -234,6 +234,8 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN2_R"),
 	SND_SOC_DAPM_INPUT("IN3_L"),
 	SND_SOC_DAPM_INPUT("IN3_R"),
+	SND_SOC_DAPM_INPUT("CM_L"),
+	SND_SOC_DAPM_INPUT("CM_R"),
 };
 
 static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
-- 
2.19.1

