Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF8CC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAA920838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017582;
	bh=JX7UUZWlO9ayH87pzAF1pvZZEwJqhaUyVWYYCxPecZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KwU6YS6RBF47AemPTpXLAQwgovP4GcyaaFiP3bv3GbV6XKMnx2dmZMj9Dln+8oEbD
	 C0jMtF+I110wyLN76SlgcUwnDj+MAMikcq3YHe3sl//O1xIwf8ychl/B09F08PBVBb
	 IK5l4YUJp8lgoBUQcLMCRLdB4mTBjGCmXyu0TTV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfLJWjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbfLJWcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:32:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA999206EC;
        Tue, 10 Dec 2019 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017137;
        bh=JX7UUZWlO9ayH87pzAF1pvZZEwJqhaUyVWYYCxPecZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sj1loNcKStQfUjkGjeS4nNmcujOKe4xco0MjfDLRoH8nASzeQYOEZcRLf0NeY4gKl
         xMpYqM59zq/N7hBb1EYbBya78Acyt6WbhvtsOwEwgSxqsvKib/iVGOLmtVgv2AoJdw
         6NDSIk2AYqbFqEDqcfa4lIzLemqGytapG5/xb048=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 85/91] debugfs: Fix !DEBUG_FS debugfs_create_automount
Date:   Tue, 10 Dec 2019 17:30:29 -0500
Message-Id: <20191210223035.14270-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kusanagi Kouichi <slash@ac.auone-net.jp>

[ Upstream commit 4250b047039d324e0ff65267c8beb5bad5052a86 ]

If DEBUG_FS=n, compile fails with the following error:

kernel/trace/trace.c: In function 'tracing_init_dentry':
kernel/trace/trace.c:8658:9: error: passing argument 3 of 'debugfs_create_automount' from incompatible pointer type [-Werror=incompatible-pointer-types]
 8658 |         trace_automount, NULL);
      |         ^~~~~~~~~~~~~~~
      |         |
      |         struct vfsmount * (*)(struct dentry *, void *)
In file included from kernel/trace/trace.c:24:
./include/linux/debugfs.h:206:25: note: expected 'struct vfsmount * (*)(void *)' but argument is of type 'struct vfsmount * (*)(struct dentry *, void *)'
  206 |      struct vfsmount *(*f)(void *),
      |      ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
Link: https://lore.kernel.org/r/20191121102021787.MLMY.25002.ppp.dion.ne.jp@dmta0003.auone-net.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/debugfs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index b20a0945b5500..7aea750538840 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -77,6 +77,8 @@ static const struct file_operations __fops = {				\
 	.llseek  = generic_file_llseek,					\
 }
 
+typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
+
 #if defined(CONFIG_DEBUG_FS)
 
 struct dentry *debugfs_create_file(const char *name, umode_t mode,
@@ -96,7 +98,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 				      const char *dest);
 
-typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
 struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
 					debugfs_automount_t f,
@@ -211,7 +212,7 @@ static inline struct dentry *debugfs_create_symlink(const char *name,
 
 static inline struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
-					struct vfsmount *(*f)(void *),
+					debugfs_automount_t f,
 					void *data)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.20.1

