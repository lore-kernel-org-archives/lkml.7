Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B982C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EAE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="b6bRhEXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbfEWMvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41827 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfEWMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id q16so5340969ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddLsiPPlKYPqW2Yby2eWqxRHzPEpKsPV3+wkowCsdyY=;
        b=b6bRhEXzVgbOx5K9R9pU2BNCVNbwrPs53JANGU/s7do77nBoNf2Eogll37DyiI3d7x
         8IcjnRciLa8+8VRE3UkC16LAaLVT62NrJyGwPqYDQhf9jbVTwSaGGuvaLtyu0WIv4qxi
         R8Mw1Rn9zgmMLoKuQvra+PVTmOhDEm8gZ/zseT1xwCurwLRNz5NjSlhNYzTs086mOa1f
         UGkITa9BG+dfBCwLZko3T7nEBWJJVK6QDEwk/F+f4lA7iABXv+dJyeMLI//+OwQXePhY
         63ZpiNvqUz+wZtFuMFXlRDTqGzMD41QjAa2HVBvO0rVPR9Yggpcc+ugl3COcXBY41hty
         X1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddLsiPPlKYPqW2Yby2eWqxRHzPEpKsPV3+wkowCsdyY=;
        b=pzqmpFdoKWk9/EqJYnN+DDkLi6T5tE73ioI2txTLoCEB8RfyU7hYowFfrEo/J2SVH0
         d/A2tJ77mN66IJbEdrqLGmzAUCt0jICpZ6Ye3KZDaOZLStBcXgVtRswvMOcPPzts5N4S
         nUyEov6d1JATWyxe7qIznAWtV95p2Ph60r5YTPuz49fD1n0w1C/ygCFwRtsRCBdeUfRK
         Td72ZAXWIu0DKlBm8M8DkNCB6iUcYzG0w9RrOTZjMD5oAzU8N2oDemBLbA5kY2hkDIxW
         1Q7r3lWw1NWxi3aXutm93GX59ebIOvfvQZPOuE0DNBMJh3EQS5crSoEPyW5hyacnUC1N
         ylUQ==
X-Gm-Message-State: APjAAAXdncXeBa5fYc4e7uuY4Ec3toH5CAdJSnOoxI+XcFQ1NyEWfnXN
        BlvISdY5bDaMeIfxRBK6iTAdAyKhaCXMtQ==
X-Google-Smtp-Source: APXvYqwdvnBv/jd5U+HTO/R5bwSc0+253jnFz/eDpjqAYngSUxeGY+h58mhevhId1G4p4Tt426LDyg==
X-Received: by 2002:a2e:89cc:: with SMTP id c12mr41892922ljk.90.1558615910243;
        Thu, 23 May 2019 05:51:50 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:49 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] staging: kpc2000: fix alignment issues in cell_probe.c
Date:   Thu, 23 May 2019 14:51:38 +0200
Message-Id: <20190523125143.32511-5-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings "Alignment should match open parenthesis"
and "Lines should not end with a '('".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 34 +++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 945d8e4e7ba5..5b88504b00ec 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -128,15 +128,13 @@ static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 
 	cell.resources = resources;
 
-	return mfd_add_devices(
-		PCARD_TO_DEV(pcard),    // parent
-		pcard->card_num * 100,  // id
-		&cell,                  // struct mfd_cell *
-		1,                      // ndevs
-		&pcard->regs_base_resource,
-		0,                      // irq_base
-		NULL                    // struct irq_domain *
-	);
+	return mfd_add_devices(PCARD_TO_DEV(pcard),    // parent
+			       pcard->card_num * 100,  // id
+			       &cell,                  // struct mfd_cell *
+			       1,                      // ndevs
+			       &pcard->regs_base_resource,
+			       0,                      // irq_base
+			       NULL);                  // struct irq_domain *
 }
 
 
@@ -373,15 +371,13 @@ static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_re
 
 	cell.resources = resources;
 
-	return mfd_add_devices(
-		PCARD_TO_DEV(pcard),    // parent
-		pcard->card_num * 100,  // id
-		&cell,                  // struct mfd_cell *
-		1,                      // ndevs
-		&pcard->dma_base_resource,
-		0,                      // irq_base
-		NULL                    // struct irq_domain *
-	);
+	return mfd_add_devices(PCARD_TO_DEV(pcard),    // parent
+			       pcard->card_num * 100,  // id
+			       &cell,                  // struct mfd_cell *
+			       1,                      // ndevs
+			       &pcard->dma_base_resource,
+			       0,                      // irq_base
+			       NULL);                  // struct irq_domain *
 }
 
 static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
@@ -462,7 +458,7 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 			switch (cte.type) {
 			case KP_CORE_ID_I2C:
 				err = probe_core_basic(core_num, pcard,
-				KP_DRIVER_NAME_I2C, cte);
+						       KP_DRIVER_NAME_I2C, cte);
 				break;
 
 			case KP_CORE_ID_SPI:
-- 
2.20.1

