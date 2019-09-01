Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D395C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EE52190F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjHWNZc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfIATXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 15:23:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33331 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfIATXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 15:23:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id go14so5589582plb.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MYmyqV51fBjQuhWN4wRJPBtp4cf5jebojptEpCVLVOk=;
        b=TjHWNZc0ZSAdLlICAmRNnY+1VKMb8ksQKlv2+3dqXX/Od6eAOEyRzvUwKpJvFshVrH
         HrrR7AzO7vyxkqqq8e3qYBKsKhC710WpwJN5/HLGqabKuwsVKvT8Sxq69tP2BrP4baWQ
         TA1MQp/Z3dMDgmRYKP/hQw4iGFquZ8eBXYA2xQazOg9QcT0Mqd4MnqWbbiBmuBpqBjle
         PLMS6HCjOTxicYWnq0Tbkd59InVsarbuDZZylarrhkkwwRu1H69HlAunEjCuH+pw53pV
         iqK/4yVXBpneAsahpXA1yg5WXLEApVp2prY059J8ZTkETMIFe9z2++wpWf0qXGy8sUHH
         AT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MYmyqV51fBjQuhWN4wRJPBtp4cf5jebojptEpCVLVOk=;
        b=RakH8+iVwmdURcA8x0yYXOjvh16LAM55g0Iq+7YgVN/MHx+phEAme6yD+gJfgHb2U5
         i67ZMLhuYT4rafuPWrxTLzOrCfCg8GOEfu+Wo2yGin6lLfkflXO6kFbcy44m0qX5rdrb
         aYtwj3WuPfygCRK3s9XltRwWqrSTSuV2XgSsAUZCBViyH2ov8bNUlnjduTeChpmUIOt/
         rxDRijwembDUcELMhu2UdiBfDy801HLF9mWmpb5Os8m9HtIxX63uc8tiTS1wdzK8rt27
         cX2052zLQGguuUnDp5ZsTV+UlxzSkDMd9odHhxmBKrCSf7rf71y2p3ECItN9zIoalccr
         Osuw==
X-Gm-Message-State: APjAAAX+JkIAZkYRr6CJnYUCxZNqMcBK+7el8mMdKtkRnGL8BKvkHnLU
        Bopj8VCdjlOL9WTumRAUV0eQkstI
X-Google-Smtp-Source: APXvYqxVwAyX5i9CZCLq1N9HsR4W+F1HPa3PbBb79wf4iu91tGmUo6frN78M/h5qjGemTUYvUXOSQQ==
X-Received: by 2002:a17:902:744a:: with SMTP id e10mr20291723plt.239.1567365828132;
        Sun, 01 Sep 2019 12:23:48 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.20.96])
        by smtp.gmail.com with ESMTPSA id s7sm21910679pfb.138.2019.09.01.12.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Sep 2019 12:23:46 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] swiotlb-zen: Convert to use macro
Date:   Mon,  2 Sep 2019 00:58:56 +0530
Message-Id: <1567366136-874-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than using static int max_dma_bits, this
can be coverted to use as macro.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/xen/swiotlb-xen.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ae1df49..d1eced5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -38,6 +38,7 @@
 #include <asm/xen/page-coherent.h>
 
 #include <trace/events/swiotlb.h>
+#define MAX_DMA_BITS 32
 /*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
  * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
@@ -114,8 +115,6 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 	return 0;
 }
 
-static int max_dma_bits = 32;
-
 static int
 xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 {
@@ -135,7 +134,7 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 				p + (i << IO_TLB_SHIFT),
 				get_order(slabs << IO_TLB_SHIFT),
 				dma_bits, &dma_handle);
-		} while (rc && dma_bits++ < max_dma_bits);
+		} while (rc && dma_bits++ < MAX_DMA_BITS);
 		if (rc)
 			return rc;
 
-- 
1.9.1

