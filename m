Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E0DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7732053B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fObzh+90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfJNTzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:55:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38086 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJNTzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:55:54 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so40574998iom.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=/JsH3ZbaYxFZMIeMJ3El7+phW3uIrRr7HdSlGV8pTHQ=;
        b=fObzh+909uBiKGUOpziEEEhmj2FsPCX2KoKRdvrxJ9eT1/7Dlq6sfzEN2ijztWLcqD
         fbfjk530z0xxRoE9+MWP82tKM5cOqwzGfQLARUauX7cwrB8yk0IdOIu+sTyXNo86h4Js
         BrQWQr9d0aJac3Bxc752pQZelfhuCZ/AiPYEtevrGqzWBA24Nq/Oo+MD8rr/VnbF5ES3
         Ren8P6+tQ/B/L+/qcTuNSQeK/XKFxqj4Oka9n+/N14C7yvUBIrH/QKq342zQ/CMjKQoM
         dQwthSiXFkUXdG1QHylM/CcW9gvaGXHJiGS4huzEpNAuCfoH8NwTtylkMZ3Q6hGCs6Na
         zWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=/JsH3ZbaYxFZMIeMJ3El7+phW3uIrRr7HdSlGV8pTHQ=;
        b=WA3w/tz/QqMs/+TEmbbXRFv7705qVy63Jdtfc6ZfmFCZXPCF5YexJqPkZXaSGV+644
         8IQDyrz16kwl7JDiXWvJDu8QLB1h92zRvuSculZUWdtjAQqShBfchRcyw1JDwupA5DPt
         lJYc+yuhtC2i11OOClMsKhxqXIus+vFyLemPOia30VgdYkrrTnflXfmZeL5GY3CdEQR9
         5l0A/piAHus55WJI8f+qiKAIdkGHZ7dCMdSgzqkM8rseTdYD7r6iyh52RUXTTjeVX8z6
         LHd/yXVSOdNZvTGcBNQr+xlB/e+UyKZnEbPycOqmiowC1LuMzjcJ7Vxe2B91kozdT7vN
         rLYA==
X-Gm-Message-State: APjAAAURuNWm3xf5hVftBvvBlr5IQjMlxhIA3dZaEO36QJOQFoCgWHb9
        HqwxNqVe1VqFmXpja3g7mDeU9w==
X-Google-Smtp-Source: APXvYqxm5qhZp906+C01WcyCOedWZWaarDwDzrPsbekHkTW+M849iW8SeZ6Qg/aoMePGd0j+AEDEzA==
X-Received: by 2002:a92:d24d:: with SMTP id v13mr2390053ilg.112.1571082953416;
        Mon, 14 Oct 2019 12:55:53 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id t9sm15355764iop.86.2019.10.14.12.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 12:55:52 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:55:49 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, andrew@sifive.com, palmer@sifive.com,
        alankao@andestech.com
Subject: [PATCH] riscv: tlbflush: remove confusing comment on
 local_flush_tlb_all()
Message-ID: <alpine.DEB.2.21.9999.1910141254360.12988@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Remove a confusing comment on our local_flush_tlb_all()
implementation.  Per an internal discussion with Andrew, while it's
true that the fence.i is not necessary, it's not the case that an
sfence.vma implies a fence.i.  We also drop the section about
"flush[ing] the entire local TLB" to better align with the language in
section 4.2.1 "Supervisor Memory-Management Fence Instruction" of the
RISC-V Privileged Specification v20190608.

Fixes: c901e45a999a1 ("RISC-V: `sfence.vma` orderes the instruction cache")
Reported-by: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Andrew Waterman <andrew@sifive.com>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/tlbflush.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 37ae4e367ad2..f02188a5b0f4 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -10,10 +10,6 @@
 #include <linux/mm_types.h>
 #include <asm/smp.h>
 
-/*
- * Flush entire local TLB.  'sfence.vma' implicitly fences with the instruction
- * cache as well, so a 'fence.i' is not necessary.
- */
 static inline void local_flush_tlb_all(void)
 {
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
-- 
2.23.0

