Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7ADC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB4233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huvkYD/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfH1W4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:21 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:44078 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfH1W4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:17 -0400
Received: by mail-qt1-f202.google.com with SMTP id x11so1390167qtm.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iz1qiAOSCOnkxPsyI19LsO+D8x7BgqmfmJjcxn2Wo2I=;
        b=huvkYD/BTecsR5bt3x7yOO0jX2I8MRzU2PCbapB9Rim+i0TKFCJwFYfs1qv2+tW+8C
         ePsPA5CHhXt/ldTR0AtqySSNyHZeLffJl9ij4Xui4ZXnF3EV6t21ZK+K/gG1Po6veo+H
         IqdfrwTV0RYI/CPocgiP/yLLGeLZP0JlyfoEcyBdllfByszYgWtJAAAKOqvZuweLqxdn
         gFBzRStgyX3yg08SjM3FfQhMcMHWR7xHI2UD0XK22xJ/xLPYA5mZvXRrTzzYt4MMVnO5
         QEuWiZ79jR4gvE6N/SZs7jP+R5d3s49LXIAHQDnYjiH1kXt3t/DJ3Ov7wjZGo3cWR9tD
         +nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iz1qiAOSCOnkxPsyI19LsO+D8x7BgqmfmJjcxn2Wo2I=;
        b=D4gIROY68Ar5ULMQMLASYardYUKrFxgSABnCCpEU/aW1cU0WfrECBIG5VYS+w8PY8J
         /lWtpfmMQqGpeBi07vzca7yYHzpS9PBlKw9u0mH4Q+6X1FYuY9WxeWZnBO0C1+iEJVU0
         7xWxqJlPhB4OqsQ0t0R28TBEYZx0Kti5EqcG6Asf++1B0aHzv7q78cby8iy3Lzaux3Tt
         zn3cGJcvJP2Omt301g8llg9BypUGtO9aufwTrG8R8gqoe2Sg0+NuJgKiN9R+0ar/Zd4I
         JsTBYFshkU6bye8KHm220ib5HSBtJlsBXBl3/8FXfb+uujQneiEOdEN7DY46qkFR4+C5
         lXjA==
X-Gm-Message-State: APjAAAV1SSUyWfH8JuLLORHXmHbq4WxGAKlcco3JQRsHWGBK9TmGMvWM
        fUPfI/6QJKsKyFC7RbGpx+xVTbUgZ0ZHrhjbMNI=
X-Google-Smtp-Source: APXvYqyE1qAUBmR6ND4QXaSdcL8VEdEtGeDIvMN3tKsp973Hqjzda8IfDFyW5E0zPdc/DGvGK91iIh4N+DfztnNDtRU=
X-Received: by 2002:a0c:c2ce:: with SMTP id c14mr4701970qvi.243.1567032975799;
 Wed, 28 Aug 2019 15:56:15 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:28 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-8-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 07/14] mips: prefer __section from compiler_attributes.h
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

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://github.com/ClangBuiltLinux/linux/issues/619
Acked-by: Paul Burton <paul.burton@mips.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/mips/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cache.h b/arch/mips/include/asm/cache.h
index 8b14c2706aa5..af2d943580ee 100644
--- a/arch/mips/include/asm/cache.h
+++ b/arch/mips/include/asm/cache.h
@@ -14,6 +14,6 @@
 #define L1_CACHE_SHIFT		CONFIG_MIPS_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* _ASM_CACHE_H */
-- 
2.23.0.187.g17f5b7556c-goog

