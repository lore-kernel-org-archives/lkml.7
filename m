Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FEFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3A72186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610930;
	bh=ZzUzwgxjCTFmScR/hxPVMaKUDsdmEpyz3ZC9vT28NPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zQfpybNEhmzbXF/BUA4nOzehmTR87lRdgetYQ/mkpQS4oc2fvHggj6U28ErtlHT+f
	 ebuC4Yl8Yfgbn/OzTdWM56IIeYFCXhpFtQNj1TDJb1YexPpHSEYMiWERK/QAUfKC7B
	 sX6q5U7b4BvLDXvyFJRTcsAq+s7+ieZpft9IurZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbfDRSIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391775AbfDRSIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:08:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762622186A;
        Thu, 18 Apr 2019 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610925;
        bh=ZzUzwgxjCTFmScR/hxPVMaKUDsdmEpyz3ZC9vT28NPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCYsUmufZ6qvE7mQt8XMmBR7tY1ce4Ad15RBvMed1BYhiD7iXIP2/sInCQqCgO6un
         k3337PGCrNVcHCWiICDDFCv90NMXRsa0Ylya0b1FOpJNWtznriy6n75hUQv7zmRTRh
         ZQeOK0PoEgVrr/7zs2TJ7O4Ibl3/7FjfCXtjjknE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 43/50] lkdtm: Add tests for NULL pointer dereference
Date:   Thu, 18 Apr 2019 19:57:54 +0200
Message-Id: <20190418160427.662462410@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/misc/lkdtm.h       |  2 ++
 drivers/misc/lkdtm_core.c  |  2 ++
 drivers/misc/lkdtm_perms.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm.h
index fdf954c2107f..6abc97b245e4 100644
--- a/drivers/misc/lkdtm.h
+++ b/drivers/misc/lkdtm.h
@@ -40,7 +40,9 @@ void lkdtm_EXEC_KMALLOC(void);
 void lkdtm_EXEC_VMALLOC(void);
 void lkdtm_EXEC_RODATA(void);
 void lkdtm_EXEC_USERSPACE(void);
+void lkdtm_EXEC_NULL(void);
 void lkdtm_ACCESS_USERSPACE(void);
+void lkdtm_ACCESS_NULL(void);
 
 /* lkdtm_rodata.c */
 void lkdtm_rodata_do_nothing(void);
diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index b2989f2d3126..035e51bea450 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -214,7 +214,9 @@ struct crashtype crashtypes[] = {
 	CRASHTYPE(EXEC_VMALLOC),
 	CRASHTYPE(EXEC_RODATA),
 	CRASHTYPE(EXEC_USERSPACE),
+	CRASHTYPE(EXEC_NULL),
 	CRASHTYPE(ACCESS_USERSPACE),
+	CRASHTYPE(ACCESS_NULL),
 	CRASHTYPE(WRITE_RO),
 	CRASHTYPE(WRITE_RO_AFTER_INIT),
 	CRASHTYPE(WRITE_KERN),
diff --git a/drivers/misc/lkdtm_perms.c b/drivers/misc/lkdtm_perms.c
index 45f1c0f96612..1a9dcdaa95f0 100644
--- a/drivers/misc/lkdtm_perms.c
+++ b/drivers/misc/lkdtm_perms.c
@@ -160,6 +160,11 @@ void lkdtm_EXEC_USERSPACE(void)
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
@@ -191,6 +196,19 @@ void lkdtm_ACCESS_USERSPACE(void)
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



