Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F434C2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8263206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TOFLyf0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfLEAKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40419 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfLEAK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so422234plp.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+buIVC/1VPKvECsxMqNDPQ+i8AJPTJg9/lSk6De449o=;
        b=TOFLyf0yU9XQEB/FeqiNbT3V7qcPRtpa6NeVrNIlQWiqVak0lOBZUpf1Yvd6G9OnJs
         zZoCQoQD7O7Nl7/81xFWrt6uhDQwLfgPC/kMg1DZ9nekQl/hofNQHT34Lb2PaxDQZZUv
         8pChH0mbB4xQmPqsjrYFEWKoH1hHaWA/Hxq4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+buIVC/1VPKvECsxMqNDPQ+i8AJPTJg9/lSk6De449o=;
        b=YjctH1lljXMeRFcakQiAhN6fuCWlEaNS23ePR0qCRHG5dvszrL1lYbXGsVtQyfopu4
         WAyspBuLKHzOBrUssRrDrlmML+fEZbbw2E+VG38Yp1ErpsbPdHcWYuypR3jRn2NVZUPJ
         bcWUFOGJsJ0lxmHnjcRE8Kegj4hRjPGYhUu/Sw4iUKJCnpo0egEALRABIebe40iEnF2I
         ZPhVmAc9S51mWu91OTQ5c11777eRbWKKTE3dxQ2Ej1aSIhQ6p8HYVj3fGaIIBjfEsRd0
         CEaYWuNAcHkRJkPuOkRemFpKmcb4jHVrBU5jkck+OSnh+LpSv/VbQV9vemCh4duR+Z5V
         g+TQ==
X-Gm-Message-State: APjAAAWkMHRC4j6B/g89EAwke24etM+7zMSY/milmEjPj6OzQvIXLdOT
        D2oFFdzJ2jOj15MqLDtdFMLJNA==
X-Google-Smtp-Source: APXvYqzgIu9igh7MFHq8gluXRTDKpLsMAIXgdWsDG2JqoQ+PmfOnBN59SFV+7mTZDoxKqvhnDHf7wQ==
X-Received: by 2002:a17:902:7083:: with SMTP id z3mr6280284plk.215.1575504626887;
        Wed, 04 Dec 2019 16:10:26 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:26 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 11/11] x86/alternatives: Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:48 -0800
Message-Id: <20191205000957.112719-12-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly options to work with pointers instead of integers.
The generated code is the same PIE just ensures input is a pointer.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/alternative.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 13adca37c99a..43a148042656 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -243,7 +243,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
 	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output : [old] "X" (oldfunc), [new] "X" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
@@ -256,8 +256,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
+		: [old] "X" (oldfunc), [new1] "X" (newfunc1),		      \
+		  [new2] "X" (newfunc2), ## input)
 
 /*
  * use this macro(s) if you need more than one output parameter
-- 
2.24.0.393.g34dc348eaf-goog

