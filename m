Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE660C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C204926782
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559298715;
	bh=gnWsYJXafTr4/ebtpkTMaILA8zE+1xeKW9QH7rg3lzY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Hurk6dR0o4en7pzUoVDNAi+ljr1SZgbOxhf0bVL68VrJC9PpJ9+/3QyrElHk1NtES
	 3mbSwF+vZeYsXA9zxK5abL9D7M7oqedgnnLrbfKh1Yz5GxP0ZOVaWd8/RJeNgV3XKN
	 96HfxjzJxc8m78A2n/lUbhEekYRh3b390A4Rd5mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfEaKby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfEaKby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:31:54 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2462677A;
        Fri, 31 May 2019 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559298713;
        bh=gnWsYJXafTr4/ebtpkTMaILA8zE+1xeKW9QH7rg3lzY=;
        h=From:To:Cc:Subject:Date:From;
        b=FUKoQH19LTF+SesZyFy8J0+ENSM97Nxg76R6Kf08tGhYALgjODVxh6x+YN9bPNYPA
         nNfJFxNYWyuuN1wwVuwdJ/QQV84N7XJY6hpPSTHQc/+cqbljN6Yg8MX0W/C+69ynn3
         B6MSOq2F2zwSDcdvmPCizxHT79hAF1mbLRK2oR7k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] Revert "ASoC: core: use component driver name as component name"
Date:   Fri, 31 May 2019 12:31:47 +0200
Message-Id: <1559298707-14903-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using component driver as a name is not unique and it breaks audio in
certain configurations, e.g. Hardkernel Odroid XU3 board where following
components are registered:
 - 3830000.i2s with driver snd_dmaengine_pcm
 - 3830000.i2s-sec with driver snd_dmaengine_pcm
 - 3830000.i2s with driver 3830000.i2s-sec

This reverts commit b19671d6caf1ac393681864d5d85dda9fa99a448.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/soc-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2d3520fca613..7abb017a83f3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3113,10 +3113,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 {
 	struct snd_soc_dapm_context *dapm;
 
-	if (driver->name)
-		component->name = kstrdup(driver->name, GFP_KERNEL);
-	else
-		component->name = fmt_single_name(dev, &component->id);
+	component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.7.4

