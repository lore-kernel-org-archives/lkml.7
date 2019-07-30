Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A0C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3E72087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEHgj6CU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfG3TNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37698 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbfG3TN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so29294621plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djb+K5YV06tE6CuanEg0CCbjMrpDNzEbnLAfye7ZkSY=;
        b=NEHgj6CUyhuGNXZT844G24GmkoVlxjwnp/ZZK+KeYPZYfnl+y2UvSztPruWijQ4cSI
         kBY38ehlnCl9JH9OOX/JsC03zQgxQlLzWzBZnYs6E5MkdIvE+bVThcfwBcwDd1fydiyS
         XhhW1KJvnX2Qrszc09rMS6Fb8iqbbIIl1pYec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djb+K5YV06tE6CuanEg0CCbjMrpDNzEbnLAfye7ZkSY=;
        b=l1npUPsvYeCBncVcWS3uV5I7OBLKyp2VMwTOoar3nw4pD1k5fNNiD9Sp9ExDnDQfxb
         apXkpleqmfccJdXTjMSC01EGm5KUkh9QHGsZRHSJZUOM8PbXtiJi6GO1iRSwwSQPvw4r
         oScLc6gigNAAZpjHkhepdy5Jn95OGmIbbzExre/f6YlEtU09D8OrHydT2ncD4JJ2gLH6
         EPZEGP1MsN/MjKS8mRLg5jFlnvANOgvldWeTsGgn1vRzVII6LdqJ5moHspfeyGQwDy7f
         Y6+jJsgAmgCHb7n9MtTrTnaog4VUT7GKArFMXooTJxef3yEVADReGTWsRXM4aKfRSCbW
         S+ig==
X-Gm-Message-State: APjAAAVR8bNRzxbdv8Cuwd1unydt44J2DUS06UN130jOR41YtppiVHO7
        7zlcMbDNKUWB6rFJhBzHgV0k9w==
X-Google-Smtp-Source: APXvYqx7PDw4+udfJ0/X/aulEp6speZuvn3qPpw/ORb5g1xlvlm+szU4lbJM3sBZ+Qyz/KRfApdJug==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr120262792pld.16.1564514006452;
        Tue, 30 Jul 2019 12:13:26 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:26 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/11] x86/alternatives: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:55 -0700
Message-Id: <20190730191303.206365-12-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
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
2.22.0.770.g0f2c4a37fd-goog

