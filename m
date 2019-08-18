Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B5EC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A5206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHRQgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:36:51 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33464 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:36:51 -0400
Received: by mail-yb1-f194.google.com with SMTP id b16so3578762ybq.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 09:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/z1lnlqAbeq6x6turKShcmzG9kg9OUp9/TqeSNEaN7o=;
        b=hPaix3/60GYY9F1kCdwiu/UwAX3+SqgttPK9LQiZe/pvNWyVlY1mm7jVp56lpKjHtc
         p/B7G2GuJTq/nk0YFXPDXOGnLpiB4H3hh30r+QvPA7ZCbiCiWvzM81f0JG0ZjvCs9kPC
         nbaPcKdrfCwuL/HRzXfwvXsmkXtO74rxfluiIeP7wCJZ40dsqiFj2f4lFsugwlWudN6+
         0LRiebBvHBEDi4MhsO4fMD5gA0V45lYh6Gtu38/GVzNdCYDKZY1E/kLGjef710Uzv27r
         KVNoPdoyaiFc5J81rWnO70Fkis8MOYR08oMibD/HLIWGDMeh6POj2Qz8lQLjOUmRikwW
         YcgQ==
X-Gm-Message-State: APjAAAXw8/1zM0ENJvRBtiUEUiZxqooOkal7rJewVoxiY6VQ2gPwDgMQ
        P6ldawUPwggDS/hFQxbvAhQ=
X-Google-Smtp-Source: APXvYqypLyrgn8MarlbnDVP6U8aKKLr5OF9Z3MKC7brXgqz8Mn3YHzZhGSaWibxCXf1VutIzwJs/cQ==
X-Received: by 2002:a25:cb12:: with SMTP id b18mr14027976ybg.92.1566146210435;
        Sun, 18 Aug 2019 09:36:50 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id v141sm2595717ywe.66.2019.08.18.09.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 09:36:49 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES
        (MTD)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: sm_ftl: fix memory leaks
Date:   Sun, 18 Aug 2019 11:36:44 -0500
Message-Id: <1566146205-2428-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sm_init_zone(), 'zone->lba_to_phys_table' is allocated through
kmalloc_array() and 'zone->free_sectors' is allocated in kfifo_alloc()
respectively. However, they are not deallocated in the following execution
if sm_read_sector() fails, leading to memory leaks. To fix this issue, free
them before returning -EIO.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/mtd/sm_ftl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index dfc47a4..4744bf9 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -774,8 +774,11 @@ static int sm_init_zone(struct sm_ftl *ftl, int zone_num)
 			continue;
 
 		/* Read the oob of first sector */
-		if (sm_read_sector(ftl, zone_num, block, 0, NULL, &oob))
+		if (sm_read_sector(ftl, zone_num, block, 0, NULL, &oob)) {
+			kfifo_free(&zone->free_sectors);
+			kfree(zone->lba_to_phys_table);
 			return -EIO;
+		}
 
 		/* Test to see if block is erased. It is enough to test
 			first sector, because erase happens in one shot */
-- 
2.7.4

