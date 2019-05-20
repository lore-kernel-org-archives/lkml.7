Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AD9C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2C82171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERQB0e/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfETXUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44477 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfETXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so832632pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGg2Bf2w3MsVGdZaS2JSU4wTchs3K+c20QEWcpV3rEI=;
        b=ERQB0e/P/lRXortlWIvM98+deOc4OBxaHJswmyMJMwN9AnRICP7O7xG5wHxdekxpip
         dVMA+/UHxaBWcNsOnnphQV7FP76TIavW2uK/wSid2a3PiFEtLKfG07ueDAPodcbMKcY9
         hB/qqPWjpM+LkCjxrt8yNsfc/gHSs5GoTKR+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGg2Bf2w3MsVGdZaS2JSU4wTchs3K+c20QEWcpV3rEI=;
        b=exzlJpUaqVn/5qeQHo6ZspXCzLMnlXWg27KkanQ8JbM62gapaaGBmDkpTaoKMZc/7O
         LC4KxWKXHHlA9aRZ9dkwRn59rXetpw+rH0a3W8Gi3j44nqjza0tCU0U5l8KleYPiLABd
         +cdK+X7WdugDCfTOZ6+sxfpeh1yezFvSnP26CwFA+sSkfnEYBirDh937zo2Y/sg0l7I8
         Loh21cTvXzyF7YIlI3eKyKOVe83CFRcCjc8dlORHHTiZrxUUHqJGY5oLMsq4DMtaeZZo
         k0ncG2LJs8fX9cS2lGC8E6KMPZ+LGavMy1CdUb9drNvLsFC+Bl8Z4K0f003sZ9nsYJJ8
         1UIA==
X-Gm-Message-State: APjAAAVI+nDYHu8pEYKJ4tW6Yjnycie2x3WcIrobtHRoafkbOx4qcMyD
        +icFIXCqFhaKPf01iEwmGZcLgg==
X-Google-Smtp-Source: APXvYqwCz/NeyhSKhhkjC1U3Pv0Ghct2bpZ0T1Gy0WqWYRztBFt7DlYc23EJLLkNN75S8gKKS6khNQ==
X-Received: by 2002:a62:e201:: with SMTP id a1mr82910863pfi.67.1558394409379;
        Mon, 20 May 2019 16:20:09 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:08 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/12] x86: relocate_kernel - Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:29 -0700
Message-Id: <20190520231948.49693-5-thgarnie@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
References: <20190520231948.49693-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@google.com>

Change the assembly code to use only absolute references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 11eda21eb697..3320368b6ec9 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -208,7 +208,7 @@ identity_mapped:
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movabsq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
 
-- 
2.21.0.1020.gf2820cf01a-goog

