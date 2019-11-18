Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93356206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 02:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW+dGN+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfKRCrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 21:47:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40550 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfKRCrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:47:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id r4so9608629pfl.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 18:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RREC1ahvRFfGyw76l4ibA9bqTupLckMQgY54O0gStrA=;
        b=lW+dGN+REA8N1B3l0ms9i7xiFULF9g+HqA3J5bWNgPmMViTEGbfFiKZqRb5DNPvniM
         nkT58TrOQmBLhxqz49sqtU1r50FRvwWUPT/uPWPvWYritw8YmnvSZpe/N1jjluLp0brm
         RwPDgpC8hKxNR3WrYAwWt4JxVxPBgKZftCWLVMEi8APgIusbf/VGUjGjXu5nRU8DjCEM
         WHU4vKhL99/VhKPIN8xoM4nd64Fw6AT8Jio2hQFHW1ZhAhsLZxDe2BRmmyOEdUp1th7u
         KuDfTgX/yUS3Vcao+srvscZfjN4uEFanBlq73GkeXVvSCv8FODgJ4DaCMFGAgBWVMZO1
         3egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RREC1ahvRFfGyw76l4ibA9bqTupLckMQgY54O0gStrA=;
        b=pv4WaW5ElVEU+nyUQqwB1vfl7ygq+iMZIs0n4CSS4OoBrHiQY0Cbel3P/xgSEedEGk
         96/3iva5004FW4NraGjtC7jnAQZ5Odkmz23YeblVBpNAcXbXpXexK2Acrxm/xOLeoW/w
         RoyjGRsyHYhHHfMuZXpfmx7iv79xTF7ATq5eACSmvHP2Kib6yyxpRyKqXqmBTOjY1B3I
         vm225P6WINsoL/KCyHDwmefRLRLSkdIsF2UEOpMPCyPh0VCkGLEAfR0NRKNihMKFSiVe
         OZTUVU5LG3yuoaLJ8mIB3zxIJgiLNAso93OUlGbOIHtjIJQ4MkcqVJ6o1GTK7FfPyUY6
         M5MQ==
X-Gm-Message-State: APjAAAUFRAiHeOgjuyQfj1KozXgL2wdvYMCMrWKK/k2KXP188HFNbyf3
        +tbfeOD4N0+jkHMP+eIugrpEmJEI
X-Google-Smtp-Source: APXvYqwkWq6NxTkksNOXzjkY9PZHBW5+dMlAb/ErmHYmqKufTtuFkiVtJ9liXzA7erSbF37VU8yNcA==
X-Received: by 2002:a63:334f:: with SMTP id z76mr3320019pgz.277.1574045254633;
        Sun, 17 Nov 2019 18:47:34 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id x186sm20158760pfx.105.2019.11.17.18.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 18:47:33 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: fsl_audmix: add missed pm_runtime_disable
Date:   Mon, 18 Nov 2019 10:47:21 +0800
Message-Id: <20191118024721.21400-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/fsl/fsl_audmix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index c7e4e9757dce..57cad4365e56 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -499,15 +499,20 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		return ret;
+		goto err_disable_pm;
 	}
 
 	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
 	if (IS_ERR(priv->pdev)) {
 		ret = PTR_ERR(priv->pdev);
 		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
+		goto err_disable_pm;
 	}
 
+	return 0;
+
+err_disable_pm:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -515,6 +520,8 @@ static int fsl_audmix_remove(struct platform_device *pdev)
 {
 	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (priv->pdev)
 		platform_device_unregister(priv->pdev);
 
-- 
2.24.0

