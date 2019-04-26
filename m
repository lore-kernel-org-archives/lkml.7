Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D889C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E676320869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZwDxj6NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDZTGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:06:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33710 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfDZTGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:06:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id d55so2189830ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfeGW2KMz/FXR0Ak0qG/Xrz3Om6FI+VqPqCOac6VWK0=;
        b=ZwDxj6NYYQ0lVHEiRjePF7dVhtTjLZ4WRcCUvquHehKY5j9KkDfD0a3VZwVjXiyRyV
         2y/yxNs4ofqQH5vNKi3sZugsV46m0sQrlAAAktvDtboto/3NtDzq6Ij5ACCAgM/a7iGB
         PKBhHHtWEMlDuI6re7GK+sSxlktUbcte/LzXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfeGW2KMz/FXR0Ak0qG/Xrz3Om6FI+VqPqCOac6VWK0=;
        b=OtZMlMFWat7CWvQ0Y/GNUAC4p8kCwQHVib4cU+fNCXuLXxfP1LvvuKNriBJPtbl2c7
         i6qFdW094uuQLWuGB9WmKAw+/3PjzdBdrYTHEAqmVOorc8sFtmtKMEHZ3qfvz0bwSHQ8
         ARcpgbA76yv6UTaxTeTXnzRJ4Yda+cDehWGIACQNzK9KSW3HpukbCGPUzB3wN9C0FMYZ
         U8jfWcq3DkQMNyeAYGFKNWG7/b+Fjbbff9IV1N3Aa9u5FE3gat09k/M4E/QtmXoZVHsH
         vHhPHNbWbVEB7PbIO/iWkaj58Pi7uH6sSioippeWE4hX/F7GlPHMPQluv9xpTJiq7uBt
         JiVA==
X-Gm-Message-State: APjAAAXlRveg7sGA+7Sc8CKscKiqz2WqFkcYT7bbLYqdyc7KJANJL9MF
        RLPvtWB3ZI+JOnp8LhqlopjWEA==
X-Google-Smtp-Source: APXvYqye2nnuhIkpxJKAk+jx5GakviX0ROdF215GjoEpPacF9cRvIq9ChoYCfJw4i0+EsI04W92Zsg==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr15544232edq.295.1556305567686;
        Fri, 26 Apr 2019 12:06:07 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id k19sm2580862ejb.43.2019.04.26.12.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:06:07 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/10] powerpc: unbreak DYNAMIC_DEBUG=y build with clang
Date:   Fri, 26 Apr 2019 21:06:03 +0200
Message-Id: <20190426190603.5982-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426190603.5982-1-linux@rasmusvillemoes.dk>
References: <20190426130015.GA12483@archlinux-i9>
 <20190426190603.5982-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current versions of clang does not like the %c modifier in inline
assembly for targets other than x86, so any DYNAMIC_DEBUG=y build
fails on ppc64. A fix is likely to land in 9.0 (see
https://github.com/ClangBuiltLinux/linux/issues/456), but unbreak the
build for older versions.

Fixes: powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Andrew, please apply and/or fold into 10/10.

 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6821c8ae1d62..8511137ab963 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -155,7 +155,7 @@ config PPC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
-	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64 && (CC_IS_GCC || CLANG_VERSION >= 90000)
 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
-- 
2.20.1

