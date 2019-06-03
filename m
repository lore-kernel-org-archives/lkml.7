Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3165DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0498024195
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="eDAYzgiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFCW3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:29:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41976 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfFCW32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so3312603lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVvkQM4fNOAgPUZLwRKZYmsBEm2aqbjd994xRlmgM+0=;
        b=eDAYzgiOQkkYd1a6x4CwFpqX67F6CPCRMEZhoDyg9V1PHmS504wYhIv6+ql1ezpqUK
         5/jhQ32ZskfDukoLpFA9SauluIzGC6eEN++ZUEHGrbno5/8dKFBAT2JgCSmEvLPuZiKr
         HzN0q115nC7onHNO1PSHflTSwzjYymwA41g/6tBwbPCcTuy0Sn1NssRsvK7xDag7EQxP
         p6hJm00qiE1MKaFZZHLdRsWLVSCSB356qVQwcwGGr24D9Zfjuu1iSPn3SsU4IlY8VCpu
         By8ZSPttIIToN3p2OqY0lBfvZcmmE8sNdID5ZSMQzWkS9OAedGuVPOo1iCeydxDwKYcm
         hEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVvkQM4fNOAgPUZLwRKZYmsBEm2aqbjd994xRlmgM+0=;
        b=nfZqHzufux0wDzzLVPUYWuYhE+1lAvlh4FTLScLJhDxKfsW4HEOM61Rw8cjetFM8gC
         fajanGTNCfg7PT8wQyreonl2vp1k/LTAvruwxyLagrcKgffbXX1efxd8WnchHtds1Cy5
         PcB50gFhgw9C5Wb8P9cj+F8n0SuunpMPAD/4WtlaoF3x6lC1JKfwqzGjmhBc8upHj2L4
         H5m5BD2kVRJ92yxUFdzFSgBHo/8g5h53f72oELisKN03vfZ5635TX17esi9mR7TGC80j
         2DaXZqKxvEt5sKXB84mlwLY19cQc5JH0xx+VbDea0I+Y54UEtLjDei92IEnztSvkk53N
         TuWA==
X-Gm-Message-State: APjAAAWFYUFo4khGjrd2Y3lD2QTQgXY5Puk/4LNitrRnWUpNMqIgya1F
        oeJI1pfuImsbKUp8W2yXIcFymw==
X-Google-Smtp-Source: APXvYqxe2HpUU1aSRP9HsZ5BwD8J12HcdP51GNkJsRx1V89E3Jniux4O101Lyb27VERsmCYexIscNw==
X-Received: by 2002:ac2:4d17:: with SMTP id r23mr9138137lfi.130.1559600967474;
        Mon, 03 Jun 2019 15:29:27 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:26 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: kpc2000: fix incorrect code comment in core.c
Date:   Tue,  4 Jun 2019 00:29:16 +0200
Message-Id: <20190603222916.20698-8-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603222916.20698-1-simon@nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 11 was removed from kp2000_pcie_probe in a previous commit but the
comment was not changed to reflect this, so do it now.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 2d8d188624f7..cd3876f1ce17 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -501,7 +501,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		goto out10;
 
 	/*
-	 * Step 12: Enable IRQs in HW
+	 * Step 11: Enable IRQs in HW
 	 */
 	writel(KPC_DMA_CARD_IRQ_ENABLE | KPC_DMA_CARD_USER_INTERRUPT_MODE,
 	       pcard->dma_common_regs);
-- 
2.20.1

