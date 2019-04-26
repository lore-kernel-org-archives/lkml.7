Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C73C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E82520679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dNgKICUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDZQrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:47:47 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52770 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDZQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:47:46 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so6907093itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqnKyrp3mArwKqL8dFKZ2FJ7oLbcOYhGCMtzg+mpDC0=;
        b=dNgKICUg+IWEQxdmdCtJcSez1ZKhkhiV71QuC+EpBG0rrvhfwciZwGars1KO58Cvx7
         cC/N/dbiY2Tk8bLLCVEjOPfJTHuhO/BOZBliSuw4Iu67sG25vzU1leEOdJ5g1qvPHpnJ
         OhqOFs8RWHCLFKgcenGaqdCJZzmSoaQKRVBPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqnKyrp3mArwKqL8dFKZ2FJ7oLbcOYhGCMtzg+mpDC0=;
        b=GQ5oAWQ8UxL9t77NhOvfucW7W+a5wiFOj4adXaLVv8uZMlRT3qOAU3Q9+YPqRwp5HW
         E18mkhZzqOuiPwsv69EpvHsSISuUoAlQrVkTCSHwiW9QTq+aQEmiecjHk0S8etdrdU6y
         4hLefwb9i160j73EyRXuhf14Iol/y5Rh9mBfIHcJptfFFCmgRkaP11HKkqdum8zO/CL4
         aBJ/f2uaBX+WX7PsgnFsGH0eX5FG/zIn3/HolfWrT/IfIphgv3Z3bnaakTgzza4ptZoy
         Znt/YgZwL5rDIk8XkVi884eKhZyiNwciIn/sMkmU2FxB+ArVt2nDdF+ltGA+OB1FT7xN
         x2cg==
X-Gm-Message-State: APjAAAWBoQKMnsh5GEo6xVXTyXamNSJYK0nm9BdAXRkVkY/Z8fdbpG6b
        5v8WcILURLf1ytUaEsW3YSTlzsnd9hPxIw==
X-Google-Smtp-Source: APXvYqy8i51neYtN3ZGXSleDs3Z783iB7tHbyaZ89nWCeKFCHDGb6h+c4WkCrQzNOBNX1Rk1Nh9slA==
X-Received: by 2002:a24:2fcb:: with SMTP id j194mr9671987itj.14.1556297265229;
        Fri, 26 Apr 2019 09:47:45 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id q22sm8856679ion.15.2019.04.26.09.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:47:44 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: avoid Oops if DMA setup fails
Date:   Fri, 26 Apr 2019 10:47:40 -0600
Message-Id: <20190426164740.211139-1-zwisler@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in sst_dsp_new() if we get an error return from sst_dma_new()
we just print an error message and then still complete the function
successfully.  This means that we are trying to run without sst->dma
properly set up, which will result in NULL pointer dereference when
sst->dma is later used.  This was happening for me in
sst_dsp_dma_get_channel():

        struct sst_dma *dma = dsp->dma;
	...
        dma->ch = dma_request_channel(mask, dma_chan_filter, dsp);

This resulted in:

   BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
   IP: sst_dsp_dma_get_channel+0x4f/0x125 [snd_soc_sst_firmware]

Fix this by adding proper error handling for the case where we fail to
set up DMA.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Cc: stable@vger.kernel.org
---
 sound/soc/intel/common/sst-firmware.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 1e067504b6043..9be3a793a55e3 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1251,11 +1251,15 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 		goto irq_err;
 
 	err = sst_dma_new(sst);
-	if (err)
+	if (err)  {
 		dev_warn(dev, "sst_dma_new failed %d\n", err);
+		goto dma_err;
+	}
 
 	return sst;
 
+dma_err:
+	free_irq(sst->irq, sst);
 irq_err:
 	if (sst->ops->free)
 		sst->ops->free(sst);
-- 
2.21.0.593.g511ec345e18-goog

