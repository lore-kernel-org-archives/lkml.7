Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F9BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B2F2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015595;
	bh=linNBckKpcBc1emALFvaHyGUGHu68qyYdlkxtYaWZxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PDQlGvGHdCnReZatR7d2geBck3iLP1iWWshFam4G5+ELdocDV1oHJ9kKFbPI9df3c
	 3bgrYSsaYd3WmGOt/QhbKHHZ2o5gto/KbZEhFqkeHGSLGXflCloNSIor5LTK1P7DQY
	 jF4lfG0Mii1tc8PKlLUplzTxAWJ5XvVmAoYIF/QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfLJWGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbfLJWF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:05:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83BB2073B;
        Tue, 10 Dec 2019 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015526;
        bh=linNBckKpcBc1emALFvaHyGUGHu68qyYdlkxtYaWZxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjgFn9segoq5XsF5LXME8jweRTzo+00M+t2HQwA3MOIUYDFaWCQ6qQkkTS0ReS69c
         hINqJMvQ1Y4CqnX98m4dXZHX1X+VW5Sb6ysdL13FDcGA7zwOI45NC9I3EuUlT9HV64
         geA0hJcjJ6D7BXCmtYQoIS3oSp7r1HAdESbJFR2A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 121/130] debugfs: Fix !DEBUG_FS debugfs_create_automount
Date:   Tue, 10 Dec 2019 17:02:52 -0500
Message-Id: <20191210220301.13262-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
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
index b93efc8feecd1..755033acd2b0d 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -77,6 +77,8 @@ static const struct file_operations __fops = {				\
 	.llseek  = no_llseek,						\
 }
 
+typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
+
 #if defined(CONFIG_DEBUG_FS)
 
 struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
@@ -98,7 +100,6 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 				      const char *dest);
 
-typedef struct vfsmount *(*debugfs_automount_t)(struct dentry *, void *);
 struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
 					debugfs_automount_t f,
@@ -227,7 +228,7 @@ static inline struct dentry *debugfs_create_symlink(const char *name,
 
 static inline struct dentry *debugfs_create_automount(const char *name,
 					struct dentry *parent,
-					struct vfsmount *(*f)(void *),
+					debugfs_automount_t f,
 					void *data)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.20.1

