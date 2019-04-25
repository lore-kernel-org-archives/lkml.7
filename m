Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943A5C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9252088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="isQnjqPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDYQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42259 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfDYQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so375364eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGf/Shutm6DsnNw4PJ3tmKYvZYHR9JR5yLXnP462NvU=;
        b=isQnjqPEQMNlwE7etx03zY8BY2mf/tMe3scLm2X7hwK8yyvjcnlXA8StSR32aLCDHP
         19lfwZODr436Pi3abr+9XybFb3kc6oKj3sc0r2YWxdXqZqG8AMRBx2uYZhuFoVkEnDZv
         9/KTO9amPcPwY7QBsGxZd1ZEGrKZw8DHL0ep0xVsy9ixSkYyKwPTdgCbiLZK5Z5TPO+H
         p2dcC+AWBuuGxzW+OvSDuh+6zTR3TbIzeUqCekgaz4hc03484me39YCn2T4cSWH48S1/
         VC1fah6Aqyky3WWkppXl7bXfpfvViCTct/wTJ104ZV3S5HqzMXkw6NWO9gMBvvvdSkyf
         DZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGf/Shutm6DsnNw4PJ3tmKYvZYHR9JR5yLXnP462NvU=;
        b=Dfjf7qhwkwSVNk4cw6/FqcVTnqRsMQ1NrexcO8RAq3GhnHkBiJvq8/7PNXCGFd1zUt
         NCTCM8OmzYbJugQCeNl9LWrPm7gQ5MZqbK5AQcha2j/6PhYgwTy1kbsEJrzbeXiQyPea
         FdTqZkyjAQ9W/eSOG8wEuwyrU++9QFb0nFsAv9zTGvDSOZSYnPp6xzwpNeW/xgDvrMuX
         PAQdH+AZo7WQNVx4OQwNtJWzhbTPt4v0EChPvARcPV9qB31KNsQVm/SU0c/be6vktQiL
         CkXl2YsvJSDZbfmHsi8j30dWdDcBSERNX0Al6hThIpW23Gmjih6KLhwuYKL4DBNz2eX9
         075g==
X-Gm-Message-State: APjAAAV6s25gfu9MT7L6lRyUFPNW2EBqnY6vV7VO9b32DgTWHo3mAcEY
        sPjg5eSDgo5hgp0ZiiqdN969U05YnFE=
X-Google-Smtp-Source: APXvYqxansDbHt7cwcr8FfP7YEqKP0gQxfPWDx8wX26+CBfMiT1Rd0HObBnJ8Nr/rGtwSAaBKHindg==
X-Received: by 2002:a17:906:53c3:: with SMTP id p3mr6943127ejo.46.1556208886702;
        Thu, 25 Apr 2019 09:14:46 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:46 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 17/27] vdso: introduce timens_static_branch
Date:   Thu, 25 Apr 2019 17:14:06 +0100
Message-Id: <20190425161416.26600-18-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch introduces timens_static_branch(), which is similar with
static_branch_unlikely.

The timens code in vdso looks like this:

       if (timens_static_branch()) {
               clk_to_ns(clk, ts);
       }

The version of vdso which is compiled from sources will never execute
clk_to_ns(). And then we can patch the 'no-op' in the straight-line
codepath with a 'jump' instruction to the out-of-line true branch and
get the timens version of the vdso library.

While cooking the patch, an alternative approach has being considered:
to omit no-ops - memcpy() the following asm ret sequience on the place of
a function call: https://github.com/0x7f454c46/linux/commit/4cc0180f6d65
Having in mind possible issues with different toolchains, the usual
static_branch() approach was choosen.

Cc: Dmitry Safonov <dima@arista.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vclock_gettime.c  |  9 +++++--
 arch/x86/entry/vdso/vdso-layout.lds.S |  1 +
 arch/x86/entry/vdso/vdso2c.h          | 11 +++++++-
 arch/x86/entry/vdso/vma.c             | 37 ++++++++++++++++++++++-----
 arch/x86/include/asm/jump_label.h     | 14 ++++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 include/linux/jump_label.h            |  5 ++++
 7 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 1d2ba6250255..8929a1285e68 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -18,6 +18,7 @@
 #include <asm/msr.h>
 #include <asm/pvclock.h>
 #include <asm/mshyperv.h>
