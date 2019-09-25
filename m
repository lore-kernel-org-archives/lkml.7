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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51496C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235F42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUsWDkCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633891AbfIYEIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:08:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46606 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbfIYEIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:08:53 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so10027568ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DgSgnjbaxWMj5EbcncKq9v8Ttw8yHLS0KwIgwEmsxew=;
        b=NUsWDkCxFK7gMFuKr6dUcowOwy4t4sfEiDCTzG2cQKkG+epD0Jl7OmNDHrpUFD8PeS
         yY46WH918Ts0dSNCVPltPt2ud4YFEthPq7A4OKpYVzm463qiUQARSwCDeoxc71UaB1yr
         /wEAxB+NtqEPtAb/oBhY6maErRI/iIlM9lcFj0EFCJbbi2PPk2I/x443CJXCBWmME3fQ
         oDolG4oUPtS49ad79YFFHM03LkzN214DsmkRsuldTsPX/rI/yAdJmyGKZl8fMUBNzdZc
         a7ZkiiGWXttbMxE+trb8xWrIa/N+/yX6kkltm6ayo5DvkYNQd2RRPeekayplLESMrdlX
         8MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DgSgnjbaxWMj5EbcncKq9v8Ttw8yHLS0KwIgwEmsxew=;
        b=IpWNh8a1LAqmM1dy1rJq9ag/a8eOj9xrc07SzbF10HiBO2HZuSkvyCEnbsPkVDoPSU
         WERkwkyEV8D2tMxpU9gxKvfG2vc3/WOZAocrCUG2oZ6Qc0UuDPMusepBFqPoAzYPwaSp
         s4Rea9/eBL5nOS7DdhlOEULv17AEQjPcUF23TFHoHmM70gf6ZlUNjjtHY9lzWQjt5LI7
         BtWVJYGhdqPUAn+O7wW+EBAwGi4dSVHhx80cXykohveXRI+14fUivVb86szZNXGSCwPj
         BTCzBBLWMNID5xmyeTfokaAayO+BtH/6gdyEN1CXL/ITfafXLC1DZodLZ3DGMkJORB9N
         leZA==
X-Gm-Message-State: APjAAAVi0YLpXgTv3GrgkEhxF0PP2ynWYFsu8JhhNfxUxP6zJYjBuQ4R
        rFMdT8pXBrGzeME+0gYDJ1c=
X-Google-Smtp-Source: APXvYqy90gGyOVD0TRAjkNHow/HCuhdXE4j/Z1008BqPZZsw6LI2uDTqlfBGsjmtr3R92X/GEIygGQ==
X-Received: by 2002:a6b:8f15:: with SMTP id r21mr8301163iod.259.1569384532039;
        Tue, 24 Sep 2019 21:08:52 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id p81sm47949ilk.86.2019.09.24.21.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 21:08:51 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Skylake: prevent memory leak in snd_skl_parse_uuids
Date:   Tue, 24 Sep 2019 23:08:38 -0500
Message-Id: <20190925040841.29141-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_skl_parse_uuids if allocation for module->instance_id fails, the
allocated memory for module shoulde be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index d43cbf4a71ef..d4db64d72b2c 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -299,6 +299,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
 		if (!module->instance_id) {
 			ret = -ENOMEM;
+			kfree(module);
 			goto free_uuid_list;
 		}
 
-- 
2.17.1

