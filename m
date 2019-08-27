Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B31C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED842186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIdzwFts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfH0UlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:41:06 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36979 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbfH0UlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:41:04 -0400
Received: by mail-pf1-f201.google.com with SMTP id w30so233656pfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6RxBbYYa4fUI8s5OPNOU3iQ7zoV1TR03oRwDSBMZl1U=;
        b=gIdzwFtsEuL6/9C2ZBd9RoB6Keyd4pHLPnayQ4xW4tnsl/5z68yn8orSk4INiOuIci
         ugqggbiUUYtg2VlnIfVTYFKBdsYRtbtW4QCb0WGZE0qK3veM9mDQv2MmlshIcze9mnIs
         ZHDIdDmwa7viz32BoNkVXvPPb6lfG8+r+E53VYJ4bzm/GU85PefMNmsrAwAnAr1rBAU4
         ZhbpBKk2kHFn0SCvX3vqScAfd2P1w8gfV+l28wbUFJlMymbtD9LteoMRZ+CokbMpiw1l
         DeivNc3FnYy/gpvdE0fukazKbLuS0jSan/u1yvNuNBYiHC2tStfSImENJKIrjj00vDzL
         2b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6RxBbYYa4fUI8s5OPNOU3iQ7zoV1TR03oRwDSBMZl1U=;
        b=ObGqoT9u0/GMBImk+32muinbBy6cyM0oPeuF3Kmou8IfO7qUuPSg+tggnZnt4rwrf7
         WtWr40obeQtkPk2KIwIwhuw0sXgdrOZNB7KjMUF0e/mto6Quq35PVe+PXMnxT5ILbu3w
         F6dKjKs5POBEIvIdwcHaUOzoWUpNoKaqFOiYhlqZLeu4pDiZtCSoxG0DYri16CKeHCkO
         YO90pFhYYo/Bq1FUwLwZDK46gbNWXJO6SYYR5lP6qLIp/nsxiRzUsr/gMOUf5D4HGwNV
         exCSKk7+VMPnKJFmHuNDE2Th2lYQuCkHohWXA0gEf895nErlkECg730cRt3EdVgsIVtF
         5fSg==
X-Gm-Message-State: APjAAAVKhZPvy0F75x1iHZXXLa17VR0FvuOyFlb23LaKagTGz4+ol6bR
        QFh8IDk1P+HzEqWIuqa/8UbmhDnrxHzy3StUCLo=
X-Google-Smtp-Source: APXvYqz6YQ/czTj20oLuDxTcYoJzZrCtSe40tno22XM5m74Qa68CuW7t/xrQG4eCWVeGnzb09ndNjke0t1GKMduRkW4=
X-Received: by 2002:a63:7d49:: with SMTP id m9mr283474pgn.161.1566938463070;
 Tue, 27 Aug 2019 13:41:03 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:40:06 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-14-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 13/14] include/linux/compiler.h: remove unused KENTRY macro
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

