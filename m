Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF4A2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5KQiyKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfDXUeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:34:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33011 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfDXUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:34:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so9882827plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=suc5YIphguybOVTE6QyZmRLNdlVBsBpozTlH+RsbifA=;
        b=R5KQiyKpY4aUSx9teSJh93jt0UeO1AONuuDa9IZDvbiNZCO8R3kVQ5iUT0dLm2O9e5
         lL/MuPn5JfrXxme4DLLRG+j4lP6WAFbmE1Lhz+x3wo9Eh0lAKDGILxcJPTX9+EVcX+/3
         S8zS8fDIjvJiMdAU3kqSh8NMHLUxMyxSKXpbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=suc5YIphguybOVTE6QyZmRLNdlVBsBpozTlH+RsbifA=;
        b=XW0N3Yp0KElfspIoSHY2iVJ+xi6UPeJVW6bpDXZMrhBvu/AWoz6J+ocHRlEt5OkCXu
         UUx7r0VAnKFXAZYJ2GRIcya6nyt43SsGLrIsCJ1MED9iKsRyUUPduyL55DrkdMJsWu1O
         /A4gqXQQGl+QhfigIJgXeARoHRRIqpDu6rSis3IVLx5Qf0/KHH3KnlZzn/gQlTPXR8P0
         YwuwgKlNcymAZdaaMaUHfW+XRzb+HU0/rqj5gfbflLE1ItqucR9Uakl3NiWbMXftopg2
         9GCAckUrPnLRooAf09t9Jt+1djvpbBY7Mj9C/Kyf4w8SnwRUfcJk5qDMzDDtjU7czJCK
         na0w==
X-Gm-Message-State: APjAAAWctL4DIGFs42LY73xS/fSCg3mV0Pyen/TMvUYgC7lXnDAp1Z1y
        jNWhNy8zPDtPByHmql/dmvL/lQ==
X-Google-Smtp-Source: APXvYqxUBKxS6wikJnQuKLXX6a6Z/8pD+GkMvzVv6y2IAqFW8W3uvRYvN4Yye5p83JuELO8tsE35sQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr35147430plb.164.1556138050966;
        Wed, 24 Apr 2019 13:34:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d3sm26389989pfn.113.2019.04.24.13.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 13:34:09 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:34:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hector Marco-Gisbert <hecmargi@upv.es>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] binfmt_elf: Update READ_IMPLIES_EXEC logic for modern CPUs
Message-ID: <20190424203408.GA11386@beast>
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
PT_GNU_STACK marking (under the assumption that toolchains that couldn't
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
always existed and toolchains have implemented PT_GNU_STACK for a while),
and x86 is adjusted to handle this combination of possible outcomes:

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
v2: adjust arm64 to avoid is_compat_task() (marc.w.gonzalez)
---
 arch/arm64/include/asm/elf.h |  8 +++++++-
 arch/x86/include/asm/elf.h   | 24 +++++++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 6adc1a90e7e6..f1bb4b388b8f 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -107,7 +107,13 @@
  */
 #define elf_check_arch(x)		((x)->e_machine == EM_AARCH64)
 
-#define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
+/*
+ * 64-bit processes should not automatically gain READ_IMPLIES_EXEC. Only
+ * 32-bit processes without PT_GNU_STACK should trigger READ_IMPLIES_EXEC
+ * out of an abundance of caution against ancient toolchains not knowing
+ * how to mark memory protection flags correctly.
+ */
+#define compat_elf_read_implies_exec(ex, stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 69c0f892e310..5e65f1dcefc9 100644
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
+	(!(__supported_pte_mask & _PAGE_NX) ||			\
+	 (mmap_is_ia32() && stk == EXSTACK_DEFAULT))
 
 struct task_struct;
 
-- 
2.17.1


-- 
Kees Cook
