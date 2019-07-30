Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5225A2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3J6fSLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfG3T3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:29:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39316 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfG3T3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:29:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so26363299pfn.6;
        Tue, 30 Jul 2019 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y+Z4pnc0JucsBU6cBRK5vZR18lsIs+7jdcMlSRJldAM=;
        b=J3J6fSLgyRAglDa91wM/WVpOub0dsDIGNqdsu1Tea+QoDMMw2jma8/oHcfiQ674cxV
         SGM7oWPI9HxiZD/zSFxrolfjn7ArdtnRmmMU+e9BgYatHIQBpxtcR++ss8iB6UHaq69T
         0ANSCqVVCNzXEKPO5jeo3kbhlSzMhZJipJNOmcNRU2FeHa4Ugjn2ZFEVEw2zF1xI/YMu
         os/CS4b8e8cLNF43RyPEXshPbDam8jORD/qqygREThewtg1ghM/f8AKfNYZLkXDfVs1+
         NVSlY+R1xu/gK7xGenjd36jma6jr6N2VOXQ4GT+0j1PHdAdwqbJT+tk4SvWjJE8b/NHo
         hd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y+Z4pnc0JucsBU6cBRK5vZR18lsIs+7jdcMlSRJldAM=;
        b=RDu5znhBvXJIjkE8Ie0OBJTNNJYdCVvssOE8LM+KMv4G5TQJ5HnLxYR9WBTBtST+Ov
         2iV80V186lochZghik2koEG6gvKwSZCh70NzvFinKROH93e6YlsOG5TI7xIzdi8XKVK9
         aOPtFF5k1CL13Slv/edRwkCby1+cfvhNlOS9PSVXR4G/Wz1JoP9ECHbAP/Ze9Ha6PB4b
         ug6xbGySM9fumttiD85fEEeqzcWB+dhDVAJ7ub1U4WP02OA0zN3IlPFK3qQgZueMAHkn
         Kymeve+fatgj4fGnsxbypV3cJYHyAo2RDstHuNnmA6e868x8RbweWlThpVhxn63dc34m
         DllQ==
X-Gm-Message-State: APjAAAX0yfw2+Dtvi+4Il+IhxuLgSQsHGtMkaGgBCaPyXDXXgIBvJJ9/
        aXd9ijQCqFgDY5ofUP2nq58=
X-Google-Smtp-Source: APXvYqzjX6/N73oQ92lnyuPiSRKxYuv2wQ9u6FtCOsJTd7+yl6rJuIeKSmKph3ilFfN340WUgdjYKw==
X-Received: by 2002:aa7:8817:: with SMTP id c23mr43961590pfo.146.1564514978219;
        Tue, 30 Jul 2019 12:29:38 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.16.0])
        by smtp.gmail.com with ESMTPSA id o32sm62411228pje.9.2019.07.30.12.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 12:29:37 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video: fbdev:via: Remove dead code
Date:   Wed, 31 Jul 2019 01:03:20 +0530
Message-Id: <1564515200-5020-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is dead code since 3.15. If there is no plan to use
it further, this can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/via/via-core.c | 43 --------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
index e2b2062..ffa2ca2 100644
--- a/drivers/video/fbdev/via/via-core.c
+++ b/drivers/video/fbdev/via/via-core.c
@@ -221,49 +221,6 @@ void viafb_release_dma(void)
 }
 EXPORT_SYMBOL_GPL(viafb_release_dma);
 
-
-#if 0
-/*
- * Copy a single buffer from FB memory, synchronously.  This code works
- * but is not currently used.
- */
-void viafb_dma_copy_out(unsigned int offset, dma_addr_t paddr, int len)
-{
-	unsigned long flags;
-	int csr;
-
-	mutex_lock(&viafb_dma_lock);
-	init_completion(&viafb_dma_completion);
-	/*
-	 * Program the controller.
-	 */
-	spin_lock_irqsave(&global_dev.reg_lock, flags);
-	viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_DONE);
-	/* Enable ints; must happen after CSR0 write! */
-	viafb_mmio_write(VDMA_MR0, VDMA_MR_TDIE);
-	viafb_mmio_write(VDMA_MARL0, (int) (paddr & 0xfffffff0));
-	viafb_mmio_write(VDMA_MARH0, (int) ((paddr >> 28) & 0xfff));
-	/* Data sheet suggests DAR0 should be <<4, but it lies */
-	viafb_mmio_write(VDMA_DAR0, offset);
-	viafb_mmio_write(VDMA_DQWCR0, len >> 4);
-	viafb_mmio_write(VDMA_TMR0, 0);
-	viafb_mmio_write(VDMA_DPRL0, 0);
-	viafb_mmio_write(VDMA_DPRH0, 0);
-	viafb_mmio_write(VDMA_PMR0, 0);
-	csr = viafb_mmio_read(VDMA_CSR0);
-	viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_START);
-	spin_unlock_irqrestore(&global_dev.reg_lock, flags);
-	/*
-	 * Now we just wait until the interrupt handler says
-	 * we're done.
-	 */
-	wait_for_completion_interruptible(&viafb_dma_completion);
-	viafb_mmio_write(VDMA_MR0, 0); /* Reset int enable */
-	mutex_unlock(&viafb_dma_lock);
-}
-EXPORT_SYMBOL_GPL(viafb_dma_copy_out);
-#endif
-
 /*
  * Do a scatter/gather DMA copy from FB memory.  You must have done
  * a successful call to viafb_request_dma() first.
-- 
1.9.1

