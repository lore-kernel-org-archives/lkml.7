Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FA5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75FB21929
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vo/YkX68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfJKANS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:13:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39897 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfJKANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:13:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so4954770pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OvLPSIr20MO1GrkJ0OvwvGngd4/e51+GSaoElj9X+Gc=;
        b=Vo/YkX68H3JSVeYxOg0wgKZHM0DDpLq1uGIDRlC9At7IoYDSFTbfrL3kzgv//JSf1l
         wfMMq2ZZ1sw3ulG7OB/Al6Lb7yhUEHFwVbMy0hx6CDWOUEDVNEPAVOGo2TBJff56wZsX
         1wJpR43jEKVUBiVd5MS1y8q4VLWL+t/un7fCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OvLPSIr20MO1GrkJ0OvwvGngd4/e51+GSaoElj9X+Gc=;
        b=dMQgMmckwZvlpQ+IwnJTFfZle2M6kyvJhLR7PpufVP74GbZRt/3U7CjFh6izoYm0b/
         +Sk9sVy58lUog6ZaNSrx6W6ktET3Xvue9D9zBsxA5/SH5BXYaiPZ4nykoEaFDYaWK9ek
         2xhaw2pICdgcwADttFKVARs23d14hWHhdQpbX8O5bu42Od5VQyq9g8zLL6rrGF2/Dzxj
         K/zVI5+CTXFJmdJlH3ImcQf9cDOUAhPOjROGIdDhM34w/uZAaWu6j42e2E6QrZ1/KxD2
         zx2GMyiG35D1H+EcBLoYx12JCKEgSkiObW5tfrCMF71CIt/fgAYCbNfjg5Z/5d6zvd4a
         rEMA==
X-Gm-Message-State: APjAAAVLxCpiVlLp25yqBxaB8Pj/PiuETwrQ0Q1GvkPvHKkORosqT7Rr
        aykWH8Lq1wB7a6UK3LIdIvc0qw==
X-Google-Smtp-Source: APXvYqwcXL9IUcA1NwWjkBG6ihgZ1mTQNQKZY+myfeizvcbcy9RQ9+vXBtLYoNyG3c9FkCNmz89Vqw==
X-Received: by 2002:a63:4383:: with SMTP id q125mr13830250pga.373.1570752781928;
        Thu, 10 Oct 2019 17:13:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v68sm8097683pfv.47.2019.10.10.17.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:12:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/29] powerpc: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:04 -0700
Message-Id: <20191011000609.29728-25-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 4e7cec088c8b..8834220036a5 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -7,6 +7,7 @@
 
 #define BSS_FIRST_SECTIONS *(.bss.prominit)
 #define EMITS_PT_NOTE
+#define RO_EXCEPTION_TABLE_ALIGN	0
 
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

