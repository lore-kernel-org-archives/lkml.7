Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA00C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CB121920
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPX+iPje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfJKAG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:06:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35021 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfJKAG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:06:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so4699718pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bl12US5Yp4ZwWvaEnQTrcBCg3LoqQRPWnxt7WskOqWM=;
        b=MPX+iPjeGRBi9W7v8BaGtEQ7Z0gPfVJ+oEGukA1Qx5FZM3UbvHSgUUNTtJdbrvF0DJ
         Lniffb/JdJpDuc2hFDvI6xqzg3lDsRa6goVJDwHcZqncxHEEePqIwXD0wmcvebpFmc8f
         hOMnZpwmNvMPGn7QBG585RWKNTpfnKyDCS46Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bl12US5Yp4ZwWvaEnQTrcBCg3LoqQRPWnxt7WskOqWM=;
        b=R/mKlrTwqtOtJfRf56i6rqNSovIj2tU4VBnqcic7qRMGIVhlKpyRhImnt6+X3WOXQ6
         4Fu7qtEz+tlsxPoX9FfWqgDR/UABPnDmUtp0L2yqD/HP2BP7yDi8aYqA5Ra7go7d2qyt
         fdjen2sMeoIy64nIgLrVgW1ImVD1Pzsg4SbYPyMokJ1xJAvaBsRuG5TTJgjTS52z9W3R
         nWfVQUR6wfgC7RxPpHRgobVztfAShxoKN6SijxJhxFR8clD7PANSp5rfec62WGuLl8co
         fvAe1RdC1COSinX2nI40qN7mVMwpq0Z+s29LTsES4dICj7sfe5D+pWtmezyJ+Opre6mL
         C+kg==
X-Gm-Message-State: APjAAAVGz542yvmChdrh7RKUsqkes1uBrnI0ZB5uAK5b04n7YYAkRM24
        puaHK76OzsDwDR06BsrNfesamA==
X-Google-Smtp-Source: APXvYqx/QRL/EGj1UNqOw9cSZc5qNyXaSBqEdm+ZR6Z42olkPMiWXRzScwFI4gnTT7Nu98OPft+Atg==
X-Received: by 2002:a17:90a:9318:: with SMTP id p24mr14062359pjo.31.1570752386117;
        Thu, 10 Oct 2019 17:06:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6sm10807049pfa.162.2019.10.10.17.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:24 -0700 (PDT)
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
Subject: [PATCH v2 06/29] s390: Move RO_DATA into "text" PT_LOAD Program Header
Date:   Thu, 10 Oct 2019 17:05:46 -0700
Message-Id: <20191011000609.29728-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving NOTES into RO_DATA, move RO_DATA back into the
"text" PT_LOAD Program Header, as done with other architectures. The
"data" PT_LOAD now starts with the writable data section.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 7e0eb4020917..13294fef473e 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,7 +52,7 @@ SECTIONS
 
 	NOTES :text :note
 
-	.dummy : { *(.dummy) } :data
+	.dummy : { *(.dummy) } :text
 
 	RO_DATA_SECTION(PAGE_SIZE)
 
@@ -64,7 +64,7 @@ SECTIONS
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
 		JUMP_TABLE_DATA
-	}
+	} :data
 	EXCEPTION_TABLE(16)
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
-- 
2.17.1

