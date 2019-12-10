Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CCDC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C62077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012688;
	bh=WYoKBU214UXqNuhST1YXOag12Gny0tgpQVdsw1Xw43c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZPamzhCw3OaQb9tLQPUG9onKj2kIZvYjExSRCW5Ii/KeuuYRbN0/5HTxJP2BmH13w
	 AzFoXkEh9o5wr5XmKEl0KEPZ1RhF8qvjCOk93HEmSMrRHhvxAANBQdJFQq9YcunT+G
	 XxXTsQUs90zl9+kXjVXGIMoZqK/GCpxPBn9uPJFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfLJVSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbfLJVMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:12:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99DE2077B;
        Tue, 10 Dec 2019 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012365;
        bh=WYoKBU214UXqNuhST1YXOag12Gny0tgpQVdsw1Xw43c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM+AbpDhMAZlyEL7kJH3OKCpX9R+7fX8SRKcq6krtRx3j5lecRuhMYQtRaaYyv0zY
         Xq4spgOG1GcaPtZJdoqdbkfbJnHtv3nbj2BIFuGNXR6Hky/QzadhxLXMGTdVSPuiSG
         iYgGMVwUPn5eEZSkpzIDPa3cGwsc0wHbPjsFUvXU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Walle <michael@walle.cc>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 292/350] ASoC: wm8904: fix regcache handling
Date:   Tue, 10 Dec 2019 16:06:37 -0500
Message-Id: <20191210210735.9077-253-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

[ Upstream commit e9149b8c00d25dbaef1aa174fc604bed207e576d ]

The current code assumes that the power is turned off in
SND_SOC_BIAS_OFF. If there are no actual regulator the codec isn't
turned off and the registers are not reset to their default values but
the regcache is still marked as dirty. Thus a value might not be written
to the hardware if it is set to the default value. Do a software reset
before turning off the power to make sure the registers are always reset
to their default states.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20191112223629.21867-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8904.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index bcb3c9d5abf0c..9e8c564f6e9c4 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -1917,6 +1917,7 @@ static int wm8904_set_bias_level(struct snd_soc_component *component,
 		snd_soc_component_update_bits(component, WM8904_BIAS_CONTROL_0,
 				    WM8904_BIAS_ENA, 0);
 
+		snd_soc_component_write(component, WM8904_SW_RESET_AND_ID, 0);
 		regcache_cache_only(wm8904->regmap, true);
 		regcache_mark_dirty(wm8904->regmap);
 
-- 
2.20.1

