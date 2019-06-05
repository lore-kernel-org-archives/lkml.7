Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B40BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606A32075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFEXSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:18:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46818 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFEXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:18:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so226165pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 16:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=wTIcqb3SuSLYyX4jaiouQi6Jmmzy6iFQXQcUcQGoiGQ=;
        b=tqAMBJgBk6zNGfdnm33ks2F0SplQzz2iEsOE9HhMbNBy9Jxp/NkPDlp05KFR49+Hue
         EcC7bbvnf03kWcYvYPU/+iTJtdGTBDT7ki5cNywtUBc/u4OTT3DnU4OQUGwJRriNt0m7
         35z4y1vhgmlGJ9GkY/COU/F6uCvwvB5OniY4gPSFuZdmqd4cCy+1Gc8WeKtdGWoJkz9+
         RtEPRhuq/2+c9hkvalUdxV9gojWa+43z3cWOTaHtMTwwifOD8sOuQ8zAkybiIm6Qx9Aw
         1dFIW8OwWDfA9h+7h07DSuKMNQyJbegsxe4SsJJb4DNrYFjVXCD5CUQVYRUXugoaUnWw
         3zrg==
X-Gm-Message-State: APjAAAWGdpZWYjtA+g1J0VSwmaDtBfNKfqfv4wpa9pOTKg9EVXyBKYJF
        rniTxJ3pf+1ynYd1UIz98RtaMpUL9ZY=
X-Google-Smtp-Source: APXvYqz0UPjUzr2DqEeL3AT5OsS9mUtNgNeT44235duzwripPH47MW2Kti8j0fnIBEI9E3FD7pmQSw==
X-Received: by 2002:a62:7995:: with SMTP id u143mr50098061pfc.61.1559776715772;
        Wed, 05 Jun 2019 16:18:35 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y13sm37199pfb.143.2019.06.05.16.18.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 16:18:35 -0700 (PDT)
Subject: [PATCH] RISC-V: Break load reservations during switch_to
Date:   Wed,  5 Jun 2019 16:17:35 -0700
Message-Id: <20190605231735.26581-1-palmer@sifive.com>
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
 arch/riscv/kernel/entry.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 1c1ecc238cfa..e9fc3480e6b4 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -330,6 +330,24 @@ ENTRY(__switch_to)
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
+#if (TASK_THREAD_RA_RA != 0)
+# error "The offset between ra and ra is non-zero"
+#endif
+#if (__riscv_xlen == 64)
+	sc.d  x0, ra, 0(a3)
+#else
+	sc.w  x0, ra, 0(a3)
+#endif
 	REG_S sp,  TASK_THREAD_SP_RA(a3)
 	REG_S s0,  TASK_THREAD_S0_RA(a3)
 	REG_S s1,  TASK_THREAD_S1_RA(a3)
-- 
2.21.0

