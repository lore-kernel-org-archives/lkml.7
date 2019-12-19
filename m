Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B8D2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bdarQnAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLSGpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:45:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33749 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfLSGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:45:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id z16so2650771pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 22:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dACTxZlWuE14iZ0X/C5ALaIg2Vn5nm1BwBkFWMDEuQI=;
        b=bdarQnAkGejJcPalNHZddG1sJ2YO99hf7u+QNYCUy62dTvjLy371YTTipyk1OzN2B4
         Sw4KXM/LrfrvAND4qeNCHKijWNotjYucUoNOYMjhz93rtmemLj7lRU3rKarNhEoBOpXt
         ynLsec/dk/ejx701CF86zwf14xfSkKjVRS1dk6fV0Pjgfj3fP4jzPnVCZolHaSuXqjme
         a0ctWvSr/hSi8r11FSIjYdPhlaAmg3HVrQXlxGrJRGpcwzSF/wky36/2nrx706u7RvRS
         6VAW7htLPrJGA0h5dS2uVhsOhqGNT4mr1ld1EgauZOkR0617DYwTKD4/8aEHBjb0lYr4
         S0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dACTxZlWuE14iZ0X/C5ALaIg2Vn5nm1BwBkFWMDEuQI=;
        b=PQnLVge/67Z+0RtlPNO1t7s/hAmexkLSq5LWU+pQiZWk5fbND4F0uek7ip3G8JhIno
         Uke9caBe0uV3ntOezcG+1mV6pkQdORb/iC5kOwXKNLSiFZWPXn5x6HO2z8vSC0Oxyk+0
         e3GwrhIDnseVhMIZvric4DXI41v9UiryYDOVj8prxxW/cTav/FLZoNFnRWXy8bIxHaHY
         BTfb2jNwRGcAWP9bY0CBXORK7QRpKqPkpQU7s8pRlKw0MpP54dboJ52HmL3MeQ3peATJ
         7RGtmuSBD59Af6u3yVxWFBpjZxMD3Ob4hXs8d794XsMZQTzDe+OtMdq2ZlyO3Qu0Pv93
         +1Pg==
X-Gm-Message-State: APjAAAVKZYvDOKuTA0IoKL5QzMaWC6SGkmzh/UPzhN443y2WsrxEarIs
        x3cfzSMGc9AyB8LkIUpD50ThYQ==
X-Google-Smtp-Source: APXvYqytLpKObbCqrVTm4p8Xo2BjhK6hfjUDZWWYMc76tJygXlJcPFqGUndDmfcum6UqM9WB9ymL/w==
X-Received: by 2002:a63:b50a:: with SMTP id y10mr7536229pge.104.1576737916334;
        Wed, 18 Dec 2019 22:45:16 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id t187sm6199566pfd.21.2019.12.18.22.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 22:45:15 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     green.hu@gmail.com, greentime@kernel.org, hch@lst.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>
Subject: [PATCH] riscv: fix scratch register clearing in M-mode.
Date:   Thu, 19 Dec 2019 14:44:59 +0800
Message-Id: <20191219064459.20790-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes that the sscratch register clearing in M-mode. It cleared
sscratch register in M-mode, but it should clear mscratch register. That will
cause kernel trap if the CPU core doesn't support S-mode when trying to access
sscratch.

Fixes: 9e80635619b5 ("riscv: clear the instruction cache and all registers when booting")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 84a6f0a4b120..797802c73dee 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -246,7 +246,7 @@ ENTRY(reset_regs)
 	li	t4, 0
 	li	t5, 0
 	li	t6, 0
-	csrw	sscratch, 0
+	csrw	CSR_SCRATCH, 0
 
 #ifdef CONFIG_FPU
 	csrr	t0, CSR_MISA
-- 
2.17.1

