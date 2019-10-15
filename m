Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A12C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EA92067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfJOKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:35:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:41707 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfJOKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:35:09 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKKAR-0006p1-Nx; Tue, 15 Oct 2019 11:35:03 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKKAR-0007DP-Cm; Tue, 15 Oct 2019 11:35:03 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/namespace: add __user to open_tree and move_mount syscalls
Date:   Tue, 15 Oct 2019 11:35:02 +0100
Message-Id: <20191015103502.27691-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thw open_tree and move_mount syscalls take names from the
user, so add the __user to these to ensure the following
warnings from sparse are fixed:

fs/namespace.c:2392:35: warning: incorrect type in argument 2 (different address spaces)
fs/namespace.c:2392:35:    expected char const [noderef] <asn:1> *name
fs/namespace.c:2392:35:    got char const *filename
fs/namespace.c:3541:38: warning: incorrect type in argument 2 (different address spaces)
fs/namespace.c:3541:38:    expected char const [noderef] <asn:1> *name
fs/namespace.c:3541:38:    got char const *from_pathname
fs/namespace.c:3550:36: warning: incorrect type in argument 2 (different address spaces)
fs/namespace.c:3550:36:    expected char const [noderef] <asn:1> *name
fs/namespace.c:3550:36:    got char const *to_pathname

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/namespace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b87b127fdce4..ed37564ccbb3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2356,7 +2356,7 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 	return file;
 }
 
-SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
+SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
 {
 	struct file *file;
 	struct path path;
@@ -3515,8 +3515,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
  * Note the flags value is a combination of MOVE_MOUNT_* flags.
  */
 SYSCALL_DEFINE5(move_mount,
-		int, from_dfd, const char *, from_pathname,
-		int, to_dfd, const char *, to_pathname,
+		int, from_dfd, const char __user *, from_pathname,
+		int, to_dfd, const char __user *, to_pathname,
 		unsigned int, flags)
 {
 	struct path from_path, to_path;
-- 
2.23.0

