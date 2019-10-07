Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2603ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A673A20679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570463251;
	bh=6rOqJ5LTuRmben0tL5N78m3bKDzdRm3se771eKCuYnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpw3cQst1KwZTb/2Fe1BvraHPnNM4MclBdvMfhH7yzNv76nvDBDOXE5G9v0wIsvlt
	 fEbH9rBNYmxd5JnttPMIGgygshvKQA4S6xfxXlov0MJUb59Q3LiT0RC5F6KfnKByZb
	 jgGd7mU+mpvI8xXNhmMasmO28l9tar13ub5lsIpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfJGPra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbfJGPrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:47:24 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676DB21924;
        Mon,  7 Oct 2019 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570463244;
        bh=6rOqJ5LTuRmben0tL5N78m3bKDzdRm3se771eKCuYnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uu6DQ1jl4KzHh5HIAtqDO4U+0FRNA2hyt3MEF2PRZfIHisTRXzOZdSxzGiBQDUa3L
         LP3avNbnVlR5JMMX+hmAgqTKOndeY3zdIchuOLLIcV/k19bbNblaCBLQzW31yVR7oF
         wz67VQ+/JFU1Il+39IBmJAS3AVfpJLPZGHmsyTBM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH v3 07/10] lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions
Date:   Mon,  7 Oct 2019 16:47:00 +0100
Message-Id: <20191007154703.5574-8-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191007154703.5574-1-will@kernel.org>
References: <20191007154703.5574-1-will@kernel.org>
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
index 40ddff74a96c..e148639a9224 100644
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
@@ -262,10 +261,6 @@ static inline void refcount_dec(refcount_t *r)
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
2.23.0.581.g78d2f28ef7-goog

