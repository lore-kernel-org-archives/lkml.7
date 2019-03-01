Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B103A20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 20:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgxYSC/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCAUIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:08:47 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:55451 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAUIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 15:08:47 -0500
Received: by mail-io1-f74.google.com with SMTP id l10so18953254iob.22
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 12:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=piSjA100sPG+ZVsc61tYlQG0rjYRR09SCBtuiXgjxhM=;
        b=bgxYSC/ehJ6FBNakJ0m5/tTf2KBxYaQpAzLKlwcy7jR1t80VFKrMwnNeDXlP3Z1nru
         7m+n390IJB3XgiSo2r4Hh/kyGRpqiZrgaGdznj3XcNRPKZ+Uj70vplenlefyhyvQjNDy
         Q42LdCo/dgGa/Ad24E1/Ngk+rU03Ft0E2uJMPACRFycKWqTCS6gWCeUtKa689M1ob7qB
         5Igjom7HBf1gkacMiwMGpO/37y/iJp/hs/UmBPv/7Bp/1rISvajWCk0YRGL6qrLvAVT6
         J1ehvNA6IwiKyurA9aOmb/W8Pmi2Zfu8MpY0afQmf/YrguKdWc9xnkve7o9la1ICWI0v
         dGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=piSjA100sPG+ZVsc61tYlQG0rjYRR09SCBtuiXgjxhM=;
        b=tXltOnbBvraipJP5XoR1jzpAsUbrM5UX+qmXVUF+rMGU/AGM2z6ax4+fryw/yHNXrs
         E5IjmgmQ0pEiOAcAfzmZVIgDZ2w+saS5NIf48AhtsNY2z1IWWu8ThVOTCWw3sVLhpqQs
         4v9U2T7iv5RBYEReJ7ZoL2FC14ivQlW/UeZ4cPIHDTd34pLqYaWopU8zbzfSa3Tx1ujB
         JLTBzY4/6BA2HP2S/GqwlcxYBWxpYsj5yPPI2WbSr3oe5vGyLxIS7tYaT14wmD1MbkMr
         oD7zXLlx4Ud4/nNFLTTl65wfmPm6mwg5tx9JYtK7tLvmxHtWxljehJboWNb83ZFqjWnp
         VRAQ==
X-Gm-Message-State: APjAAAVb7PQ6a+P71jCt4YgNscpuTzzIc4xvZJQv4uiOq3JTuMD+0ba7
        5Oh+Yg5VcKEze3ycPqliVuXAywoj9Q==
X-Google-Smtp-Source: AHgI3IbWUIuiFA+Qg0y0EYTqXdZCBPzfYtTDj8A/+yAkITp6isykIvfFpC36+Aqq/49bvumggyZn60hgjw==
X-Received: by 2002:a24:548:: with SMTP id 69mr4077709itl.29.1551470925977;
 Fri, 01 Mar 2019 12:08:45 -0800 (PST)
Date:   Fri,  1 Mar 2019 21:08:35 +0100
Message-Id: <20190301200835.18286-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] fs: use KERNEL_DS instead of get_ds()
From:   Jann Horn <jannh@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, jannh@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_ds() is a legacy name for KERNEL_DS; all architectures #define it to
KERNEL_DS, and almost every user of set_fs() uses the name KERNEL_DS.

Let the VFS also use KERNEL_DS so that we can get rid of get_ds() at some
point.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/read_write.c | 6 +++---
 fs/splice.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index ff3c5e6f87cf..30df848b7451 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -426,7 +426,7 @@ ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 	ssize_t result;
 
 	old_fs = get_fs();
-	set_fs(get_ds());
+	set_fs(KERNEL_DS);
 	/* The cast to a user pointer is valid due to the set_fs() */
 	result = vfs_read(file, (void __user *)buf, count, pos);
 	set_fs(old_fs);
@@ -499,7 +499,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 		return -EINVAL;
 
 	old_fs = get_fs();
-	set_fs(get_ds());
+	set_fs(KERNEL_DS);
 	p = (__force const char __user *)buf;
 	if (count > MAX_RW_COUNT)
 		count =  MAX_RW_COUNT;
@@ -521,7 +521,7 @@ ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 	ssize_t res;
 
 	old_fs = get_fs();
-	set_fs(get_ds());
+	set_fs(KERNEL_DS);
 	/* The cast to a user pointer is valid due to the set_fs() */
 	res = vfs_write(file, (__force const char __user *)buf, count, pos);
 	set_fs(old_fs);
diff --git a/fs/splice.c b/fs/splice.c
index de2ede048473..ec8b54b5c0d2 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -357,7 +357,7 @@ static ssize_t kernel_readv(struct file *file, const struct kvec *vec,
 	ssize_t res;
 
 	old_fs = get_fs();
-	set_fs(get_ds());
+	set_fs(KERNEL_DS);
 	/* The cast to a user pointer is valid due to the set_fs() */
 	res = vfs_readv(file, (const struct iovec __user *)vec, vlen, &pos, 0);
 	set_fs(old_fs);
-- 
2.21.0.352.gf09ad66450-goog

