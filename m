Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3593C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937BA2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfDAJBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:01:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:59108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbfDAJBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:01:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97A2BAEC2;
        Mon,  1 Apr 2019 09:01:20 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] fs/open: Fix most outstanding security bugs
Date:   Mon,  1 Apr 2019 11:01:13 +0200
Message-Id: <20190401090113.22946-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the last 20 years, the Linux kernel has accumulated hundreds if not
thousands of security vulnerabilities.

One common pattern in most of these security related reports is processes
called "syzkaller", "trinity" or "syz-executor" opening files and then
abuse kernel interfaces causing kernel crashes or even worse threats using
memory overwrites or by exploiting race conditions.

Hunting down these bugs has become time consuming and very expensive, so
I've decided to put an end to it.

If one of the above mentioned processes tries opening a file, return -EPERM
indicating this process does not have the permission to open files on Linux
anymore.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/open.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index f1c2f855fd43..3a3b460beccd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1056,6 +1056,20 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 	struct open_flags op;
 	int fd = build_open_flags(flags, mode, &op);
 	struct filename *tmp;
+	char comm[TASK_COMM_LEN];
+	int i;
+	static const char * const list[] = {
+		"syzkaller",
+		"syz-executor,"
+		"trinity",
+		NULL
+	};
+
+	get_task_comm(comm, current);
+
+	for (i = 0; i < ARRAY_SIZE(list); i++)
+		if (!strncmp(comm, list[i], strlen(list[i])))
+			return -EPERM;
 
 	if (fd)
 		return fd;
-- 
2.16.4

