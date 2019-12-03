Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F1CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DDC2073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7RcBsG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLCLNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:13:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32961 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfLCLNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:13:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay6so1584062plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPxVVC8nLDBEci1WSeW2S69uGVw9UleHZ5a7bu0I1Xs=;
        b=g7RcBsG1I43aqXOgX8NNWXdzwyKNnQzBaNigzS3hH9D+dPCt1yXrXC8KBQAxmAGw1V
         xIVzEZChlfDG+nQak288bYsUyD9FbjuWB5Hzwm9gi3Sc7px/7s/hrq5rBogS1I/+NkHs
         YlJ/+VAmQtSSMduDkdWU0dBpiA9oXDKOYfzFFxYwh8rKlAwK9S0R+nzfs0I5JMyJkcia
         VKZR8p9/KzWzukCGkgsTulEh7Q+hcEUGvxxswb3M63yMSulPhT32jXbFavKL4bQwnGny
         wl9QyR/fQTj4HCWqeF7iY3iuOaH5dRvExDdcoN2F9oeNqVKE+tn2djXq8qI967rtQEFd
         9lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPxVVC8nLDBEci1WSeW2S69uGVw9UleHZ5a7bu0I1Xs=;
        b=KQPy2JBuVCHHzxx1CWjwVTsJ6yDJp7HmS1cfYAZFF4q5Q4aKWdO3J7gv15MAT8ZbxD
         V/hFVSNU589YGzlgY7t289At/sFV5KFqdvXVnKceSHTq0m2CFFR6xzTNZ3HWujGGOEqB
         9M9JvcFxbYGcfku6wBHrJC3GwW9t1CLdJzjb2rkAFa4zLJxEavYnEyP4q6c1ZTRp48Y3
         Tt1dccOa/g2ECveTcTZbQSEqr9+FaEPOflQleM7GVkwkh4S7iogZLuUCffao8v7i/DgI
         Vcwev4lOIXWpc0GPvDVLd5rB2icNxwdOCDXdA7cTqb86wCs7kjwoLdrMJAQQQQstrjKI
         YhDA==
X-Gm-Message-State: APjAAAWyhSkSD1pOtdY49O61KSTjglI5PbE5cFYPegPdstA5T6gJ599Q
        jTlEtwb+91lYwjLRru+wAS4=
X-Google-Smtp-Source: APXvYqwVXNPxflvrN2v14hE+cqab22DeGQaHc2v2d7g8tdd1ATtAmfxDtIDe+nffB7gaEjuEQcQb5w==
X-Received: by 2002:a17:902:9692:: with SMTP id n18mr4397865plp.152.1575371596975;
        Tue, 03 Dec 2019 03:13:16 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id p5sm3160077pgj.63.2019.12.03.03.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 03:13:16 -0800 (PST)
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
Subject: [PATCH resend] ASoC: fsl_audmix: add missed pm_runtime_disable
Date:   Tue,  3 Dec 2019 19:13:03 +0800
Message-Id: <20191203111303.12933-1-hslester96@gmail.com>
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
index a1db1bce330f..5faecbeb5497 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -505,15 +505,20 @@ static int fsl_audmix_probe(struct platform_device *pdev)
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
 
@@ -521,6 +526,8 @@ static int fsl_audmix_remove(struct platform_device *pdev)
 {
 	struct fsl_audmix *priv = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_disable(&pdev->dev);
+
 	if (priv->pdev)
 		platform_device_unregister(priv->pdev);
 
-- 
2.24.0

