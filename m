Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC4DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E7F213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWNY7Uqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfFXO3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:29:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44331 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFXO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:29:51 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so2623005iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLDSqUOdMe9MkrCouXk1jv/Ee4JAOZniqc4nsexubdo=;
        b=SWNY7UqeTaGhXp/3PP16Bk7RCsVd28PMBdKweU3IFOJXIpsZR6llO9l6t+4CuKFZzk
         DoBzQDK1Aa0E1F2j5J7GBdddh2HWFwhQBIjCSkkmZ3FS1LUO6fj5gI/aFUlNhJRbSXMr
         SPs9adEfb1TKx4mq8ErXyoVGUMzKrfI3d0MdG886/zHbGFLEiHMei3C6vg9odoYoug0y
         rHmXfcwpJzDBlQP/RDzKRhkz0z57NyNF1CNlDxmWj3LKKaNYElHycgiDDfNvMOpfaTlm
         VwoC7rQH85xtR9Di1oC6us/rPKIDKqqlES+BVxkJfiPRJ3s/LUnF1Le2n4vmy2kk9k8r
         7wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLDSqUOdMe9MkrCouXk1jv/Ee4JAOZniqc4nsexubdo=;
        b=OUTt/H0bRX0slBOGwbGhwcWSUsUfcNVu/j1f+0xLrHoVnbwA0oeSiaxKMpAIFBO2FK
         +4u8o5UosG2GlpKPKIlaMspSLjfcC6qRNl5SPHVfb8xt1kjDX7aAiI6KfjO7JqAEwHcg
         VUOObjCAbHDSk5F6P9wueaoLLgAIi+H09c158LA29motZHpQFZ4FhEu8RsnIhrqgSTMY
         kXwzNr7///NuUUaP69uykGHnKGo3PFktbxOyL6okhFVVmj3TRufDKylf3lrSCja5jYLV
         wSGq2sgzg8CBZlzMVxEIB4qDrCv+QcMg83hhJvGItBBZY3Ud7s2ZP9qUuNVHe4EJjmnS
         dF5w==
X-Gm-Message-State: APjAAAXfmHBvTyRFfcuEn91FdUjI0FaaJTJADscxFANTB/kTJMULOFI7
        FYnmS/uR4PVdNlW3BvrL/Cibkl25pyqyJhjpA581wg==
X-Google-Smtp-Source: APXvYqyREa1fE3eVop3ZkfvlBbG2x/4F3cy2bnWtfffx86CIFY9fPaGXRwSIMoSV5k/qu46L7QCuZMv87Up4HzKMWTI=
X-Received: by 2002:a02:5a89:: with SMTP id v131mr17639966jaa.130.1561386590504;
 Mon, 24 Jun 2019 07:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190528100413.GA20809@fuggles.cambridge.arm.com> <20190624111600.b7e5kkfvuszj6522@willie-the-truck>
 <07e3d9ea-b917-2adb-6f88-0f1a31692d04@arm.com>
In-Reply-To: <07e3d9ea-b917-2adb-6f88-0f1a31692d04@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Jun 2019 16:29:39 +0200
Message-ID: <CAKv+Gu9VcXuz8P7-2=MZjDj-7nVOEA8FUE1fRYTvtt1mvt99Yw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Catalin)

On Mon, 24 Jun 2019 at 13:23, Ard Biesheuvel <ard.biesheuvel@arm.com> wrote:
>
> On 6/24/19 1:16 PM, Will Deacon wrote:
> > On Tue, May 28, 2019 at 11:04:20AM +0100, Will Deacon wrote:
> >> On Thu, May 23, 2019 at 11:22:52AM +0100, Ard Biesheuvel wrote:
> >>> Wire up the code introduced in v5.2 to manage the permissions
> >>> of executable vmalloc regions (and their linear aliases) more
> >>> strictly.
> >>>
> >>> One of the things that came up in the internal discussion is
> >>> whether non-x86 architectures have any benefit at all from the
> >>> lazy vunmap feature, and whether it would perhaps be better to
> >>> implement eager vunmap instead.
> >>>
> >>> Cc: Nadav Amit <namit@vmware.com>
> >>> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Will Deacon <will.deacon@arm.com>
> >>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >>> Cc: James Morse <james.morse@arm.com>
> >>>
> >>> Ard Biesheuvel (4):
> >>>    arm64: module: create module allocations without exec permissions
> >>>    arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
> >>>    arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
> >>>    arm64: bpf: do not allocate executable memory
> >>>
> >>>   arch/arm64/Kconfig                  |  1 +
> >>>   arch/arm64/include/asm/cacheflush.h |  3 ++
> >>>   arch/arm64/kernel/module.c          |  4 +-
> >>>   arch/arm64/kernel/probes/kprobes.c  |  4 +-
> >>>   arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
> >>>   arch/arm64/net/bpf_jit_comp.c       |  2 +-
> >>>   mm/vmalloc.c                        | 11 -----
> >>>   7 files changed, 50 insertions(+), 23 deletions(-)
> >>
> >> Thanks, this all looks good to me. I can get pick this up for 5.2 if
> >> Rick's fixes [1] land soon enough.
> >
> > Bah, I missed these landing in -rc5 and I think it's a bit too late for
> > us to take this for 5.2. now particularly with our limited ability to
> > fix any late regressions that might arise.
> >
> > In which case, Catalin, please can you take these for 5.3? You might run
> > into some testing failures with for-next/core due to the late of Rick's
> > fixes, but linux-next should be alright and I don't think you'll get any
> > conflicts.
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > Ard: are you ok with that?
> >
>
> That is fine, although I won't be around to pick up the pieces by the
> time the merge window opens. Also, I'd like to follow up on the lazy
> vunmap thing for non-x86, but perhaps we can talk about this at plumbers?
>

Actually, you will run into a couple of conflicts. Let me know if you
want me to respin (although they still won't apply cleanly to both
for-next/core and -next)
