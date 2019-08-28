Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15FB217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LsQZq/FH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfH1VDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:03:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46187 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfH1VDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:03:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so536668pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wEMPXU0/8bWFR5JtK39pzAaykL6QuoO0WEHBNtZu4gE=;
        b=LsQZq/FH50OjgrctHWWhNDpMfpVHWx3P8V9qHuv2ZM75Kz4a5djhKuDsQMmk1YYoee
         xsr//Q7yQUslSC/OY6EmN965WHJOLxJ3bXphrKeYfOx7dyBxSQ73vZlrDlvwWfDbC2zP
         ePJvHdFtPx1oNCpPUC8NkNCeFjPdOUZlx72+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wEMPXU0/8bWFR5JtK39pzAaykL6QuoO0WEHBNtZu4gE=;
        b=e6xB5I6CNS8EBKUeffuhR5sGVXKVd3CG3wap260Rzm2IPkumlWWEqZ8XekAMaf9ck9
         p38MWOAOlHvi5zJckjdfmn490syAsR/hZVKajnFsM+iugUBd4DRXj6MsqEb8+kh9LO8X
         Y/ipi0+uQVOQ7qyigC99mGN7gDvOrJ20fFcspLICwen5qThlZvWavQxbX+zgQ3qmXYsh
         ULYPqhBO3PMb6f572NRvwkeHEWU8p7s5zShI+yBu48u5GMH29rYKcIXr80qimGCTZokZ
         t3Ul99YS8ER2nD+qnsX5nFl+QnucaoVzcmRoC8n9HItCveVonZksSnSdt2ikqbh+R9ZG
         rL5g==
X-Gm-Message-State: APjAAAW0UaYCG065+jE4QOQUMKFzlCVsY7rzcjAtjiO0cqieyFgGuG0b
        yno0fOLkVln+Z2/oKwedp7+hWknddwY=
X-Google-Smtp-Source: APXvYqxctaTAEwDgW8N+Zel6FQytonLtlDiuDCLG22WyKmT8o1jrWkbWRuL6lBdeApwFUTY3WjQLBw==
X-Received: by 2002:aa7:9713:: with SMTP id a19mr7050084pfg.64.1567026219208;
        Wed, 28 Aug 2019 14:03:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e9sm271954pfh.155.2019.08.28.14.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:03:38 -0700 (PDT)
Date:   Wed, 28 Aug 2019 14:03:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <201908281353.0EFD0776@keescook>
References: <20190827163204.29903-1-will@kernel.org>
 <20190828073052.GL2332@hirez.programming.kicks-ass.net>
 <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828141439.sqnpm5ff4tgyn66r@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:14:40PM +0100, Will Deacon wrote:
> On Wed, Aug 28, 2019 at 09:30:52AM +0200, Peter Zijlstra wrote:
> > On Tue, Aug 27, 2019 at 05:31:58PM +0100, Will Deacon wrote:
> > > Will Deacon (6):
> > >   lib/refcount: Define constants for saturation and max refcount values
> > >   lib/refcount: Ensure integer operands are treated as signed
> > >   lib/refcount: Remove unused refcount_*_checked() variants
> > >   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
> > >   lib/refcount: Improve performance of generic REFCOUNT_FULL code
> > >   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions

BTW, can you repeat the timing details into the "Improve performance of
generic REFCOUNT_FULL code" patch?

> > So I'm not a fan; I itch at the whole racy nature of this thing and I
> > find the code less than obvious. Yet, I have to agree it is exceedingly
> > unlikely the race will ever actually happen, I just don't want to be the
> > one having to debug it.
> 
> FWIW, I think much the same about the version under arch/x86 ;)
> 
> > I've not looked at the implementation much; does it do all the same
> > checks the FULL one does? The x86-asm one misses a few iirc, so if this
> > is similarly fast but has all the checks, it is in fact better.
> 
> Yes, it passes all of the REFCOUNT_* tests in lkdtm [1] so I agree that
> it's an improvement over the asm version.
> 
> > Can't we make this a default !FULL implementation?
> 
> My concern with doing that is I think it would make the FULL implementation
> entirely pointless. I can't see anybody using it, and it would only exist
> as an academic exercise in handling the theoretical races. That's a change
> from the current situation where it genuinely handles cases which the
> x86-specific code does not and, judging by the Kconfig text, that's the
> only reason for its existence.

Looking at timing details, the new implementation is close enough to the
x86 asm version that I would be fine to drop the x86-specific case
entirely as long as we could drop "FULL" entirely too -- we'd have _one_
refcount_t implementation: it would be both complete and fast.

However, I do think a defconfig image size comparison should be done as
part of that too. I think this implementation will be larger than the
x86 asm one (but not by any amount that I think is a problem).

I'd also note that the saturation speed is likely faster in this
implementation (i.e. the number of instructions between noticing the
wrap and setting the saturation value), as it is on the other side of
a branch instead of across a trap, trap handler lookup, and call. So
the race window should even be smaller (though I continue to think it
remains hard enough to hit as to make it a non-issue in all cases: if
you can schedule INT_MAX / 2 increments before a handful of instructions
resets it to INT_MAX / 2, I suspect there are much larger problems. :)

-- 
Kees Cook
