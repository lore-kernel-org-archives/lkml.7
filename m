Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C26C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038B9206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RBA3HZTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfKVBEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:04:13 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:45907 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKVBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:45 -0500
Received: by mail-pl1-f180.google.com with SMTP id w7so2356341plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xI/dPXrrYqWegaSFAnlL3jgT7wQ+lhRdMLTgo6t8Ans=;
        b=RBA3HZTsQVNixmKnD00ysKCsEDYLlENk0r/mTUsZOUy2hD49/648riiImHjQvVx0UQ
         CVLu6vTL3NnJbZQsBBWrXdW9cDUAvmrEW95/8AV6i2Yx10wKLN21RO/l29TkxpEhsg3K
         LMUCtW6tqZ89BRUaz/wG5cnaSs+0EUGxfaLe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xI/dPXrrYqWegaSFAnlL3jgT7wQ+lhRdMLTgo6t8Ans=;
        b=NUzGdfi/osTGR3Mq47sQ6sc0yiCb+622mg5PgcOe2bYSA+iqggu/UCVztozWv5XRgE
         w3Kt38MR9sfq9zGqrGTPwtvZdrqrF/XwnfPa8m2/w5NFC+sT41hiOtABSj7Y0p9DkVDl
         USWjCBhaqdxAs3lva2FztPhpdbRUbggRrxIKzNKEx/LHybcC9hamCNvh3MMkoPGSe4eu
         tqdiZn0+5pZz7+c8bz4/woRttIo2a0xJww/yMtrle7NiOpcWU4E0ow6pwEov3oUULQZT
         8QDXIME/e1VsdECq5rbiPdZMDf3uvQ68Qp2s6hcsUc+s5i5vBqklJCyl8b9X3cfwxJh8
         NiEA==
X-Gm-Message-State: APjAAAXnSH0nu+rbzdg27mt77uaX9bK6gQV5C9QU6q44HFKa7pJS6XfO
        N7amg2jxkDnEhSUj6VZ04zmhfg==
X-Google-Smtp-Source: APXvYqxvLuLvwOD7ySfWOmJmnhEcGvvulnrYgJt72BDggzBdZ0gfowf/Jw6lqUM9sF24EUx+wum6aQ==
X-Received: by 2002:a17:902:b7cb:: with SMTP id v11mr11529425plz.176.1574384624926;
        Thu, 21 Nov 2019 17:03:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 199sm4858587pfz.186.2019.11.21.17.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 7/8] crypto: x86/glue_helper: Remove function prototype cast helpers
Date:   Thu, 21 Nov 2019 17:03:33 -0800
Message-Id: <20191122010334.12081-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191122010334.12081-1-keescook@chromium.org>
References: <20191122010334.12081-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users of the function prototype casting helpers have been
removed, delete the unused macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/crypto/glue_helper.h | 5 -----
 include/crypto/xts.h                      | 2 --
 2 files changed, 7 deletions(-)

diff --git a/arch/x86/include/asm/crypto/glue_helper.h b/arch/x86/include/asm/crypto/glue_helper.h
index ba48d5af4f16..777c0f63418c 100644
--- a/arch/x86/include/asm/crypto/glue_helper.h
+++ b/arch/x86/include/asm/crypto/glue_helper.h
@@ -18,11 +18,6 @@ typedef void (*common_glue_ctr_func_t)(const void *ctx, u8 *dst, const u8 *src,
 typedef void (*common_glue_xts_func_t)(const void *ctx, u8 *dst, const u8 *src,
 				       le128 *iv);
 
-#define GLUE_FUNC_CAST(fn) ((common_glue_func_t)(fn))
-#define GLUE_CBC_FUNC_CAST(fn) ((common_glue_cbc_func_t)(fn))
-#define GLUE_CTR_FUNC_CAST(fn) ((common_glue_ctr_func_t)(fn))
-#define GLUE_XTS_FUNC_CAST(fn) ((common_glue_xts_func_t)(fn))
-
 struct common_glue_func_entry {
 	unsigned int num_blocks; /* number of blocks that @fn will process */
 	union {
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

