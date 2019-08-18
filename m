Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDBBC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8075820851
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfHRPwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 11:52:55 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39371 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 11:52:55 -0400
Received: by mail-yw1-f68.google.com with SMTP id x74so3362174ywx.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 08:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g1IQSZ36049sL5m/iNqflUFI3mH7QgkOZ4xc+pWsHjk=;
        b=SdqIYLIGXAoRtbHoezdLO5tZXMevWq38ZyNxPvQC6zteyHhQ1PcQYTXYB+lFaaSz5h
         4VyOu3D6Se2AQQ7xmko99edOi773yxZcUAML3x8qLAdv2vzH5HsaGLsbWcg/mVETaUSf
         znD8w743RG8A50UWKXze1rYhhEWmftaWiN3BIZeBGmhcx7fO8NhOjnQdeh/LleL5qf3x
         78+goX/N5b1e3flqnKHVHSsEtmT6RgPuiXu32/dKYzwG3rJkic0D9WDyEKT+G+S0Hm/R
         CCNWHHqWIVMyd3S3sHI7anNHsyDcF1ulmmBHbjwGpIqy0HkWOsDwJ96Ykhghtebxbq5q
         7KcA==
X-Gm-Message-State: APjAAAVy1WD/dGiSKaKRwa/FGZzjnZH8LWsaFHlzl6+5AW81lqTDRomu
        i6r+TdOKpIkwsdwUJCBTH/c=
X-Google-Smtp-Source: APXvYqxvMZQAwr/cqpIhExoNWtwaedluh56/MAsewvj01XA3Q+KvR1s7Ebyp1pxO0JoR4C3DU74ZWQ==
X-Received: by 2002:a81:48cc:: with SMTP id v195mr13809539ywa.140.1566143574212;
        Sun, 18 Aug 2019 08:52:54 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id r20sm2648984ywe.41.2019.08.18.08.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 08:52:53 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:ONENAND FLASH DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: onenand_base: Fix a memory leak bug
Date:   Sun, 18 Aug 2019 10:52:49 -0500
Message-Id: <1566143569-2109-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In onenand_scan(), if CONFIG_MTD_ONENAND_VERIFY_WRITE is defined,
'this->verify_buf' is allocated through kzalloc(). However, it is not
deallocated in the following execution, if the allocation for
'this->oob_buf' fails, leading to a memory leak bug. To fix this issue,
free 'this->verify_buf' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/mtd/nand/onenand/onenand_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index e082d63..77bd32a 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -3880,6 +3880,9 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 		if (!this->oob_buf) {
 			if (this->options & ONENAND_PAGEBUF_ALLOC) {
 				this->options &= ~ONENAND_PAGEBUF_ALLOC;
+#ifdef CONFIG_MTD_ONENAND_VERIFY_WRITE
+				kfree(this->verify_buf);
+#endif
 				kfree(this->page_buf);
 			}
 			return -ENOMEM;
-- 
2.7.4

