Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44B5C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D452075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 05:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T97XQvEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFEFZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 01:25:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40814 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFEFZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 01:25:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so11731889pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9a8hKqe93DInff5ZLnJt99v7R5ylnef5GPSafD7tn0w=;
        b=T97XQvErAV5YR0vEyOAIbTyxqJCiQjCac342A9iuSijGEDjSlvqaU/Lrb+zFRoo/P4
         FCctN63E9iIlQT/mWrcniSm9A7Xo72FTJUhxAiHxdQ5Ie3ySDQx38Yh3X8OBG0T6ijaq
         ajQFu83NaqZQx8Nbr3siIhbrk4Bv7E8n34dn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9a8hKqe93DInff5ZLnJt99v7R5ylnef5GPSafD7tn0w=;
        b=O7O33SBfoZOwdcgVy+eRVkGK1fZ4cFSEjEkafWeQSbvd6HC/FvYpmFqQo53AbnmKoQ
         1VT1RRB6ril77O+bLxlf2WhQnOuon2sshdHC3PVGVavZ/CZ1/IPe6ZMiiYmITmdwV3qe
         A9EPSyTlvpYGhpRHB3GEj/WA1Jy/FWFgpjA1dCpIN7hC3SLlXT3Ur9EXLG2XwkD+GQj+
         C4DvRoxLKx/0GzMtXqIz2JxXNvAGC+I2pOXMz5gE5mthHJfogrYNsErjw0B0rzcEUw3d
         p7WikrWS/K3Otl0lji9ZAnymQOGLA1DhI/iPqOB6fRi43QC7JYQhG08FjiiWwprnclPH
         b17g==
X-Gm-Message-State: APjAAAWhp/Y4YGrpYkUwALFZjKjMtX5sIO1RaW5q0DqN84VLqS44tWhC
        8Svf0zM99jcgVXDSo7LZMAs/uA==
X-Google-Smtp-Source: APXvYqxGFosd7c5gW8eXl6gC1MPgOZJztjP50l1ighdi65fgtlv2L6pfV2Iuxc2LF2giYGCvBzI+mw==
X-Received: by 2002:a65:448a:: with SMTP id l10mr1921268pgq.53.1559712333660;
        Tue, 04 Jun 2019 22:25:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1sm12589518pfb.156.2019.06.04.22.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 22:25:32 -0700 (PDT)
Date:   Tue, 4 Jun 2019 22:25:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        kernel-hardening@lists.openwall.com
Subject: [PATCH] lib/test_stackinit: Handle Clang auto-initialization pattern
Message-ID: <201906042224.42A2CCB2BE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the gcc plugin for automatic stack variable initialization (i.e.
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL) performs initialization with
0x00 bytes, the Clang automatic stack variable initialization (i.e.
CONFIG_INIT_STACK_ALL) uses various type-specific patterns that are
typically 0xAA. Therefore the stackinit selftest has been fixed to check
that bytes are no longer the test fill pattern of 0xFF (instead of looking
for bytes that have become 0x00). This retains the test coverage for the
0x00 pattern of the gcc plugin while adding coverage for the mostly 0xAA
pattern of Clang.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_stackinit.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index e97dc54b4fdf..2d7d257a430e 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -12,7 +12,7 @@
 
 /* Exfiltration buffer. */
 #define MAX_VAR_SIZE	128
-static char check_buf[MAX_VAR_SIZE];
+static u8 check_buf[MAX_VAR_SIZE];
 
 /* Character array to trigger stack protector in all functions. */
 #define VAR_BUFFER	 32
@@ -106,9 +106,18 @@ static noinline __init int test_ ## name (void)			\
 								\
 	/* Fill clone type with zero for per-field init. */	\
 	memset(&zero, 0x00, sizeof(zero));			\
+	/* Clear entire check buffer for 0xFF overlap test. */	\
+	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Fill stack with 0xFF. */				\
 	ignored = leaf_ ##name((unsigned long)&ignored, 1,	\
 				FETCH_ARG_ ## which(zero));	\
+	/* Verify all bytes overwritten with 0xFF. */		\
+	for (sum = 0, i = 0; i < target_size; i++)		\
+		sum += (check_buf[i] != 0xFF);			\
+	if (sum) {						\
+		pr_err(#name ": leaf fill was not 0xFF!?\n");	\
+		return 1;					\
+	}							\
 	/* Clear entire check buffer for later bit tests. */	\
 	memset(check_buf, 0x00, sizeof(check_buf));		\
 	/* Extract stack-defined variable contents. */		\
@@ -126,9 +135,9 @@ static noinline __init int test_ ## name (void)			\
 		return 1;					\
 	}							\
 								\
-	/* Look for any set bits in the check region. */	\
-	for (i = 0; i < sizeof(check_buf); i++)			\
-		sum += (check_buf[i] != 0);			\
+	/* Look for any bytes still 0xFF in check region. */	\
+	for (sum = 0, i = 0; i < target_size; i++)		\
+		sum += (check_buf[i] == 0xFF);			\
 								\
 	if (sum == 0)						\
 		pr_info(#name " ok\n");				\
@@ -162,13 +171,13 @@ static noinline __init int leaf_ ## name(unsigned long sp,	\
 	 * Keep this buffer around to make sure we've got a	\
 	 * stack frame of SOME kind...				\
 	 */							\
-	memset(buf, (char)(sp && 0xff), sizeof(buf));		\
+	memset(buf, (char)(sp & 0xff), sizeof(buf));		\
 	/* Fill variable with 0xFF. */				\
 	if (fill) {						\
 		fill_start = &var;				\
 		fill_size = sizeof(var);			\
 		memset(fill_start,				\
-		       (char)((sp && 0xff) | forced_mask),	\
+		       (char)((sp & 0xff) | forced_mask),	\
 		       fill_size);				\
 	}							\
 								\
-- 
2.17.1


-- 
Kees Cook
