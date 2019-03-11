Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B869C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE4F2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335223;
	bh=4UC5z+Q1BHvLJgUw6vaGKjZq4pZcWogSpJv9iGOBE6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCWg3CT9N7EVsUTyfWxNThaJy4r9pJ993PzZE0F3MlIokMt92rNWJ/uqyu8Pbn9Sf
	 FxvKUz+buLGdX7vKP/IJwybPH22eBMZ8VIDNKcYREzN0fL4mqbN/M4J4mcd5XCj7rP
	 raKS6nzU5oiEDgiRsJj1olAIX+3w1ur57MMJSXB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfCKTzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbfCKTzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:55:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89FD82087C;
        Mon, 11 Mar 2019 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334122;
        bh=4UC5z+Q1BHvLJgUw6vaGKjZq4pZcWogSpJv9iGOBE6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7tpYaIiLMO14VPM8nD3MH6aBtft/8D6WSLXWufWaNMqzucRaxWfAs2ckZ0tU05oM
         Ow6ePWXqPdhZOgXnFcoz4lF7RYsUTh3jhg7qbqhQGOCkd9wE0vKIsR1rXd5Kx9caqa
         CAdS7hR9urklV6FY9QnkZuTtKC3W6LaHy3Idp87Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 05/52] ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA filter
Date:   Mon, 11 Mar 2019 15:54:29 -0400
Message-Id: <20190311195516.137772-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
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
index 34cfaf8f6f34..5760357a20a4 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1778,7 +1778,9 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
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

