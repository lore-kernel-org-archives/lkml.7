Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC2C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B8E20883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520593;
	bh=xjOj61j8dRKenT4sBMAUHgMw5sjHvxeGq/Du6LnwnSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqQ9EdpL2jhTMUEAD3MLvzqHqvzdtzchb49wt+g+KYV0lXMwEybFQkpDD3pJlb/HE
	 CEJF+j2DfTuGz8odlK1ipJhHOMgbjz/f6v5hw8pskcD0Qlzmpp5YP3VdrKuu5REO61
	 nYwts+JzmcvY4tUVvKsuqEbUUDgP06VTVe5pSn1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfFZDnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfFZDnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:43:03 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768F4216E3;
        Wed, 26 Jun 2019 03:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520582;
        bh=xjOj61j8dRKenT4sBMAUHgMw5sjHvxeGq/Du6LnwnSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQwoz8MLt4hfJYY2jgTlsw3hHT0vPHA5swl2Ui3cBENL3K3qYUWM0MmLlOpDlJZoj
         ct9xtnophgKzkin+Q/yZO9uGwNj1aSQxawEA3+dtA5CLwddspC0UOrDbnGB3hy53KH
         uCLNO8aVdTYux4Z+dtsc9k9R962VfHClH/RZjF04=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 38/51] ASoC: core: Fix deadlock in snd_soc_instantiate_card()
Date:   Tue, 25 Jun 2019 23:40:54 -0400
Message-Id: <20190626034117.23247-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 495f926c68ddb905a7a0192963096138c6a934e1 ]

Move the client_mutex lock to snd_soc_unbind_card() before
removing link components. This prevents the deadlock
in the error path in snd_soc_instantiate_card().

Fixes: 34ac3c3eb8 (ASoC: core: lock client_mutex while removing
link components)
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9df3bdeb5c47..c010cc864cf3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1008,14 +1008,12 @@ static void soc_remove_link_components(struct snd_soc_card *card,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 
-	mutex_lock(&client_mutex);
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
 		if (component->driver->remove_order == order)
 			soc_remove_component(component);
 	}
-	mutex_unlock(&client_mutex);
 }
 
 static void soc_remove_dai_links(struct snd_soc_card *card)
@@ -2836,12 +2834,14 @@ static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
 		snd_soc_dapm_shutdown(card);
 		snd_soc_flush_all_delayed_work(card);
 
+		mutex_lock(&client_mutex);
 		/* remove all components used by DAI links on this card */
 		for_each_comp_order(order) {
 			for_each_card_rtds(card, rtd) {
 				soc_remove_link_components(card, rtd, order);
 			}
 		}
+		mutex_unlock(&client_mutex);
 
 		soc_cleanup_card_resources(card);
 		if (!unregister)
-- 
2.20.1

