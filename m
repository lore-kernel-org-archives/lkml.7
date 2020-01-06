Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098BFC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D539D20707
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCOJmgty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAFPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:17:10 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:44642 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgAFPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:17:08 -0500
Received: by mail-wr1-f53.google.com with SMTP id q10so11062766wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUwxOiOhiSQ3VOG4n1QnFltXQzpVdC2uxmpMrj0xBkc=;
        b=PCOJmgty2UfCC20tLSAKItsBGGNfhAFp9MiR0UN2fclGnrUKNLFIKZiIMJpeWasSuN
         Qm1S17jzAyiE7igAIAOXylPGRoT9d3jDBVpeVqzEjc/bcxQri859TL3k9w8y4GV34AYM
         iS3G+Dg6g+Sn8y6l10Yv1wAaI+OPe939JB5rShuFrOGALYtp0SHOafFvkEl63FZaiM2s
         JPoohPfYIEILm1+4jYqdF9UQXXtmPTshrL+13CRFgRBL3Emajrq9WsDuHlifV+OI9h/o
         0Dj3mFqALTsdN8CObvy70XykwF4K6F+1X15RcZsChGYuzjr6N2B88jv4S2ZVXVRbzqkv
         xuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUwxOiOhiSQ3VOG4n1QnFltXQzpVdC2uxmpMrj0xBkc=;
        b=dI6pqOYT2sFGFPmxAUhlg3yVyYUTC3fffb4dn3R2yhQZM479IxeXkfKIeWw7Rha49W
         KMIHygmY5n/9gh9KMfn8YJJ/0lBEEUlbb326gVCO9GySMldFkrLP6KwSIAJtJ6CGtj+y
         koT5lCGYUGBPUBqMYP6KOjj5ztJVwRD0xNR/3jmQ6ju+1qH99UKAhrujO0YV7QBLmCjP
         37XazonO0FzLPcAkxW5hOp6TEhxv2tnWrZsiEfUlszAMMxBz8xMtQITIMc1hq87pVZOb
         OpXHyufqvqWrVpvsMWJMksDmrppYMIgJffD+LLNKyqoFuCm+kfgfTxFtz5uJIXU70YEK
         4Tjw==
X-Gm-Message-State: APjAAAXgc3OA0Cx0t2Wc4NW6ScCgn9QdckUkvjcFs4CvjbvCCflezbXG
        Dbbrw1QUJ1A1S7K5TOliUig1B/YY4aXtXw==
X-Google-Smtp-Source: APXvYqwZTHfp7/9UpuUJ5e2RmJsHYcsq3NG3ozF29Zh4Ewv6OFoXbqjHzZhSbwIBr+b+2dBzGDZHuw==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr101269812wrs.369.1578323827088;
        Mon, 06 Jan 2020 07:17:07 -0800 (PST)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id l3sm72122463wrt.29.2020.01.06.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:17:06 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/6] drm/etnaviv: determine product, customer and eco id
Date:   Mon,  6 Jan 2020 16:16:47 +0100
Message-Id: <20200106151655.311413-3-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They will be used for extended HWDB support.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 11 ++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  6 +++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index d47d1a8e0219..7ee67e12141d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -333,9 +333,13 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
 		gpu->identity.revision = etnaviv_field(chipIdentity,
 					 VIVS_HI_CHIP_IDENTITY_REVISION);
 	} else {
+		u32 chipDate = gpu_read(gpu, VIVS_HI_CHIP_DATE);
 
 		gpu->identity.model = gpu_read(gpu, VIVS_HI_CHIP_MODEL);
 		gpu->identity.revision = gpu_read(gpu, VIVS_HI_CHIP_REV);
+		gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
+		gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);
+		gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
 
 		/*
 		 * !!!! HACK ALERT !!!!
@@ -350,7 +354,6 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
 
 		/* Another special case */
 		if (etnaviv_is_model_rev(gpu, GC300, 0x2201)) {
-			u32 chipDate = gpu_read(gpu, VIVS_HI_CHIP_DATE);
 			u32 chipTime = gpu_read(gpu, VIVS_HI_CHIP_TIME);
 
 			if (chipDate == 0x20080814 && chipTime == 0x12051100) {
@@ -373,6 +376,12 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
 			gpu->identity.model = chipModel_GC3000;
 			gpu->identity.revision &= 0xffff;
 		}
+
+		if (etnaviv_is_model_rev(gpu, GC1000, 0x5037) && (chipDate == 0x20120617))
+			gpu->identity.eco_id = 1;
+
+		if (etnaviv_is_model_rev(gpu, GC320, 0x5303) && (chipDate == 0x20140511))
+			gpu->identity.eco_id = 1;
 	}
 
 	dev_info(gpu->dev, "model: GC%x, revision: %x\n",
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 8f9bd4edc96a..68bd966e3916 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -15,11 +15,11 @@ struct etnaviv_gem_submit;
 struct etnaviv_vram_mapping;
 
 struct etnaviv_chip_identity {
-	/* Chip model. */
 	u32 model;
-
-	/* Revision value.*/
 	u32 revision;
+	u32 product_id;
+	u32 customer_id;
+	u32 eco_id;
 
 	/* Supported feature fields. */
 	u32 features;
-- 
2.24.1

