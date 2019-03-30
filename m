Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F36C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7D92184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfC3L4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:56:36 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48487 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbfC3L4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:56:35 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hACbA-0004lI-KE; Sat, 30 Mar 2019 11:56:32 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1hACbA-00013M-9l; Sat, 30 Mar 2019 11:56:32 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, mingo@redhat.co, bp@alien8.de, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] [V2] x86/asm: add __user on copy_user_handle_tail() pointers
Date:   Sat, 30 Mar 2019 11:56:24 +0000
Message-Id: <20190330115624.4000-1-ben.dooks@codethink.co.uk>
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

From Linus Torvalds:

On Thu, Mar 28, 2019 at 12:24 AM Borislav Petkov <bp@alien8.de> wrote:

Well, but copy_user_generic() (which ends up calling the
copy_user_handle_tail() eventually) casts those __user pointers to
(__force void *). Converting them back to __user looks strange to me.

Linus?

Well, it does that because the x86 version of copy_user_generic() can
work in either direction, so it works when either the source or
destination (or both) are user pointers, but they don't _have_ to be.

So the "userness" of a pointer in that context is a bit ambiguous, and
so we've picked the pointers to be just plain "void *".

That said, arguably we should have gone the other way and just made
them both "__user" pointers, and do the cast the other way around.

But there's no absolutely right answer here, and nobody should ever
use copy_user_generic() directly (ie it is very much meant to be only
used as a internal helper for the cases that get the pointer
annotations right).

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

