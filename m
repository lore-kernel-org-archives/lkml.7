Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C20C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451F7204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406744AbfFKUrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:47:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59664 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406018AbfFKUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:47:12 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hanfU-0005Ew-Ja; Tue, 11 Jun 2019 22:46:56 +0200
Date:   Tue, 11 Jun 2019 22:46:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
In-Reply-To: <20190610041343.GC162238@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1906112242410.2214@nanos.tec.linutronix.de>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com> <1559944837-149589-3-git-send-email-fenghua.yu@intel.com> <CALCETrWtmrwqjThkMKU9YpTDK4o95V4HBb2_yQF2tvx5JZ9Ukw@mail.gmail.com> <20190610041343.GC162238@romley-ivt3.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019, Fenghua Yu wrote:

> On Sat, Jun 08, 2019 at 03:52:42PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > >
> > > umwait or tpause allows processor to enter a light-weight
> > > power/performance optimized state (C0.1 state) or an improved
> > > power/performance optimized state (C0.2 state) for a period
> > > specified by the instruction or until the system time limit or until
> > > a store to the monitored address range in umwait.
> > >
> > > IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> > > on the processor and set maximum time the processor can reside in
> > > C0.1 or C0.2.
> > >
> > > By default C0.2 is enabled so the user wait instructions can enter the
> > > C0.2 state to save more power with slower wakeup time.
> > 
> > Sounds good, but:
> > 
> > > +#define MSR_IA32_UMWAIT_CONTROL_C02            BIT(0)
> > 
> > > +static u32 umwait_control_cached = 100000;
> > 
> > The code seems to disagree.
> 
> The definition of bit[0] is: C0.2 is disabled when bit[0]=1. So
> 100000 means C0.2 is enabled (and max time is 100000).

which is totally non obvious. If you have to encode the control bit, then
please make it explicit, i.e. mask out the disable bit in the initializer.

Thanks,

	tglx
