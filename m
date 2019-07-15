Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA568C74A4B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D60020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQsP0UhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfGODRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:17:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38487 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGODRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:17:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id z75so6997285pgz.5;
        Sun, 14 Jul 2019 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xRxgUpoXT1ALTuAFgtLyhDcF8m82X8iHnPfbbq6cJwI=;
        b=XQsP0UhTK95J3drCisIJub8Z1FnSqDJIQ3kJVeHWEm7AHnj1XQs1Jbk5+ooMiMtar/
         oxyS46/miDf4LsBUMgSVXaGNd3K13pVltIsGDP1MHL2Z8BqD3QTTbFjyWzw6AeVVHl5z
         9pGQG8XAFTT4GR2m4Vhr2C326bjw+PAbfe3Zz/pQNejecghSwoT3G/KPxJNVK7E6d5m5
         d9lb3P72OFariR5DoUu/s80NTQkUaBcpnZmFEJ0CJhNK+qrN3LMIlt8L4BnLZYnhb1Oh
         A5iTwT3cR62j9gUAGxsJNpbSRQZOo23Di3J2HxN37bz6TlTqzcgENy7kVq9w8K9TjPvm
         kS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xRxgUpoXT1ALTuAFgtLyhDcF8m82X8iHnPfbbq6cJwI=;
        b=RnWfReDElYhXb9n1nMqLWJe6Qtus1JBuhtoC4Iue502PMhhyv8okflKanweOaZHzaA
         LM5Yo814t2E3OqdmVzRMHFMYxiEpJIWZOPrUO5vBhW3LoIrNTMOnA5vLiTpNUIP3y62l
         rXZHwhJx5hYR7MF0QsR/kj6gwz47KR2098BmSq1iDpbJMw7W2nczjpcXfjeGjtjxwAkv
         kpZS+MtvItEZrJQhwxco6hL6ohX84ICM0uFug3m9Jke8uWGIeGtLWvtQaR5Ekg5uXuvw
         NG2O3dLp8g8dsAUkokmk2f849zscsX0pIafg+k6bA31zQXTohIENYr0hB5sIC9H9hFcY
         8F7w==
X-Gm-Message-State: APjAAAX3gW5ePHIwfBYpCTS6pxQJxUqn0RuKlzMq/v0tEMafeyp96sYg
        +cxuL68ykFsTBJrC3wxB1i6M9lkmg+s=
X-Google-Smtp-Source: APXvYqyl9iJNy+EquyV6FN3HUvjsvHV1hbzYGFiMGUozuYlf+RuEMmbi/EM8W7GE/ZCu8ciRLlBrxA==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr27643098pjr.113.1563160635536;
        Sun, 14 Jul 2019 20:17:15 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id n89sm25453288pjc.0.2019.07.14.20.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:17:15 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 02/24] atm: idt77252: Remove call to memset after dma_alloc_coherent
Date:   Mon, 15 Jul 2019 11:17:09 +0800
Message-Id: <20190715031709.6281-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/atm/idt77252.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 43a14579e80e..df51680e8931 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1379,7 +1379,6 @@ init_tsq(struct idt77252_dev *card)
 		printk("%s: can't allocate TSQ.\n", card->name);
 		return -1;
 	}
-	memset(card->tsq.base, 0, TSQSIZE);
 
 	card->tsq.last = card->tsq.base + TSQ_NUM_ENTRIES - 1;
 	card->tsq.next = card->tsq.last;
-- 
2.11.0

