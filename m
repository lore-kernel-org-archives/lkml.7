Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17004C46460
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAA324866
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186357;
	bh=1V1WhftugwMezEaFfpMWEiLrO2VrcXMxFnnXubo/O/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuEzq2MXnQFj8+7s5s1Kkg0XX9zWXxlb59Q6/yeA2ZbSRAcm8fvFzXYQpkPULVl0T
	 jGst6pgR0eHf9BU/Uq6dUToAszee8yN66PnNxrYMneEqFHkN0Wp8/sG2ZUSqdCtHM3
	 ZFg8GVL/EvK2XHlJzzZ3KSBirZ/rla3YVoJotPTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfE3DTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbfE3DPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:11 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CB72458A;
        Thu, 30 May 2019 03:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186111;
        bh=1V1WhftugwMezEaFfpMWEiLrO2VrcXMxFnnXubo/O/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcaofg7JtsAs8mLjhjGP8xTZ0MPyzB4mu30XZfQlh8LVYlR7lw/vyjW5n1gQGOZkO
         MTG6sY3ra2hfV7DSoMkWu1L3ai6NpaDXp01G3HI4QFvjCASPEQ+PtBgPt3cOvg6bws
         YqVQFYL8q6pUKe3SjC940A4+bjKiR1f+FHVPHfy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        clang-built-linux@googlegroups.com, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 213/346] x86/build: Keep local relocations with ld.lld
Date:   Wed, 29 May 2019 20:04:46 -0700
Message-Id: <20190530030551.900409084@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7c21383f3429dd70da39c0c7f1efa12377a47ab6 ]

The LLVM linker (ld.lld) defaults to removing local relocations, which
causes KASLR boot failures. ld.bfd and ld.gold already handle this
correctly. This adds the explicit instruction "--discard-none" during
the link phase. There is no change in output for ld.bfd and ld.gold,
but ld.lld now produces an image with all the needed relocations.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: clang-built-linux@googlegroups.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190404214027.GA7324@beast
Link: https://github.com/ClangBuiltLinux/linux/issues/404
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index c0c7291d4ccf5..2cf52617a1e70 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -47,7 +47,7 @@ export REALMODE_CFLAGS
 export BITS
 
 ifdef CONFIG_X86_NEED_RELOCS
-        LDFLAGS_vmlinux := --emit-relocs
+        LDFLAGS_vmlinux := --emit-relocs --discard-none
 endif
 
 #
-- 
2.20.1



