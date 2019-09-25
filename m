Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92294C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A2621D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb1Ahtlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505146AbfIYQTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:19:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40090 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502025AbfIYQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:19:31 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so250205iof.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pYuFsTmE9qWC6u6KXdDEvLyMfNpvMHyP60GEDsXUFKQ=;
        b=Fb1Ahtlgvzzd8Vr99WuUx1Ti9C44tJPTP98esoLjIYV+yybzKVwfcUMpFjq6/3iQXn
         Gs7et3XahZMUcOb6zgaYc3p/ypxRlvlve6v/mmSexYqQFfxJFFlIsKnuYmiICrxE9iM0
         jctEYuPeeMIjOGI8HRctYZ+L0mARkO4rSxMVQXqBvVcEsniJ4dvBtN9/hASws7T4jxhY
         Ifg8pGkIiQ0vsFeDD8VQOZziZ7DqmzLadUCD8aZrPY7sb81kZrYgh2eN5Ge0OkEKkE6M
         bM7jEBGX/IXghm/B3jCz7UiwlkHjj4GEyWL6S3Q52v8eFE5IxaCrqcLXz+o32jnACUif
         UhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pYuFsTmE9qWC6u6KXdDEvLyMfNpvMHyP60GEDsXUFKQ=;
        b=diTtYQPxiP/8L+eUv8ZqaMtMAGZ5IaYITBnUCnk6Dvhi07RAzCK5/DOv8Zq2GbWVJS
         joxu1sx/pyjYjykgbXTRuQGQqGYFWHgYnEvzZIIaQe7VaEX+ZQvtfP67pgDDMmHHpa2k
         v9jsc1yKxW7KOnxBK8fp1r+ewJwEa1/QdIQRTK10mSPUV8+usr4JufF4InU+dCA+OOcx
         /R2MkgJvtCemltHQSvKtKXl2mc72LOcKWvTmUwzKUCytPkL5z9bMrfNXAOxu5+FuDr44
         Hux6rHFeXQfqL2rpT6JLn1WE7y25HisFudJGQHfVDsRXGvGQzkWmBziMYMdwW96CDoIz
         72Ug==
X-Gm-Message-State: APjAAAXezwqcoLmQhN4R8/xvYcH3zco07gwErkoJBIBCi3cCECWOH4+1
        y09warvyGMb4PCqe85uHWCQ=
X-Google-Smtp-Source: APXvYqz3f5RaWcSwUBFX1RIICB2l1fWSvdzbPKCmBKFRAUbUiAOdy3nLr+2xYAn/o7Dx+Yce2bbyGw==
X-Received: by 2002:a5e:8f01:: with SMTP id c1mr174946iok.148.1569428370298;
        Wed, 25 Sep 2019 09:19:30 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id v70sm270115ilk.58.2019.09.25.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 09:19:29 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: Intel: Skylake: prevent memory leak in snd_skl_parse_uuids
Date:   Wed, 25 Sep 2019 11:19:19 -0500
Message-Id: <20190925161922.22479-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_skl_parse_uuids if allocation for module->instance_id fails, the
allocated memory for module shoulde be released. I changes the
allocation for module to use devm_kzalloc to be resource_managed
allocation and avoid the release in error path.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	- Changed the allocation for module from kzalloc to devm_kzalloc
---
 sound/soc/intel/skylake/skl-sst-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index d43cbf4a71ef..ac37f04b0eea 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -284,7 +284,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 	 */
 
 	for (i = 0; i < num_entry; i++, mod_entry++) {
-		module = kzalloc(sizeof(*module), GFP_KERNEL);
+		module = devm_kzalloc(ctx->dev, sizeof(*module), GFP_KERNEL);
 		if (!module) {
 			ret = -ENOMEM;
 			goto free_uuid_list;
-- 
2.17.1

