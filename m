Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6A1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995E6218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKq3ulYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfGVU1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:27:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732467AbfGVU1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:27:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so36421132wmj.3;
        Mon, 22 Jul 2019 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EtB/DTm1uD1Rg5+zm/eSP0XMOL8UCk05lIAwopsyDqA=;
        b=CKq3ulYO+MEWXTte0ER8EmkP38GBqgAl/VpxL2p+IdNUGPDb/gXSpN0SZRXC77cl7u
         AbLQIWiyD2bgEwYTC42wKlecHcvi7RvwzHJKDRP0MgwYpPeNOkSLFPmUdLsRjwZ/+OYl
         hC5Tq2li9pN+eGxZ5GSzHhCQw+y2KNgpZgrq86DsySEjN90pFsMV+StWT0EKdsCWRhfy
         VxVSBzX64Z9/BqSyV1m416ovWyIwlNw+aKhjJcE920UcI5thI6yYG7GELMnqk4pGfdFW
         UhEyDcuuQkqg66Ax/MbCo5PLvLcZ582pfFgXaRVXgwklddFYYydeVVimkFG6c+Ng9IL9
         iWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EtB/DTm1uD1Rg5+zm/eSP0XMOL8UCk05lIAwopsyDqA=;
        b=jmn+QfLOESLTF8r0qL/QpzcFA3F4SOIL3qfdWHHsdHKBLQwNmuLwSJiLhqsOuR8Ws8
         89U9wHv9ULfxeL2Mr+4jfeV3bB7EV7uYKhkB2+KB69n+TSRlSe/4+ePN1NGwH/FenPzE
         F0fOlSLA1OrQWO949/uTk8yhnQ1n4K0Dk4hBn/R1HCr5Uy/6oiZ4wCJU+bm8FF/e5kj6
         Bp61rGXb3AyuyqmCDK5sFv6/WqI80oIrO7O9vlwW2HaShFRvy80rDODVbBVmNjXfsH9j
         l42JYqSZIFSZ+3a81rCBRbZDhiZBCpSDrhkGJ0Gzagk6gkp+9hRCQlhKQlXEb4incH6b
         Gjqw==
X-Gm-Message-State: APjAAAWLlDDAQydEeqPM/S6RmkJHMFMry3S8JCLTtnq7zin2Z1SLmvIH
        pU8oJuDM2bllPwn8aAfIFA==
X-Google-Smtp-Source: APXvYqzYm93d4oBepMPOMBNBV5rCzSEHDsUHRuhIfTV44A2tZfCQJvG0gRdvQkrgF2m8nm41aYq+qw==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr67629301wmi.42.1563827261388;
        Mon, 22 Jul 2019 13:27:41 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.254])
        by smtp.gmail.com with ESMTPSA id f1sm28028413wml.28.2019.07.22.13.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 13:27:40 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, adobriyan@gmail.com,
        linux-kbuild@vger.kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net
Subject: [PATCH 5/5] x86_64, -march=native: MOVBE support
Date:   Mon, 22 Jul 2019 23:27:23 +0300
Message-Id: <20190722202723.13408-5-adobriyan@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722202723.13408-1-adobriyan@gmail.com>
References: <20190722202723.13408-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MOVBE if it is available.

Internally MOVBE probably translates to MOV+BSWAP anyway, but who knows.

Do it because it is easy to do...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/x86/crypto/des3_ede-asm_64.S | 28 ++++++++++++++++++++++++++++
 arch/x86/kernel/verify_cpu.S      |  7 +++++++
 scripts/kconfig/cpuid.c           |  5 +++++
 scripts/march-native.sh           |  1 +
 4 files changed, 41 insertions(+)

diff --git a/arch/x86/crypto/des3_ede-asm_64.S b/arch/x86/crypto/des3_ede-asm_64.S
index 7fca43099a5f..2fd310e98b0b 100644
--- a/arch/x86/crypto/des3_ede-asm_64.S
+++ b/arch/x86/crypto/des3_ede-asm_64.S
@@ -150,6 +150,15 @@
 
 #define dummy2(a, b) /*_*/
 
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+#define read_block(io, left, right) \
+	movbe	 (io), left##d; \
+	movbe	4(io), right##d;
+
+#define write_block(io, left, right) \
+	movbe	left##d,   (io); \
+	movbe	right##d, 4(io);
+#else
 #define read_block(io, left, right) \
 	movl    (io), left##d; \
 	movl   4(io), right##d; \
@@ -161,6 +170,7 @@
 	bswapl right##d; \
 	movl   left##d,   (io); \
 	movl   right##d, 4(io);
