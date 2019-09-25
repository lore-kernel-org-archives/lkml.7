Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742FAC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1821D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569392611;
	bh=+pUotpvPxtPDE9XDRq1gUWN02qOp+MNc5U1tIj4aEEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q8+/DSfwc/LSO82zwuYDAJ+mFnWrTlyGrVXxmM/RbtP3hkv3HiqQtd4U5LtuLuS+6
	 k6A9yuI43cc417wKWLzW4RRRhYSk+vyaX9TFDKtSUIYQ/fVkTLjiJzuqejMUoGHSYE
	 7YriPOOgyp/0Atst360PQNkmA4+L/iya+XUumM04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411874AbfIYGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:23:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45400 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404570AbfIYGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:23:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so4915281wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bjOEh0remiO1SBIUmbtaD2NymPKRcZuLKqrk2Be+LSc=;
        b=OhmbCZqqehmKBug/dwmx6kGZ6epz34JLOMtkhLRxM4m4IXCCbtDGrHkmBVXrY+3tZL
         di7zPnJWpR/YrUF2UNLZw0DAXySsoTZhXMGCRgh9MP5jAr87U5eu4ssURuT6vdYopjD2
         o7aDNNSWkmBofNwp7vE8xnEJcB6Gs4pXRlEijyTmqLbokJdYDjLuuBql0isM2vz0/+v/
         M3YauIyZpD7U4egSI3vByAOO9InHgulNYbGi+6r01cJDa4VCinwBY8bG+UPh3cCx76EL
         +0Ty87cF2Fkq/LK3d4PP4PU8iM8CqfLXlpwRvFrSdrF04mdo60qndWpLuzJkUs/dHEq+
         cu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bjOEh0remiO1SBIUmbtaD2NymPKRcZuLKqrk2Be+LSc=;
        b=T8ME4uo1RA2sLQgTYLSclVXXnt3r0koL5o2eo3ywGdBlvDRc2vqOSDxCDelpOWi2Qz
         dErfLsr5J4FXBvqRRuN21CS3GlB0jJnJOanOtmLNouKyR3BrVCFjnLtHa5r41YyUs0K9
         KuvAvLFRunuutVFNDMGacWaGSo+BDY12tjqNPULz74rBhXX2gw1uwEsM7ddLYlsjFXOj
         KBoELFLv7Ajzu3Lb5PQku3vzhaeQfGoXP4CZWLWAJMyciG0HGOkrkBRY3WrNvRkB7Cch
         +US8zUUXiCMvGOA9623N3A9eoGq1U2Ux64vU5avIpnYxHx8TDpQYH/jrYDYbCM3kyB8O
         XwNw==
X-Gm-Message-State: APjAAAUCx6fEGWHt0mqxMRTud96HhWbewlmN9rT19+9tWcyoOs2SBBq+
        MOo86UZFVpc7QvEqsLrjs6g=
X-Google-Smtp-Source: APXvYqwBZurQ4uTRW+kVz5MGCDgVppKWsO764mbboyeSGhtF1gffYeYwn0yWec2NooQZKCvixAxCmA==
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr7689888wrw.80.1569392606892;
        Tue, 24 Sep 2019 23:23:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d193sm5603295wmd.0.2019.09.24.23.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 23:23:25 -0700 (PDT)
Date:   Wed, 25 Sep 2019 08:23:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
Message-ID: <20190925062323.GA65860@gmail.com>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
 <CDB07BE3-6491-4159-89E7-FBA1631A01C3@fb.com>
 <CAHk-=whbOhAmc3FEhnEkdM9AXFuKM+964r+uzzm_Q9qFaxTC7g@mail.gmail.com>
 <E4AF8E4C-A307-4AE7-85AA-F579D5BFDBDD@fb.com>
 <CAHk-=wisZfwwJo57BRigT5X_uWs6Jw4K3ezPSwCSMBHSeJTHzg@mail.gmail.com>
 <C6FC577A-A589-46FD-92FE-5C441BDB922D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6FC577A-A589-46FD-92FE-5C441BDB922D@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Song Liu <songliubraving@fb.com> wrote:

