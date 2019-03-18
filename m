Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD50AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BF12133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552932979;
	bh=97+1z+W0PfAEKdmw06EjN1wb9ginIoM6Tfu15347rUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NFNqbRbOtVBk+YnLNMZLfv9+bZ+DF6fb887u2XKfrz0hh+ZsAgio4EqBH91XCGwnC
	 hAJ0JflGZgMLIvx9quWYLNx/lr5tfUpVmIwWGWwQMQEK1jmv0V7oBDyu709XiuBsus
	 TPY4LHaoiAw6D0smLKcgwh/HjKsU8NNiZpgqXBb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCRSQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:16:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35841 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfCRSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:16:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id v10so14961805lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdsCkIVdw68rRdzVGZvJmOdhvTueF9O0zaboX1ty06E=;
        b=gVjbBeGaRuXWfxnw2PgJLqcu+kZy5YrsflyzciEpWRf5FWI1cwc4L4k8UVi45ePpPU
         2Fx+Q4epYVLypb0XS1Ex2jC8QOPFr2sHCVkudEy/b+qYvx3nibrpXxje5Reb+zobWh/U
         vPNpujfuyYJN4DBJKwMUuDYSrNpQRZQUsWgCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdsCkIVdw68rRdzVGZvJmOdhvTueF9O0zaboX1ty06E=;
        b=aT8NYkTkHpVfbrK2VHAFcNhxvnzi4cSNsmGXzYG07MBlJqPfx1yJPMMA/cHq6X2EvI
         VRPV8ImFD7CsZNMKSO5UXWOrwkXUMkI0wdRxGbPryLmt8MLQRIdr34RhNOaD1fDSTYgD
         kVoiGaJ+podqyoUrEtJSeJec6Ll5v+0wvNPhU+BrDqgBM9hPVxscFnze2bPHp31YiG9Z
         hCbywPQwlln+pO8OLpy+NOlW3Owr73SzSuZ81tlJlVjVyBeh0iP8igwhaqsxYdeZ53Yv
         Xt9cJ1Ff48zzgzp7wyVclNqb+Dsl39QsCcO9qgu5Mj4+PUXQclsYQRATKO1qOePXOPFe
         Ji7A==
X-Gm-Message-State: APjAAAXC0tPWgftvHHFd04DB1ELQh/uVJ2EyGaFEZLTaCeK+JP0sYB/q
        cRwbaUnHBo5bGYM2+Oo6zVDmRmFdy84=
X-Google-Smtp-Source: APXvYqzqHNoTFndSaP+yi63WHsXXaOHr8iDVzNkf+ac7QxEGZtDLpcm1Ea1mg6Gi8c09lK+hJr0tqA==
X-Received: by 2002:a2e:8508:: with SMTP id j8mr2801735lji.26.1552932974942;
        Mon, 18 Mar 2019 11:16:14 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q9sm2139319lfk.40.2019.03.18.11.16.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:16:14 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 5so466930lft.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:16:14 -0700 (PDT)
X-Received: by 2002:ac2:424c:: with SMTP id m12mr11243580lfl.62.1552932638336;
 Mon, 18 Mar 2019 11:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190318153840.906404905@infradead.org> <20190318155139.963285969@infradead.org>
 <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
 <20190318173657.GV6058@hirez.programming.kicks-ass.net> <20190318175135.GE6521@hirez.programming.kicks-ass.net>
In-Reply-To: <20190318175135.GE6521@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Mar 2019 11:10:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguWBY_W8-M0vSCae538mAY2vQtkrdNbZX4T8rvAYxPxg@mail.gmail.com>
Message-ID: <CAHk-=wguWBY_W8-M0vSCae538mAY2vQtkrdNbZX4T8rvAYxPxg@mail.gmail.com>
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> How about I do a patch that schedules EFLAGS for both 32bit and 64bit,
> mark this for backporting to infinity.
>
> And then at the end, after the objtool-ac bits land, I do a patch
> removing the EFLAGS scheduling for x86_64.

Sounds sane to me.

And we can make it AC-conditional if it's actually shown to be visible
from a performance standpoint.

But iirc pushf/popf isn't really that expensive - in fact I think it's
pretty cheap when system flags don't change. Which would be the common
case unless you'd also make the popf do the irq restore part and
simply make finish_lock_switch() re-enable irq's by doing an
irqrestore?

I think popf is like 20 cycles or something (and pushf is just single
cycles). Probably not worth worrying about in the task switch context.

                 Linus
