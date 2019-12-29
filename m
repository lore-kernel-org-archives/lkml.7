Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9629FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A9B222C3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642063;
	bh=Xy4RFfpP7UI71FN0VoyEB6JUALuIPsi8J5H+6qZxt5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JygEWCbXtXnYTCX6C26VH/Y7IzEodvVdtiaqd7SCwpeYXrxnx8uPqE0VEEIQ+99e7
	 BrST/1aHhw5WmWJY6GJjuQlqTW5QULoz/VNAV3kyTob6w4+kxDgBSQiWqO03J0UO8V
	 w87kZK8WB7LqQ6PZUfIwi7CrQGhe4YLqNB6PEL9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbfL2RyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732661AbfL2RyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:54:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8857520748;
        Sun, 29 Dec 2019 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642058;
        bh=Xy4RFfpP7UI71FN0VoyEB6JUALuIPsi8J5H+6qZxt5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCPSCsTmgsYLO5MEEUYL0AWlvynV7MbvmOfUEPj0uD5OlBznJY956S4tC7cI4m9Au
         +mBEKSvS/XVavnxSYfsiVQnS7JomYTsvAF3lB5t3oc4rcmfdQEWC5DDt7r6/vztYQn
         iC2v+ca+3cHV1Zh7AFO6uZskm+VAPUJiAhr2Ww5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 322/434] ASoC: wm5100: add missed pm_runtime_disable
Date:   Sun, 29 Dec 2019 18:26:15 +0100
Message-Id: <20191229172723.357824314@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4af0e519e623..91cc63c5a51f 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2617,6 +2617,7 @@ static int wm5100_i2c_probe(struct i2c_client *i2c,
 	return ret;
 
 err_reset:
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm5100);
 	wm5100_free_gpio(i2c);
@@ -2640,6 +2641,7 @@ static int wm5100_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 
+	pm_runtime_disable(&i2c->dev);
 	if (i2c->irq)
 		free_irq(i2c->irq, wm5100);
 	wm5100_free_gpio(i2c);
-- 
2.20.1



