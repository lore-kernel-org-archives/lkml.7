Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD193214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997459;
	bh=raaVFButIrKCtpE53ubIkMcQMcYpTaYJMIcpNTEU23s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nreOnpN+fzyLHeVOYK0fbpgt8eM4liPOyZFIxYfV9sg7/EmbY5cu1iJLPc8ZHN/3s
	 7u4hINorpoaRe4j9XjqaYvVR6RXK70gwtO20HaWLCd+TBCmiBpHl7wIvo20XSXFsSL
	 5ydMrgdofe1RA7styPNz+wmMNLjy7fgL44nm/aSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbfGXToS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390789AbfGXToR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053E422ADB;
        Wed, 24 Jul 2019 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997456;
        bh=raaVFButIrKCtpE53ubIkMcQMcYpTaYJMIcpNTEU23s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSf9r85e2vqp9o7fEUXF9aQfSUZOXMTagSAysrfHginQcV1/th8BS5kie8DpgpN13
         2CQ3sQ8qe8xg+Ufm4a27fIqGQXlWGrykhD1DUjgFH6YskWEyT+rkn8Z9YOmW+ClDq+
         kqkNRdMS5TO9T/yoSx4qpc4kWk2Yh44PjggpAdA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        Peter Smith <peter.smith@linaro.org>
Subject: [PATCH 5.1 003/371] arm64/efi: Mark __efistub_stext_offset as an absolute symbol explicitly
Date:   Wed, 24 Jul 2019 21:15:55 +0200
Message-Id: <20190724191724.729368386@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aa69fb62bea15126e744af2e02acc0d6cf3ed4da ]

After r363059 and r363928 in LLVM, a build using ld.lld as the linker
with CONFIG_RANDOMIZE_BASE enabled fails like so:

ld.lld: error: relocation R_AARCH64_ABS32 cannot be used against symbol
__efistub_stext_offset; recompile with -fPIC

Fangrui and Peter figured out that ld.lld is incorrectly considering
__efistub_stext_offset as a relative symbol because of the order in
which symbols are evaluated. _text is treated as an absolute symbol
and stext is a relative symbol, making __efistub_stext_offset a
relative symbol.

Adding ABSOLUTE will force ld.lld to evalute this expression in the
right context and does not change ld.bfd's behavior. ld.lld will
need to be fixed but the developers do not see a quick or simple fix
without some research (see the linked issue for further explanation).
Add this simple workaround so that ld.lld can continue to link kernels.

Link: https://github.com/ClangBuiltLinux/linux/issues/561
Link: https://github.com/llvm/llvm-project/commit/025a815d75d2356f2944136269aa5874721ec236
Link: https://github.com/llvm/llvm-project/commit/249fde85832c33f8b06c6b4ac65d1c4b96d23b83
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Debugged-by: Fangrui Song <maskray@google.com>
Debugged-by: Peter Smith <peter.smith@linaro.org>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
[will: add comment]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/image.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 33f14e484040..b22e8ad071b1 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -78,7 +78,11 @@
 
 #ifdef CONFIG_EFI
 
-__efistub_stext_offset = stext - _text;
+/*
+ * Use ABSOLUTE() to avoid ld.lld treating this as a relative symbol:
+ * https://github.com/ClangBuiltLinux/linux/issues/561
+ */
+__efistub_stext_offset = ABSOLUTE(stext - _text);
 
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
-- 
2.20.1



