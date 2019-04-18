Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B4BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B727B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611135;
	bh=jwarXQ2rAaD+Lul8YZOEmkG7/qgB9YOYlc5Fd8EKVTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioneLa9pahmkZZ/B5seAz+9x+wPBmDgV4vusxSYjZDBAmIOPY0huGFIbtkAj2uFfF
	 nSJQYfKgB+1FBLq9COkXRM3svH/uWqnEjm1UPE3zMTpTgg7nBiIUh4wNTscGuk7oMg
	 tpTmILLOaasX0NDpGp8Gs9sxqfq8xtiB4k0KkSzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391983AbfDRSMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404023AbfDRSML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C853B20675;
        Thu, 18 Apr 2019 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611131;
        bh=jwarXQ2rAaD+Lul8YZOEmkG7/qgB9YOYlc5Fd8EKVTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNVZZ9QzjT9Nn7HkX4yvLWloyug3ryAQKN6PSW5I1QtDvJbk9fZ9I5Vq2TQaPFoQW
         H4V5cbNT0uVMlc4zu3B2ONPCQrsUtV+cuwWJ0g8BLFZxhh/43OPWgw5kSKcteY3tlO
         99/PgGEDKtwCXLxBki5NETJjN6xAfADgJVdMjMC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoli Feng <fengxiaoli0714@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 63/93] cifs: fix that return -EINVAL when do dedupe operation
Date:   Thu, 18 Apr 2019 19:57:41 +0200
Message-Id: <20190418160443.795009817@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b073a08016a10f01dfb0d0b6c7fa89da0d544963 ]

dedupe_file_range operations is combiled into remap_file_range.
But it's always skipped for dedupe operations in function
cifs_remap_file_range.

Example to test:
Before this patch:
  # dd if=/dev/zero of=cifs/file bs=1M count=1
  # xfs_io -c "dedupe cifs/file 4k 64k 4k" cifs/file
  XFS_IOC_FILE_EXTENT_SAME: Invalid argument

After this patch:
  # dd if=/dev/zero of=cifs/file bs=1M count=1
  # xfs_io -c "dedupe cifs/file 4k 64k 4k" cifs/file
  XFS_IOC_FILE_EXTENT_SAME: Operation not supported

Influence for xfstests:
generic/091
generic/112
generic/127
generic/263
These tests report this error "do_copy_range:: Invalid
argument" instead of "FIDEDUPERANGE: Invalid argument".
Because there are still two bugs cause these test failed.
https://bugzilla.kernel.org/show_bug.cgi?id=202935
https://bugzilla.kernel.org/show_bug.cgi?id=202785

Signed-off-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 07cad54b84f1..e8e125acd712 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1010,7 +1010,7 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	unsigned int xid;
 	int rc;
 
-	if (remap_flags & ~REMAP_FILE_ADVISORY)
+	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clone range\n");
-- 
2.19.1



