Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD292C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855A9222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NeoCDK86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfIZR4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:56:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfIZR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:56:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id o10so1957522pgs.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ct25FYY49pcH025DailB6pbS1DlS4bIVNf04cXZx2wM=;
        b=NeoCDK86mT/W24oE5rtmJouGfsbTTEGkoSxTx4KF4CSxjsSlvFZN3J9odBOQnvlXiP
         iUyNYZOgnvxnrzhYkrDgkrU0+SzkX/L29uWuoGEThELn/fWhiKJEA65hwXsy3koRBZjm
         4+HnR9f+RjX0Rbvz5f8d8QfWgEFoMfVNcSBHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ct25FYY49pcH025DailB6pbS1DlS4bIVNf04cXZx2wM=;
        b=siNvgB/hNzSK61IBgErSdPiPakkHwnwKFZLkbLer52BL5UEA+zcfe8cEfa0nQIJgpV
         q47OFBhlyRlQj3cm6VK56ATg6J4RUBBm4iU+mn/Aso4JWySb/dEXGTYrvVbqnklcmexQ
         QLmMNc48W8lqc7CM/q4wgYEhOJFVDWqWsokheIxSBlEGK1BJWq76RDPLLXeXVkb1sXLb
         onbsRLTMam2CYg96zScC/Dg+fTBUwrJvl1c+0dDPx1kIVYl30o6hoINuzyd0ox9FMwtl
         iN1MJtvtHGDycPW7xXCabSopq0kzovQy8XAxfEDpB0zqioS7Khu7jS1nUpybcZPzryDZ
         N4ag==
X-Gm-Message-State: APjAAAX5xyB63l/b6tuczZkf5wiyz9ixO/szKR3eZlB/a7IZNES9I/qX
        WAIf1hbCB7/EWRejyTdh5XY9+A==
X-Google-Smtp-Source: APXvYqwCE1BZTT9Hh90UUQnKWrAcK2jHTYm7yifQDk8oKb7icUZpadcMBDqMvGH5nif/lmL5cmzvdg==
X-Received: by 2002:a63:186:: with SMTP id 128mr4612810pgb.157.1569520583020;
        Thu, 26 Sep 2019 10:56:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e10sm4090474pfh.77.2019.09.26.10.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:21 -0700 (PDT)
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
Subject: [PATCH 06/29] s390: Move RO_DATA into "text" PT_LOAD Program Header
Date:   Thu, 26 Sep 2019 10:55:39 -0700
Message-Id: <20190926175602.33098-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving NOTES into RO_DATA, this moves RO_DATA back
into the "text" PT_LOAD Program Header, as done with other
architectures. The "data" PT_LOAD now starts with the writable data
section.

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

