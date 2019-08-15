Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB8EC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912E22086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565889340;
	bh=kWK+alEPi2rcLJi8pBPedwby2yf2OzYaedHyLGd1/Ms=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gUtyTTUQWjnHptRR/FQBKEdVXNU+zx0Iuhvh57xcLT+MC+cIjNRUIm6Mr/QAqxlDF
	 2A1Zy6UeLXReTlPWhmS2dYrvQDebDvq59a5qn9PGVZV2kVQisAVQkRXEeUEAGNUcT0
	 RJl6JXB5gOKyJvbUezSIcLfIBdztWhdlCAqDPJr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfHORPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:15:35 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:37004 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbfHORO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:14:27 -0400
Received: by mail-wm1-f99.google.com with SMTP id z23so1867499wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=+DSWXy6YR+0x+jeOKrcGm/4VoyxLyzX52Rt+viI5/nM=;
        b=cH76NXKaT/TmM52SOT2RGMmmR5nbXbH4RueKsGeHcs0GTDNDnEZ4cCRpAfEDPprOVs
         7mQ2NW12UgJHFM3VnEJ5KBBuJNqmpIXz4XVmAMMUBFsw5eGpmdVlXo8zJKzWSlGd91BP
         Sx3QSxkaC3DUE46WuMk8/SKvOQIPXFcl+fr+ITskA5vcwIT+gMFBTy+pkt3h+RdiCvwU
         BfP2T7oLby/u67r+DbjFGwrSPy6l2pekTGZocouTjqe8DZYY3kEaRywizF2cst0490K5
         ZN0nGsQgJ8xn3Eeb09k2PRjXpp/EIUaiRwQSDBbtYb6XEKgGk6z1bLskyKhc+WEALLEa
         OZiA==
X-Gm-Message-State: APjAAAVldsFviaiVocHkpdnH7UCtuWml6liTvuBfq36sKWoGA28bbcV7
        haU+l9aIxAQGZV6ApfsyD6dlJaX9FXBnx2AoA6It3aQ2vWb78mOng/lYynaGBhSj5Q==
X-Google-Smtp-Source: APXvYqw5tWIFYqhmPqKGUvwB4qSgZ40SOEwR1C7fyoTaB7QXcLgKdLeL+Z1f2Ziu2Ohfx2U9p12FNyPyFVFr
X-Received: by 2002:a1c:f101:: with SMTP id p1mr3664335wmh.62.1565889265208;
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id o6sm50502wrm.17.2019.08.15.10.14.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 10:14:25 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyJKS-00051e-Nn; Thu, 15 Aug 2019 17:14:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 409CF2742B9E; Thu, 15 Aug 2019 18:14:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, info@metux.net,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: max98371: remove unused variable 'max98371_noload_gain_tlv'" to the asoc tree
In-Reply-To: <20190815090404.72752-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190815171424.409CF2742B9E@ypsilon.sirena.org.uk>
Date:   Thu, 15 Aug 2019 18:14:24 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98371: remove unused variable 'max98371_noload_gain_tlv'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 9d22142c9b1ec8612b880121dd0bc27311cbb2b5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 15 Aug 2019 17:04:04 +0800
Subject: [PATCH] ASoC: max98371: remove unused variable
 'max98371_noload_gain_tlv'

sound/soc/codecs/max98371.c:157:35: warning:
 max98371_noload_gain_tlv defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190815090404.72752-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98371.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index ce801489a86d..dfee05f985bd 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -154,10 +154,6 @@ static const DECLARE_TLV_DB_RANGE(max98371_gain_tlv,
 	8, 10, TLV_DB_SCALE_ITEM(400, 100, 0)
 );
 
-static const DECLARE_TLV_DB_RANGE(max98371_noload_gain_tlv,
-	0, 11, TLV_DB_SCALE_ITEM(950, 100, 0),
-);
-
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -6300, 50, 1);
 
 static const struct snd_kcontrol_new max98371_snd_controls[] = {
-- 
2.20.1

