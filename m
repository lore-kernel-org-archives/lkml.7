Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019BCC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0890222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KPMZBnze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfIZR4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:56:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42726 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfIZR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:56:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so1946938pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HjFHv9xxIhK5RJeBiuSF34CW9EFCi2H1cUI0osZb25Q=;
        b=KPMZBnze/A/QVrsTLF2KGN3ebdUhyckFs45P2jOghM70xqivIFR9hfivXkVt5CbeNY
         IE1kSylnyZRNl8HDUTfbWj8AKjNJnMw62zdeR5tu6VCLH496t+W13oMohTiMGaZ6p79Z
         3c4uLS8nqL5lvrbWSW4400GI1UZ1nPH1jjAIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HjFHv9xxIhK5RJeBiuSF34CW9EFCi2H1cUI0osZb25Q=;
        b=NqoKUgdBNJie9iOfmGxGhHFZMcvBzZKXaFBgYM5wKyfRya/T7SJTbEWzWvoT7OZB8E
         W40InC6/gZ9Wklqf4ZM4Kk2DrJsjg8zwRR5amVl33bRXHw5NuvRx5vg0kPGxNg8IBZFv
         wi0CP4XEV48b0gd09EAooPIjDC0ctL+PHjrHlSEZSn7dyFUpIevrPZ5hGIgHBf4nklBz
         iLl7SgqVLBJxrFabc3HnnRl/t7mtxnkdrUIVW7tH4ewWoyiFG8beeTSZ0rAEXjHJg87E
         Pp1/QT2p6gvf3Cy3Hgu/6pifV3xaPF1gmAnKl7f0iRQT/WA3gF4AxXrVA5opx6fla7EJ
         +FyQ==
X-Gm-Message-State: APjAAAX8Yi5k+ITivjTM9ehn9dYJ6PnkZ2SEnwkH5ndlF8aoGNcdI8Cv
        LnxtIEGQDvlQ7bbskZRxpuBlFw==
X-Google-Smtp-Source: APXvYqyFMbRLlIoK6p9J6QIn/93x5dhozlYQ0YGx3wABZc+vZZjpU1J4N8nao/7zNkR46rXeo7ym8w==
X-Received: by 2002:a62:19c7:: with SMTP id 190mr5160181pfz.105.1569520591920;
        Thu, 26 Sep 2019 10:56:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f89sm3068052pje.20.2019.09.26.10.56.24
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
Subject: [PATCH 20/29] h8300: Move EXCEPTION_TABLE to RO_DATA segment
Date:   Thu, 26 Sep 2019 10:55:53 -0700
Message-Id: <20190926175602.33098-21-keescook@chromium.org>
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
 arch/h8300/kernel/vmlinux.lds.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
index 2ac7bdcd2fe0..aba90398b774 100644
--- a/arch/h8300/kernel/vmlinux.lds.S
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#define RO_DATA_EXCEPTION_TABLE_ALIGN	16
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

