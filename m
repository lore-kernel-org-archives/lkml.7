Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E51C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7A020872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfIYAQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 20:16:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37694 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbfIYAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:16:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so2174344pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 17:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=GUy92otsO7OGtR8tORwxTtrbT2fTJHl/EHieICSRiM4=;
        b=huDyHwbD0ZYUou4byMiMzemgMgNWiyXj5kNXrKZzm703+iHDTZVuTDJUMGPrR8rdSo
         kTcIqRpH2o+E441XL2OZxBx3/BsbtCEhl8NmI5cPn377iwbBK+rWAdzp1jnvxsuio/CT
         YDxLARoYQUV6gThkzODo878ESSbbXgfYggSwkV6LaspG+0STZ4XxmZLWlpBAn0MSjiiT
         MtbcZsj1xrtB9YIj+0Hh/YWGHk6lyQXLI5ct71jyXkCi3oVE909d5M/FKcN3RIKX+KTU
         fV2ayJOTeBcY/eSx/GR2vWM5JwSwXFP+6bA0pOciBFPf80WbtrM0rHGknr3Ynv5A6b2E
         IZXA==
X-Gm-Message-State: APjAAAUQBQ5dJ+s5p24Xcei0EN0K/i51iUXDS3XmCticUZXAJ8OMgAGM
        dZJIT8OAjksqY/EBCa0oz+e+xjk4J2I=
X-Google-Smtp-Source: APXvYqwXGPVj8lR5SB6ESQqPEewNM1bRVXwCbupxnsqlnpTm8UhKAltemb3fquXUV/G/YaODLvhEpQ==
X-Received: by 2002:aa7:86c1:: with SMTP id h1mr6564484pfo.128.1569370600147;
        Tue, 24 Sep 2019 17:16:40 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z3sm1104571pjd.25.2019.09.24.17.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 17:16:39 -0700 (PDT)
Subject: [PATCH] RISC-V: Clear load reservations while restoring hart contexts
Date:   Tue, 24 Sep 2019 17:15:56 -0700
Message-Id: <20190925001556.12827-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        marco@decred.org, me@carlosedp.com, joel@sing.id.au,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is almost entirely a comment.  The bug is unlikely to manifest on
existing hardware because there is a timeout on load reservations, but
manifests on QEMU because there is no timeout.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/asm.h |  1 +
 arch/riscv/kernel/entry.S    | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 5a02b7d50940..9c992a88d858 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -22,6 +22,7 @@
 
 #define REG_L		__REG_SEL(ld, lw)
 #define REG_S		__REG_SEL(sd, sw)
+#define REG_SC		__REG_SEL(sc.d, sc.w)
 #define SZREG		__REG_SEL(8, 4)
 #define LGREG		__REG_SEL(3, 2)
 
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 74ccfd464071..9fbb256da55d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -98,7 +98,26 @@ _save_context:
  */
 	.macro RESTORE_ALL
 	REG_L a0, PT_SSTATUS(sp)
-	REG_L a2, PT_SEPC(sp)
+	/*
+	 * The current load reservation is effectively part of the processor's
+	 * state, in the sense that load reservations cannot be shared between
+	 * different hart contexts.  We can't actually save and restore a load
+	 * reservation, so instead here we clear any existing reservation --
+	 * it's always legal for implementations to clear load reservations at
+	 * any point (as long as the forward progress guarantee is kept, but
+	 * we'll ignore that here).
+	 *
+	 * Dangling load reservations can be the result of taking a trap in the
+	 * middle of an LR/SC sequence, but can also be the result of a taken
+	 * forward branch around an SC -- which is how we implement CAS.  As a
+	 * result we need to clear reservations between the last CAS and the
+	 * jump back to the new context.  While it is unlikely the store
+	 * completes, implementations are allowed to expand reservations to be
+	 * arbitrarily large.
+	 */
+	REG_L  a2, PT_SEPC(sp)
+	REG_SC x0, a2, PT_SEPC(sp)
+
 	csrw CSR_SSTATUS, a0
 	csrw CSR_SEPC, a2
 
-- 
2.21.0

