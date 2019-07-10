Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A1C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2F20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYGD6l44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfGJTGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:06:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34680 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGJTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:06:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so5301522wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahAFNDw3YnaumJC5YUU159SXkDcebAJzvmRPCMuE2B0=;
        b=IYGD6l44OnouJsX8eAShejGMGjJCPGZTzH6CFET8s9ZeYw4XYmNFmhNg+mNyAX992D
         R/sgu2vPFcBTtZ/u2Sff00a/hKYvEkjIzcr+Oq7mDhJ1ej+qS75KXOXfZRDTUVVVnP1R
         bysT/yU3xBYIP/Pvduzlbfb5A2wWlKRIrJseHMknRx8/AWgZkYcsOWC8TheUbhhU+0Bm
         hCnk9Lo1VQ6QXtF2YQ3xYRCpSW2E4H9s+FYVRqCR37WOu33RrjJeBqakAB9MwayN5W6B
         EazrJuoAHAhX0ll0uZ/X0vqTVnxOPD0ZKxM4Jd98QqjndxWFNg7VRxPExtuHAUXjV/oT
         NB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahAFNDw3YnaumJC5YUU159SXkDcebAJzvmRPCMuE2B0=;
        b=Cb2FaYVLWXPjWmRwZZrT3chjfNlPCZwVECCcbEM9IJsfbpO+VzVd9fi4rppmepa40o
         RP3saUB3wr1tU4Tcx0CJIfGiC4zJ+WRzhpOoi/o3PjsQxNpGaoVCw4ZhwrL+KYXLNeb2
         n3i8x5IlMcRMza8GJDYwREtr0SKgadReRv+Tn/4/fVykXTg58F7P8H4UOpxlYqIGErwG
         WW7I7GsXP1n/P+gTbPTL1EZ28Xz0eF6ax17s2l/HyxDoGOCIDRxotnrgy8gVVWS4//d9
         3znFHXOjuxAg+NPfPCoziX4xLk8eOzI2+JiS1BXu1syOna7M3UkWiN0wUpQ1rv04J0C+
         4igQ==
X-Gm-Message-State: APjAAAVI5E4MlapU7DQ+CD/+WbfY4v9XShe84RuJYXpL6oD5mljt/g2i
        YSV0MRCRD1L243Hwbw5FqVU=
X-Google-Smtp-Source: APXvYqzhlDMeVFAI73XwFECAAb6SYmFQQKLhVVxISeDmq0B8r5ie+QmPb4ZEQiMQDypfEaty0CMI7g==
X-Received: by 2002:a1c:7e14:: with SMTP id z20mr6357789wmc.83.1562785591085;
        Wed, 10 Jul 2019 12:06:31 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-177-233-205.red.bezeqint.net. [79.177.233.205])
        by smtp.gmail.com with ESMTPSA id o11sm3308588wmh.37.2019.07.10.12.06.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:06:30 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     keescook@chromium.org, casey@schaufler-ca.com,
        james.morris@microsoft.com, efremov@ispras.ru,
        viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, carmeli.tamir@gmail.com
Subject: [PATCH] security/lsm_hooks: Updated set/remove xattr documentation
Date:   Wed, 10 Jul 2019 15:06:07 -0400
Message-Id: <20190710190607.5026-1-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inode_setxattr and inode_removexattr hooks check for CAP_SYS_ADMIN
capability when no LSMs exist. When LSMs exist, the hook expects
them to check for capabilities - which SMACK and SELinux indeed do.

This behavior is only mentioned in a comment in the 
hooks' implementation. This patch makes it clearer for 
LSM programmers that when implememting these hooks they are
responsible for the CAP check.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 include/linux/lsm_hooks.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cfb6a19..d16c88a31ea9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -377,7 +377,8 @@
  *	Return 0 if permission is granted.
  * @inode_setxattr:
  *	Check permission before setting the extended attributes
- *	@value identified by @name for @dentry.
+ *	@value identified by @name for @dentry. Note that the hook
+ *	is responsible to check for capabilities.
  *	Return 0 if permission is granted.
  * @inode_post_setxattr:
  *	Update inode security field after successful setxattr operation.
@@ -392,7 +393,8 @@
  *	Return 0 if permission is granted.
  * @inode_removexattr:
  *	Check permission before removing the extended attribute
- *	identified by @name for @dentry.
+ *	identified by @name for @dentry. Note that the hook
+ *	is responsible to check for capabilities.
  *	Return 0 if permission is granted.
  * @inode_getsecurity:
  *	Retrieve a copy of the extended attribute representation of the
-- 
2.21.0

