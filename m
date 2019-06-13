Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE90FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD3D2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfFMP3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:29:12 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:36467 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbfFML0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:26:16 -0400
Received: from [2a01:e35:39f2:1220:9dd7:c176:119b:4c9d] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hbNrx-00086u-U7; Thu, 13 Jun 2019 13:26:14 +0200
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yann Droneaud <ydroneaud@opteya.com>
Date:   Thu, 13 Jun 2019 13:26:04 +0200
Message-Id: <ac5502a779f4e1c4ad4329a95ed41173f91bf360.1560423331.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560423331.git.ydroneaud@opteya.com>
References: <cover.1560423331.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:9dd7:c176:119b:4c9d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: [PATCH 1/3] binfmt/elf: use functions for stack manipulation
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preliminary step to AT_RANDOM alignment and randomization,
replaces STACK_ macros by elf_stack_ inline functions to make them
easier to reuse.

STACK_ROUND() needed a pointer to elf_addr_t, while STACK_ADD() and
STACK_ALLOC() don't. In the new functions, the current stack pointer
is an obvious input/output parameter of unsigned long type.

STACK_ADD() returned an unsigned long, while STACK_ROUND() returned
a pointer to elf_addr_t. elf_stack_add_items() and elf_stack_align()
return both void.

STACK_ROUND() was used to reserve space on stack (like STACK_ADD())
and to align the resulting stack pointer on 16 bytes boundary. The
macro is replaced by elf_stack_add_items() followed by elf_stack_align().

Link: https://lore.kernel.org/lkml/cover.1560423331.git.ydroneaud@opteya.com
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 fs/binfmt_elf.c | 68 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8264b468f283..87f0c8a21350 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -136,21 +136,52 @@ static int padzero(unsigned long elf_bss)
 	return 0;
 }
 
-/* Let's use some macros to make this stack manipulation a little clearer */
+/* Let's use some functions to make this stack manipulation clearer */
+static inline void elf_stack_add_items(unsigned long *pp, size_t items)
+{
+	elf_addr_t *sp = (elf_addr_t *)*pp;
+
+#ifdef CONFIG_STACK_GROWSUP
+	sp += items;
+#else
+	sp -= items;
+#endif
+
+	*pp = (unsigned long)sp;
+}
+
+static inline void elf_stack_align(unsigned long *pp)
+{
+	unsigned long p = *pp;
+
+#ifdef CONFIG_STACK_GROWSUP
+	p += 15;
+#endif
+
+	p &= ~15UL;
+
+	*pp = p;
+}
+
+static inline elf_addr_t __user *elf_stack_alloc(unsigned long *pp,
+						 size_t len)
+{
+	unsigned long p = *pp;
+	elf_addr_t __user *sp;
+
 #ifdef CONFIG_STACK_GROWSUP
-#define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) + (items))
-#define STACK_ROUND(sp, items) \
-	((15 + (unsigned long) ((sp) + (items))) &~ 15UL)
-#define STACK_ALLOC(sp, len) ({ \
-	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
-	old_sp; })
+	sp = (elf_addr_t __user *)p;
+	p += len;
 #else
-#define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
-#define STACK_ROUND(sp, items) \
-	(((unsigned long) (sp - items)) &~ 15UL)
-#define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
+	p -= len;
+	sp = (elf_addr_t __user *)p;
 #endif
 
+	*pp = p;
+
+	return sp;
+}
+
 #ifndef ELF_BASE_PLATFORM
 /*
  * AT_BASE_PLATFORM indicates the "real" hardware/microarchitecture.
@@ -198,7 +229,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
 
-		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
+		u_platform = elf_stack_alloc(&p, len);
 		if (__copy_to_user(u_platform, k_platform, len))
 			return -EFAULT;
 	}
@@ -211,7 +242,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	if (k_base_platform) {
 		size_t len = strlen(k_base_platform) + 1;
 
-		u_base_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
+		u_base_platform = elf_stack_alloc(&p, len);
 		if (__copy_to_user(u_base_platform, k_base_platform, len))
 			return -EFAULT;
 	}
@@ -220,8 +251,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	 * Generate 16 random bytes for userspace PRNG seeding.
 	 */
 	get_random_bytes(k_rand_bytes, sizeof(k_rand_bytes));
-	u_rand_bytes = (elf_addr_t __user *)
-		       STACK_ALLOC(p, sizeof(k_rand_bytes));
+	u_rand_bytes = elf_stack_alloc(&p, sizeof(k_rand_bytes));
 	if (__copy_to_user(u_rand_bytes, k_rand_bytes, sizeof(k_rand_bytes)))
 		return -EFAULT;
 
@@ -280,11 +310,13 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 
 	/* And advance past the AT_NULL entry.  */
 	ei_index += 2;
-
-	sp = STACK_ADD(p, ei_index);
+	elf_stack_add_items(&p, ei_index);
 
 	items = (argc + 1) + (envc + 1) + 1;
-	bprm->p = STACK_ROUND(sp, items);
+	elf_stack_add_items(&p, items);
+	elf_stack_align(&p);
+
+	bprm->p = p;
 
 	/* Point sp at the lowest address on the stack */
 #ifdef CONFIG_STACK_GROWSUP
-- 
2.21.0

