Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BF3C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396652075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568293036;
	bh=r5GVYW7sznRndo6LvdGdHPtWeZUYInADpSQT93bmaIM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zYGqS4PEBygY/oS2PHJTOkgli1WJpxzlPiqcuv35oNWkOLenVjXfRB4xnLLhtqc2+
	 4I0S7DbJSTS7X6GZDxOVwx4cie7QgFau51X9oH9arToQ3+AOeB2AvYgja/Jkx0uQxX
	 MXJeHsNn+Zqjk8HP9JCNknRXb1uOHH9/8oAT3ELI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfILM5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:57:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33815 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfILM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:57:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so18583769wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o5x4LczZh/4WpNcF/HWMsfZg/GCL//ccIzviDyHT0iU=;
        b=e/n28xkzlQFDtsGCE+RqPLrYDP/BPF5hSAs21UloH+gTE1lO+u95IbbgQR1UjtxjBP
         fRdG6SMutf8lFQdzvALS2/UGMkok4RB6GTpFOZlHKIPPcnpEHDAc+uzhf2t81OMM6B4z
         jGw8g88LExeI17MvyLJKFcO5N3R4yADqJgcuRZugV4tvsrwridwm4WWqCTdUQepKAkSr
         ++NYF7+95iE7CTvBsJXqYMxoVrdNLKIqP+SOwhrHq6e7fdevl2LSWr/sUazf76plrnvu
         OiZbef55JGYHc6T8kv4Xj1nDe7cDxXqgej3g88P9sepfXhMhVKdsB+Wy+CodXIusUxQ9
         5B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=o5x4LczZh/4WpNcF/HWMsfZg/GCL//ccIzviDyHT0iU=;
        b=nQfzxvyG5GBzTsOKdPrm1HRDYvPWieHHqxPTPbwweBxxCy7+IyDw0hDquHa81TWbUf
         p95rSU1amp0nP1O64HnxpG63Wj29uPLCvuim85WhgAmevIEW3pwKEMpGPRP6SBqrGsmQ
         InKp/fVgN5vrkzK0RSSoKUmqg4MjDaXscD0kTFZgZKaVqp4xD8qR6lbbs07ChbUa5wQa
         eO701Kj27yhrOA7VB8CpEWo83bvGRJYnAfmOc+ZrKuOTGNvqQz39ySZ2d6Qr1oOR5FvB
         cpSbSmnwDNa3LCoCfpqktIKgkSCMBMp6jnI9bQKAzWASzOUwbHpTyQXPLpBAt4r8IFLm
         1jIg==
X-Gm-Message-State: APjAAAXjUY0vgfAuZsatKixWvKMn1QYt+WuL9p7IdN2Ue3MkjhbWPtsI
        CVpr1bNgWNUZcKk8tMELIPI=
X-Google-Smtp-Source: APXvYqwYLqA2OtGGqmTkXwb+0El9qZfVH0UQen058sAMI37IHwMiylv+sIvqGZN5o73WEbtOQ4qx4A==
X-Received: by 2002:adf:e908:: with SMTP id f8mr34410528wrm.210.1568293032610;
        Thu, 12 Sep 2019 05:57:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v8sm38823927wra.79.2019.09.12.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 05:57:12 -0700 (PDT)
Date:   Thu, 12 Sep 2019 14:57:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190912125710.GA21080@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: afa8b475c1aec185a8e106c48b3832e0b88bc2de x86/timer: Force PIT initialization when !X86_FEATURE_ARAT

A KVM guest fix, and a kdump kernel relocation errors fix.

 Thanks,

	Ingo

------------------>
Jan Stancek (1):
      x86/timer: Force PIT initialization when !X86_FEATURE_ARAT

Steve Wahl (1):
      x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors


 arch/x86/kernel/apic/apic.c |  4 ++++
 arch/x86/purgatory/Makefile | 35 +++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index dba2828b779a..f91b3ff9dc03 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -834,6 +834,10 @@ bool __init apic_needs_pit(void)
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return true;
 
+	/* Virt guests may lack ARAT, but still have DEADLINE */
+	if (!boot_cpu_has(X86_FEATURE_ARAT))
+		return true;
+
 	/* Deadline timer is based on TSC so no further PIT action required */
 	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
 		return false;
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 8901a1f89cf5..10fb42da0007 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -18,37 +18,40 @@ targets += purgatory.ro
 KASAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
 
+# These are adjustments to the compiler flags used for objects that
+# make up the standalone purgatory.ro
+
+PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
+PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
 # sure how to relocate those.
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_sha256.o		+= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_purgatory.o	+= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_string.o		+= $(CC_FLAGS_FTRACE)
-CFLAGS_REMOVE_kexec-purgatory.o	+= $(CC_FLAGS_FTRACE)
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_FTRACE)
 endif
 
 ifdef CONFIG_STACKPROTECTOR
-CFLAGS_REMOVE_sha256.o		+= -fstack-protector
-CFLAGS_REMOVE_purgatory.o	+= -fstack-protector
-CFLAGS_REMOVE_string.o		+= -fstack-protector
-CFLAGS_REMOVE_kexec-purgatory.o	+= -fstack-protector
+PURGATORY_CFLAGS_REMOVE		+= -fstack-protector
 endif
 
 ifdef CONFIG_STACKPROTECTOR_STRONG
-CFLAGS_REMOVE_sha256.o		+= -fstack-protector-strong
-CFLAGS_REMOVE_purgatory.o	+= -fstack-protector-strong
-CFLAGS_REMOVE_string.o		+= -fstack-protector-strong
-CFLAGS_REMOVE_kexec-purgatory.o	+= -fstack-protector-strong
+PURGATORY_CFLAGS_REMOVE		+= -fstack-protector-strong
 endif
 
 ifdef CONFIG_RETPOLINE
-CFLAGS_REMOVE_sha256.o		+= $(RETPOLINE_CFLAGS)
-CFLAGS_REMOVE_purgatory.o	+= $(RETPOLINE_CFLAGS)
-CFLAGS_REMOVE_string.o		+= $(RETPOLINE_CFLAGS)
-CFLAGS_REMOVE_kexec-purgatory.o	+= $(RETPOLINE_CFLAGS)
+PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
+CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
+
+CFLAGS_REMOVE_sha256.o		+= $(PURGATORY_CFLAGS_REMOVE)
+CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
+
+CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
+CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
+
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
