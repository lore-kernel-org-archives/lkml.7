Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F77C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FB12171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfDELK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:10:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfDELK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:10:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BAGdt2726413
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:10:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BAFro2726410;
        Fri, 5 Apr 2019 04:10:15 -0700
Date:   Fri, 5 Apr 2019 04:10:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jia Zhang <tipbot@zytor.com>
Message-ID: <tip-705acedd7fcb81a1e2be2560a1fdd16a429357f6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        zhang.jia@linux.alibaba.com, hpa@zytor.com
Reply-To: zhang.jia@linux.alibaba.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190401114045.7280-1-zhang.jia@linux.alibaba.com>
References: <20190401114045.7280-1-zhang.jia@linux.alibaba.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Remove hpet_page from vDSO
Git-Commit-ID: 705acedd7fcb81a1e2be2560a1fdd16a429357f6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  705acedd7fcb81a1e2be2560a1fdd16a429357f6
Gitweb:     https://git.kernel.org/tip/705acedd7fcb81a1e2be2560a1fdd16a429357f6
Author:     Jia Zhang <zhang.jia@linux.alibaba.com>
AuthorDate: Mon, 1 Apr 2019 19:40:45 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 13:07:03 +0200

x86/vdso: Remove hpet_page from vDSO

This trivial cleanup finalizes the removal of vDSO HPET support.

Fixes: 1ed95e52d902 ("x86/vdso: Remove direct HPET access through the vDSO")
Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/20190401114045.7280-1-zhang.jia@linux.alibaba.com

---
 arch/x86/entry/vdso/vdso2c.c | 3 ---
 arch/x86/include/asm/vdso.h  | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 8e470b018512..3a4d8d4d39f8 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -73,14 +73,12 @@ const char *outfilename;
 enum {
 	sym_vvar_start,
 	sym_vvar_page,
-	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
 };
 
 const int special_pages[] = {
 	sym_vvar_page,
-	sym_hpet_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
 };
@@ -93,7 +91,6 @@ struct vdso_sym {
 struct vdso_sym required_syms[] = {
 	[sym_vvar_start] = {"vvar_start", true},
 	[sym_vvar_page] = {"vvar_page", true},
-	[sym_hpet_page] = {"hpet_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
 	{"VDSO32_NOTE_MASK", true},
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 27566e57e87d..230474e2ddb5 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -19,7 +19,6 @@ struct vdso_image {
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 
 	long sym_vvar_page;
-	long sym_hpet_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
 	long sym_VDSO32_NOTE_MASK;
