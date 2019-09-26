Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B892C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F36222E3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CqN1lXbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfIZR4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:56:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46138 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfIZR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:56:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so2223506pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=twBnW9003cRUVrvl7rna64y+l4pXeTWwCidRvKd4upQ=;
        b=CqN1lXbzhTBvyldWDeFFG0HQSt646TlwSvqceNpapyoRiUWQ5YqqN4cPwhtdyRn8hE
         PVXIyXkZUO4laSWWNvkw5iINx8LA8erBgYyntG+Tsm/SabZpT1rGUewt5++Krmp2ifoS
         gGD+zS0suOHck11+UV+BUipLiBtMBQgjj951s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=twBnW9003cRUVrvl7rna64y+l4pXeTWwCidRvKd4upQ=;
        b=k92TMnuH3r+8AIxA3PAaCI2G6vGLvkzJlIyvb4THxwiB4KjC3duw5bxLh+p5Q9Thvl
         g1ym/NgCGy0rH6GCM8kZkADH2rVjYPOu9pkVeFTuQCON/8BVtys53BPYBSfX1exe4AYT
         KrSQ3trOYd8TnonACaKVD8utIF1Q4mWKZ2t3NU3svk9kcqyQyyWig0BxOstgQf4SlNgW
         xyrCr8ER/vJxQdeSJpSx4QsWx5Nwva1Zj29pQd12uHossvTeCQD9mSimPLCwAagAhAdj
         k1id25bCSMeZLcHKTqF4afFKPsnZ4DqsOLjCYcDS78bZOYZGYOVmy3wYk/D2P/c1QfHg
         vwyw==
X-Gm-Message-State: APjAAAW3v3HJ2WsKApm8S+VX0evPZU93rBy87fbsaA/l8K1E0YELiIV1
        Fz4yuQfOHHtgKtHRKLl4nIML/g==
X-Google-Smtp-Source: APXvYqz5sqYBOjfwv1yAIr8+Vv2yIfMOshUTCRUhztJ4ypNIaY8nP1T7DvlPeRwIyHth9hoCfN4Y8A==
X-Received: by 2002:a63:cf4e:: with SMTP id b14mr4713210pgj.109.1569520578734;
        Thu, 26 Sep 2019 10:56:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k184sm5172900pge.57.2019.09.26.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:17 -0700 (PDT)
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
Subject: [PATCH 03/29] powerpc: Rename PT_LOAD identifier "kernel" to "text"
Date:   Thu, 26 Sep 2019 10:55:36 -0700
Message-Id: <20190926175602.33098-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving NOTES into RO_DATA, this renames the linker
script internal identifier for the PT_LOAD Program Header from "kernel"
to "text" to match other architectures.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index a3c8492b2b19..e184a63aa5b0 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -18,7 +18,7 @@
 ENTRY(_stext)
 
 PHDRS {
-	kernel PT_LOAD FLAGS(7); /* RWX */
+	text PT_LOAD FLAGS(7); /* RWX */
 	note PT_NOTE FLAGS(0);
 }
 
@@ -63,7 +63,7 @@ SECTIONS
 #else /* !CONFIG_PPC64 */
 		HEAD_TEXT
 #endif
-	} :kernel
+	} :text
 
 	__head_end = .;
 
@@ -112,7 +112,7 @@ SECTIONS
 		__got2_end = .;
 #endif /* CONFIG_PPC32 */
 
-	} :kernel
+	} :text
 
 	. = ALIGN(ETEXT_ALIGN_SIZE);
 	_etext = .;
@@ -163,9 +163,9 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES :kernel :note
+	NOTES :text :note
 	/* Restore program header away from PT_NOTE. */
-	.dummy : { *(.dummy) } :kernel
+	.dummy : { *(.dummy) } :text
 
 /*
  * Init sections discarded at runtime
@@ -180,7 +180,7 @@ SECTIONS
 #ifdef CONFIG_PPC64
 		*(.tramp.ftrace.init);
 #endif
-	} :kernel
+	} :text
 
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
-- 
2.17.1

