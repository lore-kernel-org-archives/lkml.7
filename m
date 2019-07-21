Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B96DC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E472085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3bTn74V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfGULXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:23:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42396 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfGULXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:23:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so16312801pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BslXCarilJmJ79dybTsD7hz/uDR7v6AMWJX0oUvPyXA=;
        b=T3bTn74V18iw1/9MyqaeY8D5Vn0btb8UV590yqmzfwsIsSm2+u5iU/xFBetV9CKyj9
         mh169LmzEOZQHlnCL3TxR2Am8JzNPD2BqAdOjaHnR195487KhCAAkbrUBuzk1o4RdZyi
         i4triTj/Cj+P3D3dJGR668epYtPjR9t4KXyX95nyh/UwfixjcEX3rgWjbzCNmFk+CeGa
         M2OWxkoELvbMG2h115an7lKv32XSE4CbzxhSxx0Iw/9uubIx4csMXRG2+zY8KGTSUoBI
         AvTARK9Imdrsy7NQqFMJkWaYBMshXeC9+Phl+UVRt4Csi3Mcb2xz2Nra2n1MGB/aklHE
         22vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BslXCarilJmJ79dybTsD7hz/uDR7v6AMWJX0oUvPyXA=;
        b=mE45DUZCV0ve4Cww4rfJuBDb6hURooJtJYoti3UOX0wMs39rserZ8XLxwThmLeVIec
         QAkZadCVzhw/f9ZC7HT1ZpwDTk5uwyqUBkmTXdKP/ml6G8DaliFWA6kzIKvF5QDcw+uP
         JQPsWY556l1kabKP57B1WQvcbT9rj02s8+Q4A9NJrHsC9F/nUHlqSWF8KALYUckwy70y
         Hp2bbtQwXSIgiI51aBCjY+t90/Gp1twiIZV9DyA3h+sZq9f8Zb5kFZaUzZesbxShkIgv
         VyPuuag8iIlx128Nys7cO4nmaI78TzTEgohtp5whb3laGghbaZstuWYy21YQBdA6k38Y
         iFtA==
X-Gm-Message-State: APjAAAUpbv+7ztDVypDLTyfB4AH753QpSDkgHwdxwLI74BbmsDz0TceT
        LJYQE+I7p39yiLsqoEG3LKk=
X-Google-Smtp-Source: APXvYqyuz1q4rMhRBgeklF3C1x+zJIycVSx/f4vbva7YQhTbqxhWkpot7nnnCKelPdsm+nfwnYu3bg==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr626348pgv.168.1563708212174;
        Sun, 21 Jul 2019 04:23:32 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id y128sm52700468pgy.41.2019.07.21.04.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 04:23:31 -0700 (PDT)
Date:   Sun, 21 Jul 2019 16:53:27 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/omfs: make use of kmemdup
Message-ID: <20190721112326.GA5927@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memcpy can be replaced with kmemdup.

fix below issue reported by coccicheck
./fs/omfs/inode.c:366:9-16: WARNING opportunity for kmemdup

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/omfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 08226a8..bc5a072 100644
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
2.7.4

