Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF11C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23C2222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yg3+62ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfIZSFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:05:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34477 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfIZSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:05:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so1640149pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oto3YJoz+uDS7YkHckkDLPsuLHSJE59Ic1Zvlvk3JIM=;
        b=Yg3+62araTz65OUjSMd7uRtDTc4qLv27ScfzOQEBsjmErC4baR+vactZeQ8EDHTDl3
         4m6/i6nTkUszRwcGPx+4rzXQZxnWhhz2/IpIkxEyLfsUcTwCPuJ3shP5kaVVlXFxeae6
         oJjvZwVhpbm6kHMwMmWob89Fc5KJC8pyBS2O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oto3YJoz+uDS7YkHckkDLPsuLHSJE59Ic1Zvlvk3JIM=;
        b=GaztO6rsylK+g60LWMNIqv+CdAvUd2Ym41TbK6j9paadMXZOKDR7TgDMejq169+BdR
         mbvG5BH7um4FYJtfOhrWpxVIT6ZytgPJvPEX5zBkQuoCEGEyIMXxlm2zUw3T+dUWyEVx
         2liZ+9C0Atg+l9sJYSbOM4Bz5eS56NQIotBpv/2l85slVGnGTDS3ejl2SKKeM4ASQa+K
         cB0iD+OKv4FqSgy+qUat5boxku3Dy90KkRhtBacbebPtMISkGD/EQ8fNVy/1oZUUn6Dz
         zBxaY3idF7KSpJJq3sWV0hg0VNsJd/AV8R3riqgrf/IsA22m7ZsnpttRyndCxRQREiy6
         DdFw==
X-Gm-Message-State: APjAAAXTfy/ZVc16b7NEYerEkZh90UCpnYk4dA+aeiPhd0LzLzobSiiA
        0FeDKKunQWoKEEYabmpMOG1lVw==
X-Google-Smtp-Source: APXvYqyRIx3xRHb+mNaLLP0zVX1hp9OZQXgJDPhnQfQ+Lb8Ihhv0yx8B8A03PaGE2C0DjuqCQpfKMg==
X-Received: by 2002:a17:902:be0c:: with SMTP id r12mr5340803pls.190.1569521121688;
        Thu, 26 Sep 2019 11:05:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm3366000pfa.65.2019.09.26.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 11:05:20 -0700 (PDT)
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
Subject: [PATCH 23/29] parisc: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 26 Sep 2019 10:55:56 -0700
Message-Id: <20190926175602.33098-24-keescook@chromium.org>
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
 arch/parisc/kernel/vmlinux.lds.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 12b3d7d5e9e4..1dc2f71e62b1 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -19,6 +19,7 @@
 				*(.data..vm0.pte)
 
 #define CC_USING_PATCHABLE_FUNCTION_ENTRY
+#define RO_DATA_EXCEPTION_TABLE_ALIGN	8
 
 #include <asm-generic/vmlinux.lds.h>
 
@@ -129,9 +130,6 @@ SECTIONS
 
 	RO_DATA(8)
 
-	/* RO because of BUILDTIME_EXTABLE_SORT */
-	EXCEPTION_TABLE(8)
-
 	/* unwind info */
 	.PARISC.unwind : {
 		__start___unwind = .;
-- 
2.17.1

