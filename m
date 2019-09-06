Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C4DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF442173B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567775625;
	bh=04VMkFAKwpuBxhJdJIYLigr+4AaTxM1JYsTMgdArZEQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hTsx4k2bEAWyKkUTVreDSSAJEFwW14S8y38HDiy5B7/FjkCS6c1uoyByuJu2PHQHP
	 W7ayXreV61KzHRgNMHzCaREh6JTw3i1QASPV3X9bOxVR2JeQOphyswu2LTJpFi6oHb
	 u84W5OO3r7C7gUUL86d40KJcsL5599F/9CH5ymI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392974AbfIFNNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389197AbfIFNNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:13:44 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAE95206BB;
        Fri,  6 Sep 2019 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567775623;
        bh=04VMkFAKwpuBxhJdJIYLigr+4AaTxM1JYsTMgdArZEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NZs4T0sE2RnKQkKahhNeB4+KuDgjS8z/UykH4cTyaD0PQ1MVUOymSG9DaLaHzbaKY
         6hhhzFGTqnZwNtCbZHUxgK+Lh3U8tnuxEfjT/3cQB9ZckHnj9qxw+JndI+b/pa4dIP
         BBsBWpVCwCnvjEqMcpu5Iq/W4HK+wvoDI7ZKxXZw=
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
Subject: [PATCH -tip v4 0/4] x86: kprobes: Prohibit kprobes on Xen/KVM emulate prefixes
Date:   Fri,  6 Sep 2019 22:13:37 +0900
Message-Id: <156777561745.25081.1205321122446165328.stgit@devnote2>
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

Here is the 4th version of patches to handle Xen/KVM emulate
prefix by x86 instruction decoder.

These patches allow x86 instruction decoder to decode
Xen and KVM emulate prefix correctly, and prohibit kprobes to
probe on it.
Previous version is here;

 https://lkml.kernel.org/r/156773433821.31441.2905951246664148487.stgit@devnote2

In this version, I added 2 patches, [1/4] fixes __ASM_FORM() to
accept macros using __stringify(), [2/4] introduces new
asm/emulate_prefix.h to initialize Xen and KVM emulate prefix
at one place. [3/4] is updated to use new emulate_prefix.h and
fix to add emulate_prefix.h to sync check list.

This series can be applied on -tip master branch which
has merged Josh's objtool/perf sharing common x86 insn
decoder series.

Thank you,

---

Masami Hiramatsu (4):
      x86/asm: Allow to pass macros to __ASM_FORM()
      x86: xen: kvm: Gather the definition of emulate prefixes
      x86: xen: insn: Decode Xen and KVM emulate-prefix signature
      x86: kprobes: Prohibit probing on instruction which has emulate prefix


 arch/x86/include/asm/asm.h                  |    8 ++++--
 arch/x86/include/asm/emulate_prefix.h       |   14 +++++++++++
 arch/x86/include/asm/insn.h                 |    6 +++++
 arch/x86/include/asm/xen/interface.h        |   11 +++------
 arch/x86/kernel/kprobes/core.c              |    4 +++
 arch/x86/kvm/x86.c                          |    4 ++-
 arch/x86/lib/insn.c                         |   34 +++++++++++++++++++++++++++
 tools/arch/x86/include/asm/emulate_prefix.h |   14 +++++++++++
 tools/arch/x86/include/asm/insn.h           |    6 +++++
 tools/arch/x86/lib/insn.c                   |   34 +++++++++++++++++++++++++++
 tools/objtool/sync-check.sh                 |    3 ++
 tools/perf/check-headers.sh                 |    3 ++
 12 files changed, 128 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/emulate_prefix.h
 create mode 100644 tools/arch/x86/include/asm/emulate_prefix.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
