Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A731AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734D1233FE
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z69PyISM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfHVObc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:31:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42935 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733053AbfHVObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:31:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so4693635lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6vURle/yUma+eW5rLJzWOxNL358DqVD4LvDOo35ub4=;
        b=Z69PyISMAGubDibz/jDX9RD9SsPVwEzQmzrpqarBcmpM+eu/UGhwntcwqKskrvNSXg
         fVRZ0My+OBfqEvJxZbiUtRqoz5VR5OKw2bp2pHU/7kXNShJ6OHeONvD4F6RDImnjxdYh
         OUu1nz38bWX/75Ut2ii6qegPhgRKpza6T1opofsn9VxnPk+32GJEhQSiyJt1bgKLNpiL
         pfekHdCC587hvfbr5d9atg2kLoUdFLNitVnki5j98ESn1tAhUy5dzumLvvs+FbYD0KV0
         gMBXcI8uJWp9I+Uy0Z3/SBacREbDbz7iYAhNlQuHtz1N/lpuMnPiykIcGCCySIKZYLvW
         36ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6vURle/yUma+eW5rLJzWOxNL358DqVD4LvDOo35ub4=;
        b=rv3+r6lOIJ5hL1WZ7spuIE7RiYV0zfXqZvcqLUPocXJBEO8w2iv9g4Zn6Io4WwezLg
         WlxwzO+Op0qzhHLkitSc03FKWo15Mz27dxkEhd590c+H/ZmbbFN+VeLUh7lxkU+yndbe
         aW9ReR+SABxXDQW6p2I80nSfDMNYf0gj2MER1odi0w4HnmvCHC+9Gj5ccc/3+kFUlilB
         6qioY4GLpcuBBrqpoWAK2TYSaVWARjmuvzvV9IBY+FgyZRHa5rJ/8FRpioGtexwcHXZA
         cCGrnm/jLkFSCrg3GeQw9WNMLD0BvIwlHAFuTCfBhe3I9eYNgt0fYN62Y7EY90YmZzhH
         oogA==
X-Gm-Message-State: APjAAAVWx8WBN9SbwmnGHovTC9iI5Lk26icUPpf7zy4ytHqrg6qrmhhm
        dUfTDm3OtT7jP30ypvrrIAd8Hdek8Xk+/wIDD+A=
X-Google-Smtp-Source: APXvYqz1avAYh0AsWmsURnKU/2s4bG/mkiWMach7jmQuStEunA2n4c+7wznzV+RVNP/7g3QUlUZfehY390JwpdzgaN4=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr21575220lff.93.1566484289181;
 Thu, 22 Aug 2019 07:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
 <20180223121456.GZ25201@hirez.programming.kicks-ass.net> <20180226203937.GA21543@tassilo.jf.intel.com>
 <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com>
 <alpine.DEB.2.21.1908121933310.7324@nanos.tec.linutronix.de>
 <CAKA=qzY=F-wj8YXhb-B7RahNceeab0rSA=06qBc8+7V-SyY-+Q@mail.gmail.com>
 <alpine.DEB.2.21.1908122133310.7324@nanos.tec.linutronix.de>
 <CAKA=qzYTax6ECQBChUrNWMRp5iY9F2SezMY2Ma_zmWxiDgjOSA@mail.gmail.com>
 <CAKA=qzY_2S11MTMEjLtQHJLgHV_nY8893EhBm4-gBmS+duYBDA@mail.gmail.com> <CAKA=qzann=Ex3owK7mJezq3JfkD1HxPiVAqQSSA=u7tPYVVXZA@mail.gmail.com>
In-Reply-To: <CAKA=qzann=Ex3owK7mJezq3JfkD1HxPiVAqQSSA=u7tPYVVXZA@mail.gmail.com>
From:   Josh Hunt <joshhunt00@gmail.com>
Date:   Thu, 22 Aug 2019 07:31:17 -0700
Message-ID: <CAKA=qzaxQ1_CsJHay17r1kfJ8D99Bnqd9OY0BqX=HH2aed9ZfQ@mail.gmail.com>
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

