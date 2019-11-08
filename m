Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F0C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39EC206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A8NLIWCi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GfWqVwQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfKHLEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:04:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHLEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:04:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2887460913; Fri,  8 Nov 2019 11:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573211052;
        bh=d85PiEzTKZnD4rW8ooec1lt7MpOUj9J4ixcs+n0zX9I=;
        h=From:To:Cc:Subject:Date:From;
        b=A8NLIWCigNLq8rWL3fhGp8qYpPpfNAQsUDH6Hvor1IKXBZPHwGOhrOidC9+NaUj3Y
         wm8NMY5+5Doi+ApMxd+ZACQjGn4gi08HpKJL/PHWzLWQmPyIbomje1uYeUcuB94hX/
         ESnVYf4t9g/3qAMHPly5aFHlg6d2cAQitpaGXSRE=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5021A602BD;
        Fri,  8 Nov 2019 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573211050;
        bh=d85PiEzTKZnD4rW8ooec1lt7MpOUj9J4ixcs+n0zX9I=;
        h=From:To:Cc:Subject:Date:From;
        b=GfWqVwQoV9Amr3ZDWp0foiRawDLhM6EebifTzZYdkktLhfYQGun36efBNw3/s58BF
         Y2X2HnRxr7fjM1Yh+rax2UK3bW0Q09eAZPIQ56QOCTlWR9dm5RmZVfnOYeZUin5WYt
         Dm7rjxmKbcgR36Ig1Tg597wOO7kCvFKb7Vt6idyk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5021A602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Fix deadlock under storage almost full/dirty condition
Date:   Fri,  8 Nov 2019 16:33:47 +0530
Message-Id: <1573211027-30785-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a potential deadlock when the storage capacity
is almost full and theren't enough free segments available, due
to which FG_GC is needed in the atomic commit ioctl as shown in
the below callstack -

schedule_timeout
io_schedule_timeout
congestion_wait
f2fs_drop_inmem_pages_all
f2fs_gc
f2fs_balance_fs
__write_node_page
f2fs_fsync_node_pages
f2fs_do_sync_file
f2fs_ioctl

If this inode doesn't have i_gc_failures[GC_FAILURE_ATOMIC] set,
then it waits forever in f2fs_drop_inmem_pages_all(), for this
atomic inode to be dropped. And the rest of the system is stuck
waiting for sbi->gc_mutex lock, which is acquired by f2fs_balance_fs()
in the stack above.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index da830fc..335ec09 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -300,7 +300,8 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 
 	if (inode) {
 		if (gc_failure) {
-			if (fi->i_gc_failures[GC_FAILURE_ATOMIC])
+			if (fi->i_gc_failures[GC_FAILURE_ATOMIC] ||
+				F2FS_I(inode)->inmem_task == current)
 				goto drop;
 			goto skip;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

