Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7D62073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013833;
	bh=xcQmC0IgbKiXPgAFyLbz7jOycLcIgPwmOhouBbiyry4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rx3N0UJH4dxd7Iscjsmzt5U8V2/E0iJbPtZnhvYMJLZmJWVvVJ2pqUXCH+xYIr8wo
	 NfoBIIM6RuDf9WD4mlJigz0I1ohKSuj38shlMDV9t24LVMETmojeYEgDPJW049ENA2
	 m6xd9d+HdLlE1gJ5y+5DtFpoSEpkX4+iZMhgzzJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfLJVhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbfLJVfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:35:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE1C24653;
        Tue, 10 Dec 2019 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013736;
        bh=xcQmC0IgbKiXPgAFyLbz7jOycLcIgPwmOhouBbiyry4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgWk4eXayTg2j0zoEV0fYlGu2Pnq6EbS8TxvjG5IJ7BOtRyE0Rd34gIuuQzNkngOA
         PPiw0IFsncwPbe4d6YVhdfgt1v7L06HUE1A1qn36QZLWtjn1OyhTnyE4BTFfIl2B4Z
         r3CjgZeadFA6AYHNpMPOyZ3cU4Am1DdFgLoKMq14=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 160/177] ASoC: wm5100: add missed pm_runtime_disable
Date:   Tue, 10 Dec 2019 16:32:04 -0500
Message-Id: <20191210213221.11921-160-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit b1176bbb70866f24099cd2720283c7219fb4a81c ]

The driver forgets to call pm_runtime_disable in remove and
probe failure.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20191118073707.28298-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm5100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index ba89d9d711f76..b793701aafcda 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2620,6 +2620,7 @@ static int wm5100_i2c_probe(struct i2c_client *i2c,
 	return ret;
 
 err_reset:
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm5100);
 	wm5100_free_gpio(i2c);
@@ -2643,6 +2644,7 @@ static int wm5100_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm5100);
 	wm5100_free_gpio(i2c);
-- 
2.20.1

