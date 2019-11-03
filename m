Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32380CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DBC214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKCSLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 13:11:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:44440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfKCSLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:11:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C422DB3E4;
        Sun,  3 Nov 2019 18:11:05 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] drivers/staging/exfat: Ensure we unlock upon error in ffsReadFile
Date:   Sun,  3 Nov 2019 10:09:21 -0800
Message-Id: <20191103180921.2844-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call was not releasing the mutex upon error.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/exfat/exfat_super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index e9e9868cae85..02dcfe06fc4f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -742,8 +742,10 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 			while (clu_offset > 0) {
 				/* clu = FAT_read(sb, clu); */
-				if (FAT_read(sb, clu, &clu) == -1)
-					return FFS_MEDIAERR;
+				if (FAT_read(sb, clu, &clu) == -1) {
+					ret = FFS_MEDIAERR;
+					goto out;
+				}
 
 				clu_offset--;
 			}
-- 
2.16.4

