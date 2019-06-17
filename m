Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12590C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E512084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfFQSVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:21:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:18866 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfFQSVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:21:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 11:21:13 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2019 11:21:13 -0700
Date:   Mon, 17 Jun 2019 11:11:42 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
Message-ID: <20190617181142.GA217081@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
 <20190611085410.GT3436@hirez.programming.kicks-ass.net>
 <0D67CEAC-9710-4ECB-9248-75B48542FF82@amacapital.net>
 <20190611172717.GC3436@hirez.programming.kicks-ass.net>
 <CALCETrW9gWtdHC3-b-VuWms5RRsSFuhhP1RsGrPDm0_bHZXK_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrW9gWtdHC3-b-VuWms5RRsSFuhhP1RsGrPDm0_bHZXK_A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 08:14:44AM -0700, Andy Lutomirski wrote:
> On Tue, Jun 11, 2019 at 10:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > (can you, perchance, look at a MUA that isn't 'broken' ?)
> >
> > On Tue, Jun 11, 2019 at 09:04:30AM -0700, Andy Lutomirski wrote:
> > >
> > >
> > > > On Jun 11, 2019, at 1:54 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > >> On Fri, Jun 07, 2019 at 03:00:35PM -0700, Fenghua Yu wrote:
> > > >> C0.2 state in umwait and tpause instructions can be enabled or disabled
> > > >> on a processor through IA32_UMWAIT_CONTROL MSR register.
> > > >>
> > > >> By default, C0.2 is enabled and the user wait instructions result in
> > > >> lower power consumption with slower wakeup time.
> > > >>
> > > >> But in real time systems which require faster wakeup time although power
> > > >> savings could be smaller, the administrator needs to disable C0.2 and all
> > > >> C0.2 requests from user applications revert to C0.1.
> > > >>
> > > >> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02" is
> > > >> created to allow the administrator to control C0.2 state during run time.
> > > >
> > > > We already have an interface for applications to convey their latency
> > > > requirements (pm-qos). We do not need another magic sys variable.
> > >
> > > I’m not sure I agree.  This isn’t an overall latency request, and
> > > setting an absurdly low pm_qos will badly hurt idle power and turbo
> > > performance.  Also, pm_qos isn’t exactly beautiful.
> > >
> > > (I speak from some experience. I may be literally the only person to
> > > write a driver that listens to dev_pm_qos latency requests. And, in my
> > > production box, I directly disable c states instead of messing with
> > > pm_qos.)
> > >
> > > I do wonder whether anyone will ever use this particular control, though.
> >
> > I agree that pm-qos is pretty terrible; but that doesn't mean we should
> > just add random control files all over the place.
> 
> I don't think pm-qos is expressive enough.  It seems entirely
> reasonable to want to do a C0.1 wait for lower latency *while waiting*
> but still want full power-saving idle when not waiting.
> 
> Do we even know what the C0.2 and C0.1 latencies are?  And why is this
> thing an MSR instead of a flag passed to UMWAIT?

I will still keep this sysfs interface in the next version of patches, right?

Thanks.

-Fenghua
