Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E44C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7202086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPILDhSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfF1Cuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:50:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34488 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1Cuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:50:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so2205613pfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5su9mFiVrtJtzhcekIAr3MXy4s+ZIx1z8ofhG+tteO4=;
        b=JPILDhSP5ATPbONpMDSBwpTg82BI4UcuX1NoYgJUbjQxN6tlwxmHHjHR6G2sI0Tc8s
         2cc4Tt0tZt9axEHI2/hrc2cyl8fq+5a3eXigZAfml1IbT0nbLcgfQvkIbarQWTMz2IU7
         oNQeEBzBNnGSj0ZEfmkScyeZ3i/ak2NI1BJHVy1Za1o1gQDTIKv/s4LmDpVwgRDZGomj
         uMGH3Zh+UgWD6KdNHcy4y+5/pOGyjMDEW4AvVpw399XmYlJp2cTsJvcYbjzEHf883nU6
         LjwBzhoQCFx2Zhq1RyOoWUjiPoJPPI5c1Xh+AK3ZTi0gyHkAET++zqWP4olGFL4ci6+j
         78qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5su9mFiVrtJtzhcekIAr3MXy4s+ZIx1z8ofhG+tteO4=;
        b=VPA5Qyz0Tu15qR9eXM2L7iir+lENUX0IEmc9BCEQTXU/mp//BNLnfY4lofFB9Itq3N
         OMzfJI/K07VN6fi/CRtN/I81CSDlg7umeA4y90FXc1/zBygw7giqfFiUcALakwKd6vAr
         jUSBgHlSflDcbf+yiLsP23Ybkdk/Sv7hNY2pfHHdsNCF6NKfhOQuEab+jIvFW6CHhDiu
         Xa37MzwUOR/ftH/OLtEPRXSyIA1mgRraK9mcRJgWuXcJWUeszrNWeFyvZBX5airheBrK
         CY+BW1JZwx5eWBnifKyTkfooGiJX+qkhkjH+2q4/n2lGtQcm3N09hqu8iMkLkQiM0TqE
         SFxw==
X-Gm-Message-State: APjAAAULnYP7fAbpKiCN9bHC8LXMrQd+xWRoX3v4IUmx+ZdV95x3yMyS
        6kMaeQeazZleGcIp1yxVn5Q=
X-Google-Smtp-Source: APXvYqxOkI+crx9UfEyNpvwC2KKY2yZ+Uu/fkdYowQKZoSujz9PfcJVdMSjJI8C3Q+qGHJXp9PQY+Q==
X-Received: by 2002:a17:90a:b903:: with SMTP id p3mr9942929pjr.79.1561690234777;
        Thu, 27 Jun 2019 19:50:34 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k6sm465209pfi.12.2019.06.27.19.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:50:34 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/27] fs: jffs2: use kzalloc rather than kmalloc followed with memset
Date:   Fri, 28 Jun 2019 10:50:28 +0800
Message-Id: <20190628025029.16081-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zero allocator rather than kmalloc followed with memset with 0.

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

