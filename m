Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD5C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6A621850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BapQQmQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfDWSia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:38:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40259 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:38:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so7947582plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eoTaxoTrFSwlznVOf9fo0DxdOq0TFTUP4kfKP9GY+WU=;
        b=BapQQmQVXCj8La3MRmOCBHvmXV36OBw+ou6J2qJflXIiT2ueEUdhZW5OCMq1KSS+IN
         Fmrcebv7g1CEMaxnLWT5arsXnJU3C7BibDSe8f7cARNGpQQKQSEvH0F4Yj9G39/rCaG6
         nzpjq/A4wneyHAzEEIZKyyDnSGiCSFejXtdzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eoTaxoTrFSwlznVOf9fo0DxdOq0TFTUP4kfKP9GY+WU=;
        b=jGEdozEQKWNLroJnR1iYvxTWdL0wzqqD0wWaSZpb5240ZPg4Qi5+3ZjGXTmxAe+niP
         fl0m41VHETIkpGE0veM+P7ttPS2u2xM8crm4BaE58qpsjmVC0Zox/mMnmrpFnMJYA4Wo
         H88PYADY5eQDtsHYvoobWie9dSY8clC+qg38RkwFBO1M/g+DdFC0K8pluhDvcPgmTnYL
         J125HpkV33wHnFj6n/9bwcCtYVKoNLjK8A3WRl6i+0II+q50sMmTm8FpTzWNeWrvQtzx
         S+Ye7VQ4GoTNU1UML7QF/6oqIcp2NrL5c816JlfHUOOkgZGFXHsNHktJBZqB8l9GywXk
         aI3w==
X-Gm-Message-State: APjAAAVcOXTQ03zRmND6wVjjhuw3cG8J9+8EUNku97X3AdFXGC+8P7Ym
        +oalgoLdsQLGwesYBrZgWVwqVQ==
X-Google-Smtp-Source: APXvYqzkYToNTgG/DoKQ0xM3nBpX7alPsyCeJSYdbw7G3Hn5c3Ht3ucA5+kXJ2gmmKuJrREzwYIslg==
X-Received: by 2002:a17:902:e793:: with SMTP id cp19mr21732783plb.65.1556044709746;
        Tue, 23 Apr 2019 11:38:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d15sm21850710pfo.34.2019.04.23.11.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 11:38:28 -0700 (PDT)
Date:   Tue, 23 Apr 2019 11:38:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <20190423183827.GA4012@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building x86 with Clang LTO and CFI, CFI jump regions are
automatically added to the end of the .text section late in linking. As a
result, the _etext position was being labelled before the appended jump
regions, causing confusion about where the boundaries of the executable
region actually are in the running kernel, and broke at least the fault
injection code. This moves the _etext mark to outside (and immediately
after) the .text area, as it already the case on other architectures
(e.g. arm64, arm).

Reported-and-tested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bad8c51fee6e..de94da2366e7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -141,11 +141,11 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-
-		/* End of text section */
-		_etext = .;
 	} :text = 0x9090
 
+	/* End of text section */
+	_etext = .;
+
 	NOTES :text :note
 
 	EXCEPTION_TABLE(16) :text = 0x9090
-- 
2.17.1


-- 
Kees Cook
