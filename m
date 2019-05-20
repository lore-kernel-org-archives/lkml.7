Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473CDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220072173E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WUdWnpkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfETSZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:25:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46626 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:25:30 -0400
Received: by mail-io1-f66.google.com with SMTP id q21so11771514iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmqIFp4icfZnPyLg0HDy/kQuXw1sl4wbvoppE+mg+DQ=;
        b=WUdWnpkXzLNbxpHv+XgWjZePSEtfJ3srhIv06ANnSQGqGE9T45z1W4UcleITOKhkYa
         ibsbnPPzo1s+D2G4L2ovyC3a0yd/b1a/gaMECFo2cIV7ytvDOQnBxvEq8/xzd+v2WbFT
         j/KoKHbpNI2e9lnEHGcBVc106hs3Z1IpolmHudPXXUDSb5kvc7i72xOYoUUku+vIu5UT
         sgzSJvmRVqF7L9LFGEX3arbANBgDgaSI6QdrjzA+w7i+2BHepr67CP567+9RTmTI9od7
         /Wjx1hfrFI0aBhPBIDiUwXgGNiKUGBfk/zAs0jA1D48EM3R2jPNyCa1ijcVeQ2Nxx4eL
         tE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmqIFp4icfZnPyLg0HDy/kQuXw1sl4wbvoppE+mg+DQ=;
        b=O7+3iRv+xI5gRvCduzxBsJYooQ5wJKko0tzHpNQ0A0JQ8WssJjxCRmbMCR7h2J1goV
         rLnKMIaHpwIMThT3Qn1RYdDwm9lIuyU3klxQVWASgb++i5sjYZsz0v5+gNhfaJOFN7tD
         /2oPZKGb9FeZZhv1Fy4i6eZSXc50Lq1pgpkuwGXggulzcld3EAXXGnHUHaO5IEtJqqR+
         mR5lZsSQvo17flcbHQeaTKx1GDsv3N843DIVc7TyJ/A2ZCD8JHxxQR5ojpJUSwqQlrE6
         iqGooKdqgK2gzdEbdFS8dtOlhKHBYMXiBFOE9OayoNcfZl33VW7KdIIDGoA3hR4ntzDZ
         A6zw==
X-Gm-Message-State: APjAAAWt2TFZvtY0b6F3cwOFhtZbYAkCxp2vHW68W6HSQRHQqk1vGqEj
        l5NTfAJ9v/Nnw79yH1CU+2FHxQ==
X-Google-Smtp-Source: APXvYqzlpFilXUERsaEKWrW4gUmc09n06Iun1qu9UaXTzhfY090JdtYxRreS+KDnxD8dlML4Bc4Duw==
X-Received: by 2002:a6b:7008:: with SMTP id l8mr41127535ioc.210.1558376729850;
        Mon, 20 May 2019 11:25:29 -0700 (PDT)
Received: from viisi.lan (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id m25sm137862iti.24.2019.05.20.11.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 11:25:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul@pwsan.com>, Wesley Terpstra <wesley@sifive.com>
Subject: [PATCH] riscv: include generic support for MSI irqdomains
Date:   Mon, 20 May 2019 11:25:28 -0700
Message-Id: <20190520182528.10627-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some RISC-V systems include PCIe host controllers that support PCIe
message-signaled interrupts.  For this to work on Linux, we need to
enable PCI_MSI_IRQ_DOMAIN and define struct msi_alloc_info.  Support
for the latter is enabled by including the architecture-generic msi.h
include.

Based on a patch from Wesley Terpstra <wesley@sifive.com>:

https://github.com/riscv/riscv-linux/commit/7d55f38fb79f459d2e88bcee7e147796400cafa8

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Wesley Terpstra <wesley@sifive.com>
---
 arch/riscv/include/asm/Kbuild | 1 +
 drivers/pci/Kconfig           | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 3d019e062c6f..b0a9fa34be5a 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab92409210a..beb3408a0272 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || X86 || RISCV
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.20.1

