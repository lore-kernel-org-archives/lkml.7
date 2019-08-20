Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF007C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E392206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfHTDDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:03:54 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33411 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHTDDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:03:54 -0400
Received: by mail-yb1-f193.google.com with SMTP id b16so1433754ybq.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 20:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T/JaohmNZpvxoXfMBJgKQy6uqfXida8R0ifjCoHqJy4=;
        b=JVLgrcIx549+6wDPXUeFTUXgxQFuN0WCVMWoOPNzayLtaleCxy3hj5hwVK3/eMbHUh
         g8rQxj0VmaJdBmkzLIuxcLshsleO7vcqWeLZXlQ3AHe1I9wn5Llk6gjwBP34yTtSwqat
         FVMQou1kkuCF2oVwI2U8jCvvkAZeUB5YyTOfjrJZ7or4/5YNSk+ypvqYpEhFMMmujJKa
         IBbDQxPkXyAlEMBdz7QeLj4IccraXBA1QPAdK0RivoeG/xC+30g/VKS/z5WvM0ognrB7
         NU8kCFj88CRMhUFEd/RU10NmC9AGpe9s85aJw0Z0Opocy9Me0zEtO+xNX+FWyzxa53L6
         Hs9w==
X-Gm-Message-State: APjAAAWeRSxEe+4IxwGAk3knSvHiqu+ttHprImKYzJ3SlKDiOtPpYHCd
        d/NI2X2xApHEPvs8NeuC0pM=
X-Google-Smtp-Source: APXvYqzj92UdY053NzsDDYyHqtOHbL0COKEx87/jaBUtYNVeYaHjYyT4RQ5O34XN5FvlCzo1AmUDug==
X-Received: by 2002:a5b:7c8:: with SMTP id t8mr18452781ybq.113.1566270233627;
        Mon, 19 Aug 2019 20:03:53 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id z6sm3820879ywg.40.2019.08.19.20.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 20:03:52 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org (open list:UBI FILE SYSTEM (UBIFS)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ubifs: fix a memory leak bug
Date:   Mon, 19 Aug 2019 22:03:46 -0500
Message-Id: <1566270227-8302-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In read_znode(), the indexing node 'idx' is allocated by kmalloc().
However, it is not deallocated in the following execution if
ubifs_node_check_hash() fails, leading to a memory leak bug. To fix this
issue, free 'idx' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/ubifs/tnc_misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
index 6f293f6..49cb34c 100644
--- a/fs/ubifs/tnc_misc.c
+++ b/fs/ubifs/tnc_misc.c
@@ -284,6 +284,7 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
 	err = ubifs_node_check_hash(c, idx, zzbr->hash);
 	if (err) {
 		ubifs_bad_hash(c, idx, zzbr->hash, lnum, offs);
+		kfree(idx);
 		return err;
 	}
 
-- 
2.7.4

