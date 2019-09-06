Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39531C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2771720870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567731037;
	bh=dTI/PD6Zp/AXRe7dx+Oz3QClHlFgk/sT4V/cXDhsk68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q0lVYRAZXiJGmNN71cKuy3NjHn8z6HOfn1u4qVFlkWGy8gUN6gnovjmH5nj3D5gWe
	 auk6DnbcJAwok2IOUbGQ/ppLRD2zL3Y8JVe4Z0iYQPl5CwCT9wAguphWkf19xYf6NB
	 408O2/Rik4XbEYCs4ABcQqnZ4xUhodo9lxkJwo3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391857AbfIFAuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390787AbfIFAuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:50:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42DA8207E0;
        Fri,  6 Sep 2019 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567731035;
        bh=dTI/PD6Zp/AXRe7dx+Oz3QClHlFgk/sT4V/cXDhsk68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fx7VJE8ob8mqtjb5+wF3Z5mBYga5Hvdg9BwlDSIKQKNDGzXS2/OmvsLpgr442JCE8
         V40l0RzRj8vWAozINBkY2HgNYNd9yitc2/ltw+m4usRPnC+UJ3d9I0cgLr7XchxmcT
         CQAYZzOO7/KokO2b+nAOt+nVmpJUUDe2ybYMWfI0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH -tip v2 2/2] x86: kprobes: Prohibit probing on instruction which has emulate prefix
Date:   Fri,  6 Sep 2019 09:50:29 +0900
Message-Id: <156773102959.29031.18377408063770100148.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156773100816.29031.12557431294039450779.stgit@devnote2>
References: <156773100816.29031.12557431294039450779.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prohibit probing on instruction which has XEN_EMULATE_PREFIX
or KVM's emulate prefix. Since that prefix is a marker for Xen
and KVM, if we modify the marker by kprobe's int3, that doesn't
work as expected.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 43fc13c831af..4f13af7cbcdb 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -351,6 +351,10 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
 	insn_get_length(insn);
 
+	/* We can not probe force emulate prefixed instruction */
+	if (insn_has_emulate_prefix(insn))
+		return 0;
+
 	/* Another subsystem puts a breakpoint, failed to recover */
 	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
 		return 0;

