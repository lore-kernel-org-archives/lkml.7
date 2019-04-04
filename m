Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F0DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7117A217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368219;
	bh=wJ74kGGv1lMzcHPDGzV96IPrARubRdOkfKjq4zHxfvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pM01tJ21Yzcd64FuhGjaD/8ngMVuv2lACqTCITA+zr2v+D18bAwpS18fomoqiptBk
	 sMslh/ULOLmdfrG03tszrG9450T/oTHDqbzIa7plg5Ihifj2UWJQQLGc8peQRAeMd/
	 VtJ2sIk+dmMW03YZ+ViuVQIJPfRlYxvGKO4niC1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfDDI45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbfDDI4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:56:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CC820882;
        Thu,  4 Apr 2019 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368214;
        bh=wJ74kGGv1lMzcHPDGzV96IPrARubRdOkfKjq4zHxfvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJjR8rxRx32ke3H3+5WIoca1rERior22S6WTT/EtDN3lGfgmFK9wlzZjao1cyKVlP
         B9eoiT9K2MKm7S1FYqzAuFBCYM2OkAw6yRE60r1udq7b/vFrnLsQEdw/nlllzi1izV
         aGqoquKXCsKpC/lgH0srn0RzM+3YV49p0qcBBPYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 064/121] vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1
Date:   Thu,  4 Apr 2019 10:47:32 +0200
Message-Id: <20190404084548.710638055@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



