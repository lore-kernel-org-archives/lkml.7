Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789752147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369175;
	bh=IJEtCEmhWjhOzOEgNoeNQzUyQM3kvnLJ6DZPHIl0K8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yaBZIamPAcU5jPe98KKWehZJMRjMXhASkXOtKxyimQhbCes3heCKMXhDaS36r5374
	 lKuAVL5J7dM736iyHjTPB2U2O4HiXAeo5eX99T+fazxTHwLcnPt9OP8+3S9/Coobv1
	 4VNlv9EN/LsluzlgUvObIkpTUUgfHWSS3gx1PKi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbfDDJMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732968AbfDDJMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A308520693;
        Thu,  4 Apr 2019 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369171;
        bh=IJEtCEmhWjhOzOEgNoeNQzUyQM3kvnLJ6DZPHIl0K8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHktE9aGX2kYN/n6Tp2O9+53oyU+N/iuTDOf1y0/U6orh+c5HW88xYABEvePXMSE3
         bUkrPHhBS+nUnJ5hfD5tCguV2Rxt5ARlWI7Wbvh61D8N7PqsG0rtHFLjv85Lu5eRQI
         nZp2CiNP3aLVwwcaxPaXrea0oeM++2nTqRSs3ORU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 123/246] vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1
Date:   Thu,  4 Apr 2019 10:47:03 +0200
Message-Id: <20190404084623.463351787@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
index ff3c5e6f87cf..27b69b85d49f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1238,6 +1238,9 @@ COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (pos == -1)
+		return do_compat_readv(fd, vec, vlen, flags);
+
 	return do_compat_preadv64(fd, vec, vlen, pos, flags);
 }
 #endif
@@ -1344,6 +1347,9 @@ COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd,
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



