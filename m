Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCACC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866E6206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 06:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="xqZPpE+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGDGIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 02:08:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34572 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfGDGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:08:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so4938139ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBhlBYpTN4I+Zp3YmG9RRV1m1SjWxog8Cy7vjAlL+k4=;
        b=xqZPpE+PwgVA2s54GRPeMXBj0Un5a7zwD9U9yhlxaRiHZ4cW2L+ecAEfyhbaqKd9cE
         E2DZrQSuCJ11SbBLxYR656cPgbZbDh4U+2i02YKZHPwfx8TBfkZlR1BYqAKIoVcF5dlB
         oRsFcN0v3VJH2aOOhW3K56vk81mOTmYiz/plNpbSLnlkg4IFFL6HvzbJ3qg8j5wndkVC
         H0DiJtG+vRHzouYWJY+Qc7p1utZgrlhKNhsXw1+36ztEOUi3h/dFdHZCUsalAjbTIfPh
         o2GOItYjSQ7+f73xDnRuVpJyVi+guPIx9OC1EfJsNZjnd3Af/Qs0fP2GxBap75A3Vydb
         kBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBhlBYpTN4I+Zp3YmG9RRV1m1SjWxog8Cy7vjAlL+k4=;
        b=jc1gWj4wZr8pB6fiEXnifdhjNEl4g2t4P7NWBmINmM5oaAZSNWXLfHMZPyOrrPSe9G
         P84u88/ABACS9sGx/BrSpAsbidEr6oeB5eBvF7WRqL9aF/y6JXPSw/oKO6HVwO2hC/oY
         /ESWLeFdNgVoo5LxMXPOaTZ/7FMBIVFvAJ2pEp8nHzBX+2GvLpVOvQHc/V7WLTbRUHZn
         /l+2ExP+IAiePk+XGCmx8fh79D9W37IqnMcNK20KB4Oa5E9qTJecnHpKpINAZZXLEf85
         eHdevZba+UdvJ7klw2yr3d08in3e4hBPqdrgtuC9g0k62pQXolNFQJEi2mq88yh8+LiB
         UTpw==
X-Gm-Message-State: APjAAAVq32RBSsxTekJ79qnuEeuR8EuhAX3nqLNpnZzAowLztFn/Cew7
        /AX88WYAaAv8DLEMqbwIg7hRLw==
X-Google-Smtp-Source: APXvYqxZ3nyZdjoAqnMLe04pmS3a9XQUtOLE6Disa0hnxUovsvE+54ynCmtEZncGBwJ1UJBA8pLZeQ==
X-Received: by 2002:a2e:8007:: with SMTP id j7mr8791384ljg.191.1562220500948;
        Wed, 03 Jul 2019 23:08:20 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id b4sm710440lfp.33.2019.07.03.23.08.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 23:08:20 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 2/3] staging: kpc2000: simplify comparison to NULL in dma.c
Date:   Thu,  4 Jul 2019 08:08:10 +0200
Message-Id: <20190704060811.10330-3-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704060811.10330-1-simon@nikanor.nu>
References: <20190704060811.10330-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warning "Comparison to NULL could be written [...]".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc_dma/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/dma.c b/drivers/staging/kpc2000/kpc_dma/dma.c
index 8092d0cf4a4a..51a4dd534a0d 100644
--- a/drivers/staging/kpc2000/kpc_dma/dma.c
+++ b/drivers/staging/kpc2000/kpc_dma/dma.c
@@ -119,7 +119,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	cur = eng->desc_pool_first;
 	for (i = 1 ; i < eng->desc_pool_cnt ; i++) {
 		next = dma_pool_alloc(eng->desc_pool, GFP_KERNEL | GFP_DMA, &next_handle);
-		if (next == NULL)
+		if (!next)
 			goto done_alloc;
 
 		clear_desc(next);
@@ -245,7 +245,7 @@ int  count_descriptors_available(struct kpc_dma_device *eng)
 
 void  clear_desc(struct kpc_dma_descriptor *desc)
 {
-	if (desc == NULL)
+	if (!desc)
 		return;
 	desc->DescByteCount         = 0;
 	desc->DescStatusErrorFlags  = 0;
-- 
2.20.1

