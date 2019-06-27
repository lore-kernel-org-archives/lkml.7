Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F5C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1302086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7D8Qcdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfF0RlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:41:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34495 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfF0RlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:41:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so1682902plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=68Sx2VJWJZyxqxxlYRI+Ma3rhm5eQfyCtxzhaZFU+Dc=;
        b=d7D8QcdgRoYgc0tN0G4Fku9kw65FYsH/JmBJwJZsciYyz2xu3iuMx/0IFSMK9DzhHC
         YxNH/SgAikOoE+OUuDT/8YVM9NULi++YiWOGjKku+wibg42dmN20IgbRIBOpRTlcieQN
         DDyZ7J51bVbgnlmBYhquALXYsHMz1O32wCTc1RW5EoHws1Zbh9a5MutEf1F5SvaNGIRf
         9iJM4NQNM2sSaSCGNSYsugr/4GC7ollQtVQ1qAG0/PzqOrQ6rupoWxA25zLa9W8dm1vy
         OeLYIo4r5LoGkFADOdF2zGAljHjeNRatQccUGqlYc4ZYW5vkwjIG3lwrZqwNPa3yeypY
         Zn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=68Sx2VJWJZyxqxxlYRI+Ma3rhm5eQfyCtxzhaZFU+Dc=;
        b=JXicyRrp5a5a+n6j2V8m7uESlJXdAS6QGG2z9QxFXwTtLlY2zskkK0EU+SgaoAuME6
         uKWOrr1qu45cx46MOOCsPOa0he+neYARFUVo917GQmD9jVhpOm6dLepXQ9NPtaPIB/aH
         aSn1FNFBMPNxrcxJBBgYqIucaq7+WWDDdQOztiqG+qSr5rHH3wiXv7CoSX/AEbc83gZh
         9x5ysNLWGTC406EhJbVxDgrPOIfuGzllmf8rpz67IOz9BKx8Nuh4Qq8ZgP3AKr4ncnkn
         pMvUiLHJ0c1F3px3cK0rbp96Js1AJlA7/7ADzZU8KdfUXOkiD+XkJdqI4kfcJYVa/Y3V
         pypg==
X-Gm-Message-State: APjAAAVqzSKAne6+M5qT/qYeCfpA3OzG1zW3sHKuGKlqmsDrqoCbbRSt
        N8d13l7I4e1yuzVMg8crUW4=
X-Google-Smtp-Source: APXvYqyQ3BRpaofxHGGPmEe5BWvSbpUwsNSCEzGOIMOz8jvllwSuhOM/2XHjuZi3Y/55eGtIfQUYUg==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr5899596plb.286.1561657268332;
        Thu, 27 Jun 2019 10:41:08 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id s43sm6322406pjb.10.2019.06.27.10.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:41:08 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 44/87] fs: jffs2: replace kmalloc and memset with kzalloc
Date:   Fri, 28 Jun 2019 01:41:00 +0800
Message-Id: <20190627174101.4291-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memset(0) -> kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 fs/jffs2/erase.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 83b8f06b4a64..30c4385c6545 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -43,7 +43,7 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
 	jffs2_dbg(1, "%s(): erase block %#08x (range %#08x-%#08x)\n",
 		  __func__,
 		  jeb->offset, jeb->offset, jeb->offset + c->sector_size);
-	instr = kmalloc(sizeof(struct erase_info), GFP_KERNEL);
+	instr = kzalloc(sizeof(struct erase_info), GFP_KERNEL);
 	if (!instr) {
 		pr_warn("kmalloc for struct erase_info in jffs2_erase_block failed. Refiling block for later\n");
 		mutex_lock(&c->erase_free_sem);
@@ -57,8 +57,6 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
 		return;
 	}
 
-	memset(instr, 0, sizeof(*instr));
-
 	instr->addr = jeb->offset;
 	instr->len = c->sector_size;
 
-- 
2.11.0

