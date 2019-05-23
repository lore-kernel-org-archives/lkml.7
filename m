Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A077C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390502089E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lrXxW/5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfEWA5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:57:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37949 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWA5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:57:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so2177917pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 17:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCcxFZ8u217pCLU2+Z7QXQBb4BZSJxt773aXmFVctu0=;
        b=lrXxW/5uiapy3w5HtMfhyB3Bk6NFY9FVuWaL71RTtfJPQMsRDPNUJ7ipQQta880l5N
         8GpHNpjXdvqbRNY+BQ07w0p05xblGT3W5Ka+LFkYA2Huk3F0A6Ztn4p1oSeVkpdpoxLE
         LdAXKWYp/K9oGn3cDvAwA1Fr6ekNdwdeBAKUtMMSxb+WkpnKgkxcqTZODoWSQJfA9tUs
         cpYaq0PTzWmljBUSbDbC3aXbPRLGwxCP3t3uxoTq5tZxmd7gMpoPfBTAovC8hsRFxImI
         3WUaej/Bo6ywL+QHNzw0QifPZAJ1sdx+u8r/4xhLepgfejmyLaTGb6mA+w27EglaPq0x
         CWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCcxFZ8u217pCLU2+Z7QXQBb4BZSJxt773aXmFVctu0=;
        b=T4mHdbOVqovq87SN7kBTDMhH7oTq5tWSmCCaBVXoG8ySEuUsTCzT1s7sr26tx9IS4D
         kaYxlNjKrue7Z5pOv5HNUe+2m7KykFD4BQCx+X958H84Os5v/jqCrLBBVX7ijAydJPXw
         EwS+7stUaZv/cPeagBUAui6aUqE2W/llPgNmn5ceOOn1ZcTnV4Q73OKf2clAAKIVuLkJ
         ZzHDx5aADEIGpajiP7fKaxVV1ezkZYoN9yrqQnDNdLzXq0rXOijUQ1Ae/MwMggbCF7Dy
         6BAVqceeumcwKtDNe0BlbaOr0YQUZSnDMtTGKW/f4YI0ympyP16xjU5WAHv/9xhyLGRL
         HSvg==
X-Gm-Message-State: APjAAAVdZhlb5Ac52RcO18tPJmaOyT+LJNmEuSiARA+oMiNr7eeEaeoG
        bHcwzhLGajMauTnTvuikgCJEVQ==
X-Google-Smtp-Source: APXvYqzmvaIMZDp1UqMAki93ZF1pRBJmeuDwiABNRTGvkxZYkz5jfP7bem/APo11T1JcRZhC4F5UYQ==
X-Received: by 2002:a62:164f:: with SMTP id 76mr100964441pfw.172.1558573038480;
        Wed, 22 May 2019 17:57:18 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:acd:159c:264f:41eb])
        by smtp.gmail.com with ESMTPSA id d13sm23716909pfh.113.2019.05.22.17.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 17:57:17 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     linux@armlinux.org.uk, yamada.masahiro@socionext.com
Cc:     ndesaulniers@google.com, stefan@agner.ch,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tri Vo <trong@android.com>
Subject: [PATCH] ARM: disable FUNCTION_TRACER when building with Clang
Date:   Wed, 22 May 2019 17:56:57 -0700
Message-Id: <20190523005657.170008-1-trong@android.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang needs "-meabi gnu" flag to emit calls to "__gnu_mcount_nc".
Otherwise, it inserts calls to undefined "mcount".

  kernel/softirq.o: In function `_local_bh_enable':
  ...
  undefined reference to `mcount'

"-meabi gnu" resolves link failures.  However, Clang does not implement
calls to "__gnu_mcount_nc" correctly.  It does not save the link
register on the stack, which corrupts the stack.  The resulting kernel
does not boot.

Disable FUNCTION_TRACER support when building with Clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/35
Suggested-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Tri Vo <trong@android.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8869742a85df..7a1804392795 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -75,7 +75,7 @@ config ARM
 	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !CC_IS_CLANG
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IDE if PCI || ISA || PCMCIA
-- 
2.21.0.1020.gf2820cf01a-goog

