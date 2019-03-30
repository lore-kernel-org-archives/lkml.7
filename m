Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B13C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F756218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909336;
	bh=A5basc301t+TI0orIEoilM9bLr/4sljV1uhd0o54rxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YQf5wubdvFuzpb5kZ3sxjYOPzNzQUW9+c8URrbJJUTlpd8cxCsOz7PKHEGUz6QsU1
	 fySprBpzuHFpRf+sceNKiH4IU0EiWtoyM398PgMRVVm5TprVMPIm8szoAR+ob+YmqT
	 7EQcdds4cK/L/3cu1j/ebq2vuMsfq22fZrNCw4qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfC3B2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730462AbfC3B2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:28:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9382184C;
        Sat, 30 Mar 2019 01:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909326;
        bh=A5basc301t+TI0orIEoilM9bLr/4sljV1uhd0o54rxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYQLv7qYjBeKD+2LPunQDsq7wD/kRJqxVWHc82luGKVjta3l+UNtuJOe2I6E9GeAl
         9tBDNZ8Bl1r3+bPXNUxdfrUjthMFSrEWpHSqJ1Ro/xZCbeFI6aoTbcX3+pTWBlODOA
         zrZpByWGOwC1Kh5ZeyrktcEqJOxoi0V8HIenU3Ps=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 03/25] lkdtm: Add tests for NULL pointer dereference
Date:   Fri, 29 Mar 2019 21:28:20 -0400
Message-Id: <20190330012842.32091-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012842.32091-1-sashal@kernel.org>
References: <20190330012842.32091-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 59a12205d3c32aee4c13ca36889fdf7cfed31126 ]

Introduce lkdtm tests for NULL pointer dereference: check access or exec
at NULL address, since these errors tend to be reported differently from
the general fault error text. For example from x86:

    pr_alert("BUG: unable to handle kernel %s at %px\n",
        address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
        (void *)address);

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/lkdtm/core.c  |  2 ++
 drivers/misc/lkdtm/lkdtm.h |  2 ++
 drivers/misc/lkdtm/perms.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..f0f9eb30bd2b 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -152,7 +152,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(EXEC_VMALLOC),
 	CRASHTYPE(EXEC_RODATA),
 	CRASHTYPE(EXEC_USERSPACE),
+	CRASHTYPE(EXEC_NULL),
 	CRASHTYPE(ACCESS_USERSPACE),
+	CRASHTYPE(ACCESS_NULL),
 	CRASHTYPE(WRITE_RO),
 	CRASHTYPE(WRITE_RO_AFTER_INIT),
 	CRASHTYPE(WRITE_KERN),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 3c6fd327e166..b69ee004a3f7 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
 void lkdtm_EXEC_VMALLOC(void);
 void lkdtm_EXEC_RODATA(void);
 void lkdtm_EXEC_USERSPACE(void);
+void lkdtm_EXEC_NULL(void);
 void lkdtm_ACCESS_USERSPACE(void);
+void lkdtm_ACCESS_NULL(void);
 
 /* lkdtm_refcount.c */
 void lkdtm_REFCOUNT_INC_OVERFLOW(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index fa54add6375a..62f76d506f04 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -164,6 +164,11 @@ void lkdtm_EXEC_USERSPACE(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+void lkdtm_EXEC_NULL(void)
+{
+	execute_location(NULL, CODE_AS_IS);
+}
+
 void lkdtm_ACCESS_USERSPACE(void)
 {
 	unsigned long user_addr, tmp = 0;
@@ -195,6 +200,19 @@ void lkdtm_ACCESS_USERSPACE(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
+void lkdtm_ACCESS_NULL(void)
+{
+	unsigned long tmp;
+	unsigned long *ptr = (unsigned long *)NULL;
+
+	pr_info("attempting bad read at %px\n", ptr);
+	tmp = *ptr;
+	tmp += 0xc0dec0de;
+
+	pr_info("attempting bad write at %px\n", ptr);
+	*ptr = tmp;
+}
+
 void __init lkdtm_perms_init(void)
 {
 	/* Make sure we can write to __ro_after_init values during __init */
-- 
2.19.1

