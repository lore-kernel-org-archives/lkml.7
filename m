Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F28ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269242168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUQH95Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfJARNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:13:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45674 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfJARNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:13:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id q7so10065083pgi.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6C8PPfwqos/xyCjtM97fgsnhM67RrRfY2Cr8/MMkmOA=;
        b=tUQH95EvgiPfl0Y+fg6kKu08+CgUfXrJXrWkufCK5PE64yrkG/R9g/iTCe/S+iz38W
         Myzy8n1qnPCY01xSN2FM3VFvCBqPoDdo63Q0OaUkFeXgdh/K26rsn0wSSg6VWLDdg1Ix
         dRQEDrRIuDaI9zSk4rPWRTHedvcW7wmFcHhflR1pJtWFj7qrTOBASvSZpVtDWbW3wJZ8
         VKriPmlX7ad0CnwbJQuedyuZW9j7d1gaTuPkVYKkQbciLDsB0bC+/lgZArMSReHnnKFV
         zPaV05g7z0avF+9ISuuWz+vNwqxEszHiin3Ip8aczWGRy6rEgHMCq5Lh78qf/5cKrn93
         KNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6C8PPfwqos/xyCjtM97fgsnhM67RrRfY2Cr8/MMkmOA=;
        b=iosk0agi77bg3io0XNPnfIVc4dncBRy13MHnanhDEwG8pyjqHD2g3yJYPBP91VsS3N
         EeYkpFVxCyRGyHJ6Q+jUl84T3upw+sOoVEj5b1PSYiC+yEuk/pFjGhx8WpIka7Ajdaak
         GkAJyExnYvbEOniAPlh37E/iJ874boXin+Na8sS0Xgxa23cFbqa/d8jnuSVR33FRk4zd
         2YYVpK3sWwTtFHYDW/K26cPy0Dwheelc+TMG0ZENM/r7nNZg+WJ1J0V8hwPOHjHK2WBH
         TZZpyCRH/4McnNdd4CNjRbtvJnWTk/5YJQU3rrylswecQz6zsYGtNMGHK79AFD7JNHtC
         LGMQ==
X-Gm-Message-State: APjAAAW5dLzNzwshjH9h0cQJ8WNpbpUOBKKPYavpPjBBJIN/rkJ2DJrZ
        X3lVKpVceQKfdn/YgAQw5qfoYrv0TFVkqmeqZdhPPuUt
X-Google-Smtp-Source: APXvYqx/scIWirpOYrA9tus4XSZDjm1o5VEP7KJ7Jgb2bzdi5lU3I4H9J8QadwZuzGoUpwaQkaBKGWy5WvkMVwIpjhg=
X-Received: by 2002:a63:2f45:: with SMTP id v66mr7548913pgv.263.1569949991015;
 Tue, 01 Oct 2019 10:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck> <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com> <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com> <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
 <20191001153056.GO41399@arrakis.emea.arm.com> <20191001164657.l2wz3ghq6icm3lim@willie-the-truck>
 <CAKwvOd=+-PEQXOZBG6rprWdOzHfcQq9ojkGo+Q28vfC4AU=Hwg@mail.gmail.com> <20191001170753.sqmfqt7zf33jgzns@willie-the-truck>
In-Reply-To: <20191001170753.sqmfqt7zf33jgzns@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 10:12:59 -0700
Message-ID: <CAKwvOdm3E=Gp1XYfs6tcNObkJXA+VwvtLZt81mQ-mbo2gtyTaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 10:08 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Oct 01, 2019 at 09:59:43AM -0700, Nick Desaulniers wrote:
> > On Tue, Oct 1, 2019 at 9:47 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Tue, Oct 01, 2019 at 04:30:56PM +0100, Catalin Marinas wrote:
> > > > In the long run, I wouldn't mandate CROSS_COMPILE_COMPAT to always be
> > > > set for the compat vDSO since with clang we could use the same compiler
> > > > binary for both native and compat (with different flags). That's once we
> > > > cleaned up the headers.
> > >
> > > But we'll still need it even with clang so that the relevant triple can be
> > > passed to the --target option. The top-level Makefile already does this:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n544
> >
> > That's not pulling the cross compiler out of a *config* (as this patch
> > is proposing); rather from an env var.
>
> CROSS_COMPILE_COMPAT is the environment variable, right? If not, then I have
> my terminology mixed up.

Ah, sorry, I'm the one misreading the patch.  I thought the commit
message was showing what the new process would be. I see now that it's
describing the issue pre-patch.  My mistake.

>
> > > so I think we should do the same thing for the compat vdso as well, which
> > > would allow us to remove this complexity by requiring that
> > > CROSS_COMPILE_COMPAT identifies the cross-compiler to use in exactly the
> > > same way as CROSS_COMPILE does.
> > >
> > > Am I missing something here?
> >
> > I think the second paragraph you wrote shows we're all in agreement,
> > but I suspect you may be conflating *how* the toplevel Makefile knows
> > we're doing a cross compile.  It doesn't read a config, this patch
> > would make it so a cross compiler is specified via config, Catalin
> > asked "please no," I agree with Catalin (and I suspect you do too).
>
> Yes, I'm saying let's have an environment variable only and drop the
> CONFIG stuff completely. I think this means that the environment variable
> must always be specified if you want the compat vDSO, but I don't see that
> as a problem.
>
> Will



-- 
Thanks,
~Nick Desaulniers
