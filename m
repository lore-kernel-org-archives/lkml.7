Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BF42147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710829;
	bh=OisHe8l2SYZxHPQktuAuQoE3rQywW6/ru5CWHjKEZUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWho0zFj2dGMYs+c9E/aJGQTLp5FSCl8VPiFd02jGtTkr6UQACJMf4+JwVq+arohn
	 fsVytsbPfqxwhAmdQxK6rgWF9PDD/O6aQ1uHDKM+7+a7xMS7aghwnvWPrvwQfncxcV
	 O9qj98QAiaUfxmXT8it/i7wisouSJeUGtV8cqL/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390919AbfC0SU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390660AbfC0SU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C87B20651;
        Wed, 27 Mar 2019 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710825;
        bh=OisHe8l2SYZxHPQktuAuQoE3rQywW6/ru5CWHjKEZUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNzcecbMAu9BeppxsotehZhYrTHix7wR/Q1Dm95ppCC3Pp6c9JdtVui97UB6/mZlS
         DvCHHUnfiQFFXcVOzDnbXl8VWEiN3hZnT25d6YDZqoyIZLoIGcrfgI9fYqWgyb5gPM
         dmOKTCQcxoXv3a96zeBC01G+lUjxNHhFvwYNhISY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     George Rimar <grimar@accesssoftek.com>, Tri Vo <trong@android.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Michael Matz <matz@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, morbo@google.com,
        ndesaulniers@google.com, ruiu@google.com, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 115/123] x86/build: Specify elf_i386 linker emulation explicitly for i386 objects
Date:   Wed, 27 Mar 2019 14:16:19 -0400
Message-Id: <20190327181628.15899-115-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Rimar <grimar@accesssoftek.com>

[ Upstream commit 927185c124d62a9a4d35878d7f6d432a166b74e3 ]

The kernel uses the OUTPUT_FORMAT linker script command in it's linker
scripts. Most of the time, the -m option is passed to the linker with
correct architecture, but sometimes (at least for x86_64) the -m option
contradicts the OUTPUT_FORMAT directive.

Specifically, arch/x86/boot and arch/x86/realmode/rm produce i386 object
files, but are linked with the -m elf_x86_64 linker flag when building
for x86_64.

The GNU linker manpage doesn't explicitly state any tie-breakers between
-m and OUTPUT_FORMAT. But with BFD and Gold linkers, OUTPUT_FORMAT
overrides the emulation value specified with the -m option.

LLVM lld has a different behavior, however. When supplied with
contradicting -m and OUTPUT_FORMAT values it fails with the following
error message:

  ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with elf_x86_64

Therefore, just add the correct -m after the incorrect one (it overrides
it), so the linker invocation looks like this:

  ld -m elf_x86_64 -z max-page-size=0x200000 -m elf_i386 --emit-relocs -T \
    realmode.lds header.o trampoline_64.o stack.o reboot.o -o realmode.elf

This is not a functional change for GNU ld, because (although not
explicitly documented) OUTPUT_FORMAT overrides -m EMULATION.

Tested by building x86_64 kernel with GNU gcc/ld toolchain and booting
it in QEMU.

 [ bp: massage and clarify text. ]

Suggested-by: Dmitry Golovin <dima@golovin.in>
Signed-off-by: George Rimar <grimar@accesssoftek.com>
Signed-off-by: Tri Vo <trong@android.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tri Vo <trong@android.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michael Matz <matz@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morbo@google.com
Cc: ndesaulniers@google.com
Cc: ruiu@google.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190111201012.71210-1-trong@android.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/Makefile        | 2 +-
 arch/x86/realmode/rm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index d88a2fddba8c..1c060748c813 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -100,7 +100,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
 AFLAGS_header.o += -I$(objtree)/$(obj)
 $(obj)/header.o: $(obj)/zoffset.h
 
-LDFLAGS_setup.elf	:= -T
+LDFLAGS_setup.elf	:= -m elf_i386 -T
 $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 4463fa72db94..96cb20de08af 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -47,7 +47,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
 targets += realmode.lds
 $(obj)/realmode.lds: $(obj)/pasyms.h
 
-LDFLAGS_realmode.elf := --emit-relocs -T
+LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
 CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
 
 targets += realmode.elf
-- 
2.19.1

