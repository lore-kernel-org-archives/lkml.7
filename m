Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19741C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8872222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GqCpdlt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfIZR44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:56:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37590 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbfIZR4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:56:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so1970142pgg.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DewAllPq01LncnaE6NYCCskktLTPQ+Oq7qAAM5yWaKA=;
        b=GqCpdlt27oIxoalJ+q55GpBWVA+O9B4EMwRWAPEitDTY5x/y/r3wW9KbkZvPr2V4X/
         S8caIKThukUOlDs2WCows35gv3FJcnOv4JTcjIQERxd+vzGaspWFjmHz3dbggEHqAL0H
         9XgrssZH7A/r46cr0/K6ftOAUAm1WnB4t7vdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DewAllPq01LncnaE6NYCCskktLTPQ+Oq7qAAM5yWaKA=;
        b=Vh11xut15jlPa2KJyjslHI/JF5or+mVhbRJbkx8fCgzj4U2QZAO/fBQvKBM7LZBK2l
         f/teS9U1002J7VYTHdQgIwvKBi3BnTc4x1Sc/lsWCV2jmiVBjeH472cTss9yY1Nj9S6M
         2k9Q5djvzl5m60e8IabptEcNQr/n+UP1gfXLv8dVUfy0Sw4Y+qbt8N9aa8/CvV5DyTLm
         f5581PEbgN0wFW87c8vef0LCrwXaZFqo0LozNWW2XJ/irtAhTJuKNL1NZMasgzSZrH4G
         NRcwkbKFfG/tqt6Wu6IKTykmD2VPv+a/9L7CmSeO/v5fP42cVVQ6isAKz0cgFJoG0gwG
         mkJQ==
X-Gm-Message-State: APjAAAVv+U0Ul8TnEB5xdxVizMoiVTLgWEu+BBlaeRTYMpIwWVIODYSz
        iXByVS9zdLExVjzL48X9phHx0w==
X-Google-Smtp-Source: APXvYqy6lsJedhQhLRYmBsUadf9UZQvX3qa3S7SjzPO8c/ioUQ997KVZPcsBQte8g5aQEg6d61NfYg==
X-Received: by 2002:a65:5c0b:: with SMTP id u11mr4650029pgr.294.1569520592850;
        Thu, 26 Sep 2019 10:56:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2sm3024583pgc.19.2019.09.26.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/29] powerpc: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 26 Sep 2019 10:55:57 -0700
Message-Id: <20190926175602.33098-25-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EXCEPTION_TABLE is read-only, so collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 4e7cec088c8b..2ed44e5824d5 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -7,6 +7,7 @@
 
 #define BSS_FIRST_SECTIONS *(.bss.prominit)
 #define EMITS_PT_NOTE
+#define RO_DATA_EXCEPTION_TABLE_ALIGN	0
 
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
@@ -162,7 +163,6 @@ SECTIONS
 		__stop__btb_flush_fixup = .;
 	}
 #endif
-	EXCEPTION_TABLE(0)
 
 /*
  * Init sections discarded at runtime
-- 
2.17.1

