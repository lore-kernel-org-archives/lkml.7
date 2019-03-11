Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720262064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334912;
	bh=CPuUdiR2OMivTzM+pCD84oPlFKpY2JbUWLEh1eqXyiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LXgirvnjbvMZdzEkPAC2JJFlDL0+gjwKX8PDR3xNlZETobkse9GixOfJrKcVh4VD7
	 l5zrPRd3v6eb8wwgB2bXT/Fblsu+1r6cS2hQhKte2guwfp2hKkpTUa1zU8iARpHY+I
	 Dmr264u8DP0xS25+nLocWHlISFr54tad6ew1BqUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfCKUIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfCKT5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD50421738;
        Mon, 11 Mar 2019 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334226;
        bh=CPuUdiR2OMivTzM+pCD84oPlFKpY2JbUWLEh1eqXyiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YXFhIOMUfUMrRpjPu0WXyBdnJM18MwP4Jx7qFJjgorW26Is76UqrJsKfKeuh1iZai
         6eOZ28EumOiuHfGf8FNh5KOScZbc/zOgWOp+H5HtXs6KtOas6EPYYBmqAo0QcqGVvH
         3KpE0dQPhrH0rQ07ltRMVQ+xQz3tDz7YJ52Zp2u8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 05/44] ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA filter
Date:   Mon, 11 Mar 2019 15:56:21 -0400
Message-Id: <20190311195700.138462-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 8077ec011b1ea26abb7ca786f28ecccfb352717f ]

AD/DA ASRC function control two ASRC clock sources separately.
Whether AD/DA filter select which clock source, we enable AD/DA ASRC
function for all cases.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index afe7d5b19313..79ebcc239786 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1757,7 +1757,9 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"ADC Stereo1 Filter", NULL, "ADC STO1 ASRC", is_using_asrc},
 	{"DAC Stereo1 Filter", NULL, "DAC STO1 ASRC", is_using_asrc},
 	{"ADC STO1 ASRC", NULL, "AD ASRC"},
+	{"ADC STO1 ASRC", NULL, "DA ASRC"},
 	{"ADC STO1 ASRC", NULL, "CLKDET"},
+	{"DAC STO1 ASRC", NULL, "AD ASRC"},
 	{"DAC STO1 ASRC", NULL, "DA ASRC"},
 	{"DAC STO1 ASRC", NULL, "CLKDET"},
 
-- 
2.19.1

