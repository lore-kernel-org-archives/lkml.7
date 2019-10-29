Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A3CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564252087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PrZ2AGRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfJ2VaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:30:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41152 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfJ2VaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:30:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id a21so43149edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqdJq1f/qIhweQts5AB1HeIVb9O7ywkFDNZusrXv0ac=;
        b=PrZ2AGRroeNtw796hVMPeML+80GYP6QyWEsnxgND+dc9gtx/OHg/KPAYFlRg85KJB2
         ZrrwSetq2naXw50GkCSuX6vr2qTerRqUQrvbdlAbZ7OpLfmXRmRnVUmKMOZGBMfYn7il
         34bQ7dLn6c6ccLIfSOQk8ypMzkskCSknF9H20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqdJq1f/qIhweQts5AB1HeIVb9O7ywkFDNZusrXv0ac=;
        b=sm7rGyXERaKylhUKcg6EC+gKb3sEsvsVZ2cT+5heUB1DLBPlL3LzvS8G/v4eSmXkuP
         bzQHLBNforSoz5IJS3CbHBiBF0CaiwnowTpRY4xtwKny2oG4rjGd8vB2Kzsnmfl9P0SX
         O+89eBG546xr1WFCaNj3fCCVkLmbEyGMio1/gnGTpro8gaiGc1wAeHz5rMrcdr8LVQo2
         30NBqBIcrxPcAtGjZwnbnF6fhcflcwzIqBdaGC98vkmNS8fFXxztnu04NQ9kyeJ/YMYb
         MT5DaxI/L/yvMaSjbyQ9C80akqSrr6VDH7RUXJaFSuOMd2E9vZBkVdbOpkx2nk/VSzqm
         bt5A==
X-Gm-Message-State: APjAAAV3ije7/y0L7etEZEKLsie+rTBeY6ie+ItJMvhzwpGi49qN9NuC
        38JssVkp6JlcIDgElzp5hb09q77ufoU=
X-Google-Smtp-Source: APXvYqzXWBsor63tKN2AgJDLBB+GtJBK1G4sl82zUXXEOLvUtrxWETktCMpRaLIkondZn/nUotOnNw==
X-Received: by 2002:a17:906:6bcd:: with SMTP id t13mr5408941ejs.231.1572384606334;
        Tue, 29 Oct 2019 14:30:06 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id m12sm364ejn.13.2019.10.29.14.30.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 14:30:05 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id g24so4166729wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:30:05 -0700 (PDT)
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr6068671wmo.147.1572384604588;
 Tue, 29 Oct 2019 14:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190730191303.206365-1-thgarnie@chromium.org>
 <20190730191303.206365-9-thgarnie@chromium.org> <20190809173003.GG2152@zn.tnic>
In-Reply-To: <20190809173003.GG2152@zn.tnic>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Tue, 29 Oct 2019 14:29:53 -0700
X-Gmail-Original-Message-ID: <CAJcbSZGfHDthCz4h_h19zGN5Mb9yC+2FCfKs7-rfCuF=G9rP3w@mail.gmail.com>
Message-ID: <CAJcbSZGfHDthCz4h_h19zGN5Mb9yC+2FCfKs7-rfCuF=G9rP3w@mail.gmail.com>
Subject: Re: [PATCH v9 08/11] x86/boot/64: Adapt assembly for PIE support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Feng Tang <feng.tang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 10:29 AM Borislav Petkov <bp@alien8.de> wrote:
>
> chOn Tue, Jul 30, 2019 at 12:12:52PM -0700, Thomas Garnier wrote:
> > Change the assembly code to use only relative references of symbols for the
> > kernel to be PIE compatible.
> >
> > Early at boot, the kernel is mapped at a temporary address while preparing
> > the page table. To know the changes needed for the page table with KASLR,
>
> These manipulations need to be done regardless of whether KASLR is
> enabled or not. You're basically accomodating them to PIE.
>
> > the boot code calculate the difference between the expected address of the
>
> calculates
>
> > kernel and the one chosen by KASLR. It does not work with PIE because all
> > symbols in code are relatives. Instead of getting the future relocated
> > virtual address, you will get the current temporary mapping.
>
> Please avoid "you", "we" etc personal pronouns in commit messages.
>
> > Instructions were changed to have absolute 64-bit references.
>
> From Documentation/process/submitting-patches.rst:
>
>  "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>   to do frotz", as if you are giving orders to the codebase to change
>   its behaviour."

Sorry for the late reply, busy couple months.

I will integrate your feedback in v10. Thanks.

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
