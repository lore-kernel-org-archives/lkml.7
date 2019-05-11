Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5368C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B720C2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnMpbkIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfEKBXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 21:23:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36459 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfEKBXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 21:23:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so7584584edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 18:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Sy6IJVq4VJSGNsCncCOevfEMVkxJ4DdVxf3Fz7dO1o=;
        b=rnMpbkIZV4iQ4uC1XfVbzikGIDK3Y+X7xhPA0psUZYD05UE/Dqd5RuIMhOxiYAFKqn
         uKs3xy3l40Rp4PJym3z08kOPIuHzjGzk2tezFv6qMlcYGEncR0+Y7n0whFx+kDsCB6Tb
         Z49SYnDW8VehUpLEXctnUsWYHTGT++65Lp23fGWAICCifApmLlteKtlNTK2oFp3mQ6lH
         ikukBB6HUN+zaBVSvGe1nLUw/HbhQ8ruWgpsy/T66ozOwjE5ykYJtuGBAtvUAPDllIxf
         /gCI9y5LGU9tCSG/+V5w754Nbb8UPqwBMl1/pqEk1U0JYG6UXtn9r/cJGpKeIlOC2zyt
         q7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Sy6IJVq4VJSGNsCncCOevfEMVkxJ4DdVxf3Fz7dO1o=;
        b=Nkb3GkMxj8V6WQtrvV8SjAh+NnBz7GHWX10e6x6mvC/lstDWeqmS2vU9aN0OMuJv1W
         UYM5XCIT6VC48ZHT/pI2Hcpf0Z1lpmO+O8QoKA5vj/PaFYkjLMR9LdR5XFC6e2LZmj5h
         kuqnQZbpoyk5dQgSyYFYJ3vnZku1+glkUWMUoKRM0bduWrt/FO76FqCXfwpNFj9USoBh
         9rKkYwpkN0/Ko4Cb66YrDl4DmPCUkje3XsAHDBB3GbSOaskGjJ5KA65qT217kdeuDV8u
         08WO0XLLTw6ei+3rozbgjTmQl8VtZc+3nkbXXZiCF+8bAwevVRy7EiXy0TrakDxBGwCp
         bqVA==
X-Gm-Message-State: APjAAAVSxKM/pk9nqkX8bTODPvKoLcgpMi2NajdURp/WpZ6KpR0aKkj6
        HqVonk3+e6wj0F963Ex9PA8=
X-Google-Smtp-Source: APXvYqx0DjxzxMiJASMnY3yXqVa1UNYgM9oYsPoKMw+8rRXJ93TwPZ8R959C69MGa/Os41aCsPmcww==
X-Received: by 2002:a50:b3a4:: with SMTP id s33mr14924192edd.112.1557537824828;
        Fri, 10 May 2019 18:23:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id r3sm941779ejb.88.2019.05.10.18.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 18:23:44 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mfd: stmfx: Fix macro definition spelling
Date:   Fri, 10 May 2019 18:23:01 -0700
Message-Id: <20190511012301.2661-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

In file included from drivers/mfd/stmfx.c:13:
include/linux/mfd/stmfx.h:7:9: warning: 'MFD_STMFX_H' is used as a
header guard here, followed by #define of a different macro
[-Wheader-guard]

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/475
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 include/linux/mfd/stmfx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/stmfx.h b/include/linux/mfd/stmfx.h
index d890595b89b6..3c67983678ec 100644
--- a/include/linux/mfd/stmfx.h
+++ b/include/linux/mfd/stmfx.h
@@ -5,7 +5,7 @@
  */
 
 #ifndef MFD_STMFX_H
-#define MFX_STMFX_H
+#define MFD_STMFX_H
 
 #include <linux/regmap.h>
 
-- 
2.21.0

