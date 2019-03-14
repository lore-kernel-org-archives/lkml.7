Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A90C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5F22087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FhYHOEPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCNHqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:46:16 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:58472 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:46:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 8162D9CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZlyW7OqZHaoY for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:46:14 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 536E1C25
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:46:14 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id l10so3620274iob.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c7GkyToJ/tCXVPEZaR++Al5CRz0mWCjmCLfiSrOb+P0=;
        b=FhYHOEPAihpJztIOL1ttd6hCf0HQUEfLVUaEjt067dN9BOYFMHdtzv9CxDXYXAtfis
         r+LRGdqyJKpOXM/XmLAjJB0N0xVn3V3g0V6mZzySykB9oqcwHX8k8VsaLV7+5UVkcc3b
         hjqAXTOKQQmohmmAwXjp5a2Ka09ImbUUOkyd8wM7zPygTRH4RhTFNZqucHeWCR1TAwlF
         GU7uFoGUc6x7OMuRu6QWuCg4ho6XDp56BiNjv9MtVkznXU9b2JIPYSuqc9CFYf1dlPMk
         7q+t8N1mdTgPtF4cK1TjZL4x+YqzwwaSDPBRvAvKAjiHQn2tc3gI5PSrh5EGVqQzYCva
         zedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c7GkyToJ/tCXVPEZaR++Al5CRz0mWCjmCLfiSrOb+P0=;
        b=c2bcmyw6IccNExMkHH6EQXxvjg5IgP1BhxqCDLwz0/Lc1otk+tjLO45y5MxguI4PUI
         kFJiPptletjWtfeFgKk02QSL83c/ZfD+wcj/Tocc9g+xm9qzSdiPzo/Pp9BzF5rzQzQz
         NN3LNOy1NzxP4obYHwHh9bIYsBMeBCvgZx3fnQaIXzzjyqJ22IrgriJewS/tTRvVrQg1
         dCS9tay7CMtzUw67F3rfUA7FnHnjTxGHOWT7feIKijqZ9nvwVgy7wGRf+0yJp+EynxQY
         01th2E8AGjVdDUCyJD1lW60yFUNfFgFJ8OsQPIwI6FW6zyUST2MBZvKIsh5iT1j4hhsa
         Zc2g==
X-Gm-Message-State: APjAAAXaXtsiOR+dDhnCOlYiVto6yn/r+gUt3v3ewPnxSIDj083eEBnt
        rYrWizZh4d20fvmQ9ToelpnbrGuP1DmsnyR2iqm/XXRMJGp5+US1t3Dd41lY2KM8ClbyYaJ+7Sf
        4OE+nLlizYZW2rWqXxqupHWb9sb17
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr23396923iog.281.1552549573925;
        Thu, 14 Mar 2019 00:46:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCLHZ4zyp7aNGCV1m4r8Zvof3vKBmsxNmlUKT0fHrLyzFJW+WNVgFQi84DveIS8GorrY9/LQ==
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr23396914iog.281.1552549573709;
        Thu, 14 Mar 2019 00:46:13 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id c1sm792474itd.23.2019.03.14.00.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:46:12 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, David Sterba <dsterba@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: affs: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 02:46:05 -0500
Message-Id: <20190314074607.28041-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If affs_bread fails, do not use ext_bh to avoid NULL pointer
 dereference

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/affs/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index a85817f54483..45b96faa40f1 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -835,7 +835,7 @@ void
 affs_truncate(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
-	u32 ext, ext_key;
+	u32 ext, ext_key, ext_bk;
 	u32 last_blk, blkcnt, blk;
 	u32 size;
 	struct buffer_head *ext_bh;
@@ -941,8 +941,12 @@ affs_truncate(struct inode *inode)
 		size = AFFS_SB(sb)->s_hashsize;
 		if (size > blkcnt - blk)
 			size = blkcnt - blk;
-		for (i = 0; i < size; i++, blk++)
-			affs_free_block(sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, i)));
+		if (ext_bh) {
+			for (i = 0; i < size; i++, blk++) {
+				ext_bk = AFFS_BLOCK(sb, ext_bh, i);
+				affs_free_block(sb, be32_to_cpu(ext_bk));
+			}
+		}
 		affs_free_block(sb, ext_key);
 		ext_key = be32_to_cpu(AFFS_TAIL(sb, ext_bh)->extension);
 		affs_brelse(ext_bh);
-- 
2.17.1

