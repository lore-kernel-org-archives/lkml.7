Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992932082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567731015;
	bh=PY5drBH1zWFrEYPfV+oCstIfCDYlYiPcrbXnEC2lJxo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Tq2Fu41DFQ/WV6u3wlFOjTN5Pg2nhIVAxy9z5OE8vX0btMF6R7td6WTzfz3dpczE2
	 mDkoTyQykV/IDDk+MtxjlinXDA5BVw3kByiRAIXso1HbaQLafgFgrGMXMxgmQQJW4C
	 fP5CPegZ6MjOhl5n4HiNALkYcGI8zTGswMB/CYwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391612AbfIFAuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390796AbfIFAuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:50:14 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD03207E0;
        Fri,  6 Sep 2019 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567731013;
        bh=PY5drBH1zWFrEYPfV+oCstIfCDYlYiPcrbXnEC2lJxo=;
        h=From:To:Cc:Subject:Date:From;
        b=UN6gjf5ihOZgtK7TP0AEgYjcs0dZJPYgRgyWrlrq4aqte2Q0Re3LmWWPDTaZJwewp
         Ciub5a0ZNGXdFzuRjZtkIXZwOvefGoGg5TPHJNeJ+PMRiQyP1bpfsVhjfcc/Xa2CjR
         RCoj5W4/H+z6B3Zm45v/vvaQXjM0t3RERJm9joFY=
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
Subject: [PATCH -tip v2 0/2] x86: kprobes: Prohibit kprobes on Xen/KVM emulate prefixes
Date:   Fri,  6 Sep 2019 09:50:08 +0900
Message-Id: <156773100816.29031.12557431294039450779.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of patches to handle Xen/KVM emulate
prefix by x86 instruction decoder.

These patches allow x86 instruction decoder to decode
Xen and KVM emulate prefix correctly, and prohibit kprobes to
probe on it.

Josh reported that the objtool can not decode such special
prefixed instructions, and I found that we also have to
prohibit kprobes to probe on such instruction.

This series can be applied on -tip master branch which
has merged Josh's objtool/perf sharing common x86 insn
decoder series.

In this version, I added KVM emulate prefix support and generalized
the interface. (insn_has_xen_prefix -> insn_has_emulate_prefix)
Also, I added insn.emulate_prefix_size for those prefixes because
that prefix is NOT an x86 instruction prefix, and the next instruction
of those emulate prefixes can have x86 instruction prefix. So we
can not use insn.prefix for it.

Thank you,

---

Masami Hiramatsu (2):
      x86: xen: insn: Decode Xen and KVM emulate-prefix signature
      x86: kprobes: Prohibit probing on instruction which has emulate prefix


 arch/x86/include/asm/insn.h             |    6 +++++
 arch/x86/include/asm/xen/interface.h    |    7 ++++--
 arch/x86/include/asm/xen/prefix.h       |   10 +++++++++
 arch/x86/kernel/kprobes/core.c          |    4 +++
 arch/x86/lib/insn.c                     |   36 +++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/insn.h       |    6 +++++
 tools/arch/x86/include/asm/xen/prefix.h |   10 +++++++++
 tools/arch/x86/lib/insn.c               |   36 +++++++++++++++++++++++++++++++
 tools/objtool/sync-check.sh             |    3 ++-
 9 files changed, 115 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/xen/prefix.h
 create mode 100644 tools/arch/x86/include/asm/xen/prefix.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
