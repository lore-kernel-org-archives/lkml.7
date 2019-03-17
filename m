Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E8BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C7B20854
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCQXJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:09:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55271 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfCQXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 19:09:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5etx-0006Eq-WF; Sun, 17 Mar 2019 23:09:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hostfs: fix mismatch between link_file definition and declaration
Date:   Sun, 17 Mar 2019 23:09:09 +0000
Message-Id: <20190317230909.7373-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function link_file declaration in the header file has the order
of the two arguments (from, to) swapped when compared to the definition
arguments of (to, from).  Fix this by swapping them around to match
the definition.

This error predates the git history, so no idea when this error
was introduced.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/hostfs/hostfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index 33b8423ef0c9..f4295aa19350 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -87,7 +87,7 @@ extern int do_mkdir(const char *file, int mode);
 extern int hostfs_do_rmdir(const char *file);
 extern int do_mknod(const char *file, int mode, unsigned int major,
 		    unsigned int minor);
-extern int link_file(const char *from, const char *to);
+extern int link_file(const char *to, const char *from);
 extern int hostfs_do_readlink(char *file, char *buf, int size);
 extern int rename_file(char *from, char *to);
 extern int rename2_file(char *from, char *to, unsigned int flags);
-- 
2.20.1

