Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6907CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19DE20656
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572445885;
	bh=m1cMkQwkZMOYChe70rwhaCfwpnALooITVqJXptvyL1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OPuPYdJHW2Bz3OPmL15gH1ztnMtrNdCtHbg73Th6UTDvS7Umq+RVhrCItqe7lK+Hb
	 LZCz9UUePtAxioQY5qRFC1bjtyVFaohSjQxEXIxKnAMhUScNJhjrWtAkdsCsOLj6iz
	 v6QH71fswIHdOYNHGaX/8zBboGeAi83EoaEYiYF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJ3Oav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfJ3Oas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:30:48 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC59A2173E;
        Wed, 30 Oct 2019 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572445847;
        bh=m1cMkQwkZMOYChe70rwhaCfwpnALooITVqJXptvyL1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8Muu39SELkyoyMiksC6iUB3M9b98ru7el0YCo6Uv0SlDT8X7gh8Gk5LGxv5HrwK+
         MNUvPS+4n8Ja+cs65CEihMfzjO5myeRqBTDOP8wAo5tISM2KenJBkkhD/NlOrPNkWQ
         tP3/GCe5ji+0wMAH4m1clhOFNzzP3PHEKCYI3VyA=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v4 02/10] lib/refcount: Ensure integer operands are treated as signed
Date:   Wed, 30 Oct 2019 14:30:27 +0000
Message-Id: <20191030143035.19440-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030143035.19440-1-will@kernel.org>
References: <20191030143035.19440-1-will@kernel.org>
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
2.24.0.rc0.303.g954a862665-goog

