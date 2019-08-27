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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F67C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABE32077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0LdiSdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfH0Uko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:44 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:55802 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0Ukn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:43 -0400
Received: by mail-qt1-f202.google.com with SMTP id z93so129721qtc.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tH7yiZ4DL/IkimFAxsXUYbqZ+IlrPZSmhVaW+hn/z/8=;
        b=n0LdiSdOzXuRJngcIMltgwmxzEdvOm/U2iaaJkJ5SMyebx7xgAPC0fWRUGoaPlgEDm
         i2Kq7YcvAIGN+5tZsRlDY7cKjJz0WNsjEZrj1G4PT5xk9M9urqOw/otYjBC1XO4LFkKF
         6BVIAhu27ZTRv5fu9QWEkkLqlSFbBSKXJhno3wD+XQvnW7oduaHsf7AxHJjI5zoue+CU
         kqp6BK40i8JQOEqSbp72KhHSCfJwrlweqQyf1rFOGeeEKZn7nHPE+ykpQ8cVpru4Tpn9
         i41OZfOBoEZH0a/ZbskqZJf4yazbh71/OPAPdM9voiUphvh7/Xt5YjE2JDzhEGBgCTnX
         6+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tH7yiZ4DL/IkimFAxsXUYbqZ+IlrPZSmhVaW+hn/z/8=;
        b=QUV62n4HEuQ2zZT2IR83HE7rS4H8atnzwadn8mGdx7bs/GrPwphrABwBNEXJy0ZVcV
         KRMcMMtceXi9tJ6F7+UgKSuXy2489DYbLK2FupGgry55I/+lZ1/6aRO5l9Fjzmuii97T
         1SsjdzWXHKxWFs4usVoFDx9Di+2JE6kmyUwIushM+RqV/97t27WpjgLhF3WtsM996dfc
         Or4W++VyUcufOL5y6jAfIiIulHcot7mgEtwqhopg0x7zs1rIdtq1MkDW/NBhxSBpOj2Q
         Jo7WJXwtmFhh80PCUyNQthWRzx/fDiHRtRFBwoszNIAcyZwNkt6+BHsY0cxgCXW+2+vx
         gNKg==
X-Gm-Message-State: APjAAAVt22liz0dPvfpMPVhUippfAvZpiHbPIKeX1exYMhsQZzCMmJ+K
        iBZ+4ouaKNsAIKBxTdPKtSQN5Qfr/xixOiZ0Cew=
X-Google-Smtp-Source: APXvYqzJZnrv473xdE+xscQzgbsuz+CeCnMlmmnf2uxt9YXP9p6WSvHCNEegfRipiXyRCHqYx1rvhuqt/+djbRX2w7c=
X-Received: by 2002:a05:6214:10e1:: with SMTP id q1mr461176qvt.148.1566938442229;
 Tue, 27 Aug 2019 13:40:42 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:58 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-6-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 05/14] ia64: prefer __section from compiler_attributes.h
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
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/ia64/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/cache.h b/arch/ia64/include/asm/cache.h
index 4eb6f742d14f..7decf91ca11a 100644
--- a/arch/ia64/include/asm/cache.h
+++ b/arch/ia64/include/asm/cache.h
@@ -25,6 +25,6 @@
 # define SMP_CACHE_BYTES	(1 << 3)
 #endif
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* _ASM_IA64_CACHE_H */
-- 
2.23.0.187.g17f5b7556c-goog

