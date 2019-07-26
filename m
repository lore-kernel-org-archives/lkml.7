Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FEFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CE7218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZUrDcHay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfGZUAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:00:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45158 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGZUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:00:52 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so107220722ioc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=sVh8r6qxozU0X539bGpCLYaNgAX3Xb97PwurXbHz33U=;
        b=ZUrDcHay4oGNKA9iwZucPi17ifpM3TRnKUVdM9LgifBV9gptxZmhT0itpa6kwHdnsT
         KkdpicK7OnEtsf0dcJD0D72zl/5tAOgF3RzBdqAz2gHJ54OxmAI+Z6J4NKFe7YUe9PjW
         SLIECT3F9mbczwi8uGQ1Tp3jYMqXHrEzmKoKimf4SV//tQ6uE2xBVtebJX7xDfqCwXFw
         hwkwo9JG6alyS34AVzOWlef16JWgcL1M542Odh9q+wSM0X3lb24iQw77Wu3xg4/Ddrax
         BiHLcrJ8fOinJ8DdVsyEL0uu2dkhqnjxXGF+LIIJtMTlhDh9Q26ebPyjTr41PGiOaTIO
         om3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=sVh8r6qxozU0X539bGpCLYaNgAX3Xb97PwurXbHz33U=;
        b=qdIIJQgF48lM5P7z8pSi9FQ89MN5HZbGH72NW+l/CnP3wSQCLHfz4I0YiAopcf4kqQ
         zQ8iK9pFuts1yn6Kxh6x0NAKiajSLvlEDx3Sj/1uMyFYzTtSJR2r4PwUOZmIT+MrJ5ZT
         6hEbo6STRehexOQV0zf03LKgufoS/VRPdFTLyo5hrk8HdrkvsvwJ9eR9P6L2l85xJfmx
         MAzLa2YQSZrOUrm5yFmQhwVnaWm5OjNme7ZOMzkZFU+ppTsugNNO2Vzuq2ASmAon33Pu
         Hk1oPx+FNCzS2JNikwGpl4zhv7cdlH5RVrJusn8qI6HdK8iVR3E6cXz9dWt9wRgezw85
         phQQ==
X-Gm-Message-State: APjAAAVyGw1PYiDfzRb3NGHTo4W8N330SaETruAG35lmTXwvlbebjPTo
        kbe0O/ZPuiWVu3JiZU5xK09rscBAKkw=
X-Google-Smtp-Source: APXvYqxqbTRydPk/GCxaDMMoixs5NtZCXarNxQefJxhOMoH3Vo4aDAI15K3eWrugoCEa6BR6Uv+ETQ==
X-Received: by 2002:a02:1c0a:: with SMTP id c10mr102301637jac.69.1564171250993;
        Fri, 26 Jul 2019 13:00:50 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id x22sm39848516iob.84.2019.07.26.13.00.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 13:00:50 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:00:49 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: kbuild: add virtual memory system selection
Message-ID: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The RISC-V specifications currently define three virtual memory
translation systems: Sv32, Sv39, and Sv48.  Sv32 is currently specific
to 32-bit systems; Sv39 and Sv48 are currently specific to 64-bit
systems.  The current kernel only supports Sv32 and Sv39, but we'd
like to start preparing for Sv48.  As an initial step, allow the
virtual memory translation system to be selected via kbuild, and stop
the build if an option is selected that the kernel doen't currently
support.

This patch currently has no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig                  | 43 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable-32.h |  4 +++
 arch/riscv/include/asm/pgtable-64.h |  4 +++
 3 files changed, 51 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727ecd6c..8ef64fe2c2b3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -155,6 +155,49 @@ config MODULE_SECTIONS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
 
+choice
+	prompt "Virtual Memory System"
+	default RISCV_VM_SV32 if 32BIT
+	default RISCV_VM_SV39 if 64BIT
+	help
+	  The RISC-V Instruction Set Manual Volume II: Privileged
+	  Architecture defines several different "virtual memory
+	  systems" which specify virtual and physical address formats
+	  and the structure of page table entries.  This determines
+	  the amount of virtual address space present and how it is
+	  translated into physical addresses.
+
+	config RISCV_VM_SV32
+	        depends on 32BIT
+		bool "RISC-V Sv32"
+		help
+		  The Sv32 virtual memory system is a page-based
+		  address and page table format for RV32 systems.
+		  It specifies a translation between 32-bit virtual
+		  addresses and 33-bit physical addresses, via a
+		  two-stage page table layout.
+	config RISCV_VM_SV39
+		depends on 64BIT
+		bool "RISC-V Sv39"
+		help
+		  The Sv39 virtual memory system is a page-based
+		  address and page table format for RV64 systems.
+		  It specifies a translation between 39-bit virtual
+		  addresses and 40-bit physical addresses, via a
+		  three-stage page table layout.
+	config RISCV_VM_SV48
+		depends on 64BIT
+		bool "RISC-V Sv48"
+		help
+		  The Sv48 virtual memory system is a page-based
+		  address and page table format for RV64 systems.
+		  It specifies a translation between 48-bit virtual
+		  addresses and 49-bit physical addresses, via a
+		  four-stage page table layout.
+
+endchoice
+
+
 choice
 	prompt "Maximum Physical Memory"
 	default MAXPHYSMEM_2GB if 32BIT
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index b0ab66e5fdb1..86d41a04735b 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -6,6 +6,10 @@
 #ifndef _ASM_RISCV_PGTABLE_32_H
 #define _ASM_RISCV_PGTABLE_32_H
 
+#if !defined(CONFIG_RISCV_VM_SV32)
+#error Only Sv32 supported
+#endif
+
 #include <asm-generic/pgtable-nopmd.h>
 #include <linux/const.h>
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 74630989006d..86935595115d 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -6,6 +6,10 @@
 #ifndef _ASM_RISCV_PGTABLE_64_H
 #define _ASM_RISCV_PGTABLE_64_H
 
+#if !defined(CONFIG_RISCV_VM_SV39)
+#error Only Sv39 supported for now
+#endif
+
 #include <linux/const.h>
 
 #define PGDIR_SHIFT     30
-- 
2.22.0