On Mon, Aug 19, 2019 at 4:16 PM Josh Hunt <joshhunt00@gmail.com> wrote:
>
> On Mon, Aug 19, 2019 at 2:17 PM Josh Hunt <joshhunt00@gmail.com> wrote:
> >
> > On Mon, Aug 12, 2019 at 12:42 PM Josh Hunt <joshhunt00@gmail.com> wrote:
> > >
> > > On Mon, Aug 12, 2019 at 12:34 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Mon, 12 Aug 2019, Josh Hunt wrote:
> > > > > On Mon, Aug 12, 2019 at 10:55 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > >
> > > > > > On Mon, 12 Aug 2019, Josh Hunt wrote:
> > > > > > > Was there any progress made on debugging this issue? We are still
> > > > > > > seeing it on 4.19.44:
> > > > > >
> > > > > > I haven't seen anyone looking at this.
> > > > > >
> > > > > > Can you please try the patch Ingo posted:
> > > > > >
> > > > > >   https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/
> > > > > >
> > > > > > and if it fixes the issue decrease the value from 128 to the point where it
> > > > > > comes back, i.e. 128 -> 64 -> 32 ...
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > >         tglx
> > > > >
> > > > > I just checked the machines where this problem occurs and they're both
> > > > > Nehalem boxes. I think Ingo's patch would only help Haswell machines.
> > > > > Please let me know if I misread the patch or if what I'm seeing is a
> > > > > different issue than the one Cong originally reported.
> > > >
> > > > Find the NHM hack below.
> > > >
> > > > Thanks,
> > > >
> > > >         tglx
> > > >
> > > > 8<----------------
> > > >
> > > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > > > index 648260b5f367..93c1a4f0e73e 100644
> > > > --- a/arch/x86/events/intel/core.c
> > > > +++ b/arch/x86/events/intel/core.c
> > > > @@ -3572,6 +3572,11 @@ static u64 bdw_limit_period(struct perf_event *event, u64 left)
> > > >         return left;
> > > >  }
> > > >
> > > > +static u64 nhm_limit_period(struct perf_event *event, u64 left)
> > > > +{
> > > > +       return max(left, 128ULL);
> > > > +}
> > > > +
> > > >  PMU_FORMAT_ATTR(event, "config:0-7"    );
> > > >  PMU_FORMAT_ATTR(umask, "config:8-15"   );
> > > >  PMU_FORMAT_ATTR(edge,  "config:18"     );
> > > > @@ -4606,6 +4611,7 @@ __init int intel_pmu_init(void)
> > > >                 x86_pmu.pebs_constraints = intel_nehalem_pebs_event_constraints;
> > > >                 x86_pmu.enable_all = intel_pmu_nhm_enable_all;
> > > >                 x86_pmu.extra_regs = intel_nehalem_extra_regs;
> > > > +               x86_pmu.limit_period = nhm_limit_period;
> > > >
> > > >                 mem_attr = nhm_mem_events_attrs;
> > > >
> > > Thanks Thomas. Will try this and let you know.
> > >
> > > --
> > > Josh
> >
> > Thomas
> >
> > I found on my setup that setting the value to 32 was the lowest value
> > I could use to keep the problem from happening. Let me know if you
> > want me to send a patch with the updated value, etc.
> >
> > I saw in the original thread from Ingo and Vince that this was seen on
> > Haswell, but I checked our Haswell boxes and so far we have not
> > reproduced the problem there.
> >
> > --
> > Josh
>
> I went ahead and sent this patch with the value set to 32:
> https://lore.kernel.org/lkml/1566256411-18820-1-git-send-email-johunt@akamai.com/T/#u
>
> I wasn't sure how/who to give credit to for the change, so please
> resubmit if what I did is incorrect or if you wanted to debug further.
> If you decide to resubmit the patch please add my tested-by and
> Bhupesh's reported-by. I'm able to reproduce the problem within about
> 2 hours if there's anything else you wanted to look into before going
> with this approach.
>
> Thanks!
> --
> Josh

Thomas

Any thoughts on the above or the patch that I sent?

Thanks!
-- 
Josh
