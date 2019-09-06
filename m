Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A6FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C13220650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393333AbfIFNiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:38:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43751 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389779AbfIFNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:38:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6ERI-000166-RF; Fri, 06 Sep 2019 13:38:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: make two arrays static const, makes object smaller
Date:   Fri,  6 Sep 2019 14:38:12 +0100
Message-Id: <20190906133812.17196-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays on the stack but instead make them
static const. Makes the object code smaller by 386 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  17443	   2076	      0	  19519	   4c3f	fs/9p/vfs_inode_dotl.o

After:
   text	   data	    bss	    dec	    hex	filename
  16897	   2236	      0	  19133	   4abd	fs/9p/vfs_inode_dotl.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/9p/vfs_inode_dotl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 60328b21c5fb..961d8d0fa905 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -167,7 +167,7 @@ static int v9fs_mapped_dotl_flags(int flags)
 {
 	int i;
 	int rflags = 0;
-	struct dotl_openflag_map dotl_oflag_map[] = {
+	static const struct dotl_openflag_map dotl_oflag_map[] = {
 		{ O_CREAT,	P9_DOTL_CREATE },
 		{ O_EXCL,	P9_DOTL_EXCL },
 		{ O_NOCTTY,	P9_DOTL_NOCTTY },
@@ -512,7 +512,7 @@ static int v9fs_mapped_iattr_valid(int iattr_valid)
 {
 	int i;
 	int p9_iattr_valid = 0;
-	struct dotl_iattr_map dotl_iattr_map[] = {
+	static const struct dotl_iattr_map dotl_iattr_map[] = {
 		{ ATTR_MODE,		P9_ATTR_MODE },
 		{ ATTR_UID,		P9_ATTR_UID },
 		{ ATTR_GID,		P9_ATTR_GID },
-- 
2.20.1

