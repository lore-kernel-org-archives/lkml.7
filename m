Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCACAC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BDF217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997768;
	bh=+zJK8Bk8taGoYfyoO82oj+hRVSPk19uqY00/kO0Y3DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEOmTkHPcI+hih/REEvPBFWcoGxREC/Oz7ieesf3vhniDv2uhrkY/jDcAASxAAyUc
	 zfMOyndcrMLng6Mv/HW/8FA/ACRFXQJTlpsC2UtkW5V64Dn2pxpAh+Ou7NBa6Ki+iu
	 14WnNXeW14yc6FOwiiMKYdKwpmSRi+0heEXLre5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391520AbfGXTt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391135AbfGXTtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:49:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB83222ADA;
        Wed, 24 Jul 2019 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997756;
        bh=+zJK8Bk8taGoYfyoO82oj+hRVSPk19uqY00/kO0Y3DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kn30C8V+pTdJqDYVrCe1pcUr4nlAAvR+IP4JzpcWGPn2pkjliSA5P/VShyc/q4GOb
         MgvpVanQw2WIQOYLddQEfFxRG6knz+9icKIH1WmIIXe/ztKZrQfilpHG0LTkmluziS
         gqpi3Tq7prpub13SOVZ1LtlWvTme4WehM9SXfFig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 133/371] ASoC: soc-core: call snd_soc_unbind_card() under mutex_lock;
Date:   Wed, 24 Jul 2019 21:18:05 +0200
Message-Id: <20190724191734.913535219@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b545542a0b866f7975254e41c595836e9bc0ff2f ]

commit 34ac3c3eb8f0c07 ("ASoC: core: lock client_mutex while removing
link components") added mutex_lock() at soc_remove_link_components().

Is is called from snd_soc_unbind_card()

	snd_soc_unbind_card()
=>		soc_remove_link_components()
		soc_cleanup_card_resources()
			soc_remove_dai_links()
=>				soc_remove_link_components()

And, there are 2 way to call it.

(1)
	snd_soc_unregister_component()
**		mutex_lock()
			snd_soc_component_del_unlocked()
=>				snd_soc_unbind_card()
**		mutex_unlock()

(2)
	snd_soc_unregister_card()
=>		snd_soc_unbind_card()

(1) case is already using mutex_lock() when it calles
snd_soc_unbind_card(), thus, we will get lockdep warning.

commit 495f926c68ddb90 ("ASoC: core: Fix deadlock in
snd_soc_instantiate_card()") tried to fixup it, but still not
enough. We still have lockdep warning when we try unbind/bind.

We need mutex_lock() under snd_soc_unregister_card()
instead of snd_remove_link_components()/snd_soc_unbind_card().

Fixes: 34ac3c3eb8f0c07 ("ASoC: core: lock client_mutex while removing link components")
Fixes: 495f926c68ddb90 ("ASoC: core: Fix deadlock in snd_soc_instantiate_card()")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c010cc864cf3..f05a5c0a8aff 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2834,14 +2834,12 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
 
-		mutex_lock(&client_mutex);
 		/* remove all components used by DAI links on this card */
 		for_each_comp_order(order) {
 			for_each_card_rtds(card, rtd) {
 				soc_remove_link_components(card, rtd, order);
 			}
 		}
-		mutex_unlock(&client_mutex);
 
 		soc_cleanup_card_resources(card);
 		if (!unregister)
@@ -2860,7 +2858,9 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
  */
 int snd_soc_unregister_card(struct snd_soc_card *card)
 {
+	mutex_lock(&client_mutex);
 	snd_soc_unbind_card(card, true);
+	mutex_unlock(&client_mutex);
 	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 
 	return 0;
-- 
2.20.1



