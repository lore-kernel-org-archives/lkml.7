Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76AE21738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOeizgBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfDDVkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:40:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37887 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:40:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so1879706pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mJ2BpxDCp5siv0DWTetU6HFZwal4/7NP8SHfAsPkk3o=;
        b=fOeizgBmAhr/l1r0J2K6aT8+CSMJ/bRWnPKnB4wnsg03Bx4sxujicqjUGxJ97j9XlB
         gypDnKuuSJ94bNqjhnHF9Gv4iIMeS2/AzDIBt0h2Hdek5fEVvDxyiUx0/R4dJ5eiabf5
         cCONV1PEixfF3Ymh+ifSWPZltD1RQSOMoiIpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mJ2BpxDCp5siv0DWTetU6HFZwal4/7NP8SHfAsPkk3o=;
        b=iq9r1LGHKhWtKcFKTIqdnccp3nxEV6hS8E+SQ+sr1b3cyNevJ0lnUZ8Rw3Re01M34o
         3AzqcsUn1UBVphAh5J/HXR3HHkTNg7cJOJjvn1ujXBHmjVCDbmJjTyyfLuyPZehEh6vK
         OItfBjAFEpMPBFAGyLJGJ21bIef/wF61dsVQRvdvVUmU5GxPHsktKa7+BqB9j1KngQEp
         OtCGZBJo5/vniIsGui5CRtRpi5AltjQ7+rcYh+AawyC5mycNWKYMmdXMm9NBIpC2Obqu
         4EfzDvL/HpnI6BlDlRXngcvDZmspnGRYtbdSX44BcW2gykdBhKYUcKWvvTufYZcDWI7N
         K/yw==
X-Gm-Message-State: APjAAAWcBQOnKgjc1E6s0sK7bNVeypLNTJJ1qewRUJQT6ijWWA7vqjWc
        m4nr5Mvzgr0T5o9cW03bJ8T0Yw==
X-Google-Smtp-Source: APXvYqwMZrNRWOi2jzZxLbpXcH6467JD8boZMitflIblBs+He1Qqs6D3+ruwc3yBLMpffkqYW1RDSg==
X-Received: by 2002:a63:465b:: with SMTP id v27mr8334474pgk.165.1554414029708;
        Thu, 04 Apr 2019 14:40:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 18sm24104767pfp.18.2019.04.04.14.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 14:40:28 -0700 (PDT)
Date:   Thu, 4 Apr 2019 14:40:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] x86/build: Keep local relocations with ld.lld
Message-ID: <20190404214027.GA7324@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLVM linker (ld.lld) defaults to removing local relocations, which
causes KASLR boot failures. ld.bfd and ld.gold already handle this
correctly. This adds the explicit instruction "--discard-none" during
the link phase. There is no change in output for ld.bfd and ld.gold,
but ld.lld now produces an image with all the needed relocations.

Link: https://github.com/ClangBuiltLinux/linux/issues/404
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index a587805c6687..56e748a7679f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -47,7 +47,7 @@ export REALMODE_CFLAGS
 export BITS
 
 ifdef CONFIG_X86_NEED_RELOCS
-        LDFLAGS_vmlinux := --emit-relocs
+        LDFLAGS_vmlinux := --emit-relocs --discard-none
 endif
 
 #
-- 
2.17.1


-- 
Kees Cook
