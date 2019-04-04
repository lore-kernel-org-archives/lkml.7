Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7363C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83EA214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368801;
	bh=5YiFH5L38o1NXDl7y5yI2kUNPsJ9MfooNVTI3JDl5ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWpUvPhJBk8mXpMUwEXWf4j9lLH5Z2pMzxrmekMxiXgAQ6+UUUCNCRuAihjENwEbF
	 jNDq2DRDpRA8qrCzgAhmPLAYWwwWoawh1eKJes8fuonDoGk/+F68UsDfNDeObNEzgC
	 rfZChyhgVcNNtZbS9aZ8n8JhyJU8qMHe/v6Oai68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbfDDJGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732341AbfDDJGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:06:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D336A21872;
        Thu,  4 Apr 2019 09:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368795;
        bh=5YiFH5L38o1NXDl7y5yI2kUNPsJ9MfooNVTI3JDl5ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjcR8OWrhCJsUoKRUnckQ5a6s90IYnSZDhWRvR92KDiTXi7lKW5175ubQRpyuTZJD
         Tik/5WFCad/I7IacThDoNB/dGVjYCwHnePNZqYwPWcW4Pio5gLpUak2BjvZrzn1rP7
         LJ0dslGKKu+AFzpEUev0WjKT1qerPyNMENJ3oSEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Golovin <dima@golovin.in>,
        George Rimar <grimar@accesssoftek.com>,
        Tri Vo <trong@android.com>, Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Matz <matz@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, morbo@google.com,
        ruiu@google.com, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 173/187] x86/build: Specify elf_i386 linker emulation explicitly for i386 objects
Date:   Thu,  4 Apr 2019 10:48:30 +0200
Message-Id: <20190404084611.243787488@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9b5adae9cc40..e2839b5c246c 100644
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



