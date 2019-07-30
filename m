Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6E20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rESudm6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfG3XF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:05:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34566 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfG3XF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:05:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so29144565edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wtr/OvD1dXcu2GnVTbhNUmnV1ZmXytBZHy9HlMnyIzc=;
        b=rESudm6UMf6HX+kgVT50kjl1k4DOJGXY+gDTBiiv+sLZP3Wlk1A14/t3Pc3BEth4QG
         oBi0cpH0gGrZ5tLRqVwxNqVJwo7O5F1WSZCTOmb5oRvjC6U2ORjcz6RVVN/ES7ioGgpT
         dHEcr0EtzlO8gnn3rfOxhCfwCBgOQ60BxpFn4SriL/8zAN4KF8mHQ60q8pFJVgQ7E5BB
         M49mnVcLEDEABE8I2bclPTZw++JAPRzkCipKHV5UlZ8JRRuZBIjRcC2SKDFsTFpUYvnf
         QNLc7mqphS00RhaARGuPr23bNFoS2X+DKSWHEvY04YgPNq/NYFCVp3Kiwl+6KHbO83wm
         sQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wtr/OvD1dXcu2GnVTbhNUmnV1ZmXytBZHy9HlMnyIzc=;
        b=c5z0/N4DpLTgvphOaDo/FdWNWmNVrbVytKTqqjWNTBSp/CR/CtpoQ8ao1gpI3xnJQP
         UK7iEfRhYzIGPzbWsYHwwxFfDHgAIGGtV5oDYTfY//SA1/gAg0NWuK34xK2SlWl+RWIL
         5dLqxaA0SmLxeyAPI3kZazduZ0/uwxAau65/6Y7u21GUCNkkvlycz0UMRlHhj1fceOVv
         A5g8Yvl/OwIsoVqEFCWB5/wL5cXvDtSzOBJG4fS6XuVZQl/QfDdeQbb6DfZtp36O7kUv
         XIMS6v/RuFZvUkihQ3B2qURDnKa2phJwkQHfr5poJXDncpm1AOJh7OVmexxV1ZoP9g0Q
         V9jQ==
X-Gm-Message-State: APjAAAXz0M0bEIyQlZ83SJp6XXaz1MF4re9JnEpOJ1jH1EwFuH+t9aCV
        tOOvq2FZxgdpj685ydlyn+0=
X-Google-Smtp-Source: APXvYqziTwNLCqI/xgVzHpbzgUdfqRPf11DI7dLBqBI85HKduT7kUl+xAloT256qE/IUhiIa2l/X+g==
X-Received: by 2002:a05:6402:129a:: with SMTP id w26mr103452834edv.167.1564527956403;
        Tue, 30 Jul 2019 16:05:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r10sm16535344edp.25.2019.07.30.16.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 16:05:55 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 3938C104078; Wed, 31 Jul 2019 02:05:55 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Date:   Wed, 31 Jul 2019 02:05:54 +0300
Message-Id: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a new instruction MOVDIR64B. The instruction moves
64-bytes as direct-store with 64-byte write atomicity from source memory
address to destination memory address.

MOVDIR64B requires the destination address to be 64-byte aligned. No
alignment restriction is enforced for source operand.

See Intel Software Developer’s Manual for more information on the
instruction.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

Several upcoming patchsets will make use of the helper.

---
 arch/x86/include/asm/special_insns.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 219be88a59d2..059e7bd331d2 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -248,6 +248,13 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
+static inline void movdir64b(void *dst, const void *src)
+{
+	/* movdir64b [rdx], rax */
+	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
+			: "=m" (*(char *)dst)
+			: "d" (src), "a" (dst));
+}
 
 #endif /* __KERNEL__ */
 
-- 
2.21.0

