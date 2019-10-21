Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B678ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922272084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfJUPGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:06:48 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:44544 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfJUPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:06:48 -0400
Received: from ramsan ([84.194.98.4])
        by albert.telenet-ops.be with bizsmtp
        id GF6m2100B05gfCL06F6mlV; Mon, 21 Oct 2019 17:06:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iMZGg-0004iu-Be; Mon, 21 Oct 2019 17:06:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iMZGg-0008Ry-9S; Mon, 21 Oct 2019 17:06:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Documentation: debugfs: Document debugfs helper for unsigned long values
Date:   Mon, 21 Oct 2019 17:06:45 +0200
Message-Id: <20191021150645.32440-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugfs_create_ulong() was added, it was not documented.

Fixes: c23fe83138ed7b11 ("debugfs: Add debugfs_create_ulong()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/filesystems/debugfs.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/debugfs.txt b/Documentation/filesystems/debugfs.txt
index 9e705026ac103b6f..50e8f91f2421ec04 100644
--- a/Documentation/filesystems/debugfs.txt
+++ b/Documentation/filesystems/debugfs.txt
@@ -93,8 +93,8 @@ the following functions can be used instead:
 
 These functions are useful as long as the developer knows the size of the
 value to be exported.  Some types can have different widths on different
-architectures, though, complicating the situation somewhat.  There is a
-function meant to help out in one special case:
+architectures, though, complicating the situation somewhat.  There are
+functions meant to help out in such special cases:
 
     void debugfs_create_size_t(const char *name, umode_t mode,
 			       struct dentry *parent, size_t *value);
@@ -102,6 +102,12 @@ function meant to help out in one special case:
 As might be expected, this function will create a debugfs file to represent
 a variable of type size_t.
 
+Similarly, there is a helper for variables of type unsigned long:
+
+    struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
+					struct dentry *parent,
+					unsigned long *value);
+
 Boolean values can be placed in debugfs with:
 
     struct dentry *debugfs_create_bool(const char *name, umode_t mode,
-- 
2.17.1

