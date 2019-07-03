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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A85DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB8D218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7CQM8ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGCNSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:18:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40868 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:18:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1241798pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hggecp1J+pdV9ln1gXz86pKkAe6jbFwdutsQVSWvACY=;
        b=X7CQM8ZDr3/XMvsumnENiXiDx1duWsXiknUhw75n4V1facoPscVA7J7IfiQPophGdg
         XBKrXL+iiozX6syhhUpNBpNdcc5sz8CjIUzTL2lv9zW1iTi/Gw3BSTFSaPVJl8iOqPpB
         hlz+rA6lYu3wASur3Sq0vB8d+Ymg/ABfezuuUVDE7qBaAlpT9X+328MomvAh77JyNd/B
         NggFpl7qR8ndKWqnZj2XUYftoE85ZwrRxk4E31Cs2kI3V9/o9tRLTDGxdTsskEDkQgTV
         ZniA0xUX9jCPKJlQKnrVQD6wK0Q4d8jZdqA07pXo14RQWcCIolMxw/7FWPrYgtCY8wJa
         ppgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hggecp1J+pdV9ln1gXz86pKkAe6jbFwdutsQVSWvACY=;
        b=nT6jP5drt7H26Xr4mc8ZIJzO56qLGA+8UPyFkdvQVdM/S0TScg5CzL38SRwN5s56VK
         T7GefWONu81HcNTCXJBE+l7/HOh9xF1Ls4bQJfMqYJ+0X80WB4iUFyEl9ZGUA+o+hxea
         lKYMIBuFo8FqQYr7iiNMAxkvh8o19tPD0C7/KnAn/TINBmngxqcDwlv9z6IsWsTopOu/
         fvZF3y/X0zSrXUaImVRv30OZ8eejObNSr3G2POK7n/t2bu+1rp1Kcf8g3SmS726mkMi5
         abRddqhN0/RVuVuzHlC5xsR/UnlHewiFAtflyH7bfv0oHc41ZvIhKI+b1GVEio9+2I9u
         S0ww==
X-Gm-Message-State: APjAAAXzb/onWZQMh7rJXKBqF8GlpLfVw9SbDzUv+xajQRXwdlG7QgLS
        coxQ9ysESIEfs3vfOizfmDA=
X-Google-Smtp-Source: APXvYqzz9NU0QsBtLGX+R5YXtiP12B3R/8sZ5cDSZ7uLONpeJjwUii/XvzHhR+vuqiWCqhIOPLLEZw==
X-Received: by 2002:a65:664d:: with SMTP id z13mr33374105pgv.99.1562159886867;
        Wed, 03 Jul 2019 06:18:06 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k19sm8183914pgl.42.2019.07.03.06.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:18:06 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 26/30] ntfs: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:17:58 +0800
Message-Id: <20190703131758.25875-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

