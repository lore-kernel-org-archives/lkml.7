Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12641205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712628;
	bh=2xZNKeDMlYI+rtCW7f+cvzDTy0aOvXxwBXGsUGoxXrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RfR0L4G30i5lKQ8sjxOcHk47u6MVgqe20J5AVgCR3em8GPAREiBkoD5Hfk43/EfXw
	 3mOGQ2H3VB0gWKYbMggQmXuWCQt7X3oOljhb2ZnK/RlIdmj5htatn0dxZ29QMAWhO6
	 66fCbNL99Zt3pFyluu6GZCYAIru6fBjcG0AAIayM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390704AbfC0Su0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390470AbfC0SSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD760217F9;
        Wed, 27 Mar 2019 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710699;
        bh=2xZNKeDMlYI+rtCW7f+cvzDTy0aOvXxwBXGsUGoxXrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niF6Xh/sp0hgHaQ3qPR6pYTruBE7UWBFq6v2ctkQ68XBNFBjOQ4t6KCVZiD3P5m0O
         Jix2GYBxGKq9cxVKxF7M383xh5irXh8tRyMoOesuTX0JpgSVUmoHLSYLwSEqEhtRQy
         LdP97A5+0D2dD/xEI/YAmbxsJCZf0lJ8/G+QxxUo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 062/123] vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1
Date:   Wed, 27 Mar 2019 14:15:26 -0400
Message-Id: <20190327181628.15899-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aurelien Jarno <aurelien@aurel32.net>

[ Upstream commit cc4b1242d7e3b42eed73881fc749944146493e4f ]

The preadv2 and pwritev2 syscalls are supposed to emulate the readv and
writev syscalls when offset == -1. Therefore the compat code should
check for offset before calling do_compat_preadv64 and
do_compat_pwritev64. This is the case for the preadv2 and pwritev2
syscalls, but handling of offset == -1 is missing in their 64-bit
equivalent.

This patch fixes that, calling do_compat_readv and do_compat_writev when
offset == -1. This fixes the following glibc tests on x32:
 - misc/tst-preadvwritev2
 - misc/tst-preadvwritev64v2

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/read_write.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 57a00ef895b2..1c3eada2fe25 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1235,6 +1235,9 @@ COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (pos == -1)
+		return do_compat_readv(fd, vec, vlen, flags);
+
 	return do_compat_preadv64(fd, vec, vlen, pos, flags);
 }
 #endif
@@ -1341,6 +1344,9 @@ COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (pos == -1)
+		return do_compat_writev(fd, vec, vlen, flags);
+
 	return do_compat_pwritev64(fd, vec, vlen, pos, flags);
 }
 #endif
-- 
2.19.1

