Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37B2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96C32187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxjYyJLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfGCQbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:31:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37254 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGCQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:31:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id g15so1514032pgi.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MlSA2nvOnfYwQ6hc08lXyQi3gXe/l2Rep+RjrEahV2Y=;
        b=UxjYyJLk3JouNyJyjB0dpA9ndYov1t6khl8nW2QIbCybAZhH4k+6cKtC0YSgg1ffEI
         hJPEwlr4pgTg51ymvhJ28fzDaCLyselyLDmQ9t4Ze+MK6n57nP1fIvrrleZmZsKzr9sq
         OBHOQRDyrK3U3qB1oPbnkk4WN9vU4dx9TmBtNgPn0kGfk5a9MwcWiNPfO0TcoQLl8QXK
         MOSDEQ5zDdLrxLYLJk7Oyokg0tJFV06Izd3eUXyGGlwz7+AxJCYWRE9FhFG5F0jroMl3
         QAt7je6oOP3ooLwxakFGr2UXdqakfpzTu0X1PcBZGgdjd//j6GwR6D+MRvmPkr/iS/7O
         7tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MlSA2nvOnfYwQ6hc08lXyQi3gXe/l2Rep+RjrEahV2Y=;
        b=foJmRcjRDbNfk8/PSqyy44tC1H3vJvQtC/V78r1HsxdsHC9+NBuKAQ5a6DFKGnhGd6
         2Alh5clCtwAY1tzQpAXBHsb1wsKbDPkWBhK0GbXPFrekaniOGqt2B7ENo6d+3AbxfegN
         OgjrD1EHqb3NYYfonutWUqDWmcvAOpxo37jTouhcrFRIsq5nPiR6kDtwD9knjrc7RFAo
         ny2hF8NTJTwQRYAqbNzu1XvK3PVbfpR6rSfPFRGnJZoWufeyKRNpnNAVkyUlb0G48SaX
         NvjcvmJ/Ier8ofmieWOpHTQdYm/yK3nh1xEDmf8HIGJKl3kRsGgZLNOC6CrtQBoTp32l
         zsWg==
X-Gm-Message-State: APjAAAUvo9IEqmWKBDaBYwvo/yXm4AffM/UTUZA1SfzpnN8kN6JWD64p
        Zx/PuIZBRZMUICqrN2wf7jIsWR7uqrw=
X-Google-Smtp-Source: APXvYqzWdwiKl7AypsUEuNDAGG3mV0bTa01bTSdGXxZwvJJjV9iSrOIjj28YH+SG6fAQ/WLNEpVkLQ==
X-Received: by 2002:a63:790c:: with SMTP id u12mr19839958pgc.424.1562171503462;
        Wed, 03 Jul 2019 09:31:43 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j15sm2978141pfr.146.2019.07.03.09.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:31:43 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 30/35] ntfs: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:31:37 +0800
Message-Id: <20190703163137.811-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 fs/ntfs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 3c4811469ae8..eed63f045bd5 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1158,14 +1158,14 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	 * map the mft record without deadlocking.
 	 */
 	rc = le32_to_cpu(ctx->attr->data.resident.value_length);
-	ir = kmalloc(rc, GFP_NOFS);
+	/* Copy the index root value (it has been verified in read_inode). */
+	ir = kmemdup((u8 *)ctx->attr +
+		le16_to_cpu(ctx->attr->data.resident.value_offset), rc, GFP_NOFS);
 	if (unlikely(!ir)) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	/* Copy the index root value (it has been verified in read_inode). */
-	memcpy(ir, (u8*)ctx->attr +
-			le16_to_cpu(ctx->attr->data.resident.value_offset), rc);
+
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ndir);
 	ctx = NULL;
-- 
2.11.0

