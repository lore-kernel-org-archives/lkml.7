Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0B208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574337581;
	bh=ghKhe68lD8e5LH1BpIOE3OBn+l5ncicssvOzw/VcY8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZKJGcvKu0d6FX6hX2OSYEgLl7G10K5ZJJWruh4ePCVl2rmqwyT2+MGD0uQQHyNwdY
	 pWzTFq0BQAQDalkTZOIASX222rN4ibv1s/iqdqDbfXr4ZUDCe6PQjHORXlmBlUrYDG
	 nrwh3L8Ooq+i95ATa+7SW2DDzhTCOnFLT3/5/s+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKUL7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfKUL7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:59:22 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5839A208CC;
        Thu, 21 Nov 2019 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337561;
        bh=ghKhe68lD8e5LH1BpIOE3OBn+l5ncicssvOzw/VcY8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OugN8NSG2RmNsRud5KKZe3msfboI7Ew9vIMHV+mIEYN/DjC8hEnslPl2FiVQU9lOG
         ppelohCBiG5Kkc1wn6b+eOV0aC5PjWrMCImgxJ2WeFeWnxNpeEBDFS8siN2e6s2W+t
         4FdFvvelbdn8xUQgFeVLIHEgFZpLRNOKg5TOiPeo=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RESEND PATCH v4 07/10] lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
Date:   Thu, 21 Nov 2019 11:58:59 +0000
Message-Id: <20191121115902.2551-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121115902.2551-1-will@kernel.org>
References: <20191121115902.2551-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definitions of REFCOUNT_MAX and REFCOUNT_SATURATED are the same,
regardless of CONFIG_REFCOUNT_FULL, so consolidate them into a single
pair of definitions.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/refcount.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 1cd0a876a789..757d4630115c 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -22,6 +22,8 @@ typedef struct refcount_struct {
 } refcount_t;
 
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
+#define REFCOUNT_MAX		INT_MAX
+#define REFCOUNT_SATURATED	(INT_MIN / 2)
 
 enum refcount_saturation_type {
 	REFCOUNT_ADD_NOT_ZERO_OVF,
@@ -57,9 +59,6 @@ static inline unsigned int refcount_read(const refcount_t *r)
 #ifdef CONFIG_REFCOUNT_FULL
 #include <linux/bug.h>
 
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-
 /*
  * Variant of atomic_t specialized for reference counts.
  *
@@ -300,10 +299,6 @@ static inline void refcount_dec(refcount_t *r)
 		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);
 }
 #else /* CONFIG_REFCOUNT_FULL */
-
-#define REFCOUNT_MAX		INT_MAX
-#define REFCOUNT_SATURATED	(INT_MIN / 2)
-
 # ifdef CONFIG_ARCH_HAS_REFCOUNT
 #  include <asm/refcount.h>
 # else
-- 
2.24.0.432.g9d3f5f5b63-goog

