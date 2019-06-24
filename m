Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A3C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B67F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+lyZQLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfFXRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:16:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36340 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFXRQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:16:03 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so558990ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 10:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6KR75hh9p9LQvATREMdziRPKl8qsGfYDtGRnDFkfxQ=;
        b=B+lyZQLddAB4n+QEZiL/i74A/XWU56eo9exzRts+SlhOJz90tX+O7QXRuJGuvJ0eA1
         hVc1WoxC/0DIWnStNLewcHDIi2C67XL9PLgIZVPisO8WuE4YN26Jrm1/Ams8hkzxt3py
         Js2luR1OYLxKjAeZB/DcDgqw8QV8n0frzbZt88yXHTeOtUTpz/+KlwwzcNJo7CDz+xhf
         QKG3GOhFdb1VxAYfiflu9u/abji1MzvGST6Fq5YumOsnzg5dhsp0twXh0FwJYhC89nwf
         CK9sL1w7lp06B9wUDXTMd01yKiTp1rY7Tc52MpeY5/fi8QssKajDpCcl0KkriJNz5FLx
         l1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6KR75hh9p9LQvATREMdziRPKl8qsGfYDtGRnDFkfxQ=;
        b=O9/bc3Fa1w47jNxnbhCKbkTUoXPp5TlyEkkLz0ZUMx/Rg3+KlVVZnKSPa/Xu+pzfpl
         5I3xrTQCK9b+hDDYXgxPxe88nMZ86/WeTNTmKyZl0TTcAI70a5uHTR4Y5edlVKN39ZA7
         ES7XyLt/sFHwkLzezH8QGk/SNgx/S7oQMFpTw8GVp21FKFTYbRB7TDGJYU20+oWD4Gn5
         Zafz6Wb9jBZvtwAM7aF9Do+aDYGhwjUPefEcEaft7n+ZhiVPwSbZFpJ0auqL12m4oQQL
         /wUfiPervV0QT8XV9EsJENUYofEjxqEkEf+w2/HzM1tVWQqdeySpzRY2oF7MBxzM/cA+
         AxHQ==
X-Gm-Message-State: APjAAAW8DfnOXRzt/VWFArXiT7L85p2giCb80CTvRCliwyIVvzBBIT0I
        7A0gvHn4zCmh0LxF6ArowhjtHZvPdB+HWq7IyccqwA==
X-Google-Smtp-Source: APXvYqzOIxLbpEhUWndgunsplFFqiKMNJzzxea8U9jzy1xBWc+igVXAx4gtx1Tv5bYL60xf/MX2qoVdkttxigtdBT/Y=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr22683948iob.49.1561396561811;
 Mon, 24 Jun 2019 10:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190528100413.GA20809@fuggles.cambridge.arm.com> <20190624111600.b7e5kkfvuszj6522@willie-the-truck>
 <07e3d9ea-b917-2adb-6f88-0f1a31692d04@arm.com> <CAKv+Gu9VcXuz8P7-2=MZjDj-7nVOEA8FUE1fRYTvtt1mvt99Yw@mail.gmail.com>
 <20190624171358.GI29120@arrakis.emea.arm.com>
In-Reply-To: <20190624171358.GI29120@arrakis.emea.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 24 Jun 2019 19:15:50 +0200
Message-ID: <CAKv+Gu_xeduZY4gHJ4snRaGRNh=fdkUW3Y4t__BLmo3v75gb4g@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Mon, 24 Jun 2019 at 19:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 24, 2019 at 04:29:39PM +0200, Ard Biesheuvel wrote:
> > On Mon, 24 Jun 2019 at 13:23, Ard Biesheuvel <ard.biesheuvel@arm.com> wrote:
> > > On 6/24/19 1:16 PM, Will Deacon wrote:
> > > > On Tue, May 28, 2019 at 11:04:20AM +0100, Will Deacon wrote:
> > > >> On Thu, May 23, 2019 at 11:22:52AM +0100, Ard Biesheuvel wrote:
> > > >>> Ard Biesheuvel (4):
> > > >>>    arm64: module: create module allocations without exec permissions
> > > >>>    arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
> > > >>>    arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
> > > >>>    arm64: bpf: do not allocate executable memory
> > > >>>
> > > >>>   arch/arm64/Kconfig                  |  1 +
> > > >>>   arch/arm64/include/asm/cacheflush.h |  3 ++
> > > >>>   arch/arm64/kernel/module.c          |  4 +-
> > > >>>   arch/arm64/kernel/probes/kprobes.c  |  4 +-
> > > >>>   arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
> > > >>>   arch/arm64/net/bpf_jit_comp.c       |  2 +-
> > > >>>   mm/vmalloc.c                        | 11 -----
> > > >>>   7 files changed, 50 insertions(+), 23 deletions(-)
> > > >>
> > > >> Thanks, this all looks good to me. I can get pick this up for 5.2 if
> > > >> Rick's fixes [1] land soon enough.
> > > >
> > > > Bah, I missed these landing in -rc5 and I think it's a bit too late for
> > > > us to take this for 5.2. now particularly with our limited ability to
> > > > fix any late regressions that might arise.
> > > >
> > > > In which case, Catalin, please can you take these for 5.3? You might run
> > > > into some testing failures with for-next/core due to the late of Rick's
> > > > fixes, but linux-next should be alright and I don't think you'll get any
> > > > conflicts.
> > > >
> > > > Acked-by: Will Deacon <will@kernel.org>
> > > >
> > > > Ard: are you ok with that?
> > >
> > > That is fine, although I won't be around to pick up the pieces by the
> > > time the merge window opens. Also, I'd like to follow up on the lazy
> > > vunmap thing for non-x86, but perhaps we can talk about this at plumbers?
> >
> > Actually, you will run into a couple of conflicts. Let me know if you
> > want me to respin (although they still won't apply cleanly to both
> > for-next/core and -next)
>
> I queued them in for-next/core (and fixed a minor conflict). Thanks.
>

OK, in that case, you will get a conflict in -next on the hunk against
mm/vmalloc.c in the second patch. Just FYI ...
