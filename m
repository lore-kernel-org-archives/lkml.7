Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAF0C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963ED2168B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfJMRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfJMRoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 13:44:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 051752086A;
        Sun, 13 Oct 2019 17:44:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJhul-000233-65; Sun, 13 Oct 2019 13:44:19 -0400
Message-Id: <20191013174419.072698505@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 13 Oct 2019 13:43:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 07/11] tracing: Do not create tracefs files if tracefs lockdown is in effect
References: <20191013174342.381019558@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If on boot up, lockdown is activated for tracefs, don't even bother creating
the files. This can also prevent instances from being created if lockdown is
in effect.

Link: http://lkml.kernel.org/r/CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index eeeae0475da9..0caa151cae4e 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/tracefs.h>
 #include <linux/fsnotify.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/parser.h>
 #include <linux/magic.h>
@@ -390,6 +391,9 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	struct dentry *dentry;
 	struct inode *inode;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS))
+		return NULL;
+
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-- 
2.23.0


