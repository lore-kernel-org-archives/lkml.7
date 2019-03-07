Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9305C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE6420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZSTLqL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCGW55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:57:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39737 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCGW55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:57:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so14885539edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGjv/3pODjN3UGu8v7Yv7AK9caCX13/af8mLLqsaVkc=;
        b=nZSTLqL0EhIPZprSM5gpKnHr3bjGN/nv6wyISQIsbo5sJJ6az0E2KVXDoJFv8gHdcl
         QuohliPHxRZQkFICPLdQpcyxHOhLUXZ2l5MQGdCAHREAKrq7gURsCM9MURQleaU4oiI8
         6SbQwK0BTKp7FYEWA1f4tXHsPoA3OugqQFc9wjuSaDJN+b3h48BocYjlVel0ZQXShImc
         beLYq7RRr+liLf20jjsMJnFdHRbslgGhKb9BSiIhD4mqujOtath9MLcTjU3m1zFE79To
         mHidQfvLQ46HxagU/WTHRhPbbRtqL8pR1+P40Ly8IEoJvqteqNbPl+Fsxr9AR2CzopXg
         SJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGjv/3pODjN3UGu8v7Yv7AK9caCX13/af8mLLqsaVkc=;
        b=YUubZYMncmUQgLdWHBICGEmhLQgjPwS3GhGjEW0tPlKEFN+JuRrHv11niZqDAPuwQ0
         oc46SZzH2L/1snhQYvaW/roMlu/euVR8VjD/qZ6YlwI2G4y5TwhHNjVpAag8+xmVc4q/
         XWWaP7b7YzBqk77QAFxuGkXIlhUMoT9VJuq3fqu2IkH3RElpwIFePPldkHJYybYbbyi/
         thYLyAGEnDRwesy70oP7sMcLfcAYesiegr/FpYb0WvW+L54c3pK0Ol9T19Op+M5keXoi
         5diThLTdVcoB/zYje0trKuXA5lXzaX9T7THSiX/+GewnfLzVwp7TdiWZEzFz+jUFehLi
         ks5w==
X-Gm-Message-State: APjAAAV7IozOWqWOpN6P3cIuGZFoBxdmvLZ35UqCOLT2CTZxZiws/W6y
        vUTARv+krx7x4+M1hImBXic=
X-Google-Smtp-Source: APXvYqxLFWrA80ZzRe+AdXNM0Le8/H4fNU5GZ73kqByUGv0JtpEcLXVvO18kxp82eDvRSAoE6J1+Cg==
X-Received: by 2002:a17:906:6a49:: with SMTP id n9mr9202032ejs.30.1551999474803;
        Thu, 07 Mar 2019 14:57:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g31sm1709941edb.45.2019.03.07.14.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:57:54 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] soc: mediatek: pwrap: Zero initialize rdata in pwrap_init_cipher
Date:   Thu,  7 Mar 2019 15:56:51 -0700
Message-Id: <20190307225650.23001-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/soc/mediatek/mtk-pmic-wrap.c:1358:6: error: variable 'rdata' is
used uninitialized whenever '||' condition is true
[-Werror,-Wsometimes-uninitialized]

If pwrap_write returns non-zero, pwrap_read will not be called to
initialize rdata, meaning that we will use some random uninitialized
stack value in our print statement. Zero initialize rdata in case this
happens.

Link: https://github.com/ClangBuiltLinux/linux/issues/401
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I don't know if this is better or to just restructure the if statement
below (I'm not an expert in this code so I'll leave that up to the
maintainers to decide).

 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 8236a6c87e19..2f632e8790f7 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1281,7 +1281,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
 static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 {
 	int ret;
-	u32 rdata;
+	u32 rdata = 0;
 
 	pwrap_writel(wrp, 0x1, PWRAP_CIPHER_SWRST);
 	pwrap_writel(wrp, 0x0, PWRAP_CIPHER_SWRST);
-- 
2.21.0

