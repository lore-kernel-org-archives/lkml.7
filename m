Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD23C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615712067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="myeQGSLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgAIDRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:17:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56110 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:17:46 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so494331pjz.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 19:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nxZyqBXaqg/tT8nIMuw+ak702y+nxZf3L89bHA/qCks=;
        b=myeQGSLe0d8bhNYOD+O0U7D3LTzqg+3ZDENr8vata5COP/HzIwMIjTBG2wyPtBHiG1
         jZp+xDkgGEq1vujRwxK+y+5o5E8Sux2i9Z25bx3dzyCvKq7ma2lar9BpNRnjdYxcAJc8
         RXDYM0cTLxY2SfJfHzTr/vH42lALj9GgEHvEUp+iaS6/Rmew2JfvIipxkCM1jwsiOcC0
         6Imv3fj13ZlG6wuzqjmOtCuVCig9bn2xtJzNoHaGzgVIHQ2cpzKDNX1Xpi3h7To1HRtX
         sh47cHsjX01t0qX8/dm+ZjRoEIiIxhfAgRbaOf5IdhFjWNXHpPZi91HOqBOnOKfDvqTH
         pA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nxZyqBXaqg/tT8nIMuw+ak702y+nxZf3L89bHA/qCks=;
        b=t1/CWwFwt6MvL7n71/FiNUgV49iVCry2UbU/l08It8+LWaXF3sxeo3zYK2gfWUWqOa
         xWW+7AnfGkdU6gvgBJ4bVHJKuD9y1v3M2BC/tveTBA+/ZdYIMoyCBLRQUsD8eWRNrXFF
         NQ7Dt4Fe3UMR5SomrTH2ZmEIvHOqhq873MRg8FzoMqOUuNTr8AvBHeee6yI4lPQpX3Uy
         gAbKsPeR6ptOiCyz4TRB2XJ5qOHJxKkLXCECNRU5JpjiIPlAgwDekET5XSGjtJwAHEkL
         Tc3nM+shcJ8G8/o0mSVofkEejmNewPx2GR62xFJHqupmAyAdT6ebaEEgMjm5noFw6FC5
         1hcw==
X-Gm-Message-State: APjAAAXxrekux6toSj5RgRF3+BeF+JGEAmebdM/R1cstkzyjiIZfpyNg
        brtz8xJwMWJl7lkjqoKjo4eE/g==
X-Google-Smtp-Source: APXvYqxCbKCHB3TlOqqbLRksmu4fkPDvL6e4D8XhJiW3qaBJy/tqYfRllbl+A3f1/Lic0mF6BNgy7g==
X-Received: by 2002:a17:90a:28a5:: with SMTP id f34mr2543811pjd.79.1578539866002;
        Wed, 08 Jan 2020 19:17:46 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l21sm5345383pff.100.2020.01.08.19.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 19:17:45 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH] riscv: set pmp configuration if kernel is running in M-mode
Date:   Thu,  9 Jan 2020 11:17:40 +0800
Message-Id: <20200109031740.29717-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is running in S-mode, the expectation is that the
bootloader or SBI layer will configure the PMP to allow the kernel to
access physical memory.  But, when the kernel is running in M-mode and is
started with the ELF "loader", there's probably no bootloader or SBI layer
involved to configure the PMP.  Thus, we need to configure the PMP
ourselves to enable the kernel to access all regions.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/csr.h | 12 ++++++++++++
 arch/riscv/kernel/head.S     |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 0a62d2d68455..0f25e6c4e45c 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -72,6 +72,16 @@
 #define EXC_LOAD_PAGE_FAULT	13
 #define EXC_STORE_PAGE_FAULT	15
 
+/* PMP configuration */
+#define PMP_R			0x01
+#define PMP_W			0x02
+#define PMP_X			0x04
+#define PMP_A			0x18
+#define PMP_A_TOR		0x08
+#define PMP_A_NA4		0x10
+#define PMP_A_NAPOT		0x18
+#define PMP_L			0x80
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
@@ -100,6 +110,8 @@
 #define CSR_MCAUSE		0x342
 #define CSR_MTVAL		0x343
 #define CSR_MIP			0x344
+#define CSR_PMPCFG0		0x3a0
+#define CSR_PMPADDR0		0x3b0
 #define CSR_MHARTID		0xf14
 
 #ifdef CONFIG_RISCV_M_MODE
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 5c8b24bf4e4e..f8f996916c5b 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -60,6 +60,12 @@ _start_kernel:
 	/* Reset all registers except ra, a0, a1 */
 	call reset_regs
 
+	/* Setup a PMP to permit access to all of memory. */
+	li a0, -1
+	csrw CSR_PMPADDR0, a0
+	li a0, (PMP_A_NAPOT | PMP_R | PMP_W | PMP_X)
+	csrw CSR_PMPCFG0, a0
+
 	/*
 	 * The hartid in a0 is expected later on, and we have no firmware
 	 * to hand it to us.
-- 
2.17.1

