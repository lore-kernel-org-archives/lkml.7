Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98937C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QAxDYqgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfDXLK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:10:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfDXLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:10:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3OBA9OH2549134
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 04:10:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3OBA9OH2549134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556104210;
        bh=EGhWyfl1jyjNzP3g5Rc/daNTDVIIRKTDGS5dPtDElaY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QAxDYqgJr73POHPk2o3OtGLllOzDcf0DHwTGY0DUalQhgw493wMPdfbJf1wzRdzsR
         MQPjyNESbCJHhxdx5OBecABwYAhJ4HviCE+xouchnfdrdgD3XEw3aK9/R+MXfTCuUI
         LmFJVuKP8uiUmaS974581fzo+SCO+oksiGaQsKO6XeGp0q7zRb6oKmZz+6YnOX/5rx
         Mawolx/BcDdvdEyaBiG1kGDF1FXACWj4g98hCIY9EqppaFPkGowVMIW5dyDPsym2SS
         MVvmxK2uKH0IsfY0dnbH2tLJ220joS45hAkaxzyrAI2bSmGRpSkfZkFdsu9p8RQbsW
         /RmnR4ufOMXDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3OBA9cX2549131;
        Wed, 24 Apr 2019 04:10:09 -0700
Date:   Wed, 24 Apr 2019 04:10:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-6ae865615fc43d014da2fd1f1bba7e81ee622d1b@git.kernel.org>
Cc:     rdunlap@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          rdunlap@infradead.org, mingo@kernel.org
In-Reply-To: <20190424072208.695962771@infradead.org>
References: <20190424072208.695962771@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/objtool] x86/uaccess: Dont leak the AC flag into
 __put_user() argument evaluation
Git-Commit-ID: 6ae865615fc43d014da2fd1f1bba7e81ee622d1b
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

Commit-ID:  6ae865615fc43d014da2fd1f1bba7e81ee622d1b
Gitweb:     https://git.kernel.org/tip/6ae865615fc43d014da2fd1f1bba7e81ee622d1b
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 24 Apr 2019 09:19:24 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 24 Apr 2019 12:19:45 +0200

x86/uaccess: Dont leak the AC flag into __put_user() argument evaluation

The __put_user() macro evaluates it's @ptr argument inside the
__uaccess_begin() / __uaccess_end() region. While this would normally
not be expected to be an issue, an UBSAN bug (it ignored -fwrapv,
fixed in GCC 8+) would transform the @ptr evaluation for:

  drivers/gpu/drm/i915/i915_gem_execbuffer.c: if (unlikely(__put_user(offset, &urelocs[r-stack].presumed_offset))) {

into a signed-overflow-UB check and trigger the objtool AC validation.

Finish this commit:

  2a418cf3f5f1 ("x86/uaccess: Don't leak the AC flag into __put_user() value evaluation")

and explicitly evaluate all 3 arguments early.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: luto@kernel.org
Fixes: 2a418cf3f5f1 ("x86/uaccess: Don't leak the AC flag into __put_user() value evaluation")
Link: http://lkml.kernel.org/r/20190424072208.695962771@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/uaccess.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 5ca7b91faf67..bb21913885a3 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -427,10 +427,11 @@ do {									\
 ({								\
 	__label__ __pu_label;					\
 	int __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) __pu_val;				\
-	__pu_val = x;						\
+	__typeof__(*(ptr)) __pu_val = (x);			\
+	__typeof__(ptr) __pu_ptr = (ptr);			\
+	__typeof__(size) __pu_size = (size);			\
 	__uaccess_begin();					\
-	__put_user_size(__pu_val, (ptr), (size), __pu_label);	\
+	__put_user_size(__pu_val, __pu_ptr, __pu_size, __pu_label);	\
 	__pu_err = 0;						\
 __pu_label:							\
 	__uaccess_end();					\
