Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8639C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABC42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ixdjzW9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfCRPyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:54:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfCRPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pnCYzyNp4D+VOly6zkbzYo7tiiDb9D+jqHg7z9JxN4A=; b=ixdjzW9gl3l6hM8yiS0gNL9BN
        h4B1H80wJhFvGpZsBNltzCtDjo580JTedzOcSdZcSW9n5PaODlyKM1GPb1D9iGbQAUD7+RUo0U1Bt
        0VwXEPTrYrt8vEOG31+1NKee358UWO4u15KYc5V2dWTZTqNDGizXyoEIiVj4wlD0tQY8MQfTGa8nn
        TpklmmrmP/XEKUftZVSLnae5fT+p8O4MVNR02HWUWMmyWBlzsRCsOJyZQ49J+qQSFb4QDK8bGJbp5
        2pVUiVY5+w8N0rVv8dkL756/SkVMXVtM5XKYFURNYEF6LX5fZk/iItu1sv8PeAmoKp3jf8vzOrYvx
        ncgbPofMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ7-0006iH-C4; Mon, 18 Mar 2019 15:52:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7D61523E9D51E; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318153840.906404905@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 00/25] objtool: UACCESS validation v4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool to validate the UACCESS (SMAP, PAN) rules which are currently
unenforced and (therefore obviously) violated.

UACCESS sections should be small; we want to limit the amount of code that can
touch userspace. Furthermore, UACCESS state isn't scheduled, this means that
anything that directly calls into the scheduler will result in random code
running with UACCESS enabled and possibly getting back into the UACCESS region
with UACCESS disabled and causing faults.

Forbid any CALL/RET while UACCESS is enabled; but provide a few exceptions.

This builds x86_64-allmodconfig and lots of x86_64-randconfig clean.

Changes since -v3:

 - removed a bunch of functions from the UACCESS-safe list
   due to the removal of CONFIG_KASAN_EXTRA=y.

 - hopefully addressed all the feedback from Josh

 - realized objtool doesn't cover x86_32

 - some added additional annotations/fixes: kcov, signal

 - retains the DF check for now, Linus, do you (still) think it is worth doing
   that DF check?

---
 arch/x86/Kconfig                           |   2 +
 arch/x86/ia32/ia32_signal.c                |  29 ++-
 arch/x86/include/asm/alternative-asm.h     |  11 +
 arch/x86/include/asm/alternative.h         |  10 +
 arch/x86/include/asm/asm.h                 |  24 --
 arch/x86/include/asm/nospec-branch.h       |  28 +-
 arch/x86/include/asm/smap.h                |  37 ++-
 arch/x86/include/asm/uaccess.h             |   5 +-
 arch/x86/include/asm/uaccess_64.h          |   3 -
 arch/x86/include/asm/xen/hypercall.h       |  24 +-
 arch/x86/kernel/signal.c                   |  29 ++-
 arch/x86/lib/copy_user_64.S                |  48 ++++
 arch/x86/lib/memcpy_64.S                   |   3 +-
 arch/x86/lib/usercopy_64.c                 |  20 --
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |   6 +-
 include/linux/compiler.h                   |   2 +-
 include/linux/uaccess.h                    |   2 +
 kernel/Makefile                            |   1 +
 kernel/trace/trace_branch.c                |   4 +
 lib/Makefile                               |   1 +
 lib/ubsan.c                                |   4 +
 mm/kasan/Makefile                          |   3 +
 mm/kasan/common.c                          |  10 +
 mm/kasan/report.c                          |   3 +-
 scripts/Makefile.build                     |   3 +
 tools/objtool/arch.h                       |   8 +-
 tools/objtool/arch/x86/decode.c            |  21 +-
 tools/objtool/builtin-check.c              |   4 +-
 tools/objtool/builtin.h                    |   2 +-
 tools/objtool/check.c                      | 400 ++++++++++++++++++++++-------
 tools/objtool/check.h                      |   4 +-
 tools/objtool/elf.c                        |  15 +-
 tools/objtool/elf.h                        |   3 +-
 tools/objtool/special.c                    |  18 ++
 tools/objtool/special.h                    |   1 +
 tools/objtool/warn.h                       |   8 +
 36 files changed, 584 insertions(+), 212 deletions(-)

