Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04671C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAAE214B2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StNnDlpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfLEAKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:23 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:47088 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfLEAKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:18 -0500
Received: by mail-pj1-f67.google.com with SMTP id z21so479445pjq.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALzclmclfe7/Are+E2zwtoN5E20g3s/7atxslYp5zww=;
        b=StNnDlpBGGpkxh4LmqeR9wQsbcrNJKHaZeCmAjkMHb8h4GTl1ZQHqs4uCC/JvHxElq
         /txNvdxS5adtJxiAROs0VVndZR8Kr1R4yXT4EJxkMc7Wt7DhsZDWJ5E+4a1VFw/xMwZy
         P/zLTliHZPcyMRn4gvSewOaYYINB+zv5mAwd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALzclmclfe7/Are+E2zwtoN5E20g3s/7atxslYp5zww=;
        b=dmE2snMnShIiuWJ7LbkoeaI+saqRYp1CxIeXPyuLSqdMQAxgOhSrX4nHli0XOqlKOc
         AA3kejG1fn3+n+RIad87U4hFQP3RkFo53pBudLXvxLe+dEgp1zAm8hbm04SXGZdL21Uw
         7KuLJoHrGfNlI3DKmyPlyiLfLYzsOCjwrpW22HRlOCUyklN41UjCTkAyqFfzTcRB8xEy
         8r6jLY9eaep1+JH0GFbO2Za6lSKmudiXgLQtjc5iYiPvzgrcKFKuDPB66MhGrLiEqFB7
         Eu5si9/HslNCHIymCWxMDf4/uVKemw+4FDJgt9YqDU7MczAfXeTU/t4NxyfmxMW2LDiA
         /jhg==
X-Gm-Message-State: APjAAAURDUOo5/Xwjq32kVMcH5JR9PM9Kx7uJ5rtzqLVtog2avAUc9NI
        gHZ3/B9/MHaXnelNe30NxLW7tw==
X-Google-Smtp-Source: APXvYqxSdZ7Wkqu57YaZ3sPkRlqDS6GltWmE59e0kHGg9y8FxcGordcqDvfMgNftRbTyxHsQtapMFw==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr6262250plr.154.1575504617608;
        Wed, 04 Dec 2019 16:10:17 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:17 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 05/11] x86: pm-trace - Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:42 -0800
Message-Id: <20191205000957.112719-6-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change assembly to use the new _ASM_MOVABS macro instead of _ASM_MOV for
the assembly to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/pm-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..972070806ce9 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -8,7 +8,7 @@
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
-		asm volatile(_ASM_MOV " $1f,%0\n"		\
+		asm volatile(_ASM_MOVABS " $1f,%0\n"		\
 			     ".section .tracedata,\"a\"\n"	\
 			     "1:\t.word %c1\n\t"		\
 			     _ASM_PTR " %c2\n"			\
-- 
2.24.0.393.g34dc348eaf-goog

