Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA19C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CF6217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kRhipY3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfDWSMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:12:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38852 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDWSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:12:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so7893001pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iQaTskhF6JjLMWEw5W+1Do9KKSLCJ8elWvLEKowTXV4=;
        b=kRhipY3UZwc9rz5bMuokumNv1HTIF0IlHukWPJp+QBwJxXU2gsz+L/ydaFbl98PReA
         7F4ASBIUnn0XdGTgcuaabrBmGGTebpJVIfPSyfz87dDq6SFPHF1M55xyfW9kNwahsg+U
         BrUQI+TdhetqSQ1HIpGkpMkd1AB/VLShupllA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iQaTskhF6JjLMWEw5W+1Do9KKSLCJ8elWvLEKowTXV4=;
        b=ptZ1GTrq2tLjrQlBKr9bOAMt+ngm1KwWYJCP28KYnO7b85U9E4v+Z2LwbJC4TwomoF
         PYO3r44k0f8Gf78ezizJf1Ov3uUsUwMaX5YKvyQdq0y32Y2jED+uGOD8A+FdwNgRmNs8
         QHKbjauURl65rSV0Xf2eKZ4wKqc+MkKXlqMQABAUSvPV3oLRqlSoio1ddtw0B1QZb4Xd
         JvfWNXtF66Dip1+DKGGiycbp9+51O5lRnj6Aj79M1M6XYjjU4LTlGS61WWyAYTfnMYeq
         pFjj/406wGVXt0pcYFYB4fPT8q3ouaX+br6EmuvLpkx8qcts9B0SI6IzGFEnluwTxEeM
         XgyQ==
X-Gm-Message-State: APjAAAUo7KCLcZ+KRmCn3YDunZNia2SxZV3f9dr2jb12wdVTZ+tKwHY6
        iiCIL71D4k6W/wKN59XK5K1Mqw==
X-Google-Smtp-Source: APXvYqz+Wl8zgwpGbBimCpQBQ9iX0uqtiSfQGROAG3ZfN/J7JhymD7vEcpy0QuMf3DyuHmdwF6SQ3g==
X-Received: by 2002:a63:4b21:: with SMTP id y33mr26698232pga.37.1556043132959;
        Tue, 23 Apr 2019 11:12:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id i15sm23203740pfd.162.2019.04.23.11.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 11:12:11 -0700 (PDT)
Date:   Tue, 23 Apr 2019 11:12:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern CPUs
Message-ID: <20190423181210.GA2443@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The READ_IMPLIES_EXEC work-around was designed for old CPUs lacking NX
(to have the visible permission flags on memory regions reflect reality:
they are all executable), and for old toolchains that lacked the ELF
PT_GNU_STACK marking (under the assumption than toolchains that couldn't
even specify memory protection flags may have it wrong for all memory
regions).

This logic is sensible, but was implemented in a way that equated having
a PT_GNU_STACK marked executable as being as "broken" as lacking the
PT_GNU_STACK marking entirely. This is not a reasonable assumption
for CPUs that have had NX support from the start (or very close to
the start). This confusion has led to situations where modern 64-bit
programs with explicitly marked executable stack are forced into the
READ_IMPLIES_EXEC state when no such thing is needed. (And leads to
unexpected failures when mmap()ing regions of device driver memory that
wish to disallow VM_EXEC[1].)

To fix this, elf_read_implies_exec() is adjusted on arm64 (where NX has
always existed and all toolchains include PT_GNU_STACK), and x86 is
adjusted to handle this combination of possible outcomes:

              CPU: | lacks NX  | has NX, ia32     | has NX, x86_64   |
 ELF:              |           |                  |                  |
 ------------------------------|------------------|------------------|
 missing GNU_STACK | needs RIE | needs RIE        | no RIE           |
 GNU_STACK == RWX  | needs RIE | no RIE: stack X  | no RIE: stack X  |
 GNU_STACK == RW   | needs RIE | no RIE: stack NX | no RIE: stack NX |

This has the effect of making binfmt_elf's EXSTACK_DEFAULT actually take
on the correct architecture default of being non-executable on arm64 and
x86_64, and being executable on ia32.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/elf.h |  9 ++++++++-
 arch/x86/include/asm/elf.h   | 24 +++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 6adc1a90e7e6..7fbd295a76d2 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -107,7 +107,14 @@
  */
 #define elf_check_arch(x)		((x)->e_machine == EM_AARCH64)
 
-#define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
+/*
+ * 64-bit processes should not automatically gain READ_IMPLIES_EXEC. Only
+ * 32-bit processes without PT_GNU_STACK should trigger READ_IMPLIES_EXEC
+ * out of an abundance of caution against ancient toolchains not knowing
+ * how to mark memory protection flags correctly.
+ */
+#define elf_read_implies_exec(ex, stk)			\
+	(is_compat_task() && stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 69c0f892e310..87d9cf7643b4 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -280,10 +280,28 @@ extern u32 elf_hwcap2;
 
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
- * have the READ_IMPLIES_EXEC personality flag set automatically.
+ * have the READ_IMPLIES_EXEC personality flag set automatically. This
+ * is needed either to show the truth about a memory mapping (i.e. CPUs
+ * that lack NX have all memory implicitly executable, so this makes
+ * sure that the visible permissions reflect reality), or to deal with
+ * old toolchains on new CPUs. Old binaries entirely lacking a GNU_STACK
+ * indicate they were likely built with a toolchain that has no idea about
+ * memory permissions, and so we must default to the lowest reasonable
+ * common denominator for the architecture: on ia32 we assume all memory
+ * to be executable by default, and on x86_64 we assume all memory to be
+ * non-executable by default.
+ *
+ *              CPU: | lacks NX  | has NX, ia32     | has NX, x86_64   |
+ * ELF:              |           |                  |                  |
+ * ------------------------------|------------------|------------------|
+ * missing GNU_STACK | needs RIE | needs RIE        | no RIE           |
+ * GNU_STACK == RWX  | needs RIE | no RIE: stack X  | no RIE: stack X  |
+ * GNU_STACK == RW   | needs RIE | no RIE: stack NX | no RIE: stack NX |
+ *
  */
-#define elf_read_implies_exec(ex, executable_stack)	\
-	(executable_stack != EXSTACK_DISABLE_X)
+#define elf_read_implies_exec(ex, stk)				\
+	(!(__supported_pte_mask & _PAGE_NX) ? 1 :		\
+		(mmap_is_ia32() && stk == EXSTACK_DEFAULT))
 
 struct task_struct;
 
-- 
2.17.1


-- 
Kees Cook
