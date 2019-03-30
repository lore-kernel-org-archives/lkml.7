Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE50BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D624217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909476;
	bh=UnqTKYylofMuqcN0OABGUyiWSKXqfBOyL39IujjBkv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XoB3eucURqaBFtYV8KeEiETPxkReXSebFE6eCkjEabZZWwHPuf1WWbitNF9zM3DfP
	 9yTYdEe6szolSkpAtkcf8QM+uUofe1uuh5nJOMrt/G+M0we4M+KqWE7vKYz5Roexw/
	 Ri/WnebzPcOTrE6IQTa+wS2LMQRrPaVu3j5BRgWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfC3BbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731853AbfC3BbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:31:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E875218D9;
        Sat, 30 Mar 2019 01:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909471;
        bh=UnqTKYylofMuqcN0OABGUyiWSKXqfBOyL39IujjBkv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2BYZ4CHqganRFjy4DAPfVDMen5IBBmLF7ZPUQ+Q7wHzjYe79716OzD8QxURh9oZHd
         6fFrIV2YqNWA2a1hg6Jcs1m/m7uwFz587nUP8X4f4Fy6rMSamHn1R0nHjK+AcM04Z/
         iQmXLFlAawodAPqqrRuV30Yw1hhqLsvLFBd8DVDE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 27/37] lkdtm: Add tests for NULL pointer dereference
Date:   Fri, 29 Mar 2019 21:30:10 -0400
Message-Id: <20190330013020.379-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
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
 drivers/misc/lkdtm.h       |  2 ++
 drivers/misc/lkdtm_core.c  |  2 ++
 drivers/misc/lkdtm_perms.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/misc/lkdtm.h b/drivers/misc/lkdtm.h
index 687a0dbbe199..614612325332 100644
--- a/drivers/misc/lkdtm.h
+++ b/drivers/misc/lkdtm.h
@@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
 void lkdtm_EXEC_VMALLOC(void);
 void lkdtm_EXEC_RODATA(void);
 void lkdtm_EXEC_USERSPACE(void);
+void lkdtm_EXEC_NULL(void);
 void lkdtm_ACCESS_USERSPACE(void);
+void lkdtm_ACCESS_NULL(void);
 
 /* lkdtm_refcount.c */
 void lkdtm_REFCOUNT_INC_OVERFLOW(void);
diff --git a/drivers/misc/lkdtm_core.c b/drivers/misc/lkdtm_core.c
index 981b3ef71e47..199271708aed 100644
--- a/drivers/misc/lkdtm_core.c
+++ b/drivers/misc/lkdtm_core.c
@@ -220,7 +220,9 @@ struct crashtype crashtypes[] = {
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
index fa54add6375a..62f76d506f04 100644
--- a/drivers/misc/lkdtm_perms.c
+++ b/drivers/misc/lkdtm_perms.c
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

