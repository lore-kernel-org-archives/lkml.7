Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD05C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADB7218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGYUaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfGYUaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:30:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F47985539;
        Thu, 25 Jul 2019 20:30:46 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-90.rdu2.redhat.com [10.10.122.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FB6F5D772;
        Thu, 25 Jul 2019 20:30:44 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/i915: Remove redundant user_access_end() from __copy_from_user() error path
Date:   Thu, 25 Jul 2019 15:29:57 -0500
Message-Id: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 25 Jul 2019 20:30:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool reports:

  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable

__copy_from_user() already does both STAC and CLAC, so the
user_access_end() in its error path adds an extra unnecessary CLAC.

Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/617
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 5fae0e50aad0..41dab9ea33cd 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1628,6 +1628,7 @@ static int check_relocations(const struct drm_i915_gem_exec_object2 *entry)
 
 static int eb_copy_relocations(const struct i915_execbuffer *eb)
 {
+	struct drm_i915_gem_relocation_entry *relocs;
 	const unsigned int count = eb->buffer_count;
 	unsigned int i;
 	int err;
@@ -1635,7 +1636,6 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 	for (i = 0; i < count; i++) {
 		const unsigned int nreloc = eb->exec[i].relocation_count;
 		struct drm_i915_gem_relocation_entry __user *urelocs;
-		struct drm_i915_gem_relocation_entry *relocs;
 		unsigned long size;
 		unsigned long copied;
 
@@ -1663,14 +1663,8 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 
 			if (__copy_from_user((char *)relocs + copied,
 					     (char __user *)urelocs + copied,
-					     len)) {
-end_user:
-				user_access_end();
-end:
-				kvfree(relocs);
-				err = -EFAULT;
-				goto err;
-			}
+					     len))
+				goto end;
 
 			copied += len;
 		} while (copied < size);
@@ -1699,10 +1693,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
 
 	return 0;
 
+end_user:
+	user_access_end();
+end:
+	kvfree(relocs);
+	err = -EFAULT;
 err:
 	while (i--) {
-		struct drm_i915_gem_relocation_entry *relocs =
-			u64_to_ptr(typeof(*relocs), eb->exec[i].relocs_ptr);
+		relocs = u64_to_ptr(typeof(*relocs), eb->exec[i].relocs_ptr);
 		if (eb->exec[i].relocation_count)
 			kvfree(relocs);
 	}
-- 
2.20.1

