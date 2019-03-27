Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ACEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B1421734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711007;
	bh=YLDaf5QYjSyieJpwIPUtgd4FJ0JjKsrv5e3tsYIbWXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OcTnsHQEcPYk1FZycponcYy02UxkouU8KI1ot8eY06I2C51Jv1HmgCzomz2JNFaJG
	 vriZQQTdBK55cMlXhM8QtmYZ/5IqtvP9LZaMnB88wH+9fSyWJtC+yVF6Op3Li2pbkj
	 NndpPhre0FYdmTWjXBVsY665GEY0MK16n9vGcGiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391488AbfC0SXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390998AbfC0SXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A56020643;
        Wed, 27 Mar 2019 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710999;
        bh=YLDaf5QYjSyieJpwIPUtgd4FJ0JjKsrv5e3tsYIbWXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPrkFjTKItlcWhmaMIepF6yfbAp1ciQcJ94ywymzqWjxPorxhYcCdV+Nno/0YD2oe
         q5JGCP0FrcbfUUpdBCWcfRzVJMjSc2+EoWAn/V8H6R9bPUgzrSX4zbzxmWkjkgNT2u
         dDK6Sf2Y7tVCjyjKaQ0RbAVNZdR2w2haaVh/edIA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Rafael=20=C3=81vila=20de=20Esp=C3=ADndola?= 
        <rafael@espindo.la>, Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Cao Jin <caoj.fnst@cn.fujitsu.com>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tri Vo <trong@android.com>, dima@golovin.in, morbo@google.com,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 84/87] x86/build: Mark per-CPU symbols as absolute explicitly for LLD
Date:   Wed, 27 Mar 2019 14:20:37 -0400
Message-Id: <20190327182040.17444-84-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael Ávila de Espíndola <rafael@espindo.la>

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
index e783a5daaab2..55f04875293f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -367,7 +367,7 @@ SECTIONS
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x = x + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(irq_stack_union);
 
-- 
2.19.1

