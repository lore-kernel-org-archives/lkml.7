Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30EFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16C621951
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j00M4OC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfGZDpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:45:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35502 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZDpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:45:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so23811959pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YEUR6IT4rKzLiHfE3iSnA+a3aUhdaLkp75DC5jJ9iFE=;
        b=j00M4OC8PCI2W3vPzRtVOnSDPCCvzDTcxlq4/I3ykR9QO7U9HQoARCPZwLTYj57IMR
         pESEkpWw+aZ3pl0j7yM0TuZgDnu+5C5cyBnjvmURhhvic0YztcSgmvWZZA+MUV83pdzj
         80nczhpBXjXna9OeLX9hoM8qUMSHABNlvR9PPWfPdWxH0SkhAeXYoPiasjd83GcHcXaU
         dUtEZ09LDnPesZK4OsnajvAHrnFjiMXbaDooJMdI/OSxVY4lFFhy9qsyd2yE+JXNHzPZ
         fG8lF5mPHWlwzoiCCrtoD1F5fr/zi8keUkyoR68ajaAmhDSNGDpwy/w88VKDzXvQ0Jo3
         pvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YEUR6IT4rKzLiHfE3iSnA+a3aUhdaLkp75DC5jJ9iFE=;
        b=WIIaZLmOoS7rNEre8UBi6l7/+PVRpsyDbTFv6NPa2sA+ukRbmSagNSEI3jSvIVQOhR
         znN7s68kPb15RAEm09WoYPvuD4CWm+7bY/EKl6wa/YmMN3itEy9QWjxTVdMWRLFYIRbC
         /YdVSyjiXiZIJLiQJc5QRTuHfpnXu2pHfZRqKmWpysqIVJnMlO11GQ5c6h+DEQVixv9t
         Ds8k5GIY2azWaJ6EP8csENp7BObvJ0o1Mkmea3HUWzW5fpg6z+//kJzkk+AdnAXOSv9d
         inOu5PXE20cpqTOtYZFEp2K0qYBCNoeTLhDwMPHyIXJ9bv15UHNuzSzB3XNmnYGDXknw
         3X1Q==
X-Gm-Message-State: APjAAAUEZ48pdzYSrCqnJy26jSjpjPf5cQHW5i3QTod6ENOPDbxwOEgG
        JC3GuXRP7SCQGgpGwdT2UCs=
X-Google-Smtp-Source: APXvYqyaJNHvmFnHtNTPgSf190jGCxD+R5RowGCCh5Euoe7WJmX+F0fbeguiW+l6reIVXxiRujt4ug==
X-Received: by 2002:a17:90a:37ac:: with SMTP id v41mr91718590pjb.6.1564112718669;
        Thu, 25 Jul 2019 20:45:18 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id h129sm48228710pfb.110.2019.07.25.20.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 20:45:18 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: f2fs: Remove unnecessary checks of SM_I(sbi) in update_general_status()
Date:   Fri, 26 Jul 2019 11:45:12 +0800
Message-Id: <20190726034512.32478-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fill_super() and put_super(), f2fs_destroy_stats() is called 
in prior to f2fs_destroy_segment_manager(), so if current
sbi can still be visited in global stat list, SM_I(sbi) should be
released yet.
For this reason, SM_I(sbi) does not need to be checked in
update_general_status().
Thank Chao Yu for advice.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/f2fs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 7706049d23bf..9b0bedd82581 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -67,7 +67,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->nr_rd_data = get_pages(sbi, F2FS_RD_DATA);
 	si->nr_rd_node = get_pages(sbi, F2FS_RD_NODE);
 	si->nr_rd_meta = get_pages(sbi, F2FS_RD_META);
-	if (SM_I(sbi) && SM_I(sbi)->fcc_info) {
+	if (SM_I(sbi)->fcc_info) {
 		si->nr_flushed =
 			atomic_read(&SM_I(sbi)->fcc_info->issued_flush);
 		si->nr_flushing =
@@ -75,7 +75,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->flush_list_empty =
 			llist_empty(&SM_I(sbi)->fcc_info->issue_list);
 	}
-	if (SM_I(sbi) && SM_I(sbi)->dcc_info) {
+	if (SM_I(sbi)->dcc_info) {
 		si->nr_discarded =
 			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
 		si->nr_discarding =
-- 
2.17.0

