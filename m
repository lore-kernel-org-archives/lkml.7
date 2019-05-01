Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF5A20651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMFmjekn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfEAUFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:05:09 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:42341 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEAUFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:05:06 -0400
Received: by mail-oi1-f202.google.com with SMTP id r84so126767oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pgwmPCltNlT2qJblASiCpctnwqNtjlaYefBmlV3joCA=;
        b=AMFmjeknKhEaJ/eh9jtp+QJfhvY+QPJUVoke8a327Koi6aQNO6J+ln7j6aJIvHIwYE
         8IaY5sY50qyQX7VW6CSR6VKL2/C/yiEv1tEMiYnkWXzxI3tTx7dzZRy24C3bkXZrOaZH
         v/6HKXlBiUnlx5g7RvwIWd47qfARkNLLJnu58vsP28Lf1xLzun0VrCJFZRKTjcBj0CQZ
         kxCjc+1RHyqrjlKu5XlAbLWMaP23VslEyGRa0EylGu9Rj7xob49sFengp78TMf1739MD
         inCxLoW1GbMipIAKe2nmPiN2XN2Kz2sB3z1MEjJhaomm/uvvldW+EC4afPJwobojLOTN
         IgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pgwmPCltNlT2qJblASiCpctnwqNtjlaYefBmlV3joCA=;
        b=B8aUkd+BciurFfCPIxPvoggdYEHPmrzDZTPypt1BJDBsXgcbZxduzaI8pe6jLlxbXu
         HjytV/zuSV/J/rZsQaNrueZ+yeWWWsO+voSmEj4h8v+tXc2nQhH63pIuQ8S+aoxqEbbU
         v0MXe32AZ7obp9n59y/RZJ4X6WAg9kPHu9i2asMn5HRofFLmmpGOenq/AxtlBbhhN/bn
         hsySit6+KoNqzaLSK8RdRC6EXOtis28ED5keH2Bwkkp5FPDS5Klhl6YprErAyBFQnekx
         qEYKxjml9t0I9zK6G8Z0yOhOktEH6JNUGRpZS8wbOwE/OizL6LoU6lBtyWxY8Wri+WYI
         wS2A==
X-Gm-Message-State: APjAAAVI9ZefMkEEN+pNIJeydOZ3Uv5WaE+sz3aHJzcnJYbToIEBH+i4
        lW2HpgwB3fLeahm0YiwK22quqeQonZwfVxdGZSc=
X-Google-Smtp-Source: APXvYqy0WApsbwDI8BfA3Z5wQECjBctYDbr5V6gFmoYub0j5ti+nozhzvzn4wnXwl6X5IMNDwLQwrHjL3uHCJNYqsPM=
X-Received: by 2002:a9d:6153:: with SMTP id c19mr6049632otk.110.1556741105717;
 Wed, 01 May 2019 13:05:05 -0700 (PDT)
Date:   Wed,  1 May 2019 13:04:50 -0700
In-Reply-To: <20190501200451.255615-1-samitolvanen@google.com>
Message-Id: <20190501200451.255615-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190501200451.255615-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 1/2] arm64: fix syscall_fn_t type
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use const struct pt_regs * instead of struct pt_regs * as
the argument type to fix indirect call type mismatches with
Control-Flow Integrity checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index a179df3674a1a..6206ab9bfcfc5 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -20,7 +20,7 @@
 #include <linux/compat.h>
 #include <linux/err.h>
 
-typedef long (*syscall_fn_t)(struct pt_regs *regs);
+typedef long (*syscall_fn_t)(const struct pt_regs *regs);
 
 extern const syscall_fn_t sys_call_table[];
 
-- 
2.21.0.593.g511ec345e18-goog

