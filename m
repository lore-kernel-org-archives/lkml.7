Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20581C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E570520835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tFyA/K3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCGLxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCGLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GIU7bkqdcNofYEsnSIvCZRtoqcbUhYFLozQs98LUjQA=; b=tFyA/K3LxECH2jT1+zynmbZ1k
        fWSUVcDJ9bw0zvz9I1DtYsp4taHfzz6Cbcy/yog1cgWVVjS/OlWlFDkZfHWpaJs8CbtksmgMukVhJ
        db+bfj9FgskmfTU/o4v/BBhD+h0u8XvsbkWLIA9078scjPetBDFNT7TyPzqzuudFNEIwTvUpabLOF
        j6aP8tdKhIAwOvYH7i0GyjkcAHMUi0S+cyYXv9SPkhl7f8HwtW51S4rXrTWbbgQ5xp4UoqI5rIJwC
        lWvxg23nSQwAycO220RIOP8ZrPn7VQxjBGKsP8WZgkN7eYxsE5ii2bihv+sxgyFVhuEjjXIC1oj8W
        3mH8U7LCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZl-0005PR-MK; Thu, 07 Mar 2019 11:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7F6582029D8D6; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307114511.870090179@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 00/20] objtool: UACCESS validation v3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool to validate the UACCESS (SMAP, PAN) rules with are currently
unenforced and (therefore obviously) violated.

UACCESS sections should be small; we want to limit the amount of code that can
touch userspace. Furthermore, UACCESS state isn't scheduled, this means that
anything that directly calls into the scheduler will result in random code
running with UACCESS enabled and possibly getting back into the UACCESS region
with UACCESS disabled and causing faults.

Forbid any CALL/RET while UACCESS is enabled; but provide a few exceptions.

This builds x86_64-allmodconfig clean, and I've only got a few randconfig
failures left (GCC-8) that I'm not quite understanding.

---
 arch/x86/ia32/ia32_signal.c                |  29 ++-
 arch/x86/include/asm/asm.h                 |  24 --
 arch/x86/include/asm/nospec-branch.h       |   4 +-
 arch/x86/include/asm/smap.h                |  20 ++
 arch/x86/include/asm/uaccess.h             |   5 +-
 arch/x86/include/asm/uaccess_64.h          |   3 -
 arch/x86/include/asm/xen/hypercall.h       |  26 +-
 arch/x86/kernel/signal.c                   |   2 +-
 arch/x86/lib/copy_user_64.S                |  48 ++++
 arch/x86/lib/memcpy_64.S                   |   3 +-
 arch/x86/lib/usercopy_64.c                 |  20 --
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |   6 +-
 include/linux/uaccess.h                    |   2 +
 kernel/trace/trace_branch.c                |   4 +
 lib/Makefile                               |   1 +
 lib/ubsan.c                                |   4 +
 mm/kasan/Makefile                          |   3 +
 mm/kasan/common.c                          |  10 +
 mm/kasan/report.c                          |   3 +-
 scripts/Makefile.build                     |   3 +
 tools/objtool/Makefile                     |   2 +-
 tools/objtool/arch.h                       |   8 +-
 tools/objtool/arch/x86/decode.c            |  26 +-
 tools/objtool/builtin-check.c              |   4 +-
 tools/objtool/builtin.h                    |   2 +-
 tools/objtool/check.c                      | 382 ++++++++++++++++++++++-------
 tools/objtool/check.h                      |   4 +-
 tools/objtool/elf.c                        |  15 +-
 tools/objtool/elf.h                        |   3 +-
 tools/objtool/special.c                    |  10 +-
 tools/objtool/warn.h                       |   8 +
 31 files changed, 511 insertions(+), 173 deletions(-)


 

