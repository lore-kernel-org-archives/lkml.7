Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF66E217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CDQ82oc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfG2V6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39690 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfG2V6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so44436071wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KM4b1fSGDoh09saiQEBtFew5NHMkXEVSfNGt1lABt5Q=;
        b=CDQ82oc4TTrn6YwPtcTnNRFTpiYIZ1v8sBNEs61xlcdktbwB7d4qATNaBXpsf0jdX/
         /ck1guG7bKv54Hwm/0qamxui3linbsnBCWlSssOW97DMCfyU2QUEA1nDv6pJ2qj8Whf+
         eafkxvGIG8kxbDWKU313nPDQA/wLEM2u/xxzhEuKsnq+XdErHgD252c384CQoOljQusQ
         fdXVCxAX7/NaQqYkn0Dne81AFvyqTJxGwKzGvWICHcms9IF8HsSbJxmAztMj7wreD0VS
         V8fhwpdUmqQbjWi8v7yvAXEhOfIBT1V3JGE45F+QONL8xtgArCVZreKJa5uL7Dy/Fyjw
         raFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KM4b1fSGDoh09saiQEBtFew5NHMkXEVSfNGt1lABt5Q=;
        b=lfcVj/1W2Dv2YwstvPbXSmU/4tP7Df7aMAgGAdEb1PQtOpgVekZgqfShSIndkVPsKd
         P8zLC9vY03EwnTV4ZwwqMNpv92EYudmSb/C7wCiMc3nIGjcHYb90xlmS60hiPjk5au5U
         95YbOaAtYBdk2XdK53r3t3CsDrrDUIZqx5RykF4T59+MGqWulc3KG+CDA6YS/QsO3btl
         ZHQtLpLvGDbmZMUnR8a1y/VXmg2GsD6iq4lgKJKIvX7ftj2ASJxmKmpI5MHVSedjg3Yu
         tfEvOgJ19UheQuI+LjhOQYrKTY+Z4mPonOQgxXEF6TV6VoufPXvTyBe+WH5tQB14kDLB
         61Kw==
X-Gm-Message-State: APjAAAUElXYczlovOs0do3WC6O61iaaZenK2KZ85qlOGW0P02zcCn/3j
        v6KCVFqCHSOern1vxF5ZuxG2OiCPb1VZqflm6JLn6KEqASrpghUsradfoWTxZYsI/zyqXhAAtAH
        WOrw0YQJzeeA1/7XKWx5Ss+bzdUHS7gaoqNnxQhMHmXcgiIOsqaTQ3yg3Tcqy0SCoIxLevUqvND
        0HOnvlCTBulz25M+R4tXj7xszsJTm8UTkyRF2AIyo=
X-Google-Smtp-Source: APXvYqywjNHWrr8KQAxEncDQc2XgmUYSOT5CDudqi7HxKaVa7UL6/ZF1USsPF/7UVDeNyf/UBfAKhg==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr106406919wmi.80.1564437519011;
        Mon, 29 Jul 2019 14:58:39 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:38 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 28/37] x86/vdso: Enable static branches for the timens vdso
Date:   Mon, 29 Jul 2019 22:57:10 +0100
Message-Id: <20190729215758.28405-29-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

The timens code in vdso looks like this:

if (timens_static_branch_unlikely()) {
       clk_to_ns(clk, ts);
}

This static branch is disabled by default. And the code generated consist
of a single atomic 'no-op' instruction, in the straight-line code path.

Enable static branches in the timens vdso: the 'no-op' instruction
gets replaced with a 'jump' instruction to the out-of-line true branch.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c    | 30 ++++++++++++++++++++++++------
 arch/x86/kernel/jump_label.c | 14 ++++++++++++++
 include/linux/jump_label.h   |  8 ++++++++
 init/Kconfig                 |  1 +
 4 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 91cf5a5c8c9e..1a3eb4656eb6 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -15,6 +15,7 @@
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
 #include <linux/time_namespace.h>
+#include <linux/jump_label.h>
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
@@ -31,20 +32,37 @@
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
 
-void __init init_vdso_image(struct vdso_image *image)
+#ifdef CONFIG_TIME_NS
+static __init void init_timens(struct vdso_image *image)
 {
-	BUG_ON(image->size % PAGE_SIZE != 0);
+	struct vdso_jump_entry *entries;
+	unsigned long entries_nr;
+
+	if (WARN_ON(image->jump_table == -1UL))
+		return;
 
-	apply_alternatives((struct alt_instr *)(image->text + image->alt),
-			   (struct alt_instr *)(image->text + image->alt +
-						image->alt_len));
-#ifdef CONFIG_TIME_NS
 	image->text_timens = vmalloc_32(image->size);
 	if (WARN_ON(image->text_timens == NULL))
 		return;
 
 	memcpy(image->text_timens, image->text, image->size);
+
+	entries = image->text_timens + image->jump_table;
+	entries_nr = image->jump_table_len / sizeof(struct vdso_jump_entry);
+	apply_vdso_jump_labels(entries, entries_nr);
+}
+#else
+static inline void init_timens(struct vdso_image *image) {}
 #endif
+
+void __init init_vdso_image(struct vdso_image *image)
+{
+	BUG_ON(image->size % PAGE_SIZE != 0);
+
+	apply_alternatives((struct alt_instr *)(image->text + image->alt),
+			   (struct alt_instr *)(image->text + image->alt +
+						image->alt_len));
+	init_timens(image);
 }
 
 struct linux_binprm;
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 044053235302..7820ac61b688 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -24,6 +24,20 @@ union jump_code_union {
 	} __attribute__((packed));
 };
 
+__init void apply_vdso_jump_labels(struct vdso_jump_entry *ent, unsigned long nr)
+{
+	while (nr--) {
+		void *code_addr	= (void *)ent + ent->code;
+		union jump_code_union jmp;
+
+		jmp.jump	= 0xe9; /* JMP rel32 */
+		jmp.offset	= ent->target - ent->code - JUMP_LABEL_NOP_SIZE;
+		memcpy(code_addr, &jmp, JUMP_LABEL_NOP_SIZE);
+
+		ent++;
+	}
+}
+
 static void bug_at(unsigned char *ip, int line)
 {
 	/*
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3526c0aee954..bb9d828ee49a 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -125,6 +125,11 @@ struct jump_entry {
 	long key;	// key may be far away from the core kernel under KASLR
 };
 
+struct vdso_jump_entry {
+	u16 code;
+	u16 target;
+};
+
 static inline unsigned long jump_entry_code(const struct jump_entry *entry)
 {
 	return (unsigned long)&entry->code + entry->code;
@@ -229,6 +234,9 @@ extern void static_key_enable(struct static_key *key);
 extern void static_key_disable(struct static_key *key);
 extern void static_key_enable_cpuslocked(struct static_key *key);
 extern void static_key_disable_cpuslocked(struct static_key *key);
+extern void apply_vdso_jump_labels(struct vdso_jump_entry *ent,
+				   unsigned long nr);
+
 
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
diff --git a/init/Kconfig b/init/Kconfig
index 9e40c07da4e1..be8bd41774f6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1072,6 +1072,7 @@ config UTS_NS
 config TIME_NS
 	bool "TIME namespace"
 	depends on ARCH_HAS_VDSO_TIME_NS
+	depends on JUMP_LABEL
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
-- 
2.22.0

