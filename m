Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B2C21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrPH//KD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfC2Qaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:30:55 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43871 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfC2Qaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:30:55 -0400
Received: by mail-pg1-f201.google.com with SMTP id u2so1968504pgi.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Lju3Sh2kmpmmLQeEIQ2kymRMSnNvrQCfL6/ZPFgSoEI=;
        b=ZrPH//KDXILltcSMKI4M4/hUUK8BM+cz1NNDwwL5YTOcX9sLI2MwKxP0L1r1qqyTE7
         JkZjn96zwZd+Adxeg6pdlk+S5oTaeDbuMLALxDFIZJR48YBU6TIkq8vBOuMewAh/1bTt
         uZmaZjrIEM4jcCgPVRRcCqnx9Ul964ceAxo51ODx0pXHFA03vyjczjq/tfXXBFF6Y6eP
         tJP78qfBKpcmE+9zvb9EZamn5FQqKkU0dp55vLOpKl7rZDc+ei3Cvrg7/TzIZQEY7nPr
         QrnWJdxPHf/uvFf8e3VHwvTCXiLKPZzMI8I4762YebYp/ujqr1tp7MhhS6cm3uKIF69h
         3E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Lju3Sh2kmpmmLQeEIQ2kymRMSnNvrQCfL6/ZPFgSoEI=;
        b=DsTb2tVepkYmrAR9OD3x4n201pUQh0ofFHEW4QTODUIXdhhDZdNeCHOzBOL0JDwizm
         IoIxZAiW+YkCdjsWMB8dQSFkisSBQkta+oKlzAem2AXoVcrR5tE7uTy6wYgP7g3lQPF9
         WtOMEDtBBvPYClGCNMc6i1I9eWu2pHnB6qoTxo19Q1i+ntA6tj5wo9ay4viJJ1p1zYJv
         p96l3JsGsTyEKkWNjvNrMweaLgqX9a8YA4Q85TAne+/iUuL/y8RsZ9g+/ZGea37LGg3V
         nhpEF6s2hDjQRgLa+CkFdALRe0qMVb5riYFDNrn9k6AkEwdyPF/mP5oTEflg0t6MTKgR
         HubA==
X-Gm-Message-State: APjAAAXb/meXtwmaakokUEyEBCUH7aisCEMtTYVwfYiIiDEqgXV5KLnR
        5GwTdUU4sw/5hb6PnmWEuJD1TfMFuw==
X-Google-Smtp-Source: APXvYqzcnWMFVy4Lz3DfzYYpL1aAkHvo0adsYYDgYIZLQLtp9/m+KrzdFNDc1v/kZDzXqwX/faFpK0n13A==
X-Received: by 2002:a17:902:5c4:: with SMTP id f62mr140691plf.39.1553877054496;
 Fri, 29 Mar 2019 09:30:54 -0700 (PDT)
Date:   Fri, 29 Mar 2019 17:30:44 +0100
Message-Id: <20190329163047.223508-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2 1/4] kernel.h: use parentheses around argument in u64_to_user_ptr()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qiaowei Ren <qiaowei.ren@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use parentheses around uses of the argument in u64_to_user_ptr() to ensure
that the cast doesn't apply to part of the argument.

There are existing uses of the macro of the form `u64_to_user_ptr(A + B)`,
which expands to `(void __user *)(uintptr_t)A + B` (the cast applies to the
first operand of the addition, the addition is a pointer addition). This
happens to still work as intended, the semantic difference doesn't cause a
difference in behavior.
But I want to use u64_to_user_ptr() with a ternary operator in the
argument, like so: `u64_to_user_ptr(A ? B : C)`. This currently doesn't
work as intended.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kernel.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 34a5036debd3..2d14e21c16c0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -47,8 +47,8 @@
 
 #define u64_to_user_ptr(x) (		\
 {					\
-	typecheck(u64, x);		\
-	(void __user *)(uintptr_t)x;	\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
 }					\
 )
 
-- 
2.21.0.392.gf8f6787159e-goog

