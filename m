Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8DD208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnshdqX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfFQR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:28:36 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44808 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfFQR2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:28:35 -0400
Received: by mail-qk1-f201.google.com with SMTP id c207so9709811qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iTRQxecWi31E9RUGi1F0DNGuHKrwwalrM0GzyTsUNjA=;
        b=XnshdqX+g/4Ydbw0GNvRY2ZN060BENLjJ668EKRsXXV5B4I8IkwgOaZgy1o3ub/oQ5
         cemtIn5zdTy/D5pNuss5JXgK3ynyOjdlKbUPH4Fv67QOvDg8bh6I5PEtuA8JuTGguql8
         v3dzh9FcTK0K+4g27TdW8t1o7yQ8FPeqlBbk3FeZ1EByg9uuATgpFU/p5Dh3hC83kBzL
         mdLdaGDObwDMyhAfIS++GeflIKrb4DtXauQhFUjmflX9x3RVwpOxzbc73QxbZHCc6ZBk
         idRa5w9qf48ezMvarkwECVpprkdoy7XIQ46VFa5lp1ihrkCDDM6gOFHDZkITRwOLB7+u
         BgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iTRQxecWi31E9RUGi1F0DNGuHKrwwalrM0GzyTsUNjA=;
        b=cjlc7FVl4u5yWLhgDga6vM8N94SGc8d3O4KyZNXCfB1PekeWCwdZI9CSyjvvrT4vh8
         K+7l5mAWteARIZMx8ikh35FP/1GC35mCip3UJwOUBFdB49CbMIDz6fYCH0nXphYqRCk6
         g5mW5U1J03um4k/uCtThP7q7DgH07kolwA71K6s8HkW8rtflzYJ40VlHD2k0DCOBkUFS
         VWjvJUUmu2kN7yHqYwDTW7EPte70mAQubcVJvJMMhrMAwIxk26RdAi1SIq0ce3BIczIh
         yNb2VkHyMAeUFgLFeljejgfHbAvMQgd2PJl8U9wSWn5S4E9XNWrS/OOeJMNKAuKj5WzE
         WsOg==
X-Gm-Message-State: APjAAAXiPl56vEiL0FSxMzlAml7CQkp0f4WXwjGKZOM1Fzcqm4U95Fmb
        bEiWy+piINNctHuzw99btPoPW27qXw==
X-Google-Smtp-Source: APXvYqwIh5dU3Z3tUjLmjOX+35JiS3tHnfM98yEdZlZvD4i1HLYa5bSH3fVsAdhDQxWihDN9mLx8HNfh/A==
X-Received: by 2002:ac8:3267:: with SMTP id y36mr93487008qta.293.1560792514307;
 Mon, 17 Jun 2019 10:28:34 -0700 (PDT)
Date:   Mon, 17 Jun 2019 10:28:29 -0700
Message-Id: <20190617172829.164520-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] kbuild: Remove unnecessary -Wno-unused-value
From:   Nathan Huckleberry <nhuck@google.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag turns off several other warnings that would
be useful. Most notably -warn_unused_result is disabled.
All of the following warnings are currently disabled:

UnusedValue
|-UnusedComparison
  |-warn_unused_comparison
|-UnusedResult
  |-warn_unused_result
|-UnevaluatedExpression
  |-PotentiallyEvaluatedExpression
    |-warn_side_effects_typeid
  |-warn_side_effects_unevaluated_context
|-warn_unused_expr
|-warn_unused_voidptr
|-warn_unused_container_subscript_expr
|-warn_unused_call

With this flag removed there are ~10 warnings.
Patches have been submitted for each of these warnings.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/520
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 3ab8d1a303cd..b293246e48fe 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -68,7 +68,6 @@ else
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
-KBUILD_CFLAGS += -Wno-unused-value
 KBUILD_CFLAGS += -Wno-format
 KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -Wno-format-zero-length
-- 
2.22.0.410.gd8fdbe21b5-goog

