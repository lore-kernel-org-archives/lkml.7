Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA6C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A208120644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlfmlTST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfF0Roj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:44:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35344 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfF0Roi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:44:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so1351069pgl.2;
        Thu, 27 Jun 2019 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PtfqAXXMltfoj6Igz7UOOQYqClcuoNbrMp0Bhkaqno4=;
        b=DlfmlTST6sqIfIinqRfcF2zB9jfE891HNZPZsvR1ey3QB6Dfk/mdZ8vU5bjIwU+6Ra
         FM4fXK7lt65CDDvpCWhcXU9vEA4gTopRoYdZSYqtCugcQ+KrCLW6XqVAKSlkwaxFzfrA
         ie5dz8xBqSEbdXO60IjGBprZSBhSzvQUioQYZ/PXRla47wzhRVBFyPG9F/tu7nM281QY
         HrCgpvaXgGe+j9355B7PKUEVVzrEEdUrXujVXJbfJEb/0n9I/BBSd490rdRr+N63gQa7
         x1dOsUuiVMSwpZWAu0hfEw8s/q3KYQUvUmBZKA4/p+dPzNs85vM7++nrWVqyTJSxmu6v
         5dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PtfqAXXMltfoj6Igz7UOOQYqClcuoNbrMp0Bhkaqno4=;
        b=DLOthQ9k+F5yUK4IadDZeUSXdt+xQKcJ8ePUSOzo3RTSlnDlKYS/KR4nDbTK5oebGy
         Nvvqgy93oVzxn6B6xMJrfOmUAxDDrzzWyOSoKOTZRIDiFpxGz9hTBbDvyvNIBgDSRY62
         g5NHLauyZAn9cbQGZTd56R4/UaEx5HMHdikXVcpsz7wi/ZlJr7cGZdLDITq/wkrLI3Q5
         JSF8dxR47Vv8MLy0IMgAHUkjXdGW3sT0WmvFHRNtxLQGEh4oDXn38P8oklRp07FITONb
         4gNIeo5k47Bnjc+0oH+ZUDJiwTjKFHn71MWjBriVpOosPl3aCsaJxqctysHRZDmgEWwI
         gPLQ==
X-Gm-Message-State: APjAAAXwJnCAbVJrLKgbA5ZKEviWJDExbRWXO5LMPZZ6CV8NohCFvkeC
        Wckx6mG1RcfWoK8KrqVOdSE=
X-Google-Smtp-Source: APXvYqx0qZ4ZB+Wax69nqnmA4cYiq4w1swsiezFvMGCG+qooBP6X/PieJQALlCqMiRGtvP/jp4KtBQ==
X-Received: by 2002:a17:90a:de02:: with SMTP id m2mr7473343pjv.18.1561657477466;
        Thu, 27 Jun 2019 10:44:37 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id z22sm2266366pgu.28.2019.06.27.10.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:44:37 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Samuel Chessman <chessman@tux.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 81/87] ethernet: ti: remove memset after pci_alloc_persistent
Date:   Fri, 28 Jun 2019 01:44:29 +0800
Message-Id: <20190627174429.5565-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_persistent calls dma_alloc_coherent directly.
In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/net/ethernet/ti/tlan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index b4ab1a5f6cd0..78f0f2d59e22 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -855,7 +855,6 @@ static int tlan_init(struct net_device *dev)
 		       dev->name);
 		return -ENOMEM;
 	}
-	memset(priv->dma_storage, 0, dma_size);
 	priv->rx_list = (struct tlan_list *)
 		ALIGN((unsigned long)priv->dma_storage, 8);
 	priv->rx_list_dma = ALIGN(priv->dma_storage_dma, 8);
-- 
2.11.0

