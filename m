Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A729C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A92F206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330145;
	bh=EORgHn6y+LW9CqXjwjHIfkrGzyJd3plfgq1dgFU7hb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fxkWwnvYEtywWU70RM6EL9YCwPXH+UddgoTbOEVqNrKnHiTkMlJSH+s557dYffwEu
	 aQ6xjsgzixrVw2N3VqmSQbctKJfeHaUQ6MA0qlH+KQbbCU+WMesXKeXevUK3FBdB1+
	 ROkGw8ROznB53wwrxk+k6QTmpGviVCbYt6D39tJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfD0BjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbfD0BjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C5220C01;
        Sat, 27 Apr 2019 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329142;
        bh=EORgHn6y+LW9CqXjwjHIfkrGzyJd3plfgq1dgFU7hb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDKJ1OaIRqvSNf110xJpSZMjNvb4YZKq43HiJUfv3Zfo6v4tgmJVo7CMnwHjs8Q0t
         423YaQ1cb0q39ocKXUCw27rK54lJLEE+6nl9hNF/NoNxmJjxysqbPhnCSJSoPbl2dG
         A5oQyFAeaI8tOQXKK2LwvrZvJ53cePVfXr0Zzczo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 20/79] ASoC: stm32: dfsdm: fix debugfs warnings on entry creation
Date:   Fri, 26 Apr 2019 21:37:39 -0400
Message-Id: <20190427013838.6596-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

[ Upstream commit c47255b61129857b74b0d86eaf59335348be05e0 ]

Register platform component with a prefix, to avoid warnings
on debugfs entries creation, due to component name
redundancy.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index 71d341b732a4..24948b95eb19 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -304,6 +304,7 @@ MODULE_DEVICE_TABLE(of, stm32_adfsdm_of_match);
 static int stm32_adfsdm_probe(struct platform_device *pdev)
 {
 	struct stm32_adfsdm_priv *priv;
+	struct snd_soc_component *component;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -331,9 +332,15 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iio_cb))
 		return PTR_ERR(priv->iio_cb);
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &stm32_adfsdm_soc_platform,
-					      NULL, 0);
+	component = devm_kzalloc(&pdev->dev, sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+#ifdef CONFIG_DEBUG_FS
+	component->debugfs_prefix = "pcm";
+#endif
+
+	ret = snd_soc_add_component(&pdev->dev, component,
+				    &stm32_adfsdm_soc_platform, NULL, 0);
 	if (ret < 0)
 		dev_err(&pdev->dev, "%s: Failed to register PCM platform\n",
 			__func__);
@@ -341,12 +348,20 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int stm32_adfsdm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_component(&pdev->dev);
+
+	return 0;
+}
+
 static struct platform_driver stm32_adfsdm_driver = {
 	.driver = {
 		   .name = STM32_ADFSDM_DRV_NAME,
 		   .of_match_table = stm32_adfsdm_of_match,
 		   },
 	.probe = stm32_adfsdm_probe,
+	.remove = stm32_adfsdm_remove,
 };
 
 module_platform_driver(stm32_adfsdm_driver);
-- 
2.19.1

