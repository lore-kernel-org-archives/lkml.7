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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F5EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D6F2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhOt2NbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfH1W4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:15 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43209 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfH1W4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:11 -0400
Received: by mail-pf1-f202.google.com with SMTP id q67so857760pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2yoc1GXfYVLtZMNWi7ZECLQeadNDjorQFIKFDUAGhfE=;
        b=DhOt2NbA0WCkAxiij5rqLx8+s6ImkZreZtvO53khZX4r8LiDrRXEaxcSqPrm+6A/wV
         RbvCPnS9TMGV9TgeEy/fod0EMRNImTnm+Z8InKr4nZuY9320QraIDLwfG4UeBPkoJrt6
         0pFqqxLJ+UKjz/GwCbVbYgV0/aCJLnIOxL26dxi/tGPsNPutnUfdcF5dSm88dTInhfJI
         WMb1aaZKtKc48GMwRkbk1+xryLFSJ+NDPSaoJ4mUag2RWBqLeeO7m3FK/Vf8NYOSFvmB
         ozSXrEfdmPCTCafdWg3hEIT3lZosf2QMhxMfyopav00wNN/1TDGLXV7Q5wdCGgLZC4Cc
         NNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2yoc1GXfYVLtZMNWi7ZECLQeadNDjorQFIKFDUAGhfE=;
        b=lzBlateSzIETjAMrGH1NIrGMvMhZDlnUItHb6NQLfwyHqO9vEYE7Q6isSI++x4A0A+
         F6soiXaTSJLKPwCt8zPjzQQ8ojyQt3jqDcP/2WZVQ8WrB3k2QHezHPEuRX1lLdghgDfO
         DD7ebbDYkWEdDqag9pOmvLCH+8YQlNo5YdEvsF0//Ip9Uk+bm/z3Owo9Hl84ZIi3UfOQ
         wvo3Y+GrFecOr611WJnQQbwuF/DGdd5932nPINQi2ciV1/T4FIlMaQTyDMhkXoeYD1yE
         2oYiWGvg8HPDBGL+1TiJ5ZNfDcpVCxZT/BH1j/LX5G3dyjU/8hQ6TczBlt0KjaNaM0RY
         +5LQ==
X-Gm-Message-State: APjAAAWlwZaRtELOuONtLvHRkhqJcQ+zqp3llIsTFcQd9fTXpZmdDtMt
        nHBiIrRd2dKjSSHt2UPLUr7XlCr9J2txWNMHpOw=
X-Google-Smtp-Source: APXvYqw0QkSd6wT7yOaU7zoS4nMfF/M9loxATVkkpNqvjLCaIJHHVOTdFNdIWNbOPJzKWJ9EOoB8v4zL2PEJy/qRoq8=
X-Received: by 2002:a65:56c1:: with SMTP id w1mr5392712pgs.395.1567032970530;
 Wed, 28 Aug 2019 15:56:10 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:26 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-6-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 05/14] ia64: prefer __section from compiler_attributes.h
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

