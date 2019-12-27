Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2B7C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB53F20643
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail-gwu-edu.20150623.gappssmtp.com header.i=@gwmail-gwu-edu.20150623.gappssmtp.com header.b="KcDYx5na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfL0EM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 23:12:28 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39356 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfL0EM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 23:12:27 -0500
Received: by mail-il1-f196.google.com with SMTP id x5so21554646ila.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 20:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail-gwu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:signed-off-by;
        bh=6aXkpopLn4foAB6+ffGtPcre5uzBvsKyE97XqmcC4Sg=;
        b=KcDYx5naRnZ7zNNwWsY5VYaVcY+lHlElceeq8l/ktIZW/PBOSHAoZJG0NmB/OE7Hpb
         Vzl07sFrHruG8HNHoGNMcXWdqwIDG2vRN5Vrasl2J4HvxAuai+IVJtOQOoPUBfiVlGs0
         dzSd7bMauBZgapLBaDZnMuYmqK7O2ifZjoenGbNLi4GTWF61Aj1mWcYvbtLfTxU7u3vt
         7TXhCSkKD4dskSm71lEVpXSxxEonSOuaI8DZ+lBx2mW+Sg4EHBKCP40NF1uBc5xiPhlw
         z/d+zooyeExkwSQCBuwofAbGIP8IzMesWVr0qMI5UFibunQkVVsbIwgVa/TUrTuJW6JC
         B8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:signed-off-by;
        bh=6aXkpopLn4foAB6+ffGtPcre5uzBvsKyE97XqmcC4Sg=;
        b=ArbA51pdbHvoP2pB56U6uGY7lVyFTw/X7zuDbMbjW9SpEEhU4ZF+krp1/GiaDcBNch
         pPHTK6VBiSQg0ViBKkKvGYOYiE9z57FoYGcKGc5TIiGwgqxZJpIhzLaVCo9aPvKSoekN
         JRyqP+7cVz2wvbcm4eiTNaOBBPm04VrrxyiZAM0KAX8DC28kin9R0kMafdEdg6MVzqPC
         luiVVCOrcBNwAng4LE9Kmr8N/ueDgmK2AZ0/3Nhutfgh+jJRdEiIPwFMwx1sbgRs4FAB
         rugc1ZF4vTzEfbgHjhwaFOpe8ootXb4OcpjMFBxfa8nrycDkKnunqWqeo/gpVGCVW9Bi
         5eog==
X-Gm-Message-State: APjAAAVCYERKV1Jj1tCIRq/QX0Yy4GCncfJwLFCUgd/ddx4L+AFcsUJx
        8SDifv34t26HIH27h+VIGzhpGg==
X-Google-Smtp-Source: APXvYqw4D+ZUYMlG3AScjOYOKGQ+G4dyjT2Yv/1aVANhTNcglZJ8sStvMsmYZss/znd8Qgkv84fB7Q==
X-Received: by 2002:a92:7509:: with SMTP id q9mr21168976ilc.67.1577419946795;
        Thu, 26 Dec 2019 20:12:26 -0800 (PST)
Received: from wenhui.pennst02.univepa.wayport.net ([12.197.38.68])
        by smtp.googlemail.com with ESMTPSA id j79sm12959436ila.52.2019.12.26.20.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 20:12:25 -0800 (PST)
From:   wenhuizhang <wenhui@gwmail.gwu.edu>
To:     wenhui@gwmail.gwu.edu
Cc:     James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Micah Morton <mortonm@chromium.org>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>
Date:   Thu, 26 Dec 2019 23:12:12 -0500
Message-Id: <20191227041214.24064-1-wenhui@gwmail.gwu.edu>
X-Mailer: git-send-email 2.17.1
Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selinux/lsm-common: reorder and format security hooks
  	Changes to be committed:
		modified:   include/linux/security.h
	Details:
		- add default hook for security_cred_getsecid
		- group hooks with functionalities and get coherent for orders
---
 include/linux/security.h | 46 +++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 3e8d4bacd59d..14f580e37b24 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -462,10 +462,6 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
-static inline void security_free_mnt_opts(void **mnt_opts)
-{
-}
-
 /*
  * This is the default capabilities functionality.  Most of these functions
  * are just stubbed out, but a few must call the proper capable code.
@@ -605,6 +601,9 @@ static inline int security_sb_alloc(struct super_block *sb)
 static inline void security_sb_free(struct super_block *sb)
 { }
 
+static inline void security_free_mnt_opts(void **mnt_opts)
+{ }
+
 static inline int security_sb_eat_lsm_opts(char *options,
 					   void **mnt_opts)
 {
@@ -679,20 +678,6 @@ static inline int security_move_mount(const struct path *from_path,
 	return 0;
 }
 
-static inline int security_path_notify(const struct path *path, u64 mask,
-				unsigned int obj_type)
-{
-	return 0;
-}
-
-static inline int security_inode_alloc(struct inode *inode)
-{
-	return 0;
-}
-
-static inline void security_inode_free(struct inode *inode)
-{ }
-
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
@@ -710,6 +695,19 @@ static inline int security_dentry_create_files_as(struct dentry *dentry,
 	return 0;
 }
 
+static inline int security_path_notify(const struct path *path, u64 mask,
+				unsigned int obj_type)
+{
+	return 0;
+}
+
+static inline int security_inode_alloc(struct inode *inode)
+{
+	return 0;
+}
+
+static inline void security_inode_free(struct inode *inode)
+{ }
 
 static inline int security_inode_init_security(struct inode *inode,
 						struct inode *dir,
@@ -982,8 +980,10 @@ static inline int security_prepare_creds(struct cred *new,
 
 static inline void security_transfer_creds(struct cred *new,
 					   const struct cred *old)
-{
-}
+{ }
+
+static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
+{ }
 
 static inline int security_kernel_act_as(struct cred *cred, u32 secid)
 {
@@ -1249,12 +1249,10 @@ static inline int security_secctx_to_secid(const char *secdata,
 }
 
 static inline void security_release_secctx(char *secdata, u32 seclen)
-{
-}
+{ }
 
 static inline void security_inode_invalidate_secctx(struct inode *inode)
-{
-}
+{ }
 
 static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-- 
2.17.1

