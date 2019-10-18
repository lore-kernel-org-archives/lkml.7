Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FCBCA9EA5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4E0222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UYH865nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504998AbfJRII6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:08:58 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33161 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504981AbfJRII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:08:56 -0400
Received: by mail-il1-f195.google.com with SMTP id v2so4742795ilm.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSBcDIKx5nYgnvY0E6Lcwtwu4qqsxuq/VRdIo5y+2Cg=;
        b=UYH865ncXlKhaR/ruHoaa2j5syS/lseyRuqhuEhLj5/69PK7JaW0oh8UpKzb/YJo53
         MteWuPrAiD6AhSp7Aax50FcMDGjpjzl/NDMbni9cBk6cdG7vronHFfvQcI8SWhGHCtt4
         4N8UDH6QdyWc0ciGW1+12iM+2BvwEeHXHXvhzSmCiXQY0mJMOIF4gNQEMf8XjgVQgxrH
         D5aK+hOzRVfDTbusI617sI+EeQZG4m2KuCcjeuG8uayegjuDC3phM47GxQGhZuVL3bZX
         w8Z6vZ9+VIRBn9Erp572wwfEkS3C5ikie31Ll8tw1iFbAmJJbDLb5hm7Fre/Wdd1oVqG
         erYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSBcDIKx5nYgnvY0E6Lcwtwu4qqsxuq/VRdIo5y+2Cg=;
        b=jG4ACDNMcAlOwipbnqRzaN8iqn0jRpn4zLQZWRAN2y59jWHR8AMVFb4o/aeGuzDDsP
         aRZDLUGQrSxa5u5xza0EfRN4DXSSn6M7lBaCKhOpVt3w30goo9jNmBUvIvcwBfKc393n
         s8GXkv9vRKAcI58WkQm/ylEIC9YVo7zKOIRu6Q1SlM0CW6zDd06XyaUEAxVlZ4shz21d
         bl+CKvc+RAWuAtFK5cKLmLbEbLBKK8hs7a3Rpu0HnvaVAPA7XnOktTFog1OAv/1hNm8Y
         Q/J4ok1jTjL6Syb7CS/pIYLFwhfseIProQ/VvYFGHcE5RCLsfJokCxv6gTFk4NqwTEwb
         YT6Q==
X-Gm-Message-State: APjAAAXt1njTuo8NYndBnyemG3Fpl5+G7TznidlnzRGgJINpWm3nCdbb
        L8lLIkTGqOl9RhGY7JeWZPv6yw==
X-Google-Smtp-Source: APXvYqzKI2kk5lHMs0yEtKm+xbMxG2eju3cK4Gef8i8iQDD25JUnHl+bMAFlMgwk9ylcXNg+trIVzQ==
X-Received: by 2002:a92:5a9b:: with SMTP id b27mr8731380ilg.180.1571386135351;
        Fri, 18 Oct 2019 01:08:55 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:08:54 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] riscv: add missing prototypes
Date:   Fri, 18 Oct 2019 01:08:37 -0700
Message-Id: <20191018080841.26712-5-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018080841.26712-1-paul.walmsley@sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse identifies these missing prototypes when building arch/riscv:

arch/riscv/kernel/cpu.c:149:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?
arch/riscv/kernel/irq.c:27:29: warning: symbol 'do_IRQ' was not declared. Should it be static?
arch/riscv/kernel/irq.c:57:13: warning: symbol 'init_IRQ' was not declared. Should it be static?
arch/riscv/kernel/syscall_table.c:15:6: warning: symbol 'sys_call_table' was not declared. Should it be static?
arch/riscv/kernel/time.c:15:13: warning: symbol 'time_init' was not declared. Should it be static?
arch/riscv/kernel/smpboot.c:135:24: warning: symbol 'smp_callin' was not declared. Should it be static?
arch/riscv/kernel/smp.c:72:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
arch/riscv/mm/init.c:151:7: warning: symbol 'trampoline_pg_dir' was not declared. Should it be static?
arch/riscv/mm/init.c:157:7: warning: symbol 'early_pg_dir' was not declared. Should it be static?
arch/riscv/kernel/process.c:32:6: warning: symbol 'show_regs' was not declared. Should it be static?

Fix by adding the missing prototypes to the appropriate header files.

This change should have no functional impact.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/include/asm/irq.h       | 3 +++
 arch/riscv/include/asm/pgtable.h   | 2 ++
 arch/riscv/include/asm/processor.h | 4 ++++
 arch/riscv/include/asm/ptrace.h    | 2 ++
 arch/riscv/include/asm/smp.h       | 2 ++
 5 files changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 75576424c0f7..589e2d9fb2a6 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,9 @@
 void riscv_timer_interrupt(void);
 void riscv_software_interrupt(void);
 
+asmlinkage void do_IRQ(struct pt_regs *regs);
+void __init init_IRQ(void);
+
 #include <asm-generic/irq.h>
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 42292d99cc74..7fc5e4a56715 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -61,6 +61,8 @@
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
+extern pgd_t trampoline_pg_dir[];
+extern pgd_t early_pg_dir[];
 extern pgd_t swapper_pg_dir[];
 
 /* MAP_PRIVATE permissions: xwr (copy-on-write) */
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f539149d04c2..ab56435de629 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -78,6 +78,10 @@ int riscv_of_processor_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
+extern const struct seq_operations cpuinfo_op;
+
+void time_init(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index d48d1e13973c..c851c095b674 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -101,6 +101,8 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->a0;
 }
 
+void show_regs(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a83451d73a4e..d19dd2e2e1da 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,6 +15,8 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
+asmlinkage void __init smp_callin(void);
+
 #ifdef CONFIG_SMP
 /*
  * Mapping between linux logical cpu index and hartid.
-- 
2.23.0

