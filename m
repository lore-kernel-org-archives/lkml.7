Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8EAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57126208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329526;
	bh=f1EeAGZqiG1bXuOBmY/pJT969bNvL+BPEZ77hN4GQis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hb7CeYhgLZ3pmOkDNFGMo6t7UyHpzoq1pPtLj5tAX+N3nezecx6LRsGmP7GcYsvQW
	 Y6v7p64c2zNMhnQCmFimo5sxWBrQI5UDHXivyzVaidH3XzM1IN8Lf0/+rCUFIoVH6U
	 gPjGFqI6k1iCwqMNdAo33ppXaNbPs+YgbFO48CL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfD0BpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfD0BoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70500215EA;
        Sat, 27 Apr 2019 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329442;
        bh=f1EeAGZqiG1bXuOBmY/pJT969bNvL+BPEZ77hN4GQis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLcZsx4tmSGwLNttSpCSKZkNKOEG4YN/KCIY/oGPXhIv8XBmgplMmQJXladq8WITt
         u38u6TbuBb19F81PP8lgm+ZJoJ9wyMC94aeYqWt6HFSNFm/Als4JOFyNefcrJGj9Ot
         hnXqBczUMK/YLC8FsVwQQH93uirK2YxIyxTOMb1A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Annaliese McDermond <nh6z@nh6z.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 4/9] ASoC: tlv320aic32x4: Fix Common Pins
Date:   Fri, 26 Apr 2019 21:43:49 -0400
Message-Id: <20190427014356.8940-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014356.8940-1-sashal@kernel.org>
References: <20190427014356.8940-1-sashal@kernel.org>
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
index f2d3191961e1..714bd0e3fc71 100644
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

