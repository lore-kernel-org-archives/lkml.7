Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F662C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578C0216C8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnnilfsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGYXjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:39:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36572 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfGYXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:39:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so23792532pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9prolDL+Bhp3LyY4fbBTGEV1uaHeMB5qkqJOff233Wo=;
        b=gnnilfsw9PFl1y7SWP83bgts6aO6Y7myoMOnWToOjhOrwX5u52dAb7lpcwNGyXI1HS
         ud7JJD3/1fVImwd8R6rplXWVwQ6shJCx9WRaFeze5tj4vRCAQ00luQWaTo7CnmZgOTsk
         v9GJteYr8jfb0TiVNL5HL192RwUBjFa32mSD0vzW64H2e/BT3DALu9C7hAMklC2d/bUX
         jvBH6veo4+LlY5XS4wJnXXdgYFGfERI0X+2r2WtbKwnf0gmj5DvZAQ/NI84EFuJ53Pjj
         iO0PABTu42Y8Q0XlkfPljqLeZqiG7yjY9rC1UBLjSP0OmD6Sco1Fmoua86iG6QwcTvRa
         VCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9prolDL+Bhp3LyY4fbBTGEV1uaHeMB5qkqJOff233Wo=;
        b=gtbsQ0RQPU2bBGDZlpzysPT61iIR8NioKtERIcbswdh5aFcmpS3d4gDLQAUP5jn3mS
         HGXWClyU6qGOHisDaRm3HksJvB5yo5V2AEo923IzcRL9DrPaHUBb0Ao7yyWNwFdrQP4D
         eiMp2jbAzMefNzElCop27NjFqUEdFtKRH+tXuyY9CxCv3tEUg1UmZ0qnUmymedu93SFt
         Y7Xs45M/yo6akzsYwll1G64NZc9ryUcGi21TytOMIrdWeEJqbRXDZdBNT2q+7tqvPKoE
         AJ57hCxz9m6imH9mpXI4fEE92mGjKnnqBWIcSqXlNqpY7AaizE/InADysgRqdmtz0QG3
         MLZA==
X-Gm-Message-State: APjAAAXyrn6xVtHpHaq+rSSiwoBKQRZUX+NWfcUGsjfkPPybOoGVJpIc
        ws6TPeiiToh5K1Ciz7ZX/QU=
X-Google-Smtp-Source: APXvYqwl8BTqAkMXqvYshZszKPiEYKFoC8MNpaXfud9Ul5VoXo6zYD92eosnuG9ivvT08H9Far5aMA==
X-Received: by 2002:a63:ff0c:: with SMTP id k12mr47230757pgi.186.1564097959856;
        Thu, 25 Jul 2019 16:39:19 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f72sm70888203pjg.10.2019.07.25.16.39.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 16:39:19 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dma-contiguous: page-align the size in dma_free_contiguous()
Date:   Thu, 25 Jul 2019 16:39:59 -0700
Message-Id: <20190725233959.15129-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725233959.15129-1-nicoleotsuka@gmail.com>
References: <20190725233959.15129-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the original dma_direct_alloc_pages() code:
{
	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;

	if (!dma_release_from_contiguous(dev, page, count))
		__free_pages(page, get_order(size));
}

The count parameter for dma_release_from_contiguous() was page
aligned before the right-shifting operation, while the new API
dma_free_contiguous() forgets to have PAGE_ALIGN() at the size.

So this patch simply adds it to prevent any corner case.

Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 kernel/dma/contiguous.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index fa8cd0f0512e..5735a9166866 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -267,7 +267,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
-	if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT))
+	if (!cma_release(dev_get_cma_area(dev), page,
+			 PAGE_ALIGN(size) >> PAGE_SHIFT))
 		__free_pages(page, get_order(size));
 }
 
-- 
2.17.1

