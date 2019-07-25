Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5009C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2BA22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564066380;
	bh=aA2TJGFrTFD2kniTHTChUAByBdRuVeG5Y7UlnhgOl/0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kFPcrFw2kMY0bm43s+faqZSkQnSgCPnm3bboMpAjZmORKHuIRPFYSjf9pVXnnUxt1
	 dIwJB8mMCDUJrK3HY+ZRTMnWwbXsvBipfqVIj8Q7ou3d10yEDaLzUccRHM8NqbOO5T
	 LYSIqBDvoRUMtDB/ZCjiopYyH4KdZS86blCovFbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfGYOw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfGYOw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:52:58 -0400
Received: from localhost.localdomain (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4667722BF5;
        Thu, 25 Jul 2019 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564066378;
        bh=aA2TJGFrTFD2kniTHTChUAByBdRuVeG5Y7UlnhgOl/0=;
        h=From:To:Cc:Subject:Date:From;
        b=o+nDEGl+dM89r2UXqrtgV3BraDJpIwnjFi2mVg9qmzUGnrxJO8NI3kLMvPWigPg9l
         a+AJK6oxKLIm4o0+9umaxohysG+PYu9NTFU2nCUM3I2+hD+TzJoJWcvLLPasngwNDA
         vho/N14ahAos9eQ3qy55bV/2vICO22/QV1tD38hE=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: disallow direct IO in atomic write
Date:   Thu, 25 Jul 2019 22:39:11 +0800
Message-Id: <20190725143911.28468-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Atomic write needs page cache to cache data of transaction,
direct IO should never be allowed in atomic write, detect
and deny it when open atomic write file.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 43d878f3db0f..34de73be2cc9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1842,6 +1842,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
+	if (filp->f_flags & O_DIRECT)
+		return -EINVAL;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
-- 
2.22.0

