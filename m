Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E3C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8026A20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n/F39DDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgABU3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:29:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46449 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgABU3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:29:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id p67so13456013oib.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 12:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HjEJhs2Jf27gEdHzHrLdwwMAZLxLyZ5viXi/19V/8Ug=;
        b=n/F39DDC0sp6aY8RyGh8CSyb+3hJ/AVM1XlzUpEbMu34VkFlW+1JwUHkHE8T/dL127
         3OlliVH7LGbPDXNqi1v+bcwEOlXYMPwnmy1MBQ6xR3E78UnHUK8naAYYiRfF04ME3LTl
         b67uez7ha7cZ6XGIxpGmBatJKKJB32pzm5No8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HjEJhs2Jf27gEdHzHrLdwwMAZLxLyZ5viXi/19V/8Ug=;
        b=fgqNmfCAr3hoplPIymL/uHm3cfx3BXEXkVfkRLqwBqB17x4vq69esA320a6BF6hLPx
         huwgtJTIMUCgDhVs8azHZkKsM2Kz00nQfi4Lz1b0/P9Ca2MxClc7Nwf0b8p4tW8fN0Y1
         QTpqu1gzcmgZTy5s3oqyzbKUGGaEfVpOwFseRLFM+CM8nJzOR9qv1vmeC6OVBkz2Q4aC
         OBMjSofrKmKaXxQzDt/BoTn5HkVjAcmJwFAVu+6pI4u69h5cmC2mij28SvPgBFKg9NpH
         gBfIegb5exLGppxxkdzgP//tdpWduFCU4oSyXz9xgB+GJwOp76RbHjlqp+ywN0wZs3hv
         n54A==
X-Gm-Message-State: APjAAAW1lu478hCQz82gS7csSln2RucwQvGuSe0V/VttR2t3aij5mwAN
        XbKPL5vXeBRotRHRS1suEFkxtQ==
X-Google-Smtp-Source: APXvYqy57r08ZTvzECDXPOHABwaTn6TJE1p1JTwICx/SMuOQl7CUAQwWERY/AyiLUpptLaKsTTmOBA==
X-Received: by 2002:aca:75cc:: with SMTP id q195mr2758124oic.178.1577996960298;
        Thu, 02 Jan 2020 12:29:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v200sm17469066oie.35.2020.01.02.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 12:29:19 -0800 (PST)
Date:   Thu, 2 Jan 2020 12:29:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH drivers/misc v5.5] lkdtm/bugs: Make double-fault test always
 available
Message-ID: <202001021226.751D3F869D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the DOUBLE_FAULT test to always be available (so test harnesses
don't have to make exceptions more missing tests), and for the
arch-specific tests to "XFAIL" so that test harnesses can reason about
expected vs unexpected failures.

Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Hi Greg, this is intended for v5.5 drivers/misc as I consider it a bug fix.
---
 drivers/misc/lkdtm/bugs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index a4fdad04809a..9eda771d3a37 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -338,13 +338,13 @@ void lkdtm_UNSET_SMEP(void)
 		native_write_cr4(cr4);
 	}
 #else
-	pr_err("FAIL: this test is x86_64-only\n");
+	pr_err("XFAIL: this test is x86_64-only\n");
 #endif
 }
 
-#ifdef CONFIG_X86_32
 void lkdtm_DOUBLE_FAULT(void)
 {
+#ifdef CONFIG_X86_32
 	/*
 	 * Trigger #DF by setting the stack limit to zero.  This clobbers
 	 * a GDT TLS slot, which is okay because the current task will die
@@ -373,6 +373,8 @@ void lkdtm_DOUBLE_FAULT(void)
 	asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
 		      "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
 
-	panic("tried to double fault but didn't die\n");
-}
+	pr_err("FAIL: tried to double fault but didn't die\n");
+#else
+	pr_err("XFAIL: this test is ia32-only\n");
 #endif
+}
-- 
2.20.1


-- 
Kees Cook
