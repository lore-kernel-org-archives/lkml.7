Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A7C206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfCENcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:32:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46612 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCENcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:32:16 -0500
Received: by mail-io1-f66.google.com with SMTP id k21so7015494ior.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 05:32:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPL+mFcnFk2fiGgyvGc6vDBsgRlRRz/RaTsBeOLEc94=;
        b=mYVsaz4NYoeFolbK1/2Y+/yKwEUALM6gUxMCgzKEEfCHttCMOSY/Wzq4W/K91tVzr7
         G6Lzg+PqzP98nXxUSxPEhZniRPhM5Jy+/X1nrtrQqsvFA91kvNKHqcpPpgtTas/3T1Uw
         Yzuwu9o4z39ZvOuwxA3mOlYRr0SEOxi4d+1Yh2etdewj7QlUuhWA6DaDWSlbvFD3HRgj
         cZmbWJtSDqpHjPcbxiXpqpmZ3HprgLygqSleykx8U8OS7Zqxh0fB3+UCSrH3/92lDdab
         bk7FMKBo4kRKaFCVCR8e+Am8Kb3JfE5SiPRhz/I5FS8BKmB/2PVYBLjIpQ89BOulHrpJ
         nuUQ==
X-Gm-Message-State: APjAAAXu/zfDyMzH4Cbx82OFwvduBwz2d9epZin2zqoY4zQmWi7WzoSc
        SYj1OOIYWpgYp6grrhrAQctiOkek0+zp0JZDOVujFg==
X-Google-Smtp-Source: APXvYqwWlJhsKFyJO0H7b0uFjzW5/GM2/w6sO+J2UainYEThrBbAlUb7ax/rHQ4L3QKD40e72qi8zZlsoEdgt0/VfpM=
X-Received: by 2002:a6b:37d4:: with SMTP id e203mr13072860ioa.137.1551792736186;
 Tue, 05 Mar 2019 05:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20190226155615.16724-1-kasong@redhat.com> <20190227120141.GN32494@hirez.programming.kicks-ass.net>
 <CACPcB9c86eT=kXcXkBkUjZnifk5bZ71SogfW2tyNudrVmWbnDQ@mail.gmail.com> <20190305122827.GJ32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190305122827.GJ32477@hirez.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 5 Mar 2019 21:32:05 +0800
Message-ID: <CACPcB9dwKK2YRU+xDvp8AEKDikjJF6Y047MoJ-RxVM49G6rwQg@mail.gmail.com>
Subject: Re: [RFC PATCH] x86, hyperv: fix kernel panic when kexec on HyperV VM
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

On Tue, Mar 5, 2019 at 8:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 27, 2019 at 10:55:46PM +0800, Kairui Song wrote:
> > On Wed, Feb 27, 2019 at 8:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 11:56:15PM +0800, Kairui Song wrote:
> > > >  arch/x86/hyperv/hv_init.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > > index 7abb09e2eeb8..92291c18d716 100644
> > > > --- a/arch/x86/hyperv/hv_init.c
> > > > +++ b/arch/x86/hyperv/hv_init.c
> > > > @@ -406,6 +406,10 @@ void hyperv_cleanup(void)
> > > >       /* Reset our OS id */
> > > >       wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> > > >
> > > > +     /* Cleanup page reference before reset the page */
> > > > +     hv_hypercall_pg = NULL;
> > > > +     wmb();
> > >
> > > What do we need that SFENCE for? Any why does it lack a comment?
> >
> > Hi, that's for ensuring the hv_hypercall_pg is reset to NULL before
> > the following wrmsr call. The wrmsr call will make the pointer address
> > invalid.
>
> WRMSR is a serializing instruction (except for TSC_DEADLINE and the
> X2APIC).
>

Many thanks for the info, I'm not aware of the exception condition, V2
is sent, will drop the barrier in V3 then.

-- 
Best Regards,
Kairui Song
