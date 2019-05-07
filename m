Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A43AC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15F5214AE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EPXA/Hhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfEGQNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:13:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34552 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfEGQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:13:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck18so8430350plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QA3HzzjjvBBxLzgrZcUsI/Ka76WXbPB2jGuemOph6Xg=;
        b=EPXA/HhfhYmNIpyStTLIe0HkJknQfVtp7TmERucT0x6/R3/KPT7QKZ1j8HPBgPNCmH
         PPj6gw/Sa78McVub6La5gCIYi1dmv7wK9IsmDDQvk1p6gCHAVy3tgJaXQoomkmjGWRSe
         9ZlZyEgwZMCzML51PiaHKSel0UM2lPxW9HPDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QA3HzzjjvBBxLzgrZcUsI/Ka76WXbPB2jGuemOph6Xg=;
        b=ZJJ+KuarkMQ9SurM7pJQfmg4/wj9TMlgLJ64D+wnzEXkmMck7ljRk9yYEqLG+cMoX/
         JZTIxgglSkEa2rH5Pr3sB9komKF47oodIhA7sCqHltjMhw0AENK7Al0V0KmW+dXaWd98
         Z9lzg+Y7UbJ8ZoTGnMWAK4sD0VLw00DdgHICPH+sRfGXxwN16fcvhWjaP8sXqv4fXnqH
         AiSD6xkc9ljA8EVTnXSzQN4oWzbYk8loMhd1me4Fkk0wI4X/8wqo4bn/2Uuvphz0vMZW
         F6CRO9PSP97inD1WL3LueLf0VQiBhVcNU3BWZW9r+7Sd940lzPzPKmycV0IVhFpiowO6
         l6zw==
X-Gm-Message-State: APjAAAWBSK1uVUR1gxXghPD5bb5n4rwNWlWzkdsULHTEZYdaFitA3Yqj
        NpXe3zsJXThR/6ZGtqKx8I9kznIhaUE=
X-Google-Smtp-Source: APXvYqyeW7D+sPyiZumGQOGNkqWQIR/WsqzmD/UtQYSmmk7rzstgyo+h1xm936mPXzVcBXe1ba+o9g==
X-Received: by 2002:a17:902:b614:: with SMTP id b20mr4001088pls.200.1557245615448;
        Tue, 07 May 2019 09:13:35 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s11sm25864557pga.36.2019.05.07.09.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:13:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Joao Moreira <jmoreira@suse.de>,
        Eric Biggers <ebiggers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v3 7/7] crypto: x86/glue_helper: Remove function prototype cast helpers
Date:   Tue,  7 May 2019 09:13:21 -0700
Message-Id: <20190507161321.34611-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507161321.34611-1-keescook@chromium.org>
References: <20190507161321.34611-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users of the function prototype casting helpers have been
removed, this deletes the unused macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/crypto/glue_helper.h | 6 ------
 include/crypto/xts.h                      | 2 --
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/crypto/glue_helper.h b/arch/x86/include/asm/crypto/glue_helper.h
index 3b039d563809..2b2d8d4a5081 100644
--- a/arch/x86/include/asm/crypto/glue_helper.h
+++ b/arch/x86/include/asm/crypto/glue_helper.h
@@ -18,12 +18,6 @@ typedef void (*common_glue_ctr_func_t)(void *ctx, u128 *dst, const u128 *src,
 typedef void (*common_glue_xts_func_t)(void *ctx, u128 *dst, const u128 *src,
 				       le128 *iv);
 
-#define GLUE_FUNC_CAST(fn) ((common_glue_func_t)(fn))
-#define GLUE_CBC_FUNC_CAST(fn) ((common_glue_cbc_func_t)(fn))
-#define GLUE_CTR_FUNC_CAST(fn) ((common_glue_ctr_func_t)(fn))
-#define GLUE_XTS_FUNC_CAST(fn) ((common_glue_xts_func_t)(fn))
-
-
 #define GLUE_CAST(func, context)					\
 asmlinkage void func(struct context *ctx, u8 *dst, const u8 *src);	\
 asmlinkage static inline						\
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index 75fd96ff976b..15ae7fdc0478 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -8,8 +8,6 @@
 
 #define XTS_BLOCK_SIZE 16
 
-#define XTS_TWEAK_CAST(x) ((void (*)(void *, u8*, const u8*))(x))
-
 static inline int xts_check_key(struct crypto_tfm *tfm,
 				const u8 *key, unsigned int keylen)
 {
-- 
2.17.1