+#include <asm/jump_label.h>
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
@@ -174,8 +175,10 @@ notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts
 		ts->tv_sec--;
 	}
 }
+#define _timens_static_branch_unlikely timens_static_branch_unlikely
 #else
 notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts) {}
+notrace static __always_inline bool _timens_static_branch_unlikely(void) { return false; }
 #endif
 
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
@@ -204,7 +207,8 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	clk_to_ns(clk, ts);
+	if (_timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 
 	return 0;
 }
@@ -220,7 +224,8 @@ notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
-	clk_to_ns(clk, ts);
+	if (_timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 }
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index ba216527e59f..69dbe4821aa5 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -45,6 +45,7 @@ SECTIONS
 	.gnu.version	: { *(.gnu.version) }
 	.gnu.version_d	: { *(.gnu.version_d) }
 	.gnu.version_r	: { *(.gnu.version_r) }
+	__jump_table	: { *(__jump_table) }	:text
 
 	.dynamic	: { *(.dynamic) }		:text	:dynamic
 
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 660f725a02c1..e4eef5e1c6ac 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -16,7 +16,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned int i, syms_nr;
 	unsigned long j;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
-		*alt_sec = NULL;
+		*alt_sec = NULL, *jump_table_sec = NULL;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
 	const char *secstrings;
 	INT_BITS syms[NSYMS] = {};
@@ -78,6 +78,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
 			    ".altinstructions"))
 			alt_sec = sh;
+		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
+			    "__jump_table"))
+			jump_table_sec  = sh;
 	}
 
 	if (!symtab_hdr)
@@ -165,6 +168,12 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		fprintf(outfile, "\t.alt_len = %lu,\n",
 			(unsigned long)GET_LE(&alt_sec->sh_size));
 	}
+	if (jump_table_sec) {
+		fprintf(outfile, "\t.jump_table = %lu,\n",
+			(unsigned long)GET_LE(&jump_table_sec->sh_offset));
+		fprintf(outfile, "\t.jump_table_len = %lu,\n",
+			(unsigned long)GET_LE(&jump_table_sec->sh_size));
+	}
 	for (i = 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 28628950214d..b9f15647e3a1 100644
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
@@ -31,20 +32,44 @@
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
 
-void __init init_vdso_image(struct vdso_image *image)
+#ifdef CONFIG_TIME_NS
+static __init void apply_jump_tables(struct vdso_jump_entry *ent, unsigned long nr)
 {
-	BUG_ON(image->size % PAGE_SIZE != 0);
+	while (nr--) {
+		void *code_addr	= (void *)ent + ent->code;
+		long target_addr = (long) ent->target - (ent->code + JUMP_LABEL_NOP_SIZE);
+		((char *)code_addr)[0] = 0xe9; /* JMP rel32 */
+		*((long *)(code_addr + 1)) = (long)target_addr;
+
+		ent++;
+	}
+}
+
+static __init void init_timens(struct vdso_image *image)
+{
+	struct vdso_jump_entry *entries;
 
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
+	apply_jump_tables(entries, image->jump_table_len / sizeof(struct vdso_jump_entry));
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
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 65191ce8e1cf..1784aa49cc82 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -51,6 +51,20 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
+static __always_inline bool timens_static_branch_unlikely(void)
+{
+	asm_volatile_goto("1:\n\t"
+		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 "2: .word 1b - 2b, %l[l_yes] - 2b\n\t"
+		 ".popsection\n\t"
+		 : :  :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 583133446874..883151c3a032 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -16,6 +16,7 @@ struct vdso_image {
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
+	unsigned long jump_table, jump_table_len;
 
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3e113a1fa0f1..69854a05d2f2 100644
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
-- 
2.21.0

