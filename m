Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E4EC04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AF12075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iXAwz7Uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfECTpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:45:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44345 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfECTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:45:51 -0400
Received: by mail-io1-f65.google.com with SMTP id v9so2288859ion.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aq2s3BnJgyxTeXCjYfqYbnyB07LuUnvkG9UrQRt2rnU=;
        b=iXAwz7Uf0odYcDlw8VydAoGs5uvncr1Fi5u8a46qCPcMqVkH2NdJwkSGgYPHJjJ+K+
         X9ezDz2GYUsNQ9xFNaXLGfRkIcFKpX3RHNBG8SZrZOzQTMk5mGGBSi3U6kdXQJxeGLQj
         cLCDrEbKt7i2uFLalnL6R5hExNEOlBZu+Tdew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aq2s3BnJgyxTeXCjYfqYbnyB07LuUnvkG9UrQRt2rnU=;
        b=DY9huvazcs2cs8qQCq9RyeVelfPy2kVC/E0/qWCstQ9iUmzn61X2bhlQ1C32PjTGvm
         6Z2XpjSePV6qrjY9f2u4+mgZyH/TIdJGuavFNp7ce2FpdsW1H8x00Ko/EHCOJFmwOQlW
         ox4UMGn2MPgb7wWy/ffvucuNncwmcL8bxTA0zV/xrUDsUJhlHjVcF8SNxblKMivFX4b8
         4FgPvoOGvKmQdvXdqMZnlLrhO3E8PbN8tufK75B2MI3qWmqEl/6lcn4iEdhKWDSVYva1
         THzMSMxktieMO6+3scKRDMF9gajJLjMEHUSEO1UjUAdYbGRAzuGGwAbiGesaTC40POva
         ca5A==
X-Gm-Message-State: APjAAAUzVfhcIhKh67toRDbSLfTjQC6dno1EuUYRVykvpQ8azKRqE8qj
        jDiuU50HnYZQgDpKEhk2w1gUxA==
X-Google-Smtp-Source: APXvYqx/c9CPkqgGv7GR57M5SbQdUCUtT77i9nI+z4D/o1f4q7bwVxYuDTtpqUfJNKEKDBQ66kDAWw==
X-Received: by 2002:a6b:e616:: with SMTP id g22mr482428ioh.231.1556912750752;
        Fri, 03 May 2019 12:45:50 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id 81sm1347273itd.41.2019.05.03.12.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 12:45:49 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [linux-4.4.y PATCH] ASoC: Intel: avoid Oops if DMA setup fails
Date:   Fri,  3 May 2019 13:45:03 -0600
Message-Id: <20190503194503.77923-1-zwisler@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190429182710.GA209252@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Zwisler <zwisler@chromium.org>

commit 0efa3334d65b7f421ba12382dfa58f6ff5bf83c4 upstream.

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

This change only affects Haswell and Broadwell systems.  Baytrail
systems explicilty opt-out of DMA via sst->pdata->resindex_dma_base
being set to -1.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Cc: stable@vger.kernel.org
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---

The upstream patch applied cleanly to all stable trees except
linux-4.4.y and linux-3.18.y.  This is the backport for linux-4.4.y, and
the code I'm fixing was introduced in v4.0 so there is no need for a
linux-3.18.y backport.

The upstream patch is currently in Mark Brown's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next

Is that good enough, or should I resend after it's been merged in the
v5.2 merge window?

---
 sound/soc/intel/common/sst-dsp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index c9452e02e0dda..c0a50ecb6dbda 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -463,11 +463,15 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 		goto irq_err;
 
 	err = sst_dma_new(sst);
-	if (err)
-		dev_warn(dev, "sst_dma_new failed %d\n", err);
+	if (err)  {
+		dev_err(dev, "sst_dma_new failed %d\n", err);
+		goto dma_err;
+	}
 
 	return sst;
 
+dma_err:
+	free_irq(sst->irq, sst);
 irq_err:
 	if (sst->ops->free)
 		sst->ops->free(sst);
-- 
2.21.0.1020.gf2820cf01a-goog

