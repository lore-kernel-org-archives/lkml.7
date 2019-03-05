Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566F9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2604B2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fyufc54n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfCEKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:30:21 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59754 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfCEKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:30:21 -0500
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2D3A324A;
        Tue,  5 Mar 2019 11:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551781818;
        bh=6lAQ1prYCDKseDYgEhVq6K6sod7MLHVfu7HBibKB6M4=;
        h=From:To:Cc:Subject:Date:From;
        b=fyufc54nlcRmi1X1ikWKKBPsE3gjyVBZQ6mYcTkqOBN1LK72px9eg6QiBRNPkQY3O
         n8TjcuaBrnyspHC0evzMP7TTRLYVwurtTtG5AnnNHcsLTFiqWDmn3dYqW0XuNz+YJZ
         2rNedSnAq6ZIfbGvHl50rf/hHokxUR7JtAiszJjE=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Dan Robertson <danlrobertson89@gmail.com>,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v3] scripts/gdb: replace flags (MS_xyz -> SB_xyz)
Date:   Tue,  5 Mar 2019 10:30:14 +0000
Message-Id: <20190305103014.25847-1-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Since commit 1751e8a6cb93 ("Rename superblock flags (MS_xyz -> SB_xyz)"),
scripts/gdb should be updated to replace MS_xyz with SB_xyz.

This change didn't directly affect the running operation of scripts/gdb until
commit e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless
explicitly enabled" removed the definitions used by constants.py.

Update constants.py.in to utilise the new internal flags, matching the
implementation at fs/proc_namespace.c::show_sb_opts.

Cc: <stable@vger.kernel.org>
Fixes: e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled"
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
[Kieran: Add fixes tag, reword commit message]
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 scripts/gdb/linux/constants.py.in | 12 ++++++------
 scripts/gdb/linux/proc.py         | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 7aad82406422..d3319a80788a 100644
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
diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 0aebd7565b03..2f01a958eb22 100644
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
-- 
2.19.1

