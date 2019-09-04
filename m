Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A828C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231D822CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567597576;
	bh=tHqEkww86KOLAmW5EQ0TIw1FCRFKi6/kyBIAI58FgmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LLnj3+NSV2Wgha7D19dbUE71MS2EPV6jEuF26b5MwEq2//8qYbs4H01pxBU/s990M
	 cNPBjdN7h31IjJ6GO8VmuzohmOAbeylErCaVlY0RNKBanWO8fefNDviqpGCLb9weha
	 CFc9Uo0za8Bt8XmGztcZtev6Pm5pEWwtr7NPCDNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfIDLqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfIDLqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:46:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0A920820;
        Wed,  4 Sep 2019 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567597574;
        bh=tHqEkww86KOLAmW5EQ0TIw1FCRFKi6/kyBIAI58FgmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCvirIxsPyDLuECE+MpjKKpTgje2DwSZK2A5hmcbdQiW1cyxc+Pvk1Lo7atnCLVqd
         CosZL3Ic2nMvEv6WwnDL97wUaNn4N5A+Gkfebg70iepgH2JEVTQIdksucUonvRQeuo
         3wD1KK8jLdHLqfGD0e+FSyAXNsQrfLCOzsdDnJDs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH -tip 2/2] x86: kprobes: Prohibit probing on instruction which has Xen prefix
Date:   Wed,  4 Sep 2019 20:46:09 +0900
Message-Id: <156759756944.24473.4664241966878257420.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156759754770.24473.11832897710080799131.stgit@devnote2>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prohibit probing on instruction which has XEN_EMULATE_PREFIX
(it must be cpuid.) Since that prefix is a marker for Xen,
if we modify the marker by kprobe's int3, that doesn't work
as expected.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 43fc13c831af..b1e86af4a985 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -351,6 +351,10 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
 	insn_get_length(insn);
 
+	/* We can not probe XEN_EMULATE_PREFIX instruction */
+	if (insn_has_xen_prefix(insn))
+		return 0;
+
 	/* Another subsystem puts a breakpoint, failed to recover */
 	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
 		return 0;

