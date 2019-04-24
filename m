Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECFEC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA86218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyxVWfA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfDXAP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:15:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39005 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfDXAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:15:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so8314088pfo.6;
        Tue, 23 Apr 2019 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h9bNhb/vyVI8CKaP4voIFfDYS/TIEFClb5DV8TzqYBo=;
        b=NyxVWfA6b3lwfqX0Bt2LiGHyJgN7my9cHOcHQ+EswGBahIzm3rWa4Dc6YqEq4YFTOH
         WgSkqBAKF2MToU3LdMAZXok9TiXu777a/uYSwE2g4eSPtkQ4p6680kaOjwvtnFmhzRq2
         wSxenJJpIoz3ejvm7rz1txhnIJauG0N2lo0LtGQGakRFZ5qeq+V+X7v9icD4MMC0leBq
         usyiNJ4c40lkQsVdeVTGYRWgxGw/n4r4Ix0+le0eaSWNxjRc9kJh5shy1XuD9He3JE2P
         45mLmfUGBa0xorKpc0p+/+iW+gRCHjU25ojQjOSnjX02l1MRYVcRgQbbHCYf98jSnyb3
         Y+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h9bNhb/vyVI8CKaP4voIFfDYS/TIEFClb5DV8TzqYBo=;
        b=MDrISQruprB7WhyY7VNI3nOn3NvVRZkHDQ36MZlHMFGimsRdr+FhFlnqmcdtJWJL2H
         MQjGL8l6Gf+V0CnX15QIJ5NtPiVVIcvRkcRRyqa8JIcgLDv510p3keoVJMiiYV4l+d4S
         aPgEgUJyhgfTGw+CnkR9jnTiHF2eX0VMj4/mz8i7k/IzxuAZtrxHT2/nlII/4mcJ9fgJ
         r/WKXtWxdgQgHo90pHo0zbD58+8PUZlKjxWW6aygwTwsr6TyYq3mEyub0BLHvKYkVmNi
         tIc1dKexbEUzMV53nW/iAp0lsBbnCvkHOnmK1pfv6J8NHxeIAjGL01uWs7TkQBGjOMC8
         bVSg==
X-Gm-Message-State: APjAAAUABdA7rIond7ptqQF4SIoZImkmE1LfNatHPEIou5pkQTrqEU5+
        yAXozGyrQ0i+qxSOEXEwp9WT0NNo1Os=
X-Google-Smtp-Source: APXvYqx6zsxArmk1PlcFE8b98yBbT3SpkJMQqpVj79Dy/DNwMKo3SYcY8GBVRcmP671IJ/+q+NlXUA==
X-Received: by 2002:a63:575e:: with SMTP id h30mr27650448pgm.54.1556064954844;
        Tue, 23 Apr 2019 17:15:54 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:1:d4f:4d24:45fa:d461])
        by smtp.gmail.com with ESMTPSA id n21sm58955712pfb.42.2019.04.23.17.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 17:15:53 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Prakhar Srivastava <prsriva@microsoft.com>
Subject: [PATCH v2 4/5 RFC] added a buffer_check LSM hook
Date:   Tue, 23 Apr 2019 17:15:43 -0700
Message-Id: <20190424001544.7188-4-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424001544.7188-1-prsriva02@gmail.com>
References: <20190424001544.7188-1-prsriva02@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

Signed-off-by: Prakhar Srivastava <prsriva@microsoft.com>
---
Currently for soft reboot(kexec_file_load) the kernel file and
signature is measured by IMA. The cmdline args used to load the kernel
is not measured.
The boot aggregate that gets calculated will have no change since the
EFI loader has not been triggered.
Adding the kexec cmdline args measure and kernel version will add some
attestable criteria.

This patch adds a LSM hook for buffer_check
Suggested by Mimi Zohar

 include/linux/lsm_hooks.h | 3 +++
 include/linux/security.h  | 5 +++++
 security/security.c       | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 080f34e66017..854bf3cac716 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1568,6 +1568,8 @@ union security_list_options {
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
 
+	int (*buffer_check)(const void *buff, int size, const char *eventname);
+
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
 					struct sock *newsk);
@@ -1813,6 +1815,7 @@ struct security_hook_heads {
 	struct list_head inode_notifysecctx;
 	struct list_head inode_setsecctx;
 	struct list_head inode_getsecctx;
+	struct list_head buffer_check;
 #ifdef CONFIG_SECURITY_NETWORK
 	struct list_head unix_stream_connect;
 	struct list_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index af675b576645..cbba0e119234 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -377,6 +377,8 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+
+void security_buffer_measure(const void *buff, int size, char *eventname);
 #else /* CONFIG_SECURITY */
 struct security_mnt_opts {
 };
@@ -776,6 +778,9 @@ static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
 	*secid = 0;
 }
 
+static inline void security_buffer_measure(const void *buff, int size, char *eventname)
+{ }
+
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 38316bb28b16..a0dfdb015412 100644
--- a/security/security.c
+++ b/security/security.c
@@ -320,6 +320,13 @@ int security_bprm_check(struct linux_binprm *bprm)
 	return ima_bprm_check(bprm);
 }
 
+void security_buffer_measure(const void *buff, int size, char *eventname)
+{
+	call_void_hook(buffer_check, buff, size, eventname);
+	return ima_buffer_check(buff, size, eventname);
+}
+
+
 void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
 	call_void_hook(bprm_committing_creds, bprm);
-- 
2.17.1

