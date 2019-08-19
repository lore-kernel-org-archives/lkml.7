Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36855C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BCC22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXb6e6bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfHSVRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:17:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35724 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfHSVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:17:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so3116388lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmRUWuZGRYvejqJ0CUl2fCALAk85wX0lVFMjrXImZdc=;
        b=mXb6e6bs4QT2yrjP7C/IBvcnLtOpwDkhvqsFMtttgrfiPi4UgcnjRWaQq+IgLVV7PH
         K6eGkIc1bpr4dPKOCCdSjwqiW8M7MmAi5XXShZeEw6JDX1QrSf7cjFCIsHfKeuQ3PZ5i
         QTH91MnnjYGe+seCnwB0N/IAWNczvsmAu5eU8PDdU6TgGSsn0YBeKZN/+B8H1QUuwg1k
         aCwFMQChTDjwVGRjyC8SHR5H/i2VSEQmRLoEc5TF7WMc3LTCM48uia3u6e3h9KQjFzXS
         r5V7pBW7M2aCORdpwLs2mXxjGr7qZX38oVMM/Q6/3mfr8ac/5uwV1NXDCG2OclY1gs9E
         xi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmRUWuZGRYvejqJ0CUl2fCALAk85wX0lVFMjrXImZdc=;
        b=EDqw0yy8VgfE1/UPn5Y3PhD/MbNbxRjGWcYk0qilkfexjAJiXz9ezxxyzhDRggiaT9
         /ndRX1UqkttUHE8QfqF6NrLd89dsLERIGyzEFKV8nM3DpjFbvSCgrKkxhMY6vCp4o34f
         0nr2Nh9xLNhQSN331q1ty/J1ga4McOIGio49f7SSCGYmA7QEyCOd2+D/2PkDEZ3DCbsp
         d1gMPTmc8mzLGBaeE0G6QDasKLCxG1GWBA5c1VxfgswbOaDa+Uqd912uqBaEy88sT/P3
         9+34mmYomUbbB+98Gu1KHJ4o5wukwGC+RDw6fMD/lfm576PBWHfef/FzgQ8+LPdSmTQb
         siBw==
X-Gm-Message-State: APjAAAV8FKRsbvIrIxvF8x3aWZG5KX54iE7uDqZj8IqEolG3F9howYzN
        Swn+ZpoYA5Jza+5gXbQVjqbPaMAUdlKcMcx/Gzc=
X-Google-Smtp-Source: APXvYqy1GFc5HAFGJmn7rYkaNBH47OgtGx7qy0XbSmtI+2P81BmyAie9L36Zrmy6MT9jzHiB85YQ8D30ZNzPkq+johQ=
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr13933150ljr.119.1566249457346;
 Mon, 19 Aug 2019 14:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
 <20180223121456.GZ25201@hirez.programming.kicks-ass.net> <20180226203937.GA21543@tassilo.jf.intel.com>
 <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com>
 <alpine.DEB.2.21.1908121933310.7324@nanos.tec.linutronix.de>
 <CAKA=qzY=F-wj8YXhb-B7RahNceeab0rSA=06qBc8+7V-SyY-+Q@mail.gmail.com>
 <alpine.DEB.2.21.1908122133310.7324@nanos.tec.linutronix.de> <CAKA=qzYTax6ECQBChUrNWMRp5iY9F2SezMY2Ma_zmWxiDgjOSA@mail.gmail.com>
In-Reply-To: <CAKA=qzYTax6ECQBChUrNWMRp5iY9F2SezMY2Ma_zmWxiDgjOSA@mail.gmail.com>
From:   Josh Hunt <joshhunt00@gmail.com>
Date:   Mon, 19 Aug 2019 14:17:25 -0700
Message-ID: <CAKA=qzY_2S11MTMEjLtQHJLgHV_nY8893EhBm4-gBmS+duYBDA@mail.gmail.com>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 12:42 PM Josh Hunt <joshhunt00@gmail.com> wrote:
>
> On Mon, Aug 12, 2019 at 12:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, 12 Aug 2019, Josh Hunt wrote:
> > > On Mon, Aug 12, 2019 at 10:55 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Mon, 12 Aug 2019, Josh Hunt wrote:
> > > > > Was there any progress made on debugging this issue? We are still
> > > > > seeing it on 4.19.44:
> > > >
> > > > I haven't seen anyone looking at this.
> > > >
> > > > Can you please try the patch Ingo posted:
> > > >
> > > >   https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/
> > > >
> > > > and if it fixes the issue decrease the value from 128 to the point where it
> > > > comes back, i.e. 128 -> 64 -> 32 ...
> > > >
> > > > Thanks,
> > > >
> > > >         tglx
> > >
> > > I just checked the machines where this problem occurs and they're both
> > > Nehalem boxes. I think Ingo's patch would only help Haswell machines.
> > > Please let me know if I misread the patch or if what I'm seeing is a
> > > different issue than the one Cong originally reported.
> >
> > Find the NHM hack below.
> >
> > Thanks,
> >
> >         tglx
> >
> > 8<----------------
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 648260b5f367..93c1a4f0e73e 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3572,6 +3572,11 @@ static u64 bdw_limit_period(struct perf_event *event, u64 left)
> >         return left;
> >  }
> >
> > +static u64 nhm_limit_period(struct perf_event *event, u64 left)
> > +{
> > +       return max(left, 128ULL);
> > +}
> > +
> >  PMU_FORMAT_ATTR(event, "config:0-7"    );
> >  PMU_FORMAT_ATTR(umask, "config:8-15"   );
> >  PMU_FORMAT_ATTR(edge,  "config:18"     );
> > @@ -4606,6 +4611,7 @@ __init int intel_pmu_init(void)
> >                 x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
> >                 x86_pmu.enable_all = intel_pmu_nhm_enable_all;
> >                 x86_pmu.extra_regs = intel_nehalem_extra_regs;
> > +               x86_pmu.limit_period = nhm_limit_period;
> >
> >                 mem_attr = nhm_mem_events_attrs;
> >
> Thanks Thomas. Will try this and let you know.
>
> --
> Josh

Thomas

I found on my setup that setting the value to 32 was the lowest value
I could use to keep the problem from happening. Let me know if you
want me to send a patch with the updated value, etc.

I saw in the original thread from Ingo and Vince that this was seen on
Haswell, but I checked our Haswell boxes and so far we have not
reproduced the problem there.

-- 
Josh
