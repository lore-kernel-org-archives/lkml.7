Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D7C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31AD21537
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329258;
	bh=2uVFUXWqcVtmdaSEQd7PH6cLrQjK0II3c/XbQwSg9hw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wDJ8knDB2mPeW0bSVfq1js1031DexIJbe98ItjFtSCAn8e5OPad9TBfPeb31zQLV+
	 gRHHQC8utXWWJHbgrQdzdrvHtnFk27O0jZAyJjlO3yyUrI8leCx4eXW0PnikVa/VqR
	 rWzRE2VJQHkGz2Bpja3vNs78ekWjtWAhgVYT9zRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfD0Bk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfD0Bkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C73208CB;
        Sat, 27 Apr 2019 01:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329253;
        bh=2uVFUXWqcVtmdaSEQd7PH6cLrQjK0II3c/XbQwSg9hw=;
        h=From:To:Cc:Subject:Date:From;
        b=O0FiFQnOSuInyx0J+yd9knTfqIrnq4iGjaHRxrGEQVVTDDagBCHQud/ETsOofKAvw
         m5AuZnQ9rRcsQ7hXf9NMgZ3mcW0ge8/QyGsj63hwoYUQFwHFiSvrTigCAR8koiQmYP
         L/9Tmcpx4QtubTuTHFEOcfuSi6VEFEZFhOhqCX6M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 01/53] ASoC: tlv320aic3x: fix reset gpio reference counting
Date:   Fri, 26 Apr 2019 21:39:58 -0400
Message-Id: <20190427014051.7522-1-sashal@kernel.org>
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
index 6a271e6e6b8f..6c0a3dad44b8 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1599,7 +1599,6 @@ static int aic3x_probe(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int ret, i;
 
-	INIT_LIST_HEAD(&aic3x->list);
 	aic3x->component = component;
 
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
@@ -1682,7 +1681,6 @@ static void aic3x_remove(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int i;
 
-	list_del(&aic3x->list);
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
@@ -1880,6 +1878,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		goto err_gpio;
 
+	INIT_LIST_HEAD(&aic3x->list);
 	list_add(&aic3x->list, &reset_list);
 
 	return 0;
@@ -1896,6 +1895,8 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
 
+	list_del(&aic3x->list);
+
 	if (gpio_is_valid(aic3x->gpio_reset) &&
 	    !aic3x_is_shared_reset(aic3x)) {
 		gpio_set_value(aic3x->gpio_reset, 0);
-- 
2.19.1

