Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6708FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F58B222CD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bQqqzNyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfIZR5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:57:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36018 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfIZR4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:56:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id t14so1974464pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BEIxyBF1HkRa8rBbPvqIJ09n3nmPR/y1tjhfe0NMzTo=;
        b=bQqqzNyNY7DBO4nvgPSIP04+h5CJyVsKfEvjzJfmS/V4+ODZb0mTUfyJbfgKxlH+Zf
         EcxsjmRdikQWm28aLyIpEcu2zYGeo3BNR4PnBQVxsPQueeDIHFJzMBwlKseyYdE8oNqC
         7R3DrfnnX5WNs3WMSqS/eB2/JT0kHs051Pfd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BEIxyBF1HkRa8rBbPvqIJ09n3nmPR/y1tjhfe0NMzTo=;
        b=kdlZ+k8zW+PmfHjYJzqsBXRjZavcrf097DOmQ1ROCoq0MwRvxV/ZZTd6/CxaC8g6Ox
         maBFNPPC9RGsXQQdsNjZVxQ/ojJE5wsnh604KOrI8WQ/EGCk/O4ZDIDpWYVysJqFbMak
         jPmElr6SmhQ2qxPYnZFZvWHFCQljgOk/p+wGxKdcCQ/7zf98aaiwDLsQGO5/LI1Ai71q
         t1Oe4MdZx7j2I69Z9U2mWyEicuqlkJVUMe57vGm2od65UAiwcnUoZ5f0vcITUn/cGVX4
         2mXrcejp3oC+RH2M7Vx1Xodn01cD0d5Dt9yTFACnh0idh+5FfsECidFZ+XliVpEYF6B6
         SsLQ==
X-Gm-Message-State: APjAAAV83ws9uh7so40YA6D5w0P4itB6sYwlBZDr0N29sWsgkjWHEjIx
        z0pY7mhRw+zVlS1ZUaGKqfjM+g==
X-Google-Smtp-Source: APXvYqyF69hVmYXL8iit7KpAdlylDNRysPjFRUoiDKvaG1bVd3Zxp6WjhsfeNoA0ipdH698250+hQw==
X-Received: by 2002:a62:c102:: with SMTP id i2mr5308106pfg.7.1569520584303;
        Thu, 26 Sep 2019 10:56:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6sm3791790pfg.123.2019.09.26.10.56.19
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
Subject: [PATCH 07/29] x86: Restore "text" Program Header with dummy section
Date:   Thu, 26 Sep 2019 10:55:40 -0700
Message-Id: <20190926175602.33098-8-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of depending on markings in the section following NOTES to
restore the associated Program Header, use a dummy section, as done
in other architectures. This is preparation for moving NOTES into the
RO_DATA macro.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e2feacf921a0..788e78978030 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,8 +147,9 @@ SECTIONS
 	} :text = 0x9090
 
 	NOTES :text :note
+	.dummy : { *(.dummy) } :text
 
-	EXCEPTION_TABLE(16) :text = 0x9090
+	EXCEPTION_TABLE(16)
 
 	/* .text should occupy whole number of pages */
 	. = ALIGN(PAGE_SIZE);
-- 
2.17.1

