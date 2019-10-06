Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581EC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04282053B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384115;
	bh=F8RTzDc+fECkTRNigXyurxf3VNTlrsOpbjYpgckPm38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IxSuFqX2cvdpWe4Gv3/kaBYG4rr9QJRTsmn71ULzqgQpDSr9u64hENR4kREBGol1M
	 YXyVb/1N+Iq7VT8rS9FojjackGSYNWIuCA3yNhuD6qOe8f32Kvv62+lh3KH0kR6OGT
	 ZLSUhi1+fEkw7jfTxMlbiZehm1YIeW6zBKI/XsyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfJFRsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730545AbfJFRnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:43:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C50B72087E;
        Sun,  6 Oct 2019 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383803;
        bh=F8RTzDc+fECkTRNigXyurxf3VNTlrsOpbjYpgckPm38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/p9H02V3J4l2ajVCpMia0Y7rG3w/ztBGzZH2z1OcQmHCVcyW2w0+/Yrn9zRHx4tZ
         rRaOhI2rrNsQxExzmZaoYKyaW4ZAuQcqbiWdc9GeQZKTulfVprzF+Cx5xT6HaQyRsB
         Hf7hf4HbXPJ1Rg0CnVEG+3miPHr1CrpQN3FFb09M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 102/166] selinux: fix residual uses of current_security() for the SELinux blob
Date:   Sun,  6 Oct 2019 19:21:08 +0200
Message-Id: <20191006171222.124230285@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>

[ Upstream commit 169ce0c081cd85f78388bb6c1638c1ad7b81bde7 ]

We need to use selinux_cred() to fetch the SELinux cred blob instead
of directly using current->security or current_security().  There
were a couple of lingering uses of current_security() in the SELinux code
that were apparently missed during the earlier conversions. IIUC, this
would only manifest as a bug if multiple security modules including
SELinux are enabled and SELinux is not first in the lsm order. After
this change, there appear to be no other users of current_security()
in-tree; perhaps we should remove it altogether.

Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/hooks.c          |  2 +-
 security/selinux/include/objsec.h | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 74dd46de01b6a..e755174647866 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3403,7 +3403,7 @@ static int selinux_inode_copy_up_xattr(const char *name)
 static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 					struct kernfs_node *kn)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 parent_sid, newsid, clen;
 	int rc;
 	char *context;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 91c5395dd20c2..586b7abd0aa73 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -37,16 +37,6 @@ struct task_security_struct {
 	u32 sockcreate_sid;	/* fscreate SID */
 };
 
-/*
- * get the subjective security ID of the current task
- */
-static inline u32 current_sid(void)
-{
-	const struct task_security_struct *tsec = current_security();
-
-	return tsec->sid;
-}
-
 enum label_initialized {
 	LABEL_INVALID,		/* invalid or not initialized */
 	LABEL_INITIALIZED,	/* initialized */
@@ -185,4 +175,14 @@ static inline struct ipc_security_struct *selinux_ipc(
 	return ipc->security + selinux_blob_sizes.lbs_ipc;
 }
 
+/*
+ * get the subjective security ID of the current task
+ */
+static inline u32 current_sid(void)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+
+	return tsec->sid;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
2.20.1



