Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A59AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CFD21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520754;
	bh=odmqd7N0vyTbULHtnRfBWJqYVpmDph2GFtV1HpPQYlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L/7xofbU+gaQmWuXXoKcM9Lnim2+jLTl7FYPn8QD2Q+UkXZgYDfJXSj6HuAE56tL7
	 ChLiDDI5uRTybWEyMYYrI8a+Me06thcWkuvs4PxS1Bj5E5uKiQ4yMUqsZy2gVaUrEZ
	 M3S/NparUH07CdYMnvW0NN73siWtZLkeNrrrV2jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfFZDpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbfFZDpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:45:45 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7882082F;
        Wed, 26 Jun 2019 03:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520744;
        bh=odmqd7N0vyTbULHtnRfBWJqYVpmDph2GFtV1HpPQYlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xiT1EYZUPzK6G/WgcLPn7TVYjCVHvyLcz6/ofsfZ/+ygrAmSJa8K3plZ0rhMCoks2
         3H/nzsEqvLDqzarCSYKjS/W//1ux/TXPpQtF7Y7ILaDRRwZGLEkvg0uVHy++IR3lQA
         zTv5TzUucEYjKs6TiZ5yBTJvHv24VjXxpeO7QlI0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/21] SoC: rt274: Fix internal jack assignment in set_jack callback
Date:   Tue, 25 Jun 2019 23:44:59 -0400
Message-Id: <20190626034506.24125-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034506.24125-1-sashal@kernel.org>
References: <20190626034506.24125-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 04268bf2757a125616b6c2140e6250f43b7b737a ]

When we call snd_soc_component_set_jack(component, NULL, NULL) we should
set rt274->jack to passed jack, so when interrupt is triggered it calls
snd_soc_jack_report(rt274->jack, ...) with proper value.

This fixes problem in machine where in register, we call
snd_soc_register(component, &headset, NULL), which just calls
rt274_mic_detect via callback.
Now when machine driver is removed "headset" will be gone, so we
need to tell codec driver that it's gone with:
snd_soc_register(component, NULL, NULL), but we also need to be able
to handle NULL jack argument here gracefully.
If we don't set it to NULL, next time the rt274_irq runs it will call
snd_soc_jack_report with first argument being invalid pointer and there
will be Oops.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt274.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index cd048df76232..43086ac9ffec 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -398,6 +398,8 @@ static int rt274_mic_detect(struct snd_soc_codec *codec,
 {
 	struct rt274_priv *rt274 = snd_soc_codec_get_drvdata(codec);
 
+	rt274->jack = jack;
+
 	if (jack == NULL) {
 		/* Disable jack detection */
 		regmap_update_bits(rt274->regmap, RT274_EAPD_GPIO_IRQ_CTRL,
@@ -405,7 +407,6 @@ static int rt274_mic_detect(struct snd_soc_codec *codec,
 
 		return 0;
 	}
-	rt274->jack = jack;
 
 	regmap_update_bits(rt274->regmap, RT274_EAPD_GPIO_IRQ_CTRL,
 				RT274_IRQ_EN, RT274_IRQ_EN);
-- 
2.20.1

