Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2557BECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32B9222D2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSecILoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfJKAGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:06:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37047 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfJKAGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:06:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so4692340pgi.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zkQRciK9mkrlSR6uxFsvjRswhc34+65nZ5EFVAGwQNE=;
        b=YSecILoAsuaYNC3glukrCd31elBfhWrMe0PzbA6TDXYdPOVhmOhkQLy8xjOVCWTle3
         sWZgpOp1PTW2fO+D3A347Fw7oous07bPkmNpp/aoq4rj0PLZ+w9ksZu6jr+caikG/bpH
         XU/ce13E03H0+EglsamH4gM2AQvQFCYts7cLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zkQRciK9mkrlSR6uxFsvjRswhc34+65nZ5EFVAGwQNE=;
        b=ovnZ9mgRRxVMkBEgHhJzRhgoY8FugNYuqmUu2weY3zsuqH1pv4LgNQ8gjcuNMtEp0p
         9x6MIqKlV0TrXpOVFitjWbHM3XQK+EWhCO8KSlVUnqfk9xWbzo5k2ncLS4tysOJGJylL
         mtSIMEr8a4AZryjyh0maNRo4bIWu9fiaQS6R1gK1ljc2jIQTf2+f6lneSR7M6n96E9AP
         u0mBLG+W94EtNpqOwNw+JXLdHfkSfda81i4BPLmqR5YTxuktJKnJn8Q7g/DSW+4b8BjT
         vXDLrnSUEVTjbd0Bea1ygUQ0te+HxnftOunsldLqfAlwqULt9ow0XyaisF0g2pxHLTsx
         aqAw==
X-Gm-Message-State: APjAAAVRBclF8+b7dG1G+YOcyxLtrYg09HxOn8ZSLy+tvD+X4oSsin/F
        +uobfOlDFY6Z1nDP7VohjXdu5Q==
X-Google-Smtp-Source: APXvYqynxI+SrUE/IFh3H47ImD9d3o8Z2E9DLcjnFNC1TbOkJf20nhWWRMuV9Tda9+s+1NYxkhzhYQ==
X-Received: by 2002:a63:2c7:: with SMTP id 190mr11717225pgc.18.1570752396275;
        Thu, 10 Oct 2019 17:06:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s141sm8901750pfs.13.2019.10.10.17.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:33 -0700 (PDT)
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
Subject: [PATCH v2 20/29] h8300: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 10 Oct 2019 17:06:00 -0700
Message-Id: <20191011000609.29728-21-keescook@chromium.org>
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
 arch/h8300/kernel/vmlinux.lds.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
index 2ac7bdcd2fe0..6b1afc2f9b68 100644
--- a/arch/h8300/kernel/vmlinux.lds.S
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#define RO_EXCEPTION_TABLE_ALIGN	16
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
@@ -37,7 +40,6 @@ SECTIONS
 #endif
 	_etext = . ;
 	}
-	EXCEPTION_TABLE(16)
 	RO_DATA(4)
 	ROMEND = .;
 #if defined(CONFIG_ROMKERNEL)
-- 
2.17.1

