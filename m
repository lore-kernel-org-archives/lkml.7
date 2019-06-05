Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7079C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911F320665
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXLvHLvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfFEP50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:57:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35297 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFEP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:57:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so4207012wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rA3vsfkqh5egWjaPGw3fMqsipviOktraHdbK2Sevo6Y=;
        b=oXLvHLvSuyfl/Z/VI+0HDmZgPfI+F4hbIyIsIG8r7tpFLSFtGqk6BbXnPscyq7zpPU
         R8bR2osq0wXH6QL6oDEfPdCDD4PHsOnJxrsfSMX9Amze/IdsUv2hTcKLf7Ijrdo2sAmY
         FkIjL1KgCvH7faWhP4fkS8spjRwEIbg8EPUMCBMAoBoMi0vGVEVxgRZb1pQ1fz6NFc2u
         aAesJiFSkX0+HAdvO9f/6BZF5RwEoWEcBssFQXUDhuEaNa/WMiaiRqHjVSmS+BNdGMtA
         SEm5jeimDTDsBAkZsc04+khhWfqmc+uvb6AE5Z0UGCCcYoKXjllAu4kSzFnLCS164W2M
         fCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rA3vsfkqh5egWjaPGw3fMqsipviOktraHdbK2Sevo6Y=;
        b=Hc+nyqgMsn1eFCsophheM1DOMIWtbAr4HzmSsypkpdInK49GZER+150t04ncrfOIkD
         pdfI2/xGsq06IbH60VNDg8qK7SJAMZ2NGhdW5j6ZBfE0cLzHHMlmozdu+ulmOUtaKc1W
         Q5m1Yd7pqx0D3ysLMePerf7ZnAeNykrxLbTFV+IdEAtgCyZxaE9+ZDWTrGkrikuRQFT2
         zF/ixM9wt9i3DZBqpAIviOgWgUhmnoqF2mPtaBasjF848ltg4YImTZeK/gFP+IseQIcW
         XfCIXUn6qddU3nKnEaxsiYe1Uw5boVcRFrXGrMFmmDbpwaxlbIyO9Emev4JcBCvvqljZ
         zJNg==
X-Gm-Message-State: APjAAAWtduZJCozG4sYKE/riCgFG0SkE3avKVdNqxdVOTEwGJ96ZvPE9
        u+zHa6TU4LSSAKb5PRU1SSJyDB32
X-Google-Smtp-Source: APXvYqxXNHjHrDbXIYSo93UBNPu5T5NR6YJpRDCej4BTK/2kDPXmTy3BCC3tETHUKya5d0J7bosZSQ==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr731522wrq.137.1559750244732;
        Wed, 05 Jun 2019 08:57:24 -0700 (PDT)
Received: from localhost.localdomain (host228-128-static.243-194-b.business.telecomitalia.it. [194.243.128.228])
        by smtp.googlemail.com with ESMTPSA id j123sm30845556wmb.32.2019.06.05.08.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:57:24 -0700 (PDT)
From:   Valerio Genovese <valerio.click@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valerio Genovese <valerio.click@gmail.com>
Subject: [PATCH] staging: kpc2000: kpc_dma: fix symbol 'kpc_dma_add_device' was not declared.
Date:   Wed,  5 Jun 2019 17:57:11 +0200
Message-Id: <20190605155711.19722-1-valerio.click@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was reported by sparse:
drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:39:7: warning: symbol 'kpc_dma_add_device
' was not declared. Should it be static?

Signed-off-by: Valerio Genovese <valerio.click@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
index ee47f43e71cf..19e88c3bc13f 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
@@ -56,6 +56,7 @@ struct dev_private_data {
 };
 
 struct kpc_dma_device *kpc_dma_lookup_device(int minor);
+void kpc_dma_add_device(struct kpc_dma_device *ldev);
 
 extern const struct file_operations  kpc_dma_fops;
 
-- 
2.17.1

