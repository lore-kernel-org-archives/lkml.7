Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E15C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32925208CE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574337555;
	bh=Yahw6bO6R/ez25DpNIdiuFxPCYgpTqm5hIUctX+cxpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XO4Ol987E8Cyt+NNGDkts6p8KvRAcgZLRfnhDJvsLM2grHblHgqXJKxKKDmGZ9oX2
	 lDZ757pOt+WG8il80sP/PeEHHqcUzy9tnDncBZ5GBKnA8j2Ce7LlI46ZvaEA5jG3Td
	 V8XpA+8WM/XD0MgcLodIVb7JYMC241EdyCD69lKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKUL7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfKUL7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:59:13 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3558F208A3;
        Thu, 21 Nov 2019 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337551;
        bh=Yahw6bO6R/ez25DpNIdiuFxPCYgpTqm5hIUctX+cxpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+7lXQYodEp5mKyP43WREUFV5RKaZWN31YwlFuZ4NbKY3xyfZGpeP4s8DDULhOZ4l
         KBclhgIy7hYu2Rc8hC4beEykCLx07Apt6vVJmfsuXMm3kmJLqlwYqX85SNb0KIgNiF
         Kvmp5G7nLa7bPSA44MFQGsI02+T5qKrdijI8zNmw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RESEND PATCH v4 02/10] lib/refcount: Ensure integer operands are treated as signed
Date:   Thu, 21 Nov 2019 11:58:54 +0000
Message-Id: <20191121115902.2551-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121115902.2551-1-will@kernel.org>
References: <20191121115902.2551-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for changing the saturation point of REFCOUNT_FULL to
INT_MIN / 2, change the type of integer operands passed into the API
from 'unsigned int' to 'int' so that we can avoid casting during
comparisons when we don't want to fall foul of C integral conversion
rules for signed and unsigned types.

Since the kernel is compiled with '-fno-strict-overflow', we don't need
to worry about the UB introduced by signed overflow here. Furthermore,
we're already making heavy use of the atomic_t API, which operates
exclusively on signed types.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 14 +++++++-------
 lib/refcount.c           |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 79f62e8d2256..89066a1471dd 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -28,7 +28,7 @@ typedef struct refcount_struct {
  * @r: the refcount
  * @n: value to which the refcount will be set
  */
-static inline void refcount_set(refcount_t *r, unsigned int n)
+static inline void refcount_set(refcount_t *r, int n)
 {
 	atomic_set(&r->refs, n);
 }
@@ -44,13 +44,13 @@ static inline unsigned int refcount_read(const refcount_t *r)
 	return atomic_read(&r->refs);
 }
 
-extern __must_check bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r);
-extern void refcount_add_checked(unsigned int i, refcount_t *r);
+extern __must_check bool refcount_add_not_zero_checked(int i, refcount_t *r);
+extern void refcount_add_checked(int i, refcount_t *r);
 
 extern __must_check bool refcount_inc_not_zero_checked(refcount_t *r);
 extern void refcount_inc_checked(refcount_t *r);
 
-extern __must_check bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r);
+extern __must_check bool refcount_sub_and_test_checked(int i, refcount_t *r);
 
 extern __must_check bool refcount_dec_and_test_checked(refcount_t *r);
 extern void refcount_dec_checked(refcount_t *r);
@@ -79,12 +79,12 @@ extern void refcount_dec_checked(refcount_t *r);
 # ifdef CONFIG_ARCH_HAS_REFCOUNT
 #  include <asm/refcount.h>
 # else
-static inline __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r)
+static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
 {
 	return atomic_add_unless(&r->refs, i, 0);
 }
 
-static inline void refcount_add(unsigned int i, refcount_t *r)
+static inline void refcount_add(int i, refcount_t *r)
 {
 	atomic_add(i, &r->refs);
 }
@@ -99,7 +99,7 @@ static inline void refcount_inc(refcount_t *r)
 	atomic_inc(&r->refs);
 }
 
-static inline __must_check bool refcount_sub_and_test(unsigned int i, refcount_t *r)
+static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
 {
 	return atomic_sub_and_test(i, &r->refs);
 }
diff --git a/lib/refcount.c b/lib/refcount.c
index 48b78a423d7d..719b0bc42ab1 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -61,7 +61,7 @@
  *
  * Return: false if the passed refcount is 0, true otherwise
  */
-bool refcount_add_not_zero_checked(unsigned int i, refcount_t *r)
+bool refcount_add_not_zero_checked(int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
@@ -101,7 +101,7 @@ EXPORT_SYMBOL(refcount_add_not_zero_checked);
  * cases, refcount_inc(), or one of its variants, should instead be used to
  * increment a reference count.
  */
-void refcount_add_checked(unsigned int i, refcount_t *r)
+void refcount_add_checked(int i, refcount_t *r)
 {
 	WARN_ONCE(!refcount_add_not_zero_checked(i, r), "refcount_t: addition on 0; use-after-free.\n");
 }
@@ -180,7 +180,7 @@ EXPORT_SYMBOL(refcount_inc_checked);
  *
  * Return: true if the resulting refcount is 0, false otherwise
  */
-bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
+bool refcount_sub_and_test_checked(int i, refcount_t *r)
 {
 	unsigned int new, val = atomic_read(&r->refs);
 
-- 
2.24.0.432.g9d3f5f5b63-goog

