Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBEAC46477
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DE22147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nhXQMKA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfFREzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:55:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42787 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFREzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:55:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so6897730pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QsQC2UzpT6NyTsbVwUSVvnO0Ud1PYkMdAize/TKgzcI=;
        b=nhXQMKA3pqnFMskPYlyfzfiZ0m1EDAn1/34A37MARMPc0vR6VdJcP0BLE/CZWd3K4G
         MV5zR19K/bY3u5fi7NY094sNRBhUptzdF+DEyNdptTYK+e8hw1nlN6XpuTFbcUGTB68s
         3p5aDl6HPjUBNt8/I3w6OE5IVo6Xj4pFf93yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QsQC2UzpT6NyTsbVwUSVvnO0Ud1PYkMdAize/TKgzcI=;
        b=PbTtCQ717Qh+QL4NLzqMoJxteMgm9MBBAyx/RwsRXK2XOfFcBR7G/lyk9mREFTqgep
         C06exGc/VgQqvKypHUBRCZR/l+ZXbIpaLiAS2rBqGFri/BghRNucFOem7oVR4eWVEIzm
         u8FFW1DLx9p8BlPVaeZbYEIiEEh66X28X7yoykozZ4tKNK/bgvUq6lBVckDkGqJccYmP
         ktBjg9UIrNnofFkB0H1zYZDIIX3f3dZ8wpQz1diB+ILIrh9/AmZcihbrMDnohzJ9vwc2
         qENorztEOA9QEdnigzWD5w/tXxig8D6nMhGHriSoVqpiIjk22oSZL3Zvp3it7408l6Dt
         xMYg==
X-Gm-Message-State: APjAAAWC0ogNNVaNV1hdP1zaTaCxYljwlrAKqRFiQpG0cRKK+X6RRfrA
        qD9ix4+6eo0vBWG06bGDbpH+NA==
X-Google-Smtp-Source: APXvYqzvoUCCIV/j/VUYbcljjbnLQAQDKu3Bb56KK/h8GtlbpUAufcbOlyMYfYfo58429sKdsQp80g==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr2950312pja.106.1560833708115;
        Mon, 17 Jun 2019 21:55:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i25sm13705186pfr.73.2019.06.17.21.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 21:55:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH v3 3/3] x86/asm: Pin sensitive CR0 bits
Date:   Mon, 17 Jun 2019 21:55:03 -0700
Message-Id: <20190618045503.39105-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618045503.39105-1-keescook@chromium.org>
References: <20190618045503.39105-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sensitive CR4 bits pinned now, it's possible that the WP bit for
CR0 might become a target as well. Following the same reasoning for
the CR4 pinning, this pins CR0's WP bit (but this can be done with a
static value).

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/special_insns.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index c8c8143ab27b..b2e84d113f2a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -31,7 +31,20 @@ static inline unsigned long native_read_cr0(void)
 
 static inline void native_write_cr0(unsigned long val)
 {
-	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
+			bits_missing = X86_CR0_WP;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
+	}
 }
 
 static inline unsigned long native_read_cr2(void)
-- 
2.17.1

