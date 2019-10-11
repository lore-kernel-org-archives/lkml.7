Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB189ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A746621D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VJjnLJGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfJKAM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:12:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41298 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfJKAM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:12:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so3593860plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bvYKnL/TaFkIaenIAvKRMlAb1gjfrMgYQ33pk+cyLNw=;
        b=VJjnLJGIO0uGgKBCPhgyxZ/iGefUMJczEPz55L/NXxQm4X5HtH7Z6IwSEISlxXbPIi
         0AKWMzRKkEkFoTXpqSQ6so/StMfOF2yJFPqmtCJOuv0Jt6L5qcDOFqlnVgUtBy87cn2m
         oVq9vePrz89q5V3+gDCK4GhXWqgAgeYpXsYQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bvYKnL/TaFkIaenIAvKRMlAb1gjfrMgYQ33pk+cyLNw=;
        b=Bc+O+k+lKFoONh+4nQoI1ps+1SvqmPRVOcOVzHW7XhNmc7EGsT7gF6u0tQP2HUu6+y
         F38nVcWM3fc/pe0CPRx53xxRWh7sp+dAP0N1K7sPpFgxzHDBHNsThm9JwBQB6jwFzELb
         rNeBqTCkGAs0wjpYF70aTL1McWPF9Nj1CxrmCia2HNKnRb+goVlbp/H91nXtS6mOAbCt
         +Pi+iRke+YwduwNDTzgNGBD2vscAE233O5G5a5ol6BL+bgBzfa23oSdezg3wzF5tvQ87
         LDmSwUYRS+C8s4kPun04vIt+qIhkB7Q/6I9rfoZPX5tKjR0iIRZtdJTDHIiLOhDJ8d3t
         i9zw==
X-Gm-Message-State: APjAAAWdrIyTdVZK0CCTsqZEm/L0Ubrh7BI8tjRDsbzwWDPrtC3SOZ7p
        zbmDsTzRsj7iQjvv21rvhDPjnA==
X-Google-Smtp-Source: APXvYqz1nJHbdicuisYaMkUGL4dW9cHVrS4hPr3bZVo4nTa2ffJhe6O1BBJ7QgwtCPb4vvcDzPVB3A==
X-Received: by 2002:a17:902:b410:: with SMTP id x16mr12316640plr.46.1570752775741;
        Thu, 10 Oct 2019 17:12:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j128sm7319082pfg.51.2019.10.10.17.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:12:52 -0700 (PDT)
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
Subject: [PATCH v2 22/29] microblaze: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:02 -0700
Message-Id: <20191011000609.29728-23-keescook@chromium.org>
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
 arch/microblaze/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index b8efb08204a1..760cac41cbfe 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -11,6 +11,8 @@
 OUTPUT_ARCH(microblaze)
 ENTRY(microblaze_start)
 
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
@@ -52,7 +54,6 @@ SECTIONS {
 
 	. = ALIGN(16);
 	RO_DATA(4096)
-	EXCEPTION_TABLE(16)
 
 	/*
 	 * sdata2 section can go anywhere, but must be word aligned
-- 
2.17.1

