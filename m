Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F0DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81AB2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203421;
	bh=6vsR90dX+zeuY7yLntA9B8uR19cXJG+V+8a3ZxCUzOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IOhlQJGK1i8+5OVCUl9+mDnkenmGikwizto9Me6LiL8ytV576DUFdlkYW2rkIjlie
	 FNJArd+FTl9FyYbzuZ6dXLL4a3AqMS6GNXXvLDx6R5bCKLO579yGek6Ool8k328dyc
	 gSHYrayhCiv0H6LCyOziJdorO8OhoHDUFHby0Gjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfGOPKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732227AbfGONzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:55:47 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107D2217F4;
        Mon, 15 Jul 2019 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198946;
        bh=6vsR90dX+zeuY7yLntA9B8uR19cXJG+V+8a3ZxCUzOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrvheWHO4TN1PoMZ6qQlAdJpmkLCE6NyAzBHe70wxnewlqodl+2guCVvYCDn0mCVY
         DChol76H/USlH1qk/5wc6iMg4TJMCo6oGxFbZg8zjf8hebtq0jajgH9HqcEq3pmZ9s
         D1cDnNQNKfBEBhcE0qCGIC9HcDleCZtDtxfJ+Uq8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 149/249] ASoC: soc-core: call snd_soc_unbind_card() under mutex_lock;
Date:   Mon, 15 Jul 2019 09:45:14 -0400
Message-Id: <20190715134655.4076-149-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

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
index 41c0cfaf2db5..9138fcb15cd3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2837,14 +2837,12 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
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
@@ -2863,7 +2861,9 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
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