+#endif
 
 ENTRY(des3_ede_x86_64_crypt_blk)
 	/* input:
@@ -434,6 +444,14 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	pushq %rsi /* dst */
 
 	/* load input */
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe 0 * 4(%rdx), RL0d;
+	movbe 1 * 4(%rdx), RR0d;
+	movbe 2 * 4(%rdx), RL1d;
+	movbe 3 * 4(%rdx), RR1d;
+	movbe 4 * 4(%rdx), RL2d;
+	movbe 5 * 4(%rdx), RR2d;
+#else
 	movl 0 * 4(%rdx), RL0d;
 	movl 1 * 4(%rdx), RR0d;
 	movl 2 * 4(%rdx), RL1d;
@@ -447,6 +465,7 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	bswapl RR1d;
 	bswapl RL2d;
 	bswapl RR2d;
+#endif
 
 	initial_permutation3(RL, RR);
 
@@ -507,6 +526,14 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 
 	final_permutation3(RR, RL);
 
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	movbe RR0d, 0 * 4(%rsi);
+	movbe RL0d, 1 * 4(%rsi);
+	movbe RR1d, 2 * 4(%rsi);
+	movbe RL1d, 3 * 4(%rsi);
+	movbe RR2d, 4 * 4(%rsi);
+	movbe RL2d, 5 * 4(%rsi);
+#else
 	bswapl RR0d;
 	bswapl RL0d;
 	bswapl RR1d;
@@ -521,6 +548,7 @@ ENTRY(des3_ede_x86_64_crypt_blk_3way)
 	movl RL1d, 3 * 4(%rsi);
 	movl RR2d, 4 * 4(%rsi);
 	movl RL2d, 5 * 4(%rsi);
+#endif
 
 	popq %r15;
 	popq %r14;
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index d3f3370e7dab..f8ff130edfb3 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -142,6 +142,13 @@ ENTRY(verify_cpu)
 	jnc	.Lverify_cpu_no_longmode
 #endif
 
+#ifdef CONFIG_MARCH_NATIVE_MOVBE
+	mov	$1, %eax
+	cpuid
+	bt	$22, %ecx
+	jnc	.Lverify_cpu_no_longmode
+#endif
+
 #if defined(CONFIG_MARCH_NATIVE_REP_MOVSB) || defined(CONFIG_MARCH_NATIVE_REP_STOSB)
 	xor	%eax, %eax
 	cpuid
diff --git a/scripts/kconfig/cpuid.c b/scripts/kconfig/cpuid.c
index 58d09bda61e5..0da1142a59da 100644
--- a/scripts/kconfig/cpuid.c
+++ b/scripts/kconfig/cpuid.c
@@ -43,6 +43,7 @@ static inline void cpuid2(uint32_t eax0, uint32_t ecx0, uint32_t *eax, uint32_t
 	);
 }
 
+static bool movbe	= false;
 static bool popcnt	= false;
 static bool rep_movsb	= false;
 static bool rep_stosb	= false;
@@ -57,6 +58,9 @@ static void intel(void)
 		cpuid(1, &eax, &ecx, &edx, &ebx);
 //		printf("%08x %08x %08x %08x\n", eax, ecx, edx, ebx);
 
+		if (ecx & (1 << 22)) {
+			movbe = true;
+		}
 		if (ecx & (1 << 23)) {
 			popcnt = true;
 		}
@@ -89,6 +93,7 @@ int main(int argc, char *argv[])
 	}
 
 #define _(x)	if (streq(opt, #x)) return x ? EXIT_SUCCESS : EXIT_FAILURE
+	_(movbe);
 	_(popcnt);
 	_(rep_movsb);
 	_(rep_stosb);
diff --git a/scripts/march-native.sh b/scripts/march-native.sh
index a41a15a64df4..530bac22fa07 100755
--- a/scripts/march-native.sh
+++ b/scripts/march-native.sh
@@ -41,6 +41,7 @@ COLLECT_GCC_OPTIONS=$(
 )
 echo "-march=native: $COLLECT_GCC_OPTIONS"
 
+"$CPUID" movbe		&& option "CONFIG_MARCH_NATIVE_MOVBE"
 "$CPUID" popcnt		&& option "CONFIG_MARCH_NATIVE_POPCNT"
 "$CPUID" rep_movsb	&& option "CONFIG_MARCH_NATIVE_REP_MOVSB"
 "$CPUID" rep_stosb	&& option "CONFIG_MARCH_NATIVE_REP_STOSB"
-- 
2.21.0

