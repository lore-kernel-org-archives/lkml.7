Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E84C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E022084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfFQXBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:01:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:38492 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfFQXBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:01:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 16:01:17 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2019 16:01:17 -0700
Date:   Mon, 17 Jun 2019 15:51:46 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
Message-ID: <20190617225146.GE217081@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrWi+uM5Rch6vaXOwHsHas928CDY5VJoBYaudD+3VFTrNw@mail.gmail.com>
 <20190610040449.GB162238@romley-ivt3.sc.intel.com>
 <CALCETrWZukWNeiCCwSMPxSHnn6YB_jJeiv4wd2MZAU9pwXf80g@mail.gmail.com>
 <20190617224820.GD217081@romley-ivt3.sc.intel.com>
 <CALCETrXnOKo3daWp-oSwaVZagQ_iP7SHCbpoB2VioWhRds5gqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXnOKo3daWp-oSwaVZagQ_iP7SHCbpoB2VioWhRds5gqw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:59:28PM -0700, Andy Lutomirski wrote:
> On Mon, Jun 17, 2019 at 3:57 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > On Sun, Jun 09, 2019 at 09:26:29PM -0700, Andy Lutomirski wrote:
> > > On Sun, Jun 9, 2019 at 9:14 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > >
> > > > On Sat, Jun 08, 2019 at 03:52:03PM -0700, Andy Lutomirski wrote:
> > > > > On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > > > >
> > > > > > C0.2 state in umwait and tpause instructions can be enabled or disabled
> > > > > > on a processor through IA32_UMWAIT_CONTROL MSR register.
> > > > > >
> > > > >
> > > > > > +static u32 get_umwait_control_c02(void)
> > > > > > +{
> > > > > > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02;
> > > > > > +}
> > > > > > +
> > > > > > +static u32 get_umwait_control_max_time(void)
> > > > > > +{
> > > > > > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> > > > > > +}
> > > > > > +
> > > > >
> > > > > I'm not convinced that these helpers make the code any more readable.
> > > >
> > > > The helpers reduce length of statements that call them. Otherwise, all of
> > > > the statements would be easily over 80 characters.
> > > >
> > > > Plus, each of the helpers is called multiple places in #0003 and #0004.
> > > > So the helpers make the patches smaller and cleaner.
> > > >
> > >
> > > I was imagining things like:
> > >
> > > umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_C02;
> > > if (whatever condition)
> > >   umwait_control_cached |= MSR_IA32_UMWAIT_CONTROL_C02;
> > > umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> > > umwait_control_cached |= new_max_time;
> >
> > How about this statement?
> > With the helpers:
> >         umwait_control_cached = max_time | get_umwait_control_c02();
> > If there is no helpers, the above statement will need two statements:
> >         umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> >         umwait_control_cached |= max_time;
> >
> > Another example:
> > With the helpers:
> >         if (umwait_control_c02 == get_umwait_control_c02())
> > If no helpers, the above statement will be long:
> >        if (umwait_control_c02 == (umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02_DISABLED))
> >
> > There are quite a few places like above examples.
> >
> > The helpers can reduce the length of those long lines and make code more
> > readable and shorter, right?
> >
> > Can I still keep the helpers?
> >
> 
> Sure, unless someone else objects.

Thank you very much for your advice!

-Fenghua
