Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD14DC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D647217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909906;
	bh=+mDl56pnovCRf9l6Z6D8C5RXi93XiDdjkUo7wLHnqTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0fPPGeubH1OFl/ygNpKrGP3P2ioiBCM4WURgh13Z4ocjHjMmnI8VVEFlo7YYC9Fqo
	 4zi8uz3T7BkaoxSIBush5tUlZWrh4vQXgV2On73FlvNWMSXf5vOV2ph0an4IOdPcNI
	 YGwXVoqW/oHnicW1UjAigFVf0Jf0NYZpCSSupUwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfC3BiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbfC3BaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C29D218A6;
        Sat, 30 Mar 2019 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909418;
        bh=+mDl56pnovCRf9l6Z6D8C5RXi93XiDdjkUo7wLHnqTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqLQoVvAgeKxqzDkVt4xCz6TDRVugY/OBprUDP3nSkzIVJ6Y5gqHVs4iOuQ4uOJ2a
         ehsy8RbAYJdKKGXEY7h+j32YiAoKbBhqchDEvXLekKGLjC6wI4cy/oIZbzKeD0X7Hd
         JxnjTjoquWI849HRpOkQPHKgNBFKdZRE6Yvvjldk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 43/57] lkdtm: Print real addresses
Date:   Fri, 29 Mar 2019 21:28:36 -0400
Message-Id: <20190330012854.32212-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330012854.32212-1-sashal@kernel.org>
References: <20190330012854.32212-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 4c411157a42f122051ae3469bee0b5cabe89e139 ]

Today, when doing a lkdtm test before the readiness of the
random generator, (ptrval) is printed instead of the address
at which it perform the fault:

[ 1597.337030] lkdtm: Performing direct entry EXEC_USERSPACE
[ 1597.337142] lkdtm: attempting ok execution at (ptrval)
[ 1597.337398] lkdtm: attempting bad execution at (ptrval)
[ 1597.337460] kernel tried to execute user page (77858000) -exploit attempt? (uid: 0)
[ 1597.344769] Unable to handle kernel paging request for instruction fetch
[ 1597.351392] Faulting instruction address: 0x77858000
[ 1597.356312] Oops: Kernel access of bad area, sig: 11 [#1]

If the lkdtm test is done later on, it prints an hashed address.

In both cases this is pointless. The purpose of the test is to
ensure the kernel generates an Oops at the expected address,
so real addresses needs to be printed. This patch fixes that.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/lkdtm/perms.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 53b85c9d16b8..fa54add6375a 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -47,7 +47,7 @@ static noinline void execute_location(void *dst, bool write)
 {
 	void (*func)(void) = dst;
 
-	pr_info("attempting ok execution at %p\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing);
 	do_nothing();
 
 	if (write == CODE_WRITE) {
@@ -55,7 +55,7 @@ static noinline void execute_location(void *dst, bool write)
 		flush_icache_range((unsigned long)dst,
 				   (unsigned long)dst + EXEC_SIZE);
 	}
-	pr_info("attempting bad execution at %p\n", func);
+	pr_info("attempting bad execution at %px\n", func);
 	func();
 }
 
@@ -66,14 +66,14 @@ static void execute_user_location(void *dst)
 	/* Intentionally crossing kernel/user memory boundary. */
 	void (*func)(void) = dst;
 
-	pr_info("attempting ok execution at %p\n", do_nothing);
+	pr_info("attempting ok execution at %px\n", do_nothing);
 	do_nothing();
 
 	copied = access_process_vm(current, (unsigned long)dst, do_nothing,
 				   EXEC_SIZE, FOLL_WRITE);
 	if (copied < EXEC_SIZE)
 		return;
-	pr_info("attempting bad execution at %p\n", func);
+	pr_info("attempting bad execution at %px\n", func);
 	func();
 }
 
@@ -82,7 +82,7 @@ void lkdtm_WRITE_RO(void)
 	/* Explicitly cast away "const" for the test. */
 	unsigned long *ptr = (unsigned long *)&rodata;
 
-	pr_info("attempting bad rodata write at %p\n", ptr);
+	pr_info("attempting bad rodata write at %px\n", ptr);
 	*ptr ^= 0xabcd1234;
 }
 
@@ -100,7 +100,7 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 		return;
 	}
 
-	pr_info("attempting bad ro_after_init write at %p\n", ptr);
+	pr_info("attempting bad ro_after_init write at %px\n", ptr);
 	*ptr ^= 0xabcd1234;
 }
 
@@ -112,7 +112,7 @@ void lkdtm_WRITE_KERN(void)
 	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
 	ptr = (unsigned char *)do_overwritten;
 
-	pr_info("attempting bad %zu byte write at %p\n", size, ptr);
+	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
 	memcpy(ptr, (unsigned char *)do_nothing, size);
 	flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
 
@@ -185,11 +185,11 @@ void lkdtm_ACCESS_USERSPACE(void)
 
 	ptr = (unsigned long *)user_addr;
 
-	pr_info("attempting bad read at %p\n", ptr);
+	pr_info("attempting bad read at %px\n", ptr);
 	tmp = *ptr;
 	tmp += 0xc0dec0de;
 
-	pr_info("attempting bad write at %p\n", ptr);
+	pr_info("attempting bad write at %px\n", ptr);
 	*ptr = tmp;
 
 	vm_munmap(user_addr, PAGE_SIZE);
-- 
2.19.1

