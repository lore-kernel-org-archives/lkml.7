Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B6C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E9E206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gwXvG33a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfGaTh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:37:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39015 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfGaTh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:37:29 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so138923556ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vZlexV9rypmA0TkuHP0oW+Ea8mrrAPr769hVW469b0k=;
        b=gwXvG33aEw1oXZFEAK07SvmqUcc+0/Db3uMmvHIqW0DfGZ/HMEargKfv8xNSfMpkWc
         iZpdZGTInx0YDunh3/0d3rxbB1ySNywvvKVchEShDHudGVRRB6DKANw/goNEq9gI1pK9
         f4d8RfQR9a/kTTkM0SjoDNgSvYE/0qaJWqV3qgZVQcOXU6GjYTrLBqcJV6lsgY51h+9o
         GMRY5uBXRpxDmN7TdtHb31CcOrUc0ju7ujZtuXuWKSUUS6rMkayTcqQENCh4Saf/bCum
         Vbk2Pt2xSFaK0hDlZysSsbdGTBEElYMjWysK9D2rrfFMdqxOa9YXY2V+apeOflb1jCSD
         lYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vZlexV9rypmA0TkuHP0oW+Ea8mrrAPr769hVW469b0k=;
        b=scZ2ysNFuRzjIVRc6kwrnm3COWhHjwzZXEDeY6XwXEdK/vD7SA/ddp0b/K7SPcXEbj
         SCdNNvzUXrtVQg3bYG2aZ4GhDQWikUX2cedl+0OQ+Aq602Mxs6pEqJwElsLqSksvEeff
         vuhPKrL3y6HNV8f+x1Pd2CCcRnI1UCmZUK8mdLZ5Fp3F/8pWwktxZpoPWAIFbW29L23P
         jIEHp+ta/TZck+hHO/SL5ZCF1puAOOZdgiil6KuEO+0BcIrP7HosRnObmZT3506xojZy
         PERvE47q+T3QLP3oSXnOqIBRDulzHTCPhwB864QfNHemFHE8OwrhRbxQUZiYv0NDPaIi
         0zVA==
X-Gm-Message-State: APjAAAX4mb1yXnf51RsYe8WkaBuCPJTA0JN0GVZn5llm/QrtcOa/m7al
        z2BhSkIrUufugXWWWc9bU4csJLPhUpI=
X-Google-Smtp-Source: APXvYqxKDvIlwfFgKBVMUpGUKlkeLd1Ku6sAzYKyVOZa36E5yyykqifvS7kuCJDTczfKX4k3OxQBCQ==
X-Received: by 2002:a05:6602:220a:: with SMTP id n10mr6861055ion.205.1564601848102;
        Wed, 31 Jul 2019 12:37:28 -0700 (PDT)
Received: from localhost ([170.10.65.222])
        by smtp.gmail.com with ESMTPSA id t4sm52254723iop.0.2019.07.31.12.37.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 12:37:27 -0700 (PDT)
Date:   Wed, 31 Jul 2019 12:37:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Bin Meng <bmeng.cn@gmail.com>
cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
In-Reply-To: <CAEUhbmUh0rJzFUoA05En9osy+Vv9AP0yOr-bs1goqk7+6SCv2g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1907301218560.3486@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com> <CAEUhbmUh0rJzFUoA05En9osy+Vv9AP0yOr-bs1goqk7+6SCv2g@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2019, Bin Meng wrote:

> The spec does not mention 40-bit physical addresses, but 56-bit.

Thanks, agreed.  Updated patch below


- Paul

From: Paul Walmsley <paul.walmsley@sifive.com>
Date: Fri, 26 Jul 2019 10:21:11 -0700
Subject: [PATCH v2] riscv: kbuild: add virtual memory system selection

The RISC-V specifications currently define three virtual memory
translation systems: Sv32, Sv39, and Sv48.  Sv32 is currently specific
to 32-bit systems; Sv39 and Sv48 are currently specific to 64-bit
systems.  The current kernel only supports Sv32 and Sv39, but we'd
like to start preparing for Sv48.  As an initial step, allow the
virtual memory translation system to be selected via kbuild, and stop
the build if an option is selected that the kernel doen't currently
support.

This second version of the patch fixes some errors in the Kconfig
description text, found by Bin Meng <bmeng.cn@gmail.com>.

This patch currently has no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/riscv/Kconfig                  | 43 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable-32.h |  4 +++
 arch/riscv/include/asm/pgtable-64.h |  4 +++
 3 files changed, 51 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727ecd6c..f5e76e25a91e 100644
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
+		  addresses and 56-bit physical addresses, via a
+		  three-stage page table layout.
+	config RISCV_VM_SV48
+		depends on 64BIT
+		bool "RISC-V Sv48"
+		help
+		  The Sv48 virtual memory system is a page-based
+		  address and page table format for RV64 systems.
+		  It specifies a translation between 48-bit virtual
+		  addresses and 56-bit physical addresses, via a
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

