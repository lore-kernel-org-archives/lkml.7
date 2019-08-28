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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D502C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70E42339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMbU2OyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfH1W4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:12 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50111 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfH1W4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:09 -0400
Received: by mail-qk1-f201.google.com with SMTP id l14so1609847qke.16
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uqPQg6B/bO6e2oO0RWU/9KfcrqEBl402Sr4PpXrmZmI=;
        b=wMbU2OyPf3rFonkJbQ0wnImMKCEnwBI6Fdc7hS1qKKi2qEZxBn80d7aA/5N5SpNbS6
         kDYDXogL/j90hxIc0Nhh+DzSJ+yDX6GGzU396lafxavIFWPx2tCNAMrn75SidlcDcnhF
         PmrYj+yT3bXJHTxMey43cZL4vxPAeEMlt61ylLqPRtHKxEtP6EUOMGmh73hSyh+twaAt
         iOxHLhwoLPNYSw1kUsXwfR9BBlIe+UlbM/RgLS6kP6pOl5EVmssWclAvoiZQ486eyShj
         FtqUYKsQyBSNaE5HpfHNEGAT2k3TK8uAmRtFvMLQqVe3ZcFKOrzFGJBj8R8mZPrEfG8y
         kANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uqPQg6B/bO6e2oO0RWU/9KfcrqEBl402Sr4PpXrmZmI=;
        b=W8uOdRGfNzWqaAjkZd4vtj+HPh/+11In2/9BiH4EOAGbvhpPL2gyYGSZvHKi/wDTyy
         yole5SGq3kJZx44Fr0C4iHAsVniotKRG+tbCMI2s52tBnhGaJiYokF7Uzuzw3ntmOmaW
         fYObc9mLmqKW3JK2xQVjXTazSqEHkXUO5jaI0zt1m/KL42yHN7NwVJOv43F1bTVGx4RE
         iDomRqInx9y80xIPNu8vzEiI+Pn9HkEYMTAWPPRAgNTYyjfRN+qOmpK1IZkCl5c31TdN
         oqstZxWWTsT2wFCUShlUp8RsZjhVYHYbHWUE51lerLBPJTyjMTjgTyLp1syv/2XBU2dT
         GgKg==
X-Gm-Message-State: APjAAAWABKgLG4VkOVHjMp/M6iSPsiE12xial0/Yt7N+yGUjsefpRtSt
        zMFPGMsBvETAhFsALVYuXa7SsOb4dJqBob23KM0=
X-Google-Smtp-Source: APXvYqwWjsha8W6OyYf4pMwADgdQ2nhnraNM8a2SWto7wuC2KJF92hySgl5TdLqNp5HskxLRVGLC+DH2XwoY4zMMOu0=
X-Received: by 2002:ad4:4533:: with SMTP id l19mr4645199qvu.23.1567032968146;
 Wed, 28 Aug 2019 15:56:08 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:25 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 04/14] um: prefer __section from compiler_attributes.h
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
 arch/um/kernel/um_arch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a818ccef30ca..18e0287dd97e 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -52,9 +52,9 @@ struct cpuinfo_um boot_cpu_data = {
 	.ipi_pipe		= { -1, -1 }
 };
 
-union thread_union cpu0_irqstack
-	__attribute__((__section__(".data..init_irqstack"))) =
-		{ .thread_info = INIT_THREAD_INFO(init_task) };
+union thread_union cpu0_irqstack __section(.data..init_irqstack) = {
+	.thread_info = INIT_THREAD_INFO(init_task)
+};
 
 /* Changed in setup_arch, which is called in early boot */
 static char host_info[(__NEW_UTS_LEN + 1) * 5];
-- 
2.23.0.187.g17f5b7556c-goog

