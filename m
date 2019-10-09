Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457CEECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EAD21848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfJIOGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:06:43 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:59385 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfJIOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:06:43 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iICbv-0008Pz-1y; Wed, 09 Oct 2019 15:06:39 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iICbu-0003FS-Af; Wed, 09 Oct 2019 15:06:38 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: add kernel/fork.c function definitions
Date:   Wed,  9 Oct 2019 15:06:37 +0100
Message-Id: <20191009140637.12443-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the definitions of arch_release_task_struct,
arch_task_cache_init and arch_dup_task_struct which
are used in kernel/fork.c but defined in various
architecture's <asm/thread_info.h>.

Fixes the following warnings:

kernel/fork.c:160:13: warning: symbol 'arch_release_task_struct' was not declared. Should it be static?
kernel/fork.c:752:20: warning: symbol 'arch_task_cache_init' was not declared. Should it be static?
kernel/fork.c:841:12: warning: symbol 'arch_dup_task_struct' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/include/asm/thread_info.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 0d0d5178e2c3..3d65d152dd19 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -118,6 +118,11 @@ extern void iwmmxt_task_switch(struct thread_info *);
 extern void vfp_sync_hwstate(struct thread_info *);
 extern void vfp_flush_hwstate(struct thread_info *);
 
+/* for kernel/fork.c */
+extern void arch_release_task_struct(struct task_struct *tsk);
+extern void arch_task_cache_init(void);
+extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
+
 struct user_vfp;
 struct user_vfp_exc;
 
-- 
2.23.0

