Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD73206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHYjY8VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbfC0TVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:21:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44496 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731942AbfC0SG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so3681265pll.11;
        Wed, 27 Mar 2019 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/YXZOeivVuhwK3RtnoyXerm+U79Z9AKGovazBbAWY/I=;
        b=lHYjY8VHIvQxqfgXogtUg3hyD1kR4bw0lK8I24vERbXGWQY2apvRcS+UbSBU7yyZlc
         ue9X6frVb/kEeVRO+z2n+toM8b+zQ43In1JbON89U7huZIfMj8oQ6JwNog8OAZNYGvhD
         M2+ff2ZbnIXT/ay+knEFRm/AC45Pn4eilMmmXnPJHwDyCBrdWzkvqf/0gkqt+lg0tZZp
         19czQ+ZVakq2BgnCA4UgEB0yl+umGI0EriDe0olRHx2gWv77m1FPhTTUyKvSHjWSYCIs
         UNwIOnmlZ3ouT+nTHUsRCaF8Pio/rGcpaPRvrmFXshSZFrGStq/jLjCNBSkV9mFT3hqh
         Nl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/YXZOeivVuhwK3RtnoyXerm+U79Z9AKGovazBbAWY/I=;
        b=jk/X9Z2FaTJVOmkvMa2JZRQ9285Ov3Uzs6ziVdBuK0NGXjlWk2Cr1SmDQpyYXPt2nk
         HFCK8tm9i7i/VscERxFqF4pG3KCIp5hW7mZOg+BslGa90HvMXrzFNoclwTGweGI04Ab1
         kPf3MU9v/fVl3xtwWiEkjFG3uqDig/5qDSMZfct1est5IFzv9sENaMZH9hiefRIj3RIo
         JRKM9x9y0rAnl8YBZhBfEEetK9jXZ8qRP+AqjG5W5PiEYFIWZfsNGxrembYRUWR/wbPX
         kBC6Sv2PotveKjvPvllxf+FhXjGygpgsaz4LbBVNp2s+svIti+0ysseoMPynKiHRXWTp
         6tpQ==
X-Gm-Message-State: APjAAAU2AWrgKIbzq5Q02+RSmmE2+69jJwT2FgDiXIi9YFWntRPh7Vaj
        UG749xIAzGGNgDIFZ7oTWJI=
X-Google-Smtp-Source: APXvYqxhdLQbtwUdT5Ixf1l1FtLD56yIyPZWRDk9bSHu8mJrUkFlSkWJQtC6NGR6cCSRx2dY3WcEnw==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr38099794pla.132.1553710018486;
        Wed, 27 Mar 2019 11:06:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:0:1008:fd00:ed8e:8493:d2b7:8f54])
        by smtp.gmail.com with ESMTPSA id o5sm49686052pgc.16.2019.03.27.11.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 11:06:57 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH RFC] vdso: introduce timens_static_branch
Date:   Wed, 27 Mar 2019 11:06:51 -0700
Message-Id: <20190327180651.14495-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190327175957.GA9309@gmail.com>
References: <20190327175957.GA9309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Dmitry Safonov <dima@arista.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/x86/entry/vdso/vclock_gettime.c  | 21 ++++++++++++++-------
 arch/x86/entry/vdso/vdso-layout.lds.S |  1 +
 arch/x86/entry/vdso/vdso2c.h          | 11 ++++++++++-
 arch/x86/entry/vdso/vma.c             | 19 +++++++++++++++++++
 arch/x86/include/asm/jump_label.h     | 14 ++++++++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 include/linux/jump_label.h            |  5 +++++
 7 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index cb55bd994497..74de42f1f7d8 100644
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
@@ -39,7 +40,7 @@ extern u8 hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
-#ifdef BUILD_VDSO_TIME_NS
+#ifdef CONFIG_TIME_NS
 extern u8 timens_page
 	__attribute__((visibility("hidden")));
 #endif
@@ -145,9 +146,9 @@ notrace static inline u64 vgetcyc(int mode)
 	return U64_MAX;
 }
 
+#ifdef CONFIG_TIME_NS
 notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts)
 {
-#ifdef BUILD_VDSO_TIME_NS
 	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
 	struct timespec64 *offset64;
 
@@ -173,9 +174,12 @@ notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts
 		ts->tv_nsec += NSEC_PER_SEC;
 		ts->tv_sec--;
 	}
-
-#endif
 }
+#define _timens_static_branch_unlikely timens_static_branch_unlikely
+#else
+notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts) {}
+notrace static __always_inline bool _timens_static_branch_unlikely(void) { return false; }
+#endif
 
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
 {
@@ -203,8 +207,9 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	clk_to_ns(clk, ts);
-
+	if (_timens_static_branch_unlikely()) {
+		clk_to_ns(clk, ts);
+	}
 	return 0;
 }
 
@@ -219,7 +224,9 @@ notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
-	clk_to_ns(clk, ts);
+	if (_timens_static_branch_unlikely()) {
+		clk_to_ns(clk, ts);
+	}
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
index 0b8d9f6f0ce3..5c0e6491aefb 100644
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
@@ -38,6 +39,22 @@ static __init int vdso_setup(char *s)
 __setup("vdso=", vdso_setup);
 #endif
 
+#ifdef CONFIG_TIME_NS
+static __init int apply_jump_tables(struct vdso_jump_entry *ent, unsigned long nr)
+{
+	while (nr--) {
+		void *code_addr	= (void *)ent + ent->code;
+		long target_addr = (long) ent->target - (ent->code + JUMP_LABEL_NOP_SIZE);
+		((char *)code_addr)[0] = 0xe9; /* JMP rel32 */
+		*((long *)(code_addr + 1)) = (long)target_addr;
+
+		ent++;
+	}
+
+	return 0;
+}
+#endif
+
 void __init init_vdso_image(struct vdso_image *image)
 {
 	BUG_ON(image->size % PAGE_SIZE != 0);
@@ -51,6 +68,8 @@ void __init init_vdso_image(struct vdso_image *image)
 		return;
 
 	memcpy(image->text_timens, image->text, image->size);
+	apply_jump_tables((struct vdso_jump_entry *)(image->text_timens + image->jump_table),
+			image->jump_table_len / sizeof(struct vdso_jump_entry));
 #endif
 }
 
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
2.20.1

