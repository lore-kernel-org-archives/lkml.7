Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C951FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB3920657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhw6JkVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCFUtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:49:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35914 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:49:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so14556803qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNuGI2CppkFjxucCGIV9yGeUTwNTWg57KHtYskN0og0=;
        b=Rhw6JkVeVhZQSlOSzxGVl6iB+WP4MGtFsh2DQAJYfi/yjHcBkhAjyDFoz4pQENk4eo
         R6dRWJJfAJBYeblvfqF2IWibtxKRK9vi3GHTRxAA0SVmAj80AtJ7udKjbzYFI182buAF
         v8PzZ0HiLr8OqufCGNcR811XOCiLgMg60z9IvuDrxsZD5zpDtHWqzpI9H/POxKuaBSGY
         Prgt2HqSFiM/xo4asiIThi2uvWIsaq1de3jrflDJDRs+j2InA90CiE0VkQmM0Y7jDrnG
         x3p5LJuv0dVZ/i5l449wHIae2ADoIXb0tfId3GJ9VIrHo/2XFRTJeygHZfpnw9BUkwG2
         U7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNuGI2CppkFjxucCGIV9yGeUTwNTWg57KHtYskN0og0=;
        b=Y9f2n09bca3o5228TFWtNZVIehcq6tAr/rXwmgHD9PrB7zLD+EeYorZO0QHPkKq5zE
         0qjkZpyD0TMLE/AR/CrVSvrB8/2KRe6jjNqAy9ovZEU6z7ojWrFeWV094NPLVnlt9jER
         TcqUpimWBdgluJdA1xXUG2Q800i163iLIuv2A0msyTcjwPcVXQ3tY0MP0mcSpytL/ize
         O6ozounPle/Ka2nk3fpqBgZ5VLlBaYtRE5ZFsjURwiRkqVNQY2dZFO13HyjsWh/NI/lP
         DricZTM2JMj912JbwGDjd78g88tWIm8z7H3mN+O03IM4lThH4wq1p8PRafFRxZN6iGnv
         ubMw==
X-Gm-Message-State: APjAAAXU/4sXr+/aKrVaMDfOV6119eX5X2ywIWZO7vLauoWromw6kuak
        izkmDOSpo8AcMAn0SXqvNVbsvyg=
X-Google-Smtp-Source: APXvYqwi1TSPDkzcEmko1NOW9+8dv9lukmxxfx9fv1woieEdWIUilF8EXaWxtHjswNAREwiy32EVvw==
X-Received: by 2002:a0c:93e4:: with SMTP id g33mr7776796qvg.3.1551905389178;
        Wed, 06 Mar 2019 12:49:49 -0800 (PST)
Received: from mwhitehe.remote.csb (pool-98-116-99-216.nycmny.fios.verizon.net. [98.116.99.216])
        by smtp.gmail.com with ESMTPSA id b66sm1642627qkj.57.2019.03.06.12.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 12:49:48 -0800 (PST)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 2/2] x86/CPU: Remove {get,set}Cx86_old macros used for Cyrix processors
Date:   Wed,  6 Mar 2019 15:49:27 -0500
Message-Id: <1551905367-26931-3-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551905367-26931-1-git-send-email-tedheadster@gmail.com>
References: <1551905367-26931-1-git-send-email-tedheadster@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The getCx86_old() and setCx86_old() macros have been replaced with
correctly working getCx86() and setCx86(), so remove these unused macros.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/include/asm/processor-cyrix.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/x86/include/asm/processor-cyrix.h b/arch/x86/include/asm/processor-cyrix.h
index aaedd73..df700a6 100644
--- a/arch/x86/include/asm/processor-cyrix.h
+++ b/arch/x86/include/asm/processor-cyrix.h
@@ -3,19 +3,6 @@
  * NSC/Cyrix CPU indexed register access. Must be inlined instead of
  * macros to ensure correct access ordering
  * Access order is always 0x22 (=offset), 0x23 (=value)
- *
- * When using the old macros a line like
- *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
- * gets expanded to:
- *  do {
- *    outb((CX86_CCR2), 0x22);
- *    outb((({
- *        outb((CX86_CCR2), 0x22);
- *        inb(0x23);
- *    }) | 0x88), 0x23);
- *  } while (0);
- *
- * which in fact violates the access order (= 0x22, 0x22, 0x23, 0x23).
  */
 
 static inline u8 getCx86(u8 reg)
@@ -29,11 +16,3 @@ static inline void setCx86(u8 reg, u8 data)
 	outb(reg, 0x22);
 	outb(data, 0x23);
 }
-
-#define getCx86_old(reg) ({ outb((reg), 0x22); inb(0x23); })
-
-#define setCx86_old(reg, data) do { \
-	outb((reg), 0x22); \
-	outb((data), 0x23); \
-} while (0)
-
-- 
1.8.3.1

