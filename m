Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49918218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfB1Sud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:50:33 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:41202 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfB1Suc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:50:32 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gzQlJ-0000bI-R2; Thu, 28 Feb 2019 18:50:29 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92-RC6)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gzQlJ-0000ej-3e; Thu, 28 Feb 2019 18:50:29 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.co, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] x86/asm: add __user on copy_user_handle_tail() pointers
Date:   Thu, 28 Feb 2019 18:50:27 +0000
Message-Id: <20190228185027.2480-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_user_handle_tail() clearly uses both from and to as pointers
to user-space memory. This triggers sparse warning on using the calls
to get and put to user-space. This can be fixed easily by changing the
call to take __user annotated pointer.s

arch/x86/lib/usercopy_64.c:68:21: warning: incorrect type in argument 1 (different address spaces)
arch/x86/lib/usercopy_64.c:68:21:    expected void const volatile [noderef] <asn:1>*<noident>
arch/x86/lib/usercopy_64.c:68:21:    got char *
arch/x86/lib/usercopy_64.c:70:21: warning: incorrect type in argument 1 (different address spaces)
arch/x86/lib/usercopy_64.c:70:21:    expected void const volatile [noderef] <asn:1>*<noident>
arch/x86/lib/usercopy_64.c:70:21:    got char *to

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/x86/include/asm/uaccess_64.h | 2 +-
 arch/x86/lib/usercopy_64.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index a9d637bc301d..cbca2cb28939 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -208,7 +208,7 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 }
 
 unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len);
+copy_user_handle_tail(char __user *to, char __user *from, unsigned len);
 
 unsigned long
 mcsafe_handle_tail(char *to, char *from, unsigned len);
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index ee42bb0cbeb3..aa180424e77a 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL(clear_user);
  * it is not necessary to optimize tail handling.
  */
 __visible unsigned long
-copy_user_handle_tail(char *to, char *from, unsigned len)
+copy_user_handle_tail(char __user *to, char __user *from, unsigned len)
 {
 	for (; len; --len, to++) {
 		char c;
-- 
2.20.1

