Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472ABC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F8521850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368015;
	bh=N3I19M0DslE398M3EDkLExyWyFoCta1JzhWhIwyReZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fZJaqGDYMRdGx34uTZjIoRFBpJ2IV9V/fvgyUwqK9jquAfFTAfe7Y7LUSZdtUVwCN
	 jCVaChGf5c6CmNJdpN1Vj3noQ2/86WFOdP2wZykDu/7pCNW0+Kfw9Qmp+veaOmUUMW
	 4kksh4anSuVcHKmcRlyDAqDnLUrgg5W4bir/NSf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfDDIxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbfDDIxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:53:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426C22184E;
        Thu,  4 Apr 2019 08:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368010;
        bh=N3I19M0DslE398M3EDkLExyWyFoCta1JzhWhIwyReZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yt7h7LZqSb1sL7BQDpkNQERQoqdnO0SMnUUNCRQXUI+Kw2j33v8NGVVkmbj6QfjmS
         MMYhmH/0jbcg0KJsnLZD1Mo5Nhz7sCxh4PsoRN7aRzwSCDcyCmwVgbl0Q0fdhwO5qR
         vtlH1QnVOZqqRsMdWyuiC5HIiV0TXjmeJ9YcjBkE=
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
Subject: [PATCH 4.9 88/91] x86/build: Mark per-CPU symbols as absolute explicitly for LLD
Date:   Thu,  4 Apr 2019 10:48:12 +0200
Message-Id: <20190404084540.564317571@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



