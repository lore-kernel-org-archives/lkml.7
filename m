Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ACAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3E1208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfIAPWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:22:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43465 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIAPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:22:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i4Rgp-0002Pi-Gp; Sun, 01 Sep 2019 15:22:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] autofs: remove redundant assignment to variable err
Date:   Sun,  1 Sep 2019 16:22:51 +0100
Message-Id: <20190901152251.11374-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable err is being assigned a value that is never read and
is being re-assigned a little later on. The assignment is redundant
and hence can be removed.

Addresses-Coverity: ("Ununsed value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/autofs/dev-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index a3cdb0036c5d..65d84b4d4464 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -422,7 +422,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	struct autofs_info *ino;
 	struct path path;
 	dev_t devid;
-	int err = -ENOENT;
+	int err;
 
 	/* param->path has been checked in validate_dev_ioctl() */
 
-- 
2.20.1

