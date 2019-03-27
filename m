Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5561421734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710921;
	bh=Eyh49VM6KiZsg7ILW3mv3eS0ykT4JNSXNdBuqlqujR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNZGiojhxKmSkeYr7R6lKMFpvips1TTjXPxQI+o7OU2jT8IyRVgeJzbbhh1s/T6Ff
	 ZzDkxVPGuRKyVnRISjRoTzWcAs1dSLeiIyBtejpnOi9OArntCbzka65hSyWrT0STP1
	 zMeZKR6fyd4DwI8SGurmw+drYRPsx1IeWDm6PNmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403786AbfC0SV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391242AbfC0SVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:21:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC1D20449;
        Wed, 27 Mar 2019 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710912;
        bh=Eyh49VM6KiZsg7ILW3mv3eS0ykT4JNSXNdBuqlqujR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FThvKf5x3boCVeV8Xo8lSmpNSnObnvdJC1d3NwYfXqlwq73scytY5dHOQTVanNq2y
         vSUv76MKbsG37XlBDWInj/CobhjLTqszOGbiC5LPAm7fhoBDZu+9dHyQtwzT+E4ZnE
         d+bbAlQcwTr6HljjiK0cODrB/8fo9heGlrjkErcU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 43/87] vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1
Date:   Wed, 27 Mar 2019 14:19:56 -0400
Message-Id: <20190327182040.17444-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
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
index 9819f7c6c8c5..6ab67b860159 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1204,6 +1204,9 @@ COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, int, flags)
 {
+	if (pos == -1)
+		return do_compat_readv(fd, vec, vlen, flags);
+
 	return do_compat_preadv64(fd, vec, vlen, pos, flags);
 }
 #endif
@@ -1310,6 +1313,9 @@ COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, int, flags)
 {
+	if (pos == -1)
+		return do_compat_writev(fd, vec, vlen, flags);
+
 	return do_compat_pwritev64(fd, vec, vlen, pos, flags);
 }
 #endif
-- 
2.19.1

