Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63989C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAB321920
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLT/IFk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfJKAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:06:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36451 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfJKAGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:06:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so4704659pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFfN5juCtHu18am/Lscu0/nkwdENrYqqL+l/G+SE/2I=;
        b=fLT/IFk/zcWpEKQQpsCuZreeSESJFRNdZ9hKHV0Y/h8n0IfaNLHOqmTYtdPHeZxkjc
         xWb/DQdE2uR1oDMr4EtvYElJra/mVKFp1aLbbQ6bJ3wnEDggQhIotPy3fghpdD1vLtdp
         EDoZ6HuknzX/OdZ89Gdo2kWzGjDi4EqKGpRbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aFfN5juCtHu18am/Lscu0/nkwdENrYqqL+l/G+SE/2I=;
        b=aHcFgPu0tfWB2rzEUn0VJ2CcysmWAmJ8wtRTAZWede3blL36WdvMHA8f9fhLJjwMf0
         z7lqM3+0EV8x5bDUQj6A/hZ5rX4THogducKvSUhLCTcMnjxgOooPBXWmz5XhSKDHmUc6
         8ep7JETtRtTZQFWy5/gS+bOYfMWkf3v5RXXFg60BCZQCwoVspnTJwbpekmhDswF3Di8D
         tAtS6WPe+ZNuXdAP7tR3mBQdngwAolbqfi1rXH3DuD94LPIZ2VELt6/u+2G3QLRjlRqb
         5tCHpmxbtk2xT1rC9tteBZF91/j615hK4A0t7sfMWwoCUj7ckryu5uR/V6VMhKZZ2YPU
         Y77w==
X-Gm-Message-State: APjAAAUjWUEHtjy4J/wuZGljqyuna/01ZctbGL4ia84dCjFiTdeO+Q2n
        qBCpFTaxHkiSyBsQ8hXwLMT4jQ==
X-Google-Smtp-Source: APXvYqxt91xs+DlKHANMAIgcph9JiYJXmwrfwOJOztv5tZwNFPibvGy6e5lUsAYLGSGL3bBhVSlFEA==
X-Received: by 2002:a63:906:: with SMTP id 6mr13901748pgj.324.1570752394983;
        Thu, 10 Oct 2019 17:06:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm10473924pfq.187.2019.10.10.17.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:32 -0700 (PDT)
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
Subject: [PATCH v2 16/29] x86: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:05:56 -0700
Message-Id: <20191011000609.29728-17-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The exception table was needlessly marked executable. In preparation
for execute-only memory, move the table into the RO_DATA segment via
the new macro that can be used by any architectures that want to make
a similar consolidation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a1a758e25b2b..b06d6e1188de 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -22,6 +22,7 @@
 #endif
 
 #define EMITS_PT_NOTE
+#define RO_EXCEPTION_TABLE_ALIGN	16
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/asm-offsets.h>
@@ -145,8 +146,6 @@ SECTIONS
 #endif
 	} :text = 0x9090
 
-	EXCEPTION_TABLE(16)
-
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.17.1

