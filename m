Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72FB217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDKE2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:28:07 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:36571
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbfDKE2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 00:28:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AiCQAUwa5c/+g/0HZlHgEGBwaBZYI?=
 =?us-ascii?q?RgTgzJ4QOk38BAQEBAQEGgRA4a4hIhHCMCyMYAYRAhW0iOBIBAQMBAQEIAQE?=
 =?us-ascii?q?BAQJtKIV0BFIoDQIYDgJJFhOFCwyrPXwzGgKKEoELJYtHF3iBB4ERM4Iqc4d?=
 =?us-ascii?q?OglcDjRWFHDuTHgmUBxqCBoloA4hyAS2MQ5RyIYFWTS4KgyeQWTUwgQUBAY9?=
 =?us-ascii?q?mAQE?=
X-IPAS-Result: =?us-ascii?q?A2AiCQAUwa5c/+g/0HZlHgEGBwaBZYIRgTgzJ4QOk38BA?=
 =?us-ascii?q?QEBAQEGgRA4a4hIhHCMCyMYAYRAhW0iOBIBAQMBAQEIAQEBAQJtKIV0BFIoD?=
 =?us-ascii?q?QIYDgJJFhOFCwyrPXwzGgKKEoELJYtHF3iBB4ERM4Iqc4dOglcDjRWFHDuTH?=
 =?us-ascii?q?gmUBxqCBoloA4hyAS2MQ5RyIYFWTS4KgyeQWTUwgQUBAY9mAQE?=
X-IronPort-AV: E=Sophos;i="5.60,336,1549900800"; 
   d="scan'208";a="156305197"
Received: from unknown (HELO pluto.themaw.net) ([118.208.63.232])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 11 Apr 2019 12:28:03 +0800
Subject: [PATCH] vfs: update d_make_root() description
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 11 Apr 2019 12:28:02 +0800
Message-ID: <155495688227.8321.9167555170089867027.stgit@pluto.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearify d_make_root() usage, error handling and cleanup
requirements.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/porting |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index cf43bc4dbf31..1ebc1c6eb64b 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -428,8 +428,19 @@ release it yourself.
 --
 [mandatory]
 	d_alloc_root() is gone, along with a lot of bugs caused by code
-misusing it.  Replacement: d_make_root(inode).  The difference is,
-d_make_root() drops the reference to inode if dentry allocation fails.  
+misusing it.  Replacement: d_make_root(inode).  On success d_make_root(inode)
+allocates and returns a new dentry instantiated with the passed in inode.
+On failure NULL is returned and the passed in inode is dropped so failure
+handling need not do any cleanup for the inode. If d_make_root(inode)
+is passed a NULL inode it returns NULL and also requires no further
+error handling. Typical usage is:
+
+	inode = foofs_new_inode(....);
+	s->s_root = d_make_inode(inode);
+	if (!s->s_root)
+		/* Nothing needed for the inode cleanup */
+		return -ENOMEM;
+	...
 
 --
 [mandatory]

