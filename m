Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE7C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DE205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfFGWWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:22:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39033 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbfFGWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:22:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so1327064plm.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=/dYQFi3bBss8afoakW/tqhqFRGchq2/jlK/9FbC0dDw=;
        b=CRpLZcithTAUTXSFnbOxkIL/JpE212VzdWO1oXFzuAv4S7EtqRnZe5zNmINAubZQuM
         rwlkhvEU+b2E/nBvOP2iXptzNEbpKB6oRzGACiLfJpI8CQx75jmhwsDzqtrXfqvGe5sF
         6jEF1fsJrAONUKZM6eHY2+VodcPkLhtS0sxD6eZGmfSqEZ1yvrCF9LUFzqlUL7Wv6qBL
         yjxWfb3klQUPRjfFZsNb7sYnzJ4EpbpQm1J3jbbUWk1t+FMc/Qzlzu6jkWkXiQcEr68w
         vRF5y/NDkA1IbHjzbgyxoehAWkZD3sOOxTNTmQZo8RHWpboL5Qc8y9O80HKZIXgfdyQr
         cyQQ==
X-Gm-Message-State: APjAAAVPnCUSyp9ogWjLhk9E385PtBHG4ss5tT+DQEgsYgu3sIyEm/gE
        H29CfdQGQewk3KtCNTj1gC7RURxtpSE=
X-Google-Smtp-Source: APXvYqzaIEf54bQUJpk9zAErhDTINFE9FzSORfLuunKkVFb1lASR7PlmH0H2/zyDFAugX85Q3bsNOQ==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr57009546plo.163.1559946159940;
        Fri, 07 Jun 2019 15:22:39 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n13sm3205489pff.59.2019.06.07.15.22.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 15:22:39 -0700 (PDT)
Subject: [PATCH v2] RISC-V: Break load reservations during switch_to
Date:   Fri,  7 Jun 2019 15:22:22 -0700
Message-Id: <20190607222222.15300-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org,
         Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
         me@carlosedp.com, joel@sing.id.au
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment describes why in detail.  This was found because QEMU never
gives up load reservations, the issue is unlikely to manifest on real
hardware.

Thanks to Carlos Eduardo for finding the bug!

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
Changes since v1 <20190605231735.26581-1-palmer@sifive.com>:

* REG_SC is now defined as a helper macro, for any code that wants to SC
  a register-sized value.
* The explicit #ifdef to check that TASK_THREAD_RA_RA is 0 has been
  removed.  Instead we rely on the assembler to catch non-zero SC
  offsets.  I've tested this does actually work.

 arch/riscv/include/asm/asm.h |  1 +
 arch/riscv/kernel/entry.S    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 5ad4cb622bed..946b671f996c 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -30,6 +30,7 @@
 
 #define REG_L		__REG_SEL(ld, lw)
 #define REG_S		__REG_SEL(sd, sw)
+#define REG_SC		__REG_SEL(sc.w, sc.d)
 #define SZREG		__REG_SEL(8, 4)
 #define LGREG		__REG_SEL(3, 2)
 
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 1c1ecc238cfa..af685782af17 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -330,6 +330,17 @@ ENTRY(__switch_to)
 	add   a3, a0, a4
 	add   a4, a1, a4
 	REG_S ra,  TASK_THREAD_RA_RA(a3)
+	/*
+	 * The Linux ABI allows programs to depend on load reservations being
+	 * broken on context switches, but the ISA doesn't require that the
+	 * hardware ever breaks a load reservation.  The only way to break a
+	 * load reservation is with a store conditional, so we emit one here.
+	 * Since nothing ever takes a load reservation on TASK_THREAD_RA_RA we
+	 * know this will always fail, but just to be on the safe side this
+	 * writes the same value that was unconditionally written by the
+	 * previous instruction.
+	 */
+	REG_SC x0, ra, TASK_THREAD_RA_RA(a3)
 	REG_S sp,  TASK_THREAD_SP_RA(a3)
 	REG_S s0,  TASK_THREAD_S0_RA(a3)
 	REG_S s1,  TASK_THREAD_S1_RA(a3)
-- 
2.21.0

