Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D29ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8422082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWe3W8J0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404234AbfJQCu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:50:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34982 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbfJQCu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:50:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so391096plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBH7etPDsYjgS5BhMdpaKPc/Crn0//m1aMzm71ODCNQ=;
        b=WWe3W8J0p2jYm3Jgp8uyqXVx2DXPc5xEMRUw5652KX5FUo9zGfgs/FhgucBzo3mxth
         EL8GDPepsOkB/9w5yAg6FkZ3r3NnQNhMOFAMDu6HMehgah4+nhktKEw5nJiqhzLR4BzV
         I2mCIKX3mYS2SySi65+P6T9dYe2NombsqUncLakU2mU+mqYN7hDBwWCkiLgrnvadeGM1
         mMPKElo8K4+u6uxzM3cCnL9mNuTR3tQzZ9A//viv/TRZXnexdjG3CiA58RhpLnxJFK7d
         6baBx9RdOcV269dv9B+x5nqdY2/aUMJU/yTOUNfjtIDbtQ98FWAKJZb4MiFXoZFbKxdx
         BTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBH7etPDsYjgS5BhMdpaKPc/Crn0//m1aMzm71ODCNQ=;
        b=skXzTyekPY8c2uY0gimXAu8UYj3KQn99gMBdZxfWUL5rsdUm7PKGAO/zk29dpF5A1h
         smZFuxAKZpGfeFvdI+lWYz5AXPZLljb4q1tvgZ2HG5jCliWnFIaeCjyH5p7BnFrTLih3
         HI3PnYD649ZBMLoC8+A/5/4kvnMFS8VZJeBro1NwCzPRjGj1fjrigdXUiQKKCL3qJt6a
         wqAp31z+e6XcZo4NLAgLOs42a10KyxpOuNL2a/FwuGo4+F/tlHH0IQsn2eJlvVAgmR1Q
         ExCLP3BMxGEbguQBTRG0VJRYPruT4bC35vrHFJfmTRPqn2woaI3U5nZGC1oh07UTqMIK
         8kOQ==
X-Gm-Message-State: APjAAAW05kfuiqy+qdpAu8mn2dNWK1R5+ReocX/yLHwyYIkZUxP0kiVD
        F+AqriToSjABL0mNGK1NZsA=
X-Google-Smtp-Source: APXvYqyDe3E19e8X61V/mZ1VQbFs6VrITm5+ugiO4YwKQ5l7WNcqzD/ArSWMhPEL2ky6Z6hjtQDL+Q==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr341484plo.190.1571280657315;
        Wed, 16 Oct 2019 19:50:57 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id m4sm530714pjs.8.2019.10.16.19.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 19:50:56 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: Intel: sof-rt5682: add a check for devm_clk_get
Date:   Thu, 17 Oct 2019 10:50:44 +0800
Message-Id: <20191017025044.31474-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sof_audio_probe misses a check for devm_clk_get and may cause problems.
Add a check for it to fix the bug.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index a437567b8cee..6d15c7ff66bf 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -576,6 +576,15 @@ static int sof_audio_probe(struct platform_device *pdev)
 	/* need to get main clock from pmc */
 	if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
 		ctx->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		if (IS_ERR(ctx->mclk)) {
+			ret = PTR_ERR(ctx->mclk);
+
+			dev_err(&pdev->dev,
+				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
+				ret);
+			return ret;
+		}
+
 		ret = clk_prepare_enable(ctx->mclk);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
-- 
2.20.1

