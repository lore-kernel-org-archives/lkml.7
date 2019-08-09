Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C19C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFFC2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UpBT+PDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfHIVRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:17:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33063 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfHIVRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:17:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x79LGMLZ3828121
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 9 Aug 2019 14:16:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x79LGMLZ3828121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565385383;
        bh=8GC51esmJAMemctQ8NRQZocGfyl2HrGEQQBZNCBvgSE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UpBT+PDVElDI0d2QSG3+x9QDdRPvLYP3hxWn93rsf0UvfqZS5JP8xdVPJTPD5Filj
         vrm/tbaPpr3mqZvm/0lWkESFXdbbhvCiT8+uqhkpuyyweDCXSqm+G1FKGkTBFj9zwC
         NQzFA2Pj1NYpn1l+golnzN7zzCRKocSxPP8x/Q5afuQ2R70OoI/MFcDXvtwLbUkkkm
         Hguqftza2023vmIouL8N098BxyMYZAgfzAFgQfxeRiYFnW7KCMst7WkFmhxSqwkpAu
         tcxGJsWHMe2n6MwKdomnELjQ2PArxaJ9gjyvobfFufivS6p2FZF5ETOYlVMiBRLN0z
         aGusTYkY0w0AQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x79LGL2s3828118;
        Fri, 9 Aug 2019 14:16:21 -0700
Date:   Fri, 9 Aug 2019 14:16:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-e6a9522ac3ff59980ea00e070b6b8573aface36a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        tglx@linutronix.de, sedat.dilek@gmail.com, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, chris@chris-wilson.co.uk,
        jpoimboe@redhat.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, sedat.dilek@gmail.com,
          linux-kernel@vger.kernel.org, ndesaulniers@google.com,
          jpoimboe@redhat.com, chris@chris-wilson.co.uk, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
Git-Commit-ID: e6a9522ac3ff59980ea00e070b6b8573aface36a
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

Commit-ID:  e6a9522ac3ff59980ea00e070b6b8573aface36a
Gitweb:     https://git.kernel.org/tip/e6a9522ac3ff59980ea00e070b6b8573aface36a
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 25 Jul 2019 15:29:57 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 9 Aug 2019 23:13:25 +0200

drm/i915: Remove redundant user_access_end() from __copy_from_user() error path

Objtool reports:

  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable

__copy_from_user() already does both STAC and CLAC, so the
user_access_end() in its error path adds an extra unnecessary CLAC.

Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://github.com/ClangBuiltLinux/linux/issues/617
Link: https://lkml.kernel.org/r/51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com

---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 20 +++++++++-----------
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
@@ -1699,10 +1693,14 @@ end:
 
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
