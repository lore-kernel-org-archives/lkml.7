Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0500C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB96213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414356;
	bh=Ki4HRNe4pmJ51wuO8/lmIi9PQCbA/qabJmo1SqVWlqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dD83VotARy3yOE1h99I1me5qsZOHM0B3N1JhqHEbj1I2Q9EzNWi8NeYylZdPs0spn
	 UCGIjRpyhRDnbCf78f0EKp5IZjNt6U6GtKqnVbdWhHbrJyEiU0Lahma9H3YG+pq8+r
	 e8/Ux5WvZBsVYW5jzW3JwmnN3ERzzVvKosWJe8Bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfCLSMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfCLRLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:35 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E36F214AF;
        Tue, 12 Mar 2019 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410694;
        bh=Ki4HRNe4pmJ51wuO8/lmIi9PQCbA/qabJmo1SqVWlqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1KaUqX/uEmjTLdTPpW1Ng7DoD+uNyJlp/O+ErZIt939ugc2BdiZrNjaHug8BNsDx
         jN7UXNfnKVrE2eN3FMaTj333/UKCUduSAK/oJ239qXiCViLkGJ0saPverTC09t4SPe
         vzh3zcEwha6PS/uSumZS7HepdDsAj4U/1hup8cuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Dan Robertson <danlrobertson89@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 20/25] scripts/gdb: replace flags (MS_xyz -> SB_xyz)
Date:   Tue, 12 Mar 2019 10:08:58 -0700
Message-Id: <20190312170405.070629032@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

From: Jackie Liu <liuyun01@kylinos.cn>

commit 663cb6340c6e84fe29aa6d0fa63d85ea6bd6cd19 upstream.

Since commit 1751e8a6cb93 ("Rename superblock flags (MS_xyz ->
SB_xyz)"), scripts/gdb should be updated to replace MS_xyz with SB_xyz.

This change didn't directly affect the running operation of scripts/gdb
until commit e262e32d6bde "vfs: Suppress MS_* flag defs within the
kernel unless explicitly enabled" removed the definitions used by
constants.py.

Update constants.py.in to utilise the new internal flags, matching the
implementation at fs/proc_namespace.c::show_sb_opts.

Note to stable, e262e32d6bde landed in v5.0-rc1 (which was just
released), so we'll want this picked back to 5.0 stable once this patch
hits mainline (akpm just picked it up).  Without this, debugging a
kernel a kernel via GDB+QEMU is broken in the 5.0 release.

[kieran.bingham@ideasonboard.com: add fixes tag, reword commit message]
Link: http://lkml.kernel.org/r/20190305103014.25847-1-kieran.bingham@ideasonboard.com
Fixes: e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled"
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Dan Robertson <danlrobertson89@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/gdb/linux/constants.py.in |   12 ++++++------
 scripts/gdb/linux/proc.py         |   12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -37,12 +37,12 @@
 import gdb
 
 /* linux/fs.h */
-LX_VALUE(MS_RDONLY)
-LX_VALUE(MS_SYNCHRONOUS)
-LX_VALUE(MS_MANDLOCK)
-LX_VALUE(MS_DIRSYNC)
-LX_VALUE(MS_NOATIME)
-LX_VALUE(MS_NODIRATIME)
+LX_VALUE(SB_RDONLY)
+LX_VALUE(SB_SYNCHRONOUS)
+LX_VALUE(SB_MANDLOCK)
+LX_VALUE(SB_DIRSYNC)
+LX_VALUE(SB_NOATIME)
+LX_VALUE(SB_NODIRATIME)
 
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -114,11 +114,11 @@ def info_opts(lst, opt):
     return opts
 
 
-FS_INFO = {constants.LX_MS_SYNCHRONOUS: ",sync",
-           constants.LX_MS_MANDLOCK: ",mand",
-           constants.LX_MS_DIRSYNC: ",dirsync",
-           constants.LX_MS_NOATIME: ",noatime",
-           constants.LX_MS_NODIRATIME: ",nodiratime"}
+FS_INFO = {constants.LX_SB_SYNCHRONOUS: ",sync",
+           constants.LX_SB_MANDLOCK: ",mand",
+           constants.LX_SB_DIRSYNC: ",dirsync",
+           constants.LX_SB_NOATIME: ",noatime",
+           constants.LX_SB_NODIRATIME: ",nodiratime"}
 
 MNT_INFO = {constants.LX_MNT_NOSUID: ",nosuid",
             constants.LX_MNT_NODEV: ",nodev",
@@ -184,7 +184,7 @@ values of that process namespace"""
             fstype = superblock['s_type']['name'].string()
             s_flags = int(superblock['s_flags'])
             m_flags = int(vfs['mnt']['mnt_flags'])
-            rd = "ro" if (s_flags & constants.LX_MS_RDONLY) else "rw"
+            rd = "ro" if (s_flags & constants.LX_SB_RDONLY) else "rw"
 
             gdb.write(
                 "{} {} {} {}{}{} 0 0\n"


