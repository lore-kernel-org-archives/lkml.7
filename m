Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2952C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B3F2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329124;
	bh=Di+yDEjF/FXbuvnsbQVbBroYUrVIMoFYGcyRGjg9Abg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WXqqBFvTS9iGkPzGzmEDvUDqB8HFqQu2EAx4u2CX0a2mHSwGBYO1QpWLHfADNtMsB
	 0JBAX3oSLxNxXrG6q3o4yRWEcfMwyQ8qBlmPH2JVNinGvnx+LX0fLqvoH1RoVD4BQ1
	 REu42ek6rA8B/yxAlYKsnEWqHlx8PyZo/nLcnQ2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfD0Bim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfD0Bil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB2C82084F;
        Sat, 27 Apr 2019 01:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329120;
        bh=Di+yDEjF/FXbuvnsbQVbBroYUrVIMoFYGcyRGjg9Abg=;
        h=From:To:Cc:Subject:Date:From;
        b=d4DYIJY0tDiP3ki9ZuoPBUty1bmMM3Ns57mVTVcUI5joYG+EHZRjMdmU7luqcBuKa
         YUXf+IAk75WOFRnYWrFFpEnQJ51JoAZe1AeQUzdQys1eixIpQd98SKCPx9EbP+i3i6
         q8aA4uBfCD3yWLwY7gT9bwEvFJ+Ws69SkT8xrSpk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 01/79] ASoC: tlv320aic3x: fix reset gpio reference counting
Date:   Fri, 26 Apr 2019 21:37:20 -0400
Message-Id: <20190427013838.6596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Puschmann <philipp.puschmann@emlix.com>

[ Upstream commit 82ad759143ed77673db0d93d53c1cde7b99917ee ]

This patch fixes a bug that prevents freeing the reset gpio on unloading
the module.

aic3x_i2c_probe is called when loading the module and it calls list_add
with a probably uninitialized list entry aic3x->list (next = prev = NULL)).
So even if list_del is called it does nothing and in the end the gpio_reset
is not freed. Then a repeated module probing fails silently because
gpio_request fails.

When moving INIT_LIST_HEAD to aic3x_i2c_probe we also have to move
list_del to aic3x_i2c_remove because aic3x_remove may be called
multiple times without aic3x_i2c_remove being called which leads to
a NULL pointer dereference.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6aa0edf8c5ef..cea3ebecdb12 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1609,7 +1609,6 @@ static int aic3x_probe(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int ret, i;
 
-	INIT_LIST_HEAD(&aic3x->list);
 	aic3x->component = component;
 
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
@@ -1692,7 +1691,6 @@ static void aic3x_remove(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int i;
 
-	list_del(&aic3x->list);
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
@@ -1890,6 +1888,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		goto err_gpio;
 
+	INIT_LIST_HEAD(&aic3x->list);
 	list_add(&aic3x->list, &reset_list);
 
 	return 0;
@@ -1906,6 +1905,8 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
 
+	list_del(&aic3x->list);
+
 	if (gpio_is_valid(aic3x->gpio_reset) &&
 	    !aic3x_is_shared_reset(aic3x)) {
 		gpio_set_value(aic3x->gpio_reset, 0);
-- 
2.19.1

