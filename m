Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200D0C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E974D20659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irk3T2tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfGBH7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35075 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGBH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so7853273pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=87Kr2cmnEebEllKtxPbUleYwXT+bl8U9XGBIL2ezWfE=;
        b=irk3T2tlAq9RPeJksx1YPUiHmtn1FIBYER31v6qnwYrPi/QY/IJlW/GEo1NW96uNSx
         HD3l6+7IeoUWb1CC3dTGB2cPBKWi+kg3FszGaEOpok2x+C6y/uMcWsm2Ib9Ru3Iymo3C
         nBpxbVISbUYn5eptb4nNljEhGUMp5fwHU2FVt1S+pgY2y9FfAp7cMO+13O4OHYrQW0tH
         TTN+FlR5STxKoUKqvhNQjKXq223I1+p32Mwxw5jwZex91jafWBDQ5m5+06xD961jIoI7
         XcfUU3zWk/S2sc+VEM9lukBssPSY/rBtluapn6nv1+XpR0piTgKJB9+Hfqh4qkb+RTBS
         XSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=87Kr2cmnEebEllKtxPbUleYwXT+bl8U9XGBIL2ezWfE=;
        b=nPO1DdeinYfhNjEganlTU2U9JRkuGZydNLFXla53zIldYy3HM3yxD8gzq9cAXEeiHd
         qCKbERI6XjCONIM7CDeRSxWsPopHDdJzh+e+Fcd86UwGK7xibB0nca+Zj3aCWn5nBklC
         0UuSyGSYTqpCq5+yB5F01sjobLuCZow/o1OE3qkWt2uEvIcWY3Dlcj7EolJDx5b1pD4w
         Ni2rNRqD6P1kwNyIxg1QYr5TzfLppCWz5mZEv/jORU/smR2cAQ/IWNDF7Vmhe6strDMB
         2Fr/tuTsvFOVVvM01M+6So98jtKBjkeKtDzD8LAmaSvVlRk7Fg7uiTEqEOfL7NC9SAvb
         0S/A==
X-Gm-Message-State: APjAAAVUIF3Y4vVP26Fko6ukc/GX5CsR8oSbpaSzGeArbpzCJrVk9ew1
        nPPwi0ywGscE18X2E38BylgZ85eGJOY=
X-Google-Smtp-Source: APXvYqyr1wr9hO4LggZChVELBUYh96exUYhvPvlFde0qwf5Yxuwp852LS4Cie4lLg6jbQbcadFM9zA==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr3922563pjs.109.1562054394851;
        Tue, 02 Jul 2019 00:59:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id c69sm1642725pje.6.2019.07.02.00.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:54 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 24/27] fs: jffs2: use kzalloc rather than kmalloc followed with memset
Date:   Tue,  2 Jul 2019 15:59:48 +0800
Message-Id: <20190702075948.24632-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zero allocator rather than kmalloc followed with memset with 0.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Fix pr_warn message.

 fs/jffs2/erase.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 83b8f06b4a64..6887ce8b6cd8 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -43,9 +43,9 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
 	jffs2_dbg(1, "%s(): erase block %#08x (range %#08x-%#08x)\n",
 		  __func__,
 		  jeb->offset, jeb->offset, jeb->offset + c->sector_size);
-	instr = kmalloc(sizeof(struct erase_info), GFP_KERNEL);
+	instr = kzalloc(sizeof(struct erase_info), GFP_KERNEL);
 	if (!instr) {
-		pr_warn("kmalloc for struct erase_info in jffs2_erase_block failed. Refiling block for later\n");
+		pr_warn("kzalloc for struct erase_info in jffs2_erase_block failed. Refiling block for later\n");
 		mutex_lock(&c->erase_free_sem);
 		spin_lock(&c->erase_completion_lock);
 		list_move(&jeb->list, &c->erase_pending_list);
@@ -57,8 +57,6 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
 		return;
 	}
 
-	memset(instr, 0, sizeof(*instr));
-
 	instr->addr = jeb->offset;
 	instr->len = c->sector_size;
 
-- 
2.11.0

