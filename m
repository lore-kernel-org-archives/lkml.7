Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB18C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496C0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nm8mqSYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKKRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:22:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39252 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfKKRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:22:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id 29so9847698pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pqogoWx5m1B/3lE5KZVv4DafwpAuy45MHrtjmUfNbcI=;
        b=Nm8mqSYzBtksad+d15VDCUxV23KogboujhWU4b1Ax4N7eS9d1k5c4alCNCDBHvB4H/
         tVrcOE8hdbRwjpu2Q92RIEjBjoNpPW0GgEEggYGL9VWjV/samS6kUULXUxOmbOh+9hCd
         Bd2cdE/5TNwCRdwW/wWNoXM0AahNpeOr/9CZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pqogoWx5m1B/3lE5KZVv4DafwpAuy45MHrtjmUfNbcI=;
        b=F4wjnPW8TfHzOz10bjPvfTeBv7vwAHtcHkxRbFTK36RDQTZL9w0Km4Fu8GwxR9Ep23
         LgEWnf+Go8HzLGIBZZdYQtAD6ldlAHclcwIIZ7cc5HAU8NHnGirL/lk8R6hmz2/2ngfH
         3i8KX7LwdFtw/Nf1zUJRN/W7sAZlkH7ugS6dflKpKQ21cvd3cqpfjKbV0C1H6lEYQZiw
         iq8QQlX575YciuPDoc2rQGSL+9YDWMb/IA3rpE88Fdkpd/j2lsNGVCqqfLqOGT1/mYEF
         VJlkMr4Tu3APvwcQnJEHQNJGPLgz8LkbPB6WYtHg6zJkgRWQMkiJK1uSwzTWRtDhDTrg
         jjNA==
X-Gm-Message-State: APjAAAVvvR76X2mn0SipgTjyaqusiWgtWi6YVp8EVq1Z45rb+e3Op4Ut
        5oBHV7mi2Tac5OAsGb69tWnyZgXwW+s=
X-Google-Smtp-Source: APXvYqw6i+HKkrhCfsmAGZPUXdi7v0AusuCR/HRg/FG9ckSgWnWiws7AvVKgK3oDRZQNIJMh6I+9sA==
X-Received: by 2002:a62:5b83:: with SMTP id p125mr31460834pfb.237.1573492922081;
        Mon, 11 Nov 2019 09:22:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y138sm16517953pfb.174.2019.11.11.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 09:22:01 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:22:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH] m68k: Convert missed RODATA to RO_DATA
Message-ID: <201911110920.5840E9AF1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I missed two instances of the old RODATA macro (seems I was searching
for vmlinux.lds* not vmlinux*lds*). Fix both instances and double-check
the entire tree for other "RODATA" instances in linker scripts.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: c82318254d15 ("vmlinux.lds.h: Replace RODATA with RO_DATA")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/m68k/kernel/vmlinux-std.lds  | 2 +-
 arch/m68k/kernel/vmlinux-sun3.lds | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/vmlinux-std.lds b/arch/m68k/kernel/vmlinux-std.lds
index 6e7eb49ed985..4d33da4e7106 100644
--- a/arch/m68k/kernel/vmlinux-std.lds
+++ b/arch/m68k/kernel/vmlinux-std.lds
@@ -31,7 +31,7 @@ SECTIONS
 
   _sdata = .;			/* Start of data section */
 
-  RODATA
+  RO_DATA(4096)
 
   RW_DATA(16, PAGE_SIZE, THREAD_SIZE)
 
diff --git a/arch/m68k/kernel/vmlinux-sun3.lds b/arch/m68k/kernel/vmlinux-sun3.lds
index 1a0ad6b6dd8c..87d9f4d08f65 100644
--- a/arch/m68k/kernel/vmlinux-sun3.lds
+++ b/arch/m68k/kernel/vmlinux-sun3.lds
@@ -24,7 +24,7 @@ SECTIONS
 	*(.fixup)
 	*(.gnu.warning)
 	} :text = 0x4e75
-	RODATA
+	RO_DATA(4096)
 
   _etext = .;			/* End of text section */
 
-- 
2.17.1


-- 
Kees Cook
