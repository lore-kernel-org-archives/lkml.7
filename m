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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93466C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6855A2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncz+4Nxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGCQcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:32:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39098 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfGCQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:32:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so1536795pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FY+ZBBtXcmHqcIWsRbQ4qMYQ9CLYFu3E2aO2yWzMrUA=;
        b=ncz+4NxhM1cxYl3UgwPV4btCGh1174GprNdVwIpAWXJz6I5bvKFFEfPf5Zew80EQjq
         qmU0eOEeD2aGIIMd4AlAcu7wVwNlGBVCFBymAlmHqGR6ZFV0nfJ506DFl95qNsh/9AuH
         ag8re/SC6ebDbsx4XLUzeqUTGnFEu4DkM0qGzKE/rMT50bl3A6pxLfgc78EtqSVVWYR2
         9xUJV5JoTDj230DR2WFcTAgzthazOvVdfx3sEmPz85HMRblkEe2hMgOv6Ddey8QQHmzM
         9GubnNcV/jh1WqVaBBi3avLEy+cSvaXBHE4SDwtIlGd+GElRU8mhmWOnsUDqA5BKzi3e
         +3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FY+ZBBtXcmHqcIWsRbQ4qMYQ9CLYFu3E2aO2yWzMrUA=;
        b=iJnrW+cy4vno6FRJIjplBREyol0cMPm1TqoAtrJmlsyIbyND3f/a12cjyEyfjKy+23
         NN4+iB8HresfscJOll9gnw6ZM6E8lMZ/n/ae08ima/9vtYtsWFtWsem5+O+TzibAlTuf
         8UVMeOKGGur9rFMMHEb0RajJnR7Pjg+fd30P3y9bcKUV21EAMci62N0KDB9gBpL8ecNl
         IWO7209E6hi0opOBkLTI2wpRvumUm9O73FCLoCXmXoVIJPc/m1vOgO3gQPXYu3dI8esU
         kZmUNKOKByYoXWxBgkkTGckTkmmVcj0pS8SXzPHjnDzywRWjjs8Q1hXkI3RXBpu8haGk
         +5pw==
X-Gm-Message-State: APjAAAXdgv1UFHzA8ihUGLbIxaE0g0sIPsfxDbG47290IWtt+Q3B1q5z
        5yrMj6cNiFKQ/ISqN7RQg1Y=
X-Google-Smtp-Source: APXvYqy4RNABHR6FpDAN772vA0sEu4XwdGTGVimwrGr+s1fv0K3wRBwgvuEPHNZuBmo2cOzy0B5fTw==
X-Received: by 2002:a65:42c6:: with SMTP id l6mr39388184pgp.442.1562171529277;
        Wed, 03 Jul 2019 09:32:09 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id n89sm11315483pjc.0.2019.07.03.09.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:32:08 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 32/35] omfs: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:31:58 +0800
Message-Id: <20190703163158.937-1-huangfq.daxian@gmail.com>
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

 fs/omfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 08226a835ec3..1aa0c0a224b1 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -363,12 +363,11 @@ static int omfs_get_imap(struct super_block *sb)
 		bh = sb_bread(sb, block++);
 		if (!bh)
 			goto nomem_free;
-		*ptr = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
 		if (!*ptr) {
 			brelse(bh);
 			goto nomem_free;
 		}
-		memcpy(*ptr, bh->b_data, sb->s_blocksize);
 		if (count < sb->s_blocksize)
 			memset((void *)*ptr + count, 0xff,
 				sb->s_blocksize - count);
-- 
2.11.0

