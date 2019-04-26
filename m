Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A4C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fSwqpLRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDZTGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:06:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33704 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfDZTGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:06:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id d55so2189778ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbJdb5w6w7kGge6MK7fpgojp+/1d46380TesN+HnNWM=;
        b=fSwqpLRolPJ46QmV/agHQ/lqD3fy1huJYcBCSpRwzn8y3xEuk+fjhnnLdTxSY/yhm8
         2vpQzU67MbQol1d1EzimEA9xhYbX78yBe3wcn3TqNvFFnobZy4W66y8KLDznm8m9GKdC
         BAuX4dNpqMsrPWEuU+aHj4giA/AyTMSBpQGy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbJdb5w6w7kGge6MK7fpgojp+/1d46380TesN+HnNWM=;
        b=VlML7hyqFa8pNKYy19G7tWIOeJAmMXBv6cHrGvKpvv7c4bjY1hgK+OyxK/AuOkLlec
         bNCgfHgzuyK75N1xavkymDxTAG0178HVZ4RnYm0J10Xlv495w1YZQqspSSWP7cNwDMz+
         DS6UxLOvl/1KWXJGdHh4f/yePoOT9OX/zuC6f02TTalD7iaURXKaIda9KzVTUShc+nRi
         akMRs80D9a9uXQwF1U1c+YnNfaEJwBgMA8BJlLHCeV8pTZVHsx7dhm8TgKoyadVthwuN
         iaHawqlz4oXrllzo/Pge5Siewh2VqEkyRFWNy5dxtY1dR7ixHNi7thuyOnSJAC9L9Nh0
         X+QQ==
X-Gm-Message-State: APjAAAV73HpqYuApmdvTwFUkwSJn21qlxvg2KMiJs6TqxmARX+pIPUoA
        oF9DJMPyu6LlaDOPjnPlWI2Dk8LfMDJJOozG
X-Google-Smtp-Source: APXvYqyD1abKt8W0dog8jznz/NdVrVMEyK7yJ252mj0vgNIu7VnkERtx93syyI68SOgGlYHp0QKnvw==
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr23027225ejd.260.1556305566537;
        Fri, 26 Apr 2019 12:06:06 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id k19sm2580862ejb.43.2019.04.26.12.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:06:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Will Deacon <will.deacon@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/10] arm64: unbreak DYNAMIC_DEBUG=y build with clang
Date:   Fri, 26 Apr 2019 21:06:02 +0200
Message-Id: <20190426190603.5982-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426130015.GA12483@archlinux-i9>
References: <20190426130015.GA12483@archlinux-i9>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current versions of clang does not like the %c modifier in inline
assembly for targets other than x86, so any DYNAMIC_DEBUG=y build
fails on arm64. A fix is likely to land in 9.0 (see
https://github.com/ClangBuiltLinux/linux/issues/456), but unbreak the
build for older versions.

Fixes: arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Andrew, please apply and/or fold into 9/10.

 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d0871d523d5d..315992e33b17 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -83,7 +83,7 @@ config ARM64
 	select CRC32
 	select DCACHE_WORD_ACCESS
 	select DMA_DIRECT_REMAP
-	select DYNAMIC_DEBUG_RELATIVE_POINTERS
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS if CC_IS_GCC || CLANG_VERSION >= 90000
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
-- 
2.20.1

