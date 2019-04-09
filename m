Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9156921841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KBBodNXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDIV0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45737 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfDIV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:26:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id o26so96049edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0w4/Dek1MuUw9RUJIx68ZSWHBKjhr7mhry+FNPNfIwY=;
        b=KBBodNXybAF2N0oz3UqQW4QAQhMFuL7IUEI2k3dTe9WGsBNYEUkj/w1uX4ecLowxEq
         QLufKDomd2RHIqVh46h3AejR6bT/lPVcPfp6/vgtb995pJp8fT7ykJ97joGs8fixSd5h
         8Pwh7h2lgwaytAjGlQi+1MLKOANFZp7rSTvf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0w4/Dek1MuUw9RUJIx68ZSWHBKjhr7mhry+FNPNfIwY=;
        b=KcLJXyztrbOu9cW1ic9TibQs7kyWCojlt093fPy0d/jW/9v5hxSeDAsFWwSlNuJUWh
         YvUruaY2aZaj0uytw4hShXcSjrdHkAJA+X01gGAnSjF1JfM4kTMnY2Ly/4MNTH3F9gh9
         ntHJ55vF7yZdE00pMXbdCSL/QxSFme7oX9hpsJw2MbkAa0OieOKfKZ12FcfHUQg72lo9
         mCOylY/DVwPmWl4ak7KOp8OVt8wSI7XMryyDbIaoFi5mX7Nznc0F4Z8U6ArWeZYFQ961
         QzuVITGqLLvc06qxmudK0xe1fB/5sB66iegovTYP7QaXzKp8tRFzVFUjvgK73zuuFm8V
         3f1w==
X-Gm-Message-State: APjAAAVFpZt153KXARg7UQJToFPxo6moBjK3puEjW0Dg92DC3pI3IaBP
        F0PH4dQPpxmg87s9e/HaArplVQ==
X-Google-Smtp-Source: APXvYqzibpE9q7ZYACnBi7xa1MPMRgPRkeGW7TzqdFCwCosgloKMSxnGgPQmDbXVEfUbKJl7CwQ8jg==
X-Received: by 2002:a50:9179:: with SMTP id f54mr24290864eda.207.1554845159330;
        Tue, 09 Apr 2019 14:25:59 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:59 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 09/10] arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
Date:   Tue,  9 Apr 2019 23:25:16 +0200
Message-Id: <20190409212517.7321-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to GENERIC_BUG_RELATIVE_POINTERS, one can now relativize the
four const char* members of struct _ddebug, thus saving 16 bytes per
instance (one for each pr_debug(), dev_debug() etc. in a
CONFIG_DYNAMIC_DEBUG kernel). The asm-generic implementation seems to
work out-of-the-box, though this is only compile-tested.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm64/Kconfig            | 1 +
 arch/arm64/include/asm/Kbuild | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e34b9eba5de..d0871d523d5d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -83,6 +83,7 @@ config ARM64
 	select CRC32
 	select DCACHE_WORD_ACCESS
 	select DMA_DIRECT_REMAP
+	select DYNAMIC_DEBUG_RELATIVE_POINTERS
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 1e17ea5c372b..1ead0d645686 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += delay.h
 generic-y += div64.h
 generic-y += dma.h
 generic-y += dma-contiguous.h
+generic-y += dynamic_debug.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += hw_irq.h
-- 
2.20.1

