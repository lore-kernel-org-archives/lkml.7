Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9006CC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E67D206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwNLFIBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfDYTxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46849 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbfDYTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so346405pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lhsES5zrfmug+wtErL+IQRdyF1VD03Excx4/nk2IFg=;
        b=gwNLFIBD7Wlzfx1grISAVu4PM/6mAnUJ3raeI1DsQCgo9cxK6BUfEdhsW6huBUZqMY
         eyzBFsoEoHvoCD7+D2stG7psx3D/GJKWewnck0g6mQRId8LKle1QP7Pg839lD8zDlOzG
         b48ZslCc7V6r8729eh/R1JFiog6JjBW+hCnTzEO3K98cidLQV4tmE4SEkVkFLoCskxlE
         yZIL4orKRU4mD+y7Jc9+0IfIIPeHSOQa/BFFB/QNbP3s82jvXVtc1FGaq2R4TE8R3ogN
         THphlqzFAtjWEw3UldGknPLKqJlkQXzyeRN2+TSZUx+MSSolI4ExnGVzWK4nkcWXLNMv
         B7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lhsES5zrfmug+wtErL+IQRdyF1VD03Excx4/nk2IFg=;
        b=L+PHMK42GiaZ0Hq8AUcmSoaIFf6v503HSXt9ngaD4G+rT6O9OnygNIZN3JjWHPe5c0
         miUeYMDkKP/yLYc7lgJSesoYuuHcpyJRD4a9zhK5qEdfalg2/7OskLXwH89LBvSEVP7E
         IKP1z74b+H4d53cxIk/wTZO4Y9JfBMqXjRRgNUuEj9/VcjGZBQCUEOsVoDA5YZHj4WWH
         SOWQlVqjZTUF2M2gTYOAUPKsDZ60WfFIuH0mS/KpTTyiqqR0t2PwbbihJHoZ6JOFcRt6
         UUtLHqrwIwjHg2/FsPPet1ASATySjs5jG/vcyPn6u9Bu1RCZ/Eq4K81Zp29KK4S/jHmE
         QaBw==
X-Gm-Message-State: APjAAAX2pNb2SW0F/ne5ZEs4ObSBsv1Zmp7FWgjdv8gI483FWLFBWC8I
        F7L5OFkh8RF8LLNtmbny4SkLvw==
X-Google-Smtp-Source: APXvYqxIq85rShwEMf71gOmVMzHLyIwyEa4wPFvXqxorDVVEcqqJ7ORNmcQm7r46wHJOLIx/YPNJ8A==
X-Received: by 2002:aa7:8dc2:: with SMTP id j2mr3872589pfr.82.1556221996361;
        Thu, 25 Apr 2019 12:53:16 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/32] coresight: tmc: Report DMA setup failures
Date:   Thu, 25 Apr 2019 13:52:41 -0600
Message-Id: <20190425195310.31562-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If we failed to setup the DMA mask for TMC-ETR, report the
error before failing the probe.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 2a02da3d630f..647b6aa93554 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -340,6 +340,8 @@ static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
 static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 			     u32 devid, void *dev_caps)
 {
+	int rc;
+
 	u32 dma_mask = 0;
 
 	/* Set the unadvertised capabilities */
@@ -369,7 +371,10 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 		dma_mask = 40;
 	}
 
-	return dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(dma_mask));
+	rc = dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(dma_mask));
+	if (rc)
+		dev_err(drvdata->dev, "Failed to setup DMA mask: %d\n", rc);
+	return rc;
 }
 
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
-- 
2.17.1

