Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1626CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5421904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125948;
	bh=5oh5hAyZFu5AeJUrrHdUOrHXP+rumm5GX6/3wO48bb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBhS422j5CKuxlb5YB16Ql5/+rJz+C3GM2n9wipuNGhFw1GdL4HLSVItoxKHq4qOH
	 eG/PAhFVoffftxLq6c9cTymtGi2vQ8+BG/mu2rJnYDfDJk6UpxHXDRjsN7wEUwx1aV
	 +PK18U2563ekkkhLD6GbVzrqvEC09iFOZwuKZ1HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfDXRM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733154AbfDXRMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:25 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F0721908;
        Wed, 24 Apr 2019 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125944;
        bh=5oh5hAyZFu5AeJUrrHdUOrHXP+rumm5GX6/3wO48bb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+x5Z7HsmFeSPQsOxQML6Ej8MAqYBqLpQqbmKIvMnDYmC5vgwt3hQsySEOHh+N0HG
         EWz6As0yK9W0ylNQYSQTHxxNN1I5kEg6/ES/LhY8k58T7UEmohkByVhHZSKZkuPDHN
         Q43lvSQ5gxZMbea1EcWwMQ6zzxebEoznRuKcVpYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Golovin <dima@golovin.in>,
        =?UTF-8?q?Rafael=20=C3=81vila=20de=20Esp=C3=ADndola?= 
        <rafael@espindo.la>, Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Cao Jin <caoj.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tri Vo <trong@android.com>, morbo@google.com,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 039/104] x86/build: Mark per-CPU symbols as absolute explicitly for LLD
Date:   Wed, 24 Apr 2019 19:08:56 +0200
Message-Id: <20190424170859.144971923@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d071ae09a4a1414c1433d5ae9908959a7325b0ad ]

Accessing per-CPU variables is done by finding the offset of the
variable in the per-CPU block and adding it to the address of the
respective CPU's block.

Section 3.10.8 of ld.bfd's documentation states:

  For expressions involving numbers, relative addresses and absolute
  addresses, ld follows these rules to evaluate terms:

  Other binary operations, that is, between two relative addresses
  not in the same section, or between a relative address and an
  absolute address, first convert any non-absolute term to an
  absolute address before applying the operator."

Note that LLVM's linker does not adhere to the GNU ld's implementation
and as such requires implicitly-absolute terms to be explicitly marked
as absolute in the linker script. If not, it fails currently with:

  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:153: at least one side of the expression must be absolute
  ld.lld: error: ./arch/x86/kernel/vmlinux.lds:154: at least one side of the expression must be absolute
  Makefile:1040: recipe for target 'vmlinux' failed

This is not a functional change for ld.bfd which converts the term to an
absolute symbol anyways as specified above.

Based on a previous submission by Tri Vo <trong@android.com>.

Reported-by: Dmitry Golovin <dima@golovin.in>
Signed-off-by: Rafael Ávila de Espíndola <rafael@espindo.la>
[ Update commit message per Boris' and Michael's suggestions. ]
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
[ Massage commit message more, fix typos. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Dmitry Golovin <dima@golovin.in>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Cao Jin <caoj.fnst@cn.fujitsu.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tri Vo <trong@android.com>
Cc: dima@golovin.in
Cc: morbo@google.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181219190145.252035-1-ndesaulniers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 49edf2dd3613..1bd47a144db1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -345,7 +345,7 @@ SECTIONS
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x = x + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(irq_stack_union);
 
-- 
2.19.1



