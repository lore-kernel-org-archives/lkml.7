Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF68C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFCB24672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgAGTol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:44:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42417 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgAGTok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:44:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id j5so742070qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptIoTNzH/x5OyREv4tWBlwHk2cNJ81G7inlJs7+x/90=;
        b=kfyfnGhREnJ/E97ZKaeRrmj0+eg1QlN6ubzWx8wPD6myxzMquv5eeUj3lpP32EzbTC
         /A7g7VghqHCwCGCi7ricUqJU/vK8ryp+YBR7pVFP92ccj/VogMDK4nN2aMIDkr6KnQtW
         tDepj0QXmvAVQ/nvLVy4DQsqOmhkROxWSbznGHWwibI5iTY2uHsFy7a0p8vL0Ug9Td84
         Z7VDeeTXk78Pb63hLiXYejnO5NDTB4Mf28fz/44/RAU8PGZlA2C7vsa3aO12Yc8jsB/i
         JEs5VCYT+OmEWbAbVBVb05W6vCcSXYjhGO9eVybEEAy4oTjM1uBYyOUfl6FC691JW9y2
         f2Qg==
X-Gm-Message-State: APjAAAUs285vCLM1Xv9dETLJTTriBlqVLFn6fK8L7qVypJenGMKm8ZkM
        ojPbkoQo3ucCDh9r0geWKzE=
X-Google-Smtp-Source: APXvYqxv9T5l5rXVUZc139nsAd6zS9RbFhzH4sdnUMwjD78ftrhauuRx6yuRt3EGaYFT56DwJdBeTg==
X-Received: by 2002:ac8:21b5:: with SMTP id 50mr564752qty.10.1578426279295;
        Tue, 07 Jan 2020 11:44:39 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s20sm280137qkg.131.2020.01.07.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:44:38 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/boot/compressed/64: Use leal to initialize boot stack pointer
Date:   Tue,  7 Jan 2020 14:44:35 -0500
Message-Id: <20200107194436.2166846-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107194436.2166846-1-nivedita@alum.mit.edu>
References: <20200107194436.2166846-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's shorter, and it's what we use in every other place, so make it
consistent.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 58a512e33d8d..edd29340bcfd 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -81,9 +81,7 @@ SYM_FUNC_START(startup_32)
 	subl	$1b, %ebp
 
 /* setup a stack and make sure cpu supports long mode. */
-	movl	$boot_stack_end, %eax
-	addl	%ebp, %eax
-	movl	%eax, %esp
+	leal	boot_stack_end(%ebp), %esp
 
 	call	verify_cpu
 	testl	%eax, %eax
-- 
2.24.1

