Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE2820848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfCENeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:34:25 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37570 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCENeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:34:25 -0500
Received: by mail-it1-f195.google.com with SMTP id z124so4451630itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 05:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1HuBxsxpVtJ+RVyOZrjsj4BRmjBSB53lrOmIhikXCQ=;
        b=mMZesd4WnJu/58mUFBiI0gbEbK07XUS/kJKClycfl8GL4I3ixVR3jy8mF91vCKLYbO
         jF77gArVPuQ3drzgf3PciUhS94TDCkciqLR8VlpBdglxD/683HTlhvOnFbpQy+Orn9Vo
         8R4Qv82STbASOdSPm8eubVWhCB0w6/XS/pSHKLyYI5Rv4uHjizbHgNNN/duix5kqrMpU
         14v5TS2xaQmABAlB+0kTRH0cYG62nqShEncDWzYC4fVc9JQnS/XNmtBl0bKfm4ZE+Eb+
         wTrAYEY65Z1U5pMj/WK9uWOpH4d7G09pcJvzZzzL/QMY+MnkNgb+LATIaFsLolW03Rvy
         4F6g==
X-Gm-Message-State: APjAAAWNyf8C/YaZgCOlScU8YjFzkWKn4wyvJoQQuLcK0FmhN/vB0b2J
        dCMqZEQL7T5B8nJph8dJGpxFV8mDP7Yk6jpTK5dieA==
X-Google-Smtp-Source: APXvYqwGdMtkiUFdjT6+uIAcGP0qutDvYS+iK0MmFCUJ5HG8jWUa2HOfCQGI2DgRQ082pX2WBtCA6y4pzUK8y2eGnwc=
X-Received: by 2002:a24:73c5:: with SMTP id y188mr2653344itb.147.1551792864344;
 Tue, 05 Mar 2019 05:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20190305121703.29769-1-kasong@redhat.com> <20190305123329.GK32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190305123329.GK32477@hirez.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 5 Mar 2019 21:34:13 +0800
Message-ID: <CACPcB9c=M26J8V7S_SzuccCTcPkr1DOUqK6w01esieJYYeBpEA@mail.gmail.com>
Subject: Re: [PATCH v2] x86, hyperv: fix kernel panic when kexec on HyperV
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        devel@linuxdriverproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 8:33 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 05, 2019 at 08:17:03PM +0800, Kairui Song wrote:
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 7abb09e2eeb8..34aa1e953dfc 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -406,6 +406,12 @@ void hyperv_cleanup(void)
> >       /* Reset our OS id */
> >       wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> >
> > +     /* Cleanup hypercall page reference before reset the page */
> > +     hv_hypercall_pg = NULL;
> > +
> > +     /* Make sure page reference is cleared before wrmsr */
>
> This comment forgets to tell us who cares about this. And why the wrmsr
> itself isn't serializing enough.
>
> > +     wmb();
> > +
> >       /* Reset the hypercall page */
> >       hypercall_msr.as_uint64 = 0;
> >       wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>
> That looks like a fake MSR; and you're telling me that VMEXIT doesn't
> serialize?

Thanks for the review, seem I being a bit paranoid on this. Will drop
it and send a v3 if no one has any other complaint.

--
Best Regards,
Kairui Song
