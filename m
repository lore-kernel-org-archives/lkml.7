Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E8C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7C92189F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YO7rYeBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403906AbfGHRtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40160 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391061AbfGHRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so8654867pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYVCK+lE6TfQr6KRbpNni5BR/rdhwG4w+KTNeQVPvFA=;
        b=YO7rYeBTtbOSPm2PM2bUxLHbjhObhohK+nc071hlnGlCjMy8KwfWnPBD8qNgCz3fB1
         8RchZLAzudKMoEAymQQLjNDFw0lA8xTX0qJciZeUvBDr2VLBQ3P0M+Pa7oSYMgRHrMdN
         woz/GPDPKTh6ACUfHbMv4pAEfp7T2uaZhoVGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYVCK+lE6TfQr6KRbpNni5BR/rdhwG4w+KTNeQVPvFA=;
        b=JKeCz96eMPSrR+tQu3HRCG8EIwpXnaSkOsKD9L9nY7iYUikrUa2tFmCbIN65wIrEiX
         zu6wflHuQJfckPPlRRm1WiVUYSrgevVZmj0TDie4od8Tz8Qb5GebgdD1xh5kDML9gHOq
         1ApFR/DAcQO/szlmrc+cZ8+bi0hHsAgLpHyfe+yz+Q4Domgf21q+tlQYNZgCho3Gn/7J
         UUpo3bNbDQ9aDT+Pa0xQhCxTT4LakbRoDhcvw26VQCPtWwN8p2mMjtRFdz4kuQlvXt55
         o8rImJOk9sSYzwllgJ1JYxuif629neyLF1M1nR06MRMWkLKWBzuh0ShdVHgEJMmWtqUB
         PgTw==
X-Gm-Message-State: APjAAAXGCGZDyZUME/c1jxiMCyMAVPUTKIvy0u3JSDW8BWYAlcIrTCME
        7xaMZNPrpXRDx2fgm8aZYklFfg==
X-Google-Smtp-Source: APXvYqzLN6oNXPNoxCuXGt+FuBI73Vtvl0VQN9tamK8mlquFWOHra5OXoyNjTYkeZDsSJbhySbtUxA==
X-Received: by 2002:a17:902:684f:: with SMTP id f15mr26566998pln.332.1562608182892;
        Mon, 08 Jul 2019 10:49:42 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:42 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/11] x86/alternatives: Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:49:04 -0700
Message-Id: <20190708174913.123308-12-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly options to work with pointers instead of integers.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/alternative.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 094fbc9c0b1c..28a838106e5f 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -243,7 +243,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
 	asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output : [old] "X" (oldfunc), [new] "X" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
@@ -256,8 +256,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
+		: [old] "X" (oldfunc), [new1] "X" (newfunc1),		      \
+		  [new2] "X" (newfunc2), ## input)
 
 /*
  * use this macro(s) if you need more than one output parameter
-- 
2.22.0.410.gd8fdbe21b5-goog

