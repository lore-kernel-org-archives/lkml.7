Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23052C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43532070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfDBIoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:44:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbfDBIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:44:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x328hJKJ1310039
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 2 Apr 2019 01:43:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x328hHIT1310034;
        Tue, 2 Apr 2019 01:43:17 -0700
Date:   Tue, 2 Apr 2019 01:43:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ben Dooks <tipbot@zytor.com>
Message-ID: <tip-b5dbb6799e3e5b8ebdce33b52b2d4ec9c66e15fe@git.kernel.org>
Cc:     mingo@kernel.org, adobriyan@gmail.com, bp@suse.de,
        jannh@google.com, ben.dooks@codethink.co.uk, mingo@redhat.com,
        hpa@zytor.com, mojha@codeaurora.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, x86@kernel.org,
        dan.j.williams@intel.com, mpatocka@redhat.com
Reply-To: bp@suse.de, adobriyan@gmail.com, mingo@kernel.org,
          jannh@google.com, ben.dooks@codethink.co.uk,
          mojha@codeaurora.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
          dan.j.williams@intel.com, mpatocka@redhat.com,
          tglx@linutronix.de, x86@kernel.org
In-Reply-To: <20190330115624.4000-1-ben.dooks@codethink.co.uk>
References: <20190330115624.4000-1-ben.dooks@codethink.co.uk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Annotate copy_user_handle_tail() pointers
 with __user
Git-Commit-ID: b5dbb6799e3e5b8ebdce33b52b2d4ec9c66e15fe
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

Commit-ID:  b5dbb6799e3e5b8ebdce33b52b2d4ec9c66e15fe
Gitweb:     https://git.kernel.org/tip/b5dbb6799e3e5b8ebdce33b52b2d4ec9c66e15fe
Author:     Ben Dooks <ben.dooks@codethink.co.uk>
AuthorDate: Sat, 30 Mar 2019 11:56:24 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 2 Apr 2019 10:38:51 +0200

x86/asm: Annotate copy_user_handle_tail() pointers with __user

copy_user_handle_tail() clearly uses both @from and @to as pointers to
user-space memory.

Currently, it triggers sparse warning on using the calls to get and put
to user-space which can be fixed easily by changing the call to take
__user annotated pointers:

  arch/x86/lib/usercopy_64.c:68:21: warning: incorrect type in argument 1 (different address spaces)
  arch/x86/lib/usercopy_64.c:68:21:    expected void const volatile [noderef] <asn:1>*<noident>
  arch/x86/lib/usercopy_64.c:68:21:    got char *
  arch/x86/lib/usercopy_64.c:70:21: warning: incorrect type in argument 1 (different address spaces)
  arch/x86/lib/usercopy_64.c:70:21:    expected void const volatile [noderef] <asn:1>*<noident>
  arch/x86/lib/usercopy_64.c:70:21:    got char *to

Linus further explains the reasoning why it was done this way:

On Thu, Mar 28, 2019 at 12:24 AM Borislav Petkov <bp@alien8.de> wrote:
> Well, but copy_user_generic() (which ends up calling the
> copy_user_handle_tail() eventually) casts those __user pointers to
> (__force void *). Converting them back to __user looks strange to me.
>
> Linus?

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

 [ bp: massage. ]

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: mingo@redhat.co
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190330115624.4000-1-ben.dooks@codethink.co.uk
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
