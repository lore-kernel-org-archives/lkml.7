Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B05C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138D220828
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfGXCn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:43:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfGXCn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:43:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 340F7308212D;
        Wed, 24 Jul 2019 02:43:28 +0000 (UTC)
Received: from treble (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA48D601B7;
        Wed, 24 Jul 2019 02:43:26 +0000 (UTC)
Date:   Tue, 23 Jul 2019 21:43:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 - clang / objtool status
Message-ID: <20190724023946.yxsz5im22fz4zxrn@treble>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 24 Jul 2019 02:43:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:

>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x86: redundant UACCESS disable

Looking at this one, I think I agree with objtool.

PeterZ, Linus, I know y'all discussed this code a few months ago.

__copy_from_user() already does a CLAC in its error path.  So isn't the
user_access_end() redundant for the __copy_from_user() error path?

Untested fix:

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
