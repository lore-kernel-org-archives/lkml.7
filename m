Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766AC17444
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CEC2196F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2atN5xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfKILgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 06:36:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38236 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKILgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 06:36:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so6916472pfp.5;
        Sat, 09 Nov 2019 03:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IySrLInNHpGtXZb/RlBk37czseGukluRznzmeXhsOUw=;
        b=c2atN5xyWK5ZrlenspGo0BGSReIDH9DVJ0qGXWoIw/Bm3pvXnC33rk7wgsIK7ihu27
         BbZNVY/5xvmfG9ORUr7R2H7G/kg/mByqtzEZenb+y5IyWK7Dz0JNDFLp9SDNZ0x5gQBs
         TYg1iliRzD1GZTQMK42JzI0kopIAktzxaEGRIz2MhvtG6vAPAiBNZ+Tgel2pg7sTQgg5
         wfzAbCXpDOKScJMYAWbIb9rv3vb23qePDLLtkh6V8hzLi4XRSJve9cD5nc0YpBfDdG0w
         DEaWOkd32D5H+W2mJE0qqC/+T2qu07dtAqrYKuq0fAiREiTnvq3rhuJjYUKWa70pmEKk
         26pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IySrLInNHpGtXZb/RlBk37czseGukluRznzmeXhsOUw=;
        b=f02AnQ1Is0WeQV19TdyLQTwRIwVjuVJ0ZVgzRCVIv2Oz3NJEofG2CPotgDcTRr/GKY
         P0rzoSSueT6+mIGY9vmNLVhwz21HCps5FaThyObvRrgeF7dUTF7dWr+yVjZUszuf7Tde
         xXBaJzTUQpLH1uEO5uv7dPFiMx5ilF/1HbJ+p6dBr+ksd3wPJ+UY7wyhVp4F5CYsTNsj
         kMyZJTWVsVgwgtDaPmHUn3GEjUHQk8bfD43UZruwBjFJyiEHZwlWN87Pv0vH+dnV1Utz
         9gQw9W1h7ygbvA2ruOVwCLfJEiQ8ghR9/Gm9zMPQJJobCBi9i1e6VkAzDKMEbHR+UR8m
         YICA==
X-Gm-Message-State: APjAAAW7sDptdX/Jl6amG1yqJrSwKoE2mK6UP7wkLfr8mADAylHTWHdw
        1t5flQSKavjZHntYIPxZaHA=
X-Google-Smtp-Source: APXvYqyThD6xef7t/WXPB/lRjTcr8wjUSnUYFWVHKkgpQuccnZB0IobwOMDFpgZ+Q3do3iYXTVbMgA==
X-Received: by 2002:a63:c103:: with SMTP id w3mr17766224pgf.275.1573299400205;
        Sat, 09 Nov 2019 03:36:40 -0800 (PST)
Received: from localhost.localdomain ([103.82.150.242])
        by smtp.gmail.com with ESMTPSA id j126sm10757713pfg.4.2019.11.09.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 03:36:39 -0800 (PST)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Satendra Singh Thakur <sst2005@gmail.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: zx: remove: removed dmam_pool_destroy
Date:   Sat,  9 Nov 2019 17:06:09 +0530
Message-Id: <20191109113609.6159-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105165855.GC952516@vkoul-mobl>
References: <20191105165855.GC952516@vkoul-mobl>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the probe method dmam_pool_create is used. Therefore, there is no
need to explicitly call dmam_pool_destroy in remove method as this
will be automatically taken care by devres

Signed-off-by: Satendra Singh Thakur <sst2005@gmail.com>
---
 v1: modified the subject line with new tags

 drivers/dma/zx_dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/zx_dma.c b/drivers/dma/zx_dma.c
index 9f4436f7c914..7e4e457ac6d5 100644
--- a/drivers/dma/zx_dma.c
+++ b/drivers/dma/zx_dma.c
@@ -894,7 +894,6 @@ static int zx_dma_remove(struct platform_device *op)
 		list_del(&c->vc.chan.device_node);
 	}
 	clk_disable_unprepare(d->clk);
-	dmam_pool_destroy(d->pool);
 
 	return 0;
 }
-- 
2.17.1

