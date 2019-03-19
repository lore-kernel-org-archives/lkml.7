Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C8520700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK4XnfV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCSCVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:21:25 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50543 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfCSCUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:36 -0400
Received: by mail-it1-f196.google.com with SMTP id m137so8135075ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7GvUFWVFREgikvW3Mpnlx9jXsuTxf9sLym6wnUrISE=;
        b=PK4XnfV7TPR5xj/wcvkBnwuGj9viAsZnTaCnEaIYtVCMofSFk3znttbF7tVthjsdEh
         1vP9O5PdeZ+c5J6w3eq2hnLONNvgtfH0jr4p7UWesQNna0Fk4PLTARMra3VBFHy+9e2j
         dzGPHlS6butSlutSUasEK6QthuqqPWFH+MyfuonXWifPKljBOgvyqwMo0VplbcG2BGxw
         Fim8yL5HHT2xZEP1+LiKP3OfQ80IHaPqXR4ZrbvtLywQrLzge682ec6mKv1g3s3DTONJ
         VoTbOaI1TRUdImobd2A3UedLe1bMD4bL8zNlT99xHUTH/ng0TsLojpHBX7VvM5dRmIy/
         t6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7GvUFWVFREgikvW3Mpnlx9jXsuTxf9sLym6wnUrISE=;
        b=dmmwtNLSfqCggGV4o7A/D7BSWHwpiQKSKHInY9nt63dBsvwbIV3OCMVnPghdlSJ5CB
         uwszYRNk+vv9HK7XvuzJoAUWYoj1zGFlE3P5a0JdjWKKMAVPbTm/Btq0jpHD95GRZAaM
         EDdGhH9lVgqx9h+YOHVYRdXBu4bcRvAuJRl2o4nlkR3OO9jroJhZUuKeGwf9QKcOrz4z
         JbTa/NCL2dBElys+7ys8ckER5DcYj3Mi6G9HnetDIRNTJECNvd7NzAbaMO8seJAyDUTf
         EHntg1q2FY6c2rdd0B7XKzmR9njP9xKHT7TsDuDXAVHksKLDkIKIe0DrjnUUgq+wtDta
         rl9A==
X-Gm-Message-State: APjAAAWNUVBlw7/1X8fDRhulh6bGYWqQHOmLWR/8qpE1qtZuQyJlD7bj
        kJ9970zqmd3mWiDvJJxzg5w=
X-Google-Smtp-Source: APXvYqy76DReZqlr4BHnEgoBRSN+K+2Uygpc2Ab/+E2zXSKa6OrFkEjGa6TtIP6f2p2tUNciIFcuFg==
X-Received: by 2002:a24:3449:: with SMTP id z70mr37832itz.169.1552962035204;
        Mon, 18 Mar 2019 19:20:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:34 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 02/11] staging: mt7621-mmc: Remove obsolete comments and variables
Date:   Mon, 18 Mar 2019 20:20:03 -0600
Message-Id: <20190319022012.11051-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These comments don't contain useful code or alternate implementation
ideas.  Remove them.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/mt6575_sd.h | 3 ---
 drivers/staging/mt7621-mmc/sd.c        | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/mt6575_sd.h b/drivers/staging/mt7621-mmc/mt6575_sd.h
index 038a484a9476..8b6cf17175cd 100644
--- a/drivers/staging/mt7621-mmc/mt6575_sd.h
+++ b/drivers/staging/mt7621-mmc/mt6575_sd.h
@@ -39,8 +39,6 @@
 #include <linux/bitops.h>
 #include <linux/mmc/host.h>
 
-// #include <mach/mt6575_reg_base.h> /* --- by chhung */
-
 /*--------------------------------------------------------------------------*/
 /* Common Definition                                                        */
 /*--------------------------------------------------------------------------*/
@@ -418,7 +416,6 @@ struct msdc_host {
 
 	int                         error;
 	spinlock_t                  lock;           /* mutex */
-	struct semaphore            sem;
 
 	u32                         blksz;          /* host block size */
 	void __iomem                *base;           /* host base address */
diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 049b312131a9..9074848a8251 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -100,7 +100,6 @@ static int cd_active_low = 1;
 struct msdc_hw msdc0_hw = {
 	.clk_src        = 0,
 	.flags          = MSDC_CD_PIN_EN | MSDC_REMOVABLE,
-//	.flags          = MSDC_WP_PIN_EN | MSDC_CD_PIN_EN | MSDC_REMOVABLE,
 };
 
 /* end of +++ */
@@ -1669,7 +1668,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	host->timeout_clks = DEFAULT_DTOC * 65536;
 
 	host->mrq = NULL;
-	//init_MUTEX(&host->sem); /* we don't need to support multiple threads access */
 
 	dma_coerce_mask_and_coherent(mmc_dev(mmc), DMA_BIT_MASK(32));
 
-- 
2.21.0