> 
> 
> > On Sep 17, 2019, at 4:35 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > On Tue, Sep 17, 2019 at 4:29 PM Song Liu <songliubraving@fb.com> wrote:
> >> 
> >> How about we just do:
> >> 
> >> diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
> >> index b196524759ec..0437f65250db 100644
> >> --- i/arch/x86/mm/pti.c
> >> +++ w/arch/x86/mm/pti.c
> >> @@ -341,6 +341,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
> >>                }
> >> 
> >>                if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
> >> +                       WARN_ON_ONCE(addr & ~PMD_MASK);
> >>                        target_pmd = pti_user_pagetable_walk_pmd(addr);
> >>                        if (WARN_ON(!target_pmd))
> >>                                return;
> >> 
> >> So it is a "warn and continue" check just for unaligned PMD address.
> > 
> > The problem there is that the "continue" part can be wrong.
> > 
> > Admittedly it requires a pretty crazy setup: you first hit a
> > pmd_large() entry, but the *next* pmd is regular, so you start doing
> > the per-page cloning.
> > 
> > And that per-page cloning will be wrong, because it will start in the
> > middle of the next pmd, because addr wasn't aligned, and the previous
> > pmd-only clone did
> > 
> >                        addr += PMD_SIZE;
> > 
> > to go to the next case.
> > 
> > See?
> 
> I see. This is tricky. 
> 
> Maybe we should skip clone of the first unaligned large pmd?
> 
> diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
> index 7f2140414440..1dfa69f8196b 100644
> --- i/arch/x86/mm/pti.c
> +++ w/arch/x86/mm/pti.c
> @@ -343,6 +343,11 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>                 }
> 
>                 if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
> +                       if (WARN_ON_ONCE(addr & ~PMD_MASK)) {
> +                               addr = round_up(addr, PMD_SIZE);
> +                               continue;
> +                       }
> +
>                         target_pmd = pti_user_pagetable_walk_pmd(addr);
>                         if (WARN_ON(!target_pmd))
>                                 return;

No, we should do a proper iteration of the page table structures.

> Or we can round_down the addr and copy the whole PMD properly:
> 
> diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
> index 7f2140414440..bee9881f2e85 100644
> --- i/arch/x86/mm/pti.c
> +++ w/arch/x86/mm/pti.c
> @@ -343,6 +343,9 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>                 }
> 
>                 if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
> +                       if (WARN_ON_ONCE(addr & ~PMD_MASK))
> +                               addr &= PMD_MASK;
> +
>                         target_pmd = pti_user_pagetable_walk_pmd(addr);
>                         if (WARN_ON(!target_pmd))
>                                 return;
> 
> I think the latter is better, but I am not sure. 

While this works, it's the wrong iterator pattern I believe.

In this function we iterate by passing in a 'random' [start,end) virtual 
memory address range with no particular alignment assumptions, then look 
up all pagetable entries covered by that range.

The iteration's principle is straightforward: we look up the first 
address (byte granular) then continue iterating according to the observed 
structure of the kernel pagetables, by skipping the range we have just 
looked up:

- If the current PUD is not mapped, then we set 'addr' to the first byte 
  after the virtual memory range represented by the current PUD entry:

    addr = round_up(addr + 1, PUD_SIZE);

- If the current PMD is not mapped, then the next byte is:

    addr = round_up(addr + 1, PMD_SIZE);

The part Linus correctly pointed it is still iterating incorrectly and 
might potentially be unrobust is:

    addr += PMD_SIZE;

This is buggy because it doesn't step to the next byte after the current 
mapped PMD, but potentially somewhere into the middle of the next 
PMD-sized range of virtual memory (which might or might not be covered by 
a PMD entry). The iterations after that might be similarly offset and 
buggy as well.

The right fix is to *fix the address iterator*, to use the basic 
principle of the function, with the same general exact calculation 
pattern we use in the other cases:

    addr = round_down(addr, PMD_SIZE) + PMD_SIZE;

BTW., I'd also suggest using this new round_down() pattern in the other 
two cases as well:

    addr = round_down(addr, PUD_SIZE) + PUD_SIZE;
    ...
    addr = round_down(addr, PMD_SIZE) + PMD_SIZE;

Why? Because this:

    addr = round_up(addr + 1, PUD_SIZE);

Will iterate incorrectly if 'addr' (which is byte granular) is the last 
*byte* of a PUD range, it will incorrectly skip the next PUD range...

Is a page-unaligned address likely to be passed in to this function? With 
the current users I really hope it won't happen, but it costs nothing to 
use clean iterators and think through all cases - it also makes the code 
more readable.

Three random nits about the pti_clone_pgtable() function:

- Could we please also fix all WARN()'s in that function to be 
  WARN_ONCE()? Any warning from that function is probably fatal to the 
  bootup anyway, and it doesn't help if we potentially spam many 
  warnings.

- Please add an explanation comment to why the 'BUG();' case is 
  unrecoverable and needs us to crash the kernel.

- Please add a comment about what the 'level' parameter does. It's non-obvious.

Thanks,

	Ingo
