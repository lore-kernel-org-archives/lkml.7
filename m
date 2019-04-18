Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC33C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7118121871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610587;
	bh=xF0TOWc7e2J8vc50T1ggSAbby129Zq08vr5bk8ecc7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=je8AMK/QGkdqpZ3ZIk1J/8COf504YhTsHKh/X+FeNbqDpqDal7hM0aIOQOO9S3oPw
	 sIG1nLDe18WTVTEyLN3PLHNv5N7cfHl6bgop37IZuHMLjhFGVy9srJusCnmbrjTqAF
	 C5oAJDKarLMAhm3Bytio+hvQAXsAxj4RW5nqLL14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390866AbfDRSDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390857AbfDRSDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3087F21871;
        Thu, 18 Apr 2019 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610582;
        bh=xF0TOWc7e2J8vc50T1ggSAbby129Zq08vr5bk8ecc7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6lFcOkOm14oCkVfNi5CGJ1195to+Vsgu08Vh2gk53ZrzRzZVIeqr/yc6oSi/VdJn
         co4Bzj2BLGryLXlDnuHk1TwbZ9idGtQsxyx3amjaNzy5/iDNc2kX93WWs+Xq9dZ941
         Ejk9v24yCbjDCMZ2CZrIa7goSkyaSTXsRfW3AA60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/110] lkdtm: Print real addresses
Date:   Thu, 18 Apr 2019 19:57:20 +0200
Message-Id: <20190418160446.521619972@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



