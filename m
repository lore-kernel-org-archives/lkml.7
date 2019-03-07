Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F27C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EFB2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfCGRPm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:15:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52751 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfCGRPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:15:41 -0500
Received: from [172.19.131.165] ([8.46.77.96])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x27HErM42268389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Mar 2019 09:14:57 -0800
Date:   Thu, 07 Mar 2019 09:14:45 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190307114511.870090179@infradead.org>
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
CC:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
From:   hpa@zytor.com
Message-ID: <1321FA0E-51AA-4A4E-9249-8A745F510F93@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2019 3:45:11 AM PST, Peter Zijlstra <peterz@infradead.org> wrote:
>Teach objtool to validate the UACCESS (SMAP, PAN) rules with are
>currently
>unenforced and (therefore obviously) violated.
>
>UACCESS sections should be small; we want to limit the amount of code
>that can
>touch userspace. Furthermore, UACCESS state isn't scheduled, this means
>that
>anything that directly calls into the scheduler will result in random
>code
>running with UACCESS enabled and possibly getting back into the UACCESS
>region
>with UACCESS disabled and causing faults.
>
>Forbid any CALL/RET while UACCESS is enabled; but provide a few
>exceptions.
>
>This builds x86_64-allmodconfig clean, and I've only got a few
>randconfig
>failures left (GCC-8) that I'm not quite understanding.
>
>---
> arch/x86/ia32/ia32_signal.c                |  29 ++-
> arch/x86/include/asm/asm.h                 |  24 --
> arch/x86/include/asm/nospec-branch.h       |   4 +-
> arch/x86/include/asm/smap.h                |  20 ++
> arch/x86/include/asm/uaccess.h             |   5 +-
> arch/x86/include/asm/uaccess_64.h          |   3 -
> arch/x86/include/asm/xen/hypercall.h       |  26 +-
> arch/x86/kernel/signal.c                   |   2 +-
> arch/x86/lib/copy_user_64.S                |  48 ++++
> arch/x86/lib/memcpy_64.S                   |   3 +-
> arch/x86/lib/usercopy_64.c                 |  20 --
> drivers/gpu/drm/i915/i915_gem_execbuffer.c |   6 +-
> include/linux/uaccess.h                    |   2 +
> kernel/trace/trace_branch.c                |   4 +
> lib/Makefile                               |   1 +
> lib/ubsan.c                                |   4 +
> mm/kasan/Makefile                          |   3 +
> mm/kasan/common.c                          |  10 +
> mm/kasan/report.c                          |   3 +-
> scripts/Makefile.build                     |   3 +
> tools/objtool/Makefile                     |   2 +-
> tools/objtool/arch.h                       |   8 +-
> tools/objtool/arch/x86/decode.c            |  26 +-
> tools/objtool/builtin-check.c              |   4 +-
> tools/objtool/builtin.h                    |   2 +-
>tools/objtool/check.c                      | 382
>++++++++++++++++++++++-------
> tools/objtool/check.h                      |   4 +-
> tools/objtool/elf.c                        |  15 +-
> tools/objtool/elf.h                        |   3 +-
> tools/objtool/special.c                    |  10 +-
> tools/objtool/warn.h                       |   8 +
> 31 files changed, 511 insertions(+), 173 deletions(-)
>
>
> 

This is phenomenal. Thank you so much for digging into this. I'm hoping this will greatly reduce the risk of future leakage.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
