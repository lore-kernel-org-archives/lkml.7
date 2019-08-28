Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A66C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA99C233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dI5spwXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfH1W4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:36 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55918 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfH1W4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:32 -0400
Received: by mail-pl1-f202.google.com with SMTP id u24so799442plq.22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6RxBbYYa4fUI8s5OPNOU3iQ7zoV1TR03oRwDSBMZl1U=;
        b=dI5spwXfZwaXJJJGLP+3s8pi+5tH9oLSVIATkx/9S9KRLM4d/SJVbeZw2cXMYwOIX3
         Qq/g0LsfcXBc59m1se1ALpG7EdbIT5JaZsXxknVsPyMZMJMDwGHUwgCv77YcNpK8yb1a
         ujquOoWvY1DTAzk0gFMvYqSU7mDnsNE6eaEZATK5/UeecBMbmWjgVmL54sX8RkMDhmuv
         K95INy/7EQxWckULbQEtulTM7A3q/enbJaBcASsxRB+zUC3lYQTtDMUWhfYb/Qv/ex3y
         MnmcqCFalt+80IQsKRLmQpIOjwVqi4hI3NhRi5neRP0SmvoQ8TGcM+TKJvDNxKW4C4wY
         cyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6RxBbYYa4fUI8s5OPNOU3iQ7zoV1TR03oRwDSBMZl1U=;
        b=CR6CP868OfTudDtF4yeZ19Oaa2VYPNPuD7idAy0yTYmMblVr5KA3o+yT9xuYwcLuTw
         hDrvMW9+f9WE0VELsIlUBKGeBUAYN6MQcVleLIl/o/R0pvEoj/x8/Evf7lcY+gn9VwBX
         wpFJ35jWXDXYmdmg2z37E5zqfNmhA3fa296hOgdAJB5VZozImvUhLzyGD+QgWHwTqzY1
         3P27Ys9VWLs4J4p5ClRYOWvVC6XgPpfxgdxh1VtA9s/gfNsvhBeKOk12Va13fzAD6l++
         FOSi0z1FsWfJ/VFZy52PrRaKiGI7YZ5ahJwfj6eFTRQ4G1HdVWMBmNlH9C/3dGAAGD3k
         aNmg==
X-Gm-Message-State: APjAAAXvCKVXlXXS1xlPkfTuVZUAETAMdzToFSTdyk5EG6zTBiwkjeCE
        r9SQTlfHAnt8RdbncSjYZqCkpGUDxqiVA1m7Src=
X-Google-Smtp-Source: APXvYqy8b+bzfspcAmcNXbTxLJBEy8Zi4FfVA8er9UvZcB1bp/M6P0SRLuXnXFuJlWKwhZB8jtwQf+V9mIYGxwk7t0U=
X-Received: by 2002:a63:31cc:: with SMTP id x195mr5459002pgx.147.1567032991282;
 Wed, 28 Aug 2019 15:56:31 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:34 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-14-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 13/14] include/linux/compiler.h: remove unused KENTRY macro
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is not used throughout the kernel. Delete it rather than
update the __section to be a fully spelled out
__attribute__((__section__())) to avoid
https://bugs.llvm.org/show_bug.cgi?id=42950.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5e88e7e33abe..f01c1e527f85 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -136,29 +136,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 } while (0)
 #endif
 
-/*
- * KENTRY - kernel entry point
- * This can be used to annotate symbols (functions or data) that are used
- * without their linker symbol being referenced explicitly. For example,
- * interrupt vector handlers, or functions in the kernel image that are found
- * programatically.
- *
- * Not required for symbols exported with EXPORT_SYMBOL, or initcalls. Those
- * are handled in their own way (with KEEP() in linker scripts).
- *
- * KENTRY can be avoided if the symbols in question are marked as KEEP() in the
- * linker script. For example an architecture could KEEP() its entire
- * boot/exception vector code rather than annotate each function and data.
- */
-#ifndef KENTRY
-# define KENTRY(sym)						\
-	extern typeof(sym) sym;					\
-	static const unsigned long __kentry_##sym		\
-	__used							\
-	__section("___kentry" "+" #sym )			\
-	= (unsigned long)&sym;
-#endif
-
 #ifndef RELOC_HIDE
 # define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
-- 
2.23.0.187.g17f5b7556c-goog

