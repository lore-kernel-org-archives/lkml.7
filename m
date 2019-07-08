Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC0C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A53C218A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kV0yLxy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390246AbfGHRtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39059 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387759AbfGHRta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so7571792pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHzYtWmSFmeH9NbFwqWKy4UztiT2kxra8C1X8yUmUfM=;
        b=kV0yLxy2kpMjOwguVfayi7phtFRYimSGCn/j1wuyKjll3J3KBdoeR84Ly2P7THz2O6
         1/X14UpK0enZCuSRXpOX9dzeN2DoreXYkCymkk0qGXCxmW+9ryMXHuu+eJ6Spe4Nu+kY
         c02Lz1ShzpKhcdhhBTYM7FKjKh8qL2F0m1R9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHzYtWmSFmeH9NbFwqWKy4UztiT2kxra8C1X8yUmUfM=;
        b=kYVhmwF+KcwXFmvIx5Otx6ak9YMnZ7mCas03dw6uyNjbGH/qKXd2T5sm17/xhRswEo
         X1Ou1sgerFF/uxDtiIWWliaGNcVeCS8VTVTfG/PY1TNKQE37/YB3hEs+cdzhFy2Uc8U+
         zMjQijVsIEjHl1VqML+tg/MxRDrShfhshcpjpx5Yc/JWw8vY/RmvAP9YN22UhvOB6Ilj
         hQfXT6c4Rl6hDri4t5nl+evTWlczpAJgkhKERRL9CO9JGl05VfEdWNU+TWL8AHD3VWVo
         ZSgf6S+bVqOEprcd+VxFrIY8QZr3BbOyaUgbJz0E8BJCRt7kQHH8YIx9YQ8xlNcGEfzg
         Q9YQ==
X-Gm-Message-State: APjAAAW1boQBQsnPVWNpqxSPM6sQdNVCZE9Nm5kBH97LBUE3YSqliOIV
        hgAIjNIO9hChNv6yq3PqWVvGBdkTdPg=
X-Google-Smtp-Source: APXvYqxcOh2L5ETIH15om1Lngn2WXi3piqkN48igLZFnoxb4cW4xxjqv4e9K/9qm1u+nuEor01c/ng==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr27246758pjq.64.1562608170298;
        Mon, 08 Jul 2019 10:49:30 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:29 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/11] x86: relocate_kernel - Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:48:56 -0700
Message-Id: <20190708174913.123308-4-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only absolute references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c51ccff5cd01..c72889b09840 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -206,7 +206,7 @@ identity_mapped:
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movabsq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
 
-- 
2.22.0.410.gd8fdbe21b5-goog

