Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D321872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyjcDtH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfCNUqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:46:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37949 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfCNUqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:46:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id s1so7743653qte.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNuGI2CppkFjxucCGIV9yGeUTwNTWg57KHtYskN0og0=;
        b=WyjcDtH/uQrRaCySdqwShooAmLuzYSxhbE7K3lJbQB3IUqPswgKxUSN4y5NBIKnade
         otQtt4xOZvs/LT5HwvTXTPs6n3l1iLhUEWd1ntKn5v9VaL8IDhou+lZwX5BoXawkYxfr
         SAZACfVYxtnXXxxB6Bx3aSCsmtkgdgxyx6IzxDg4MXFimuiX8Ax0yS1SwMjp+xaFG8P9
         EGitf4zyx1IH8h0dF4I622hJbCq+7jRo1FqsJwY3nEeNW1UlGGEX0bbkbwfkWb6Eyhgb
         crUc8JOZ5/hpsWCrm/45QICyrw4o77hIz8gAguVurBZvn6yrZxZqNbm6cwVinSMhBfDz
         H7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNuGI2CppkFjxucCGIV9yGeUTwNTWg57KHtYskN0og0=;
        b=J+79xGKwTLv2BcBR5XyLuhARowln23tIABr3qVPD/dICgMh90yJtrIsK5DRuLwvNL6
         xDmLJt9F1mwlf1M2NWKFeKPQ6kqNP5NrZmwSNOlZu573NrtFDOWomTBw5FMgOXKws2qP
         uRBiafU2klhEsWpEY+a65j4k7LRckI4KkbOh8hbwjrV5gDn9T+KEoY6Az9lc5IqS4r8x
         1ZwyJM5uSsGyhXOMkoEWEcB8pDKE2sE5US4VtQJ+BsG5NYb10rF0j/auxjioUISNKcU7
         JLMJG9tIni0Yrid96YzarbQ9Tkjf/CDU0GlqzOy2fujvOAqf8cVwuvWBNDwapi6r+E0Y
         8L4Q==
X-Gm-Message-State: APjAAAWL/2OjDw/lVEnW+fq8EWpdOIlr4dc6dldgVx9wxjlLzHh9mPeb
        mKm6u49IDwDKRWbb47w7mp9IPRg=
X-Google-Smtp-Source: APXvYqzxkEDr5SyiUX3ZGvxJ7ByhyuxmQ19wY6lZFC9B6tlInWui+xWe88UE0RZhd2NcXeYfTSux1Q==
X-Received: by 2002:ac8:3092:: with SMTP id v18mr48099qta.41.1552596378521;
        Thu, 14 Mar 2019 13:46:18 -0700 (PDT)
Received: from mwhitehe.remote.csb (ip-107-51-47-37.nymnny.spcsdns.net. [107.51.47.37])
        by smtp.gmail.com with ESMTPSA id j188sm16460qkc.55.2019.03.14.13.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:46:18 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org
Cc:     Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH 2/2] x86/CPU: Remove {get,set}Cx86_old macros used for Cyrix processors
Date:   Thu, 14 Mar 2019 16:46:01 -0400
Message-Id: <1552596361-8967-3-git-send-email-tedheadster@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552596361-8967-1-git-send-email-tedheadster@gmail.com>
References: <1552596361-8967-1-git-send-email-tedheadster@gmail.com>
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

