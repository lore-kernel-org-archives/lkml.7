Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E8EC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94921655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJXleVLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgABKCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:02:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44192 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgABKCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:02:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so40165349lje.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 02:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vckSF9hpY/qz2kAzKmxateqNX/b2XwGcAzaPFz9WQdQ=;
        b=TJXleVLoHctBPaOFvOv6CBlbQzySi93ukWOTrbxAnVszwNIKvekkBg0kLqA/Up4QDV
         IXsPkEGu47pYf0YNuo6sxMZykuzzD5jaPAc8BuPdywUUNDWetq9pikeV3j5nRpZMqwAX
         xswDDZ+yBQuWLPOBjfrVlJRpNnWGck36vEQS9YHyPDKf1Il+KT08+InDmRVeaKayFOFX
         I9D05hcO10SbgtwKWh2RJQ5zuLfxZRdnIzR+jGy36CzzKWW76052OdreLrtr3rmRCwGZ
         dGecClihocL73d3Zv2bGBYerkBDXwsQMFwK2+R0YrQpXkwzpJhVhmZSJRJNVUqoxfq5D
         lzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vckSF9hpY/qz2kAzKmxateqNX/b2XwGcAzaPFz9WQdQ=;
        b=PCvjiWK5IUFCx0edAk10+nBXEIFf29PVh/7ZZRJDClpHibzvkz+MoaV+fdZ2CQCpzE
         ARGXB1s9OorAZWJqegO6qL3TMVJ6+o0KTtEe7SSNM9/FDOpYWOxNhckaTlgYsEplWp1W
         lz9HQw42Cr+fdh0vQO40AOcCV5xzdduea1NaWJtGShvEJDoecgODiHY44/9huNQNBN0G
         xTkJHYjhZPvO+kWjNQZz7CAaBflqhUTgPRoGnuErumeiDtWOZow12yvIF293E775TyVw
         AkfEH68LBLGAXZ+XTt3FcBrZwImh8Ao/Yp4W2GVpFblyEeYOneMZgV8D0coZAgHdS9Rz
         eMYQ==
X-Gm-Message-State: APjAAAWPkBzdGQQw6O9dX+y48GrxecpfroaJlImFStquzHMPBpcPq58D
        8uMinVHRoV2JokU6h7a3YOAzbiyG6rk=
X-Google-Smtp-Source: APXvYqy+OuS6PLVs/lm3LeFD0O7BF2v4S4kgM9bCjj1OccQ6dLHnyBdURAmyaNC9b1jbGsueQxOG3Q==
X-Received: by 2002:adf:df90:: with SMTP id z16mr86769792wrl.273.1577959364963;
        Thu, 02 Jan 2020 02:02:44 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id r6sm55418683wrq.92.2020.01.02.02.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 02:02:44 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/6] drm/etnaviv: determine product, customer and eco id
Date:   Thu,  2 Jan 2020 11:02:16 +0100
Message-Id: <20200102100230.420009-3-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102100230.420009-1-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They will be used for extended HWDB support. The eco id logic was taken
from galcore kernel driver sources.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 17 +++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  6 +++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index d47d1a8e0219..253301be9e95 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -321,6 +321,18 @@ static void etnaviv_hw_specs(struct etnaviv_gpu *gpu)
 		gpu->identity.varyings_count -= 1;
 }
 
+static void etnaviv_hw_eco_id(struct etnaviv_gpu *gpu)
+{
+	const u32 chipDate = gpu_read(gpu, VIVS_HI_CHIP_DATE);
+	gpu->identity.eco_id = gpu_read(gpu, VIVS_HI_CHIP_ECO_ID);
+
+	if (etnaviv_is_model_rev(gpu, GC1000, 0x5037) && (chipDate == 0x20120617))
+		gpu->identity.eco_id = 1;
+
+	if (etnaviv_is_model_rev(gpu, GC320, 0x5303) && (chipDate == 0x20140511))
+		gpu->identity.eco_id = 1;
+}
+
 static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
 {
 	u32 chipIdentity;
@@ -362,6 +374,8 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
 			}
 		}
 
+		gpu->identity.product_id = gpu_read(gpu, VIVS_HI_CHIP_PRODUCT_ID);
+
 		/*
 		 * NXP likes to call the GPU on the i.MX6QP GC2000+, but in
 		 * reality it's just a re-branded GC3000. We can identify this
@@ -375,6 +389,9 @@ static void etnaviv_hw_identify(struct etnaviv_gpu *gpu)
 		}
 	}
 
+	etnaviv_hw_eco_id(gpu);
+	gpu->identity.customer_id = gpu_read(gpu, VIVS_HI_CHIP_CUSTOMER_ID);
+
 	dev_info(gpu->dev, "model: GC%x, revision: %x\n",
 		 gpu->identity.model, gpu->identity.revision);
 
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

