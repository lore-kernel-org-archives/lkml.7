Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBA7C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042E227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiEquNkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfGXInK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:43:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42610 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:43:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so20851820pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Ol/+/EACU1mDtCvpt+iEiYJ2SN+qSkf9suJGxid6UE=;
        b=PiEquNkHK4nn2WkH3wqswaX9lLCPjHym9g95ww2KLH/+5cwz42kzG42PyZffZ4u8zr
         hY4UppU3tgKNFFllYQGmGoB2Cdl4Bo6mwJckc2WpR2Wyt2cqyIk9YB1uWh6FFnG4ZAzd
         ir/Y6ME74fPSJFnWvYY0JP7Lz2N2+cLCeGCkyARvfY6Zdfbgw/zUA+gmz6hT19YHLxfu
         9WfM+WAw0KTdkqe+v2FJ/V+9ustDnksRcKKwKHkrDxUar3BWDQeg5XWlg3L6DYgUqQ3u
         ZqzbeT2MwR+J0BWRPH6lTCagRChanNSYZxRH3I45eviZTovR7+jdqUFIUOgCoDQ7b/XY
         +KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Ol/+/EACU1mDtCvpt+iEiYJ2SN+qSkf9suJGxid6UE=;
        b=Pw7Jicp5AKB3tnIc49wIPP3vaDIvFgb4i+imVi/Es/xi9g4GUnDTT5aTWxhewYJe76
         WFAnBU/uEJsPTFfDDOsMEl1a1+zeSPLsGCb5uJUH+qcCFG6zedhrXfPfuBQjf+5zfLTe
         EnEmQgPJr+u8G072EcTdeaKsatNvJYnavkdz6Prc9f7mDJln5scwzt5kSHzyIisPxMBB
         lAoJC0RLwKO3r/VVJWdnpR+6dwVuZAsbz7Gynl83vW39GsZbOKWIWPXFJ2DJFKFxKiPZ
         vwLJBYQDSvto1KcFU9OmlxKLYTvZKOkebrjKGKX1b0g7c47lghMvAzc72lyFIy1tBjaH
         rExQ==
X-Gm-Message-State: APjAAAUr6FIJlG7p+PRnH6/C3YGTq2nJxnTDrrEmuqu88jC75bLePPJT
        MYI86d0u/Cxw6EwNOLmvHQzDeBW6+t4=
X-Google-Smtp-Source: APXvYqyNcnZli/KlqTQVySyRa6gjjsg9uLU36wPchRtlzigKX3VX3hrtCaR+kxLa6joBAhija30nuQ==
X-Received: by 2002:a62:8c81:: with SMTP id m123mr10114404pfd.240.1563957789574;
        Wed, 24 Jul 2019 01:43:09 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id r15sm49326364pfh.121.2019.07.24.01.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 01:43:09 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: gfs2: Fix a null-pointer dereference in gfs2_alloc_inode()
Date:   Wed, 24 Jul 2019 16:43:03 +0800
Message-Id: <20190724084303.1236-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gfs2_alloc_inode(), when kmem_cache_alloc() on line 1724 returns
NULL, ip is assigned to NULL. In this case, "return &ip->i_inode" will
cause a null-pointer dereference.

To fix this null-pointer dereference, NULL is returned when ip is NULL.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/gfs2/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 0acc5834f653..c07c3f4f8451 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1728,8 +1728,9 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 		memset(&ip->i_res, 0, sizeof(ip->i_res));
 		RB_CLEAR_NODE(&ip->i_res.rs_node);
 		ip->i_rahead = 0;
-	}
-	return &ip->i_inode;
+		return &ip->i_inode;
+	} else
+		return NULL;
 }
 
 static void gfs2_free_inode(struct inode *inode)
-- 
2.17.0

