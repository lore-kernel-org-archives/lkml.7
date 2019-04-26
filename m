Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4949C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B8E208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcHDpG5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfD0Gnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38018 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfD0Gng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so2630779pgl.5;
        Fri, 26 Apr 2019 23:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mq726et3FUsm8L5SG93p+KUhd7ShOgthVM8qUN29ytY=;
        b=ZcHDpG5oI881U7Ra0/L2O5huO2cwDn2YrdsQ5hiAWkm6WdBzN67nlkJvfLDLJC5q+X
         UOCeP+9RydbCT4dO6iGp4lZQdm3+sXHNSQC0G0grGB6NOlnyKbwZn5NdDqZwDHIXRDud
         3mNZu1J6RFiZozyuuSJ7f0wBAoiYQFhmUfj5tGkTm8jduQKjEFGn6AF04k5qQYjIWsXY
         4YzLX+ZgfiYxaYFVUDUXXbJdfkkMMJKkcbeIB+VGTLlKKEI2dS4TTD29m/lBt3TdxyYa
         a4fp8LYLp6QEbTAIinVcBUAwlwg+TwtnzyGC3pPfhsUXM3/E24y9pQ9Ah5nWVdchzhK2
         LMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mq726et3FUsm8L5SG93p+KUhd7ShOgthVM8qUN29ytY=;
        b=bGF4oNImy9xNe8NZH9foiS8upuxXKgS4qSzGlTeFBNrLl27nHbGXv8Io5bM1tqdzDL
         vGEQiMJ6yQIcQc6jkiJf1WyQdeg/tfBJ/3puaZPk2XO74UezsL8nMeWoqc8Tx4KBRwnd
         CPyq9ljeWzfvVvx5COZao1KrFbTUbdTnp02cuDP/zf8uBA+S9Z4iY+BzFyN/2jMF2EVs
         FOv3Rx7Wu0LeDsb09j8JkNB5H3qErpNTKgauWKktz2iikoXjGj8Fj60x+1grSPW28tBW
         h8hMVmrNxBt7LFINkMNz2ddxeXdhNpelCwI6VZx8hcr9dphqArVf1VPWgVAsKQzHDiBB
         cYMQ==
X-Gm-Message-State: APjAAAXSE+zDMZn2L7+YO0b/FA94QvvMnNA3ZoxppUIlYZ5hgDTkEvaD
        to3BcGP1GLRfcUzYuUbPa1g=
X-Google-Smtp-Source: APXvYqz6QdLKu0nIIJYQFhptNQ/c9BRHYqidvmm2brorovTM3Ggu9E591UYxGE1lKlV0dGgfmeOtWg==
X-Received: by 2002:a63:e051:: with SMTP id n17mr5092049pgj.19.1556347415619;
        Fri, 26 Apr 2019 23:43:35 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:35 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v6 22/24] x86/alternative: Comment about module removal races
Date:   Fri, 26 Apr 2019 16:23:01 -0700
Message-Id: <20190426232303.28381-23-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Add a comment to clarify that users of text_poke() must ensure that
no races with module removal take place.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/alternative.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 18f959975ea0..7b9b49dfc05a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -810,6 +810,11 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
  * It means the size must be writable atomically and the address must be aligned
  * in a way that permits an atomic write. It also makes sure we fit on a single
  * page.
+ *
+ * Note that the caller must ensure that if the modified code is part of a
+ * module, the module would not be removed during poking. This can be achieved
+ * by registering a module notifier, and ordering module removal and patching
+ * trough a mutex.
  */
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
-- 
2.17.1

