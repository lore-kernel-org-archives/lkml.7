Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A77C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3E721D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WAsHYQaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfJKANB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:13:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36997 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfJKAM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:12:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so4959444pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BONbSwO3yUZE8RnSGxOUsa1O5SfUej1bEo+UUtcRz+8=;
        b=WAsHYQawMi4SZmZgp8/tZRHbrTyjaN/efP/1ePAdIKhuzenhHAkQSemi72oSFyzy5T
         BUP8VJmLQCYcSjbNgTQmhLF0rh39giv7Aj/ab5NbcDAnNRa5xqPwvle+ummM9Ru1MTnT
         6FSY7l03L75U7xLgPLADUTO/JJnoTeuiDWO4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BONbSwO3yUZE8RnSGxOUsa1O5SfUej1bEo+UUtcRz+8=;
        b=jFq0mZguAUpmm4tFkDE8XFgLJKWP9iEq6hvV95KYEzPK63ktZc6Yy9BEINKJHLpZov
         VOtRn/oSBo5wQfIcCMDl+X/7jlYMwdLmVE6dZlDV1OCJaskx5pMKMOp1PQkBF6K87XSx
         FCsbBun2t/Gx2TjlOVTVzGlts0mrMHm5zlYDtN+/XdEMXZgullTiVogvALoTq7MiYJBl
         I/jg0C4cTO8TDGWhLQe6fZzvys8wZH28WgPXALkF/81QvedwEPKkP2LFd3XrnXh/D7xI
         TIziNaSrzVZ4/QylddcYJLLdGdKrFEEOAkt6UH6tbw+1A3ipY8qtcEqBfZoLBoshd8av
         trJg==
X-Gm-Message-State: APjAAAURDMG4KLiLhW9h9SQeTNEk3pafMGasNbsTPiMgyqeEBrjZh4pE
        KdMSeapn9xqYD2mN8ofx1oEL0w==
X-Google-Smtp-Source: APXvYqxI99kv+xtRG2LlmRclYNJDw1iNLuQgHN4M3GLkprM+ZRb8jXZUnF9huFcBlH1wmB6a5xQwdw==
X-Received: by 2002:a62:5284:: with SMTP id g126mr13294604pfb.95.1570752778224;
        Thu, 10 Oct 2019 17:12:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm5379454pjw.31.2019.10.10.17.12.53
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
Subject: [PATCH v2 21/29] ia64: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:01 -0700
Message-Id: <20191011000609.29728-22-keescook@chromium.org>
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
 arch/ia64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 11d5115bc44d..1ec6b703c5b4 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 #include <asm/thread_info.h>
 
 #define EMITS_PT_NOTE
+#define RO_EXCEPTION_TABLE_ALIGN	16
 
 #include <asm-generic/vmlinux.lds.h>
 
@@ -70,7 +71,6 @@ SECTIONS {
 	/*
 	 * Read-only data
 	 */
-	EXCEPTION_TABLE(16)
 
 	/* MCA table */
 	. = ALIGN(16);
-- 
2.17.1

