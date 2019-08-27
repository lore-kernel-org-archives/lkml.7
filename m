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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA1DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CFF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iD5Ox0Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfH0Ukw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:52 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:33424 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0Ukv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:51 -0400
Received: by mail-qt1-f202.google.com with SMTP id z4so182509qts.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jdT1qqSDs2qFZzLVnvA8tbfOhFVP3FSFASOlvOrlNi4=;
        b=iD5Ox0Ujybxm5MGH5+JvS/NIUjFsEsRINEO9WSqSIOq1NsnfaUXMY0/4OYvLKkiqTk
         Nb8OT8rye6gaiP6NP9McvKngKEIno81ydeKx+3m8cIz/fNSWmOqCI5gSVfpyEyjD4wCF
         Ui19boz/LAoZa8N8aOmOS1mPINSGPMpmAAR5Y0R+q/wJheuPgTL+n39PWUyYs+qMKfgL
         4I7moS1Gv3VY/5nHHdVrNuSi6TMfzaRe5buc7XrKtmVhJVqnKrRJMWJXVtnLBfSOS8pE
         3HabM+dyLOhE5J8trjwPQaGAqDqs7DbToGaNFAtsWAa13c1sz6IQG7gPOWe3Ub8mGHfm
         kGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jdT1qqSDs2qFZzLVnvA8tbfOhFVP3FSFASOlvOrlNi4=;
        b=AzzAN3u51sQDPSMx0hhys0Iyh1C8AtUCQ/a2Ei5qcLCnesETqH+anF0Y3DuaJnJnwu
         BgYRQJKM6KtYro9UzAhaINHM8FpBTHCNu5zaBZIFDqIQZP1dvc7X9kgV0n3UsRL96t+1
         n5CfCT4CKxWUFyLAvosFWlIRB1pJDmEvAbxiUbDy+dBYb2jZ8+BYTa3eG+kqQtK8zOvA
         SWvFewGno51J8atyPxDtWOThOWcv4L+yJ8sqZD/1UAM7aA5Mq7gHhEupY2fYBR1LGszT
         vZ9suISxhj48oydo/nyPCy9Xcqzwyt83ZLjErVq0fwPIQj1pIJaSyytjQ3d4daCz3TxG
         LpRQ==
X-Gm-Message-State: APjAAAW6uNB9r2h/ZTnW13w6bsJBq3LBo7+Qdvhz8kffbrH6rplK2avO
        wlzjZ1jaULimEzVFxpAv9Pr2S0wSjJcWf9XQ/FU=
X-Google-Smtp-Source: APXvYqzBv03oAq+2n+liA5CsdGFZfhAXitlTdyz2iG8KA5zWMF6S2ydo1DmOTBwY6ZcomM/4l19nS6i4hA81c9Ax+Bs=
X-Received: by 2002:a05:6214:18a:: with SMTP id q10mr410277qvr.157.1566938449923;
 Tue, 27 Aug 2019 13:40:49 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:40:01 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-9-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 08/14] sparc: prefer __section from compiler_attributes.h
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
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Acked-by: David S. Miller <davem@davemloft.net>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sparc/include/asm/cache.h | 2 +-
 arch/sparc/kernel/btext.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
index dcfd58118c11..9a9effdd01e2 100644
--- a/arch/sparc/include/asm/cache.h
+++ b/arch/sparc/include/asm/cache.h
@@ -21,6 +21,6 @@
 
 #define SMP_CACHE_BYTES (1 << SMP_CACHE_BYTES_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* !(_SPARC_CACHE_H) */
diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 5869773f3dc4..b2eff8f8f27b 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -24,7 +24,7 @@ static void draw_byte_32(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_16(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_8(unsigned char *bits, unsigned int *base, int rb);
 
-#define __force_data __attribute__((__section__(".data")))
+#define __force_data __section(.data)
 
 static int g_loc_X __force_data;
 static int g_loc_Y __force_data;
-- 
2.23.0.187.g17f5b7556c-goog

