Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA9C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FB720820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfFJEXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:23:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:63398 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfFJEXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:23:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2019 21:23:02 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2019 21:23:02 -0700
Date:   Sun, 9 Jun 2019 21:13:43 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
Message-ID: <20190610041343.GC162238@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
 <CALCETrWtmrwqjThkMKU9YpTDK4o95V4HBb2_yQF2tvx5JZ9Ukw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWtmrwqjThkMKU9YpTDK4o95V4HBb2_yQF2tvx5JZ9Ukw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 03:52:42PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> >
> > umwait or tpause allows processor to enter a light-weight
> > power/performance optimized state (C0.1 state) or an improved
> > power/performance optimized state (C0.2 state) for a period
> > specified by the instruction or until the system time limit or until
> > a store to the monitored address range in umwait.
> >
> > IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> > on the processor and set maximum time the processor can reside in
> > C0.1 or C0.2.
> >
> > By default C0.2 is enabled so the user wait instructions can enter the
> > C0.2 state to save more power with slower wakeup time.
> 
> Sounds good, but:
> 
> > +#define MSR_IA32_UMWAIT_CONTROL_C02            BIT(0)
> 
> > +static u32 umwait_control_cached = 100000;
> 
> The code seems to disagree.

The definition of bit[0] is: C0.2 is disabled when bit[0]=1. So
100000 means C0.2 is enabled (and max time is 100000).

Would it be better to change 
+#define MSR_IA32_UMWAIT_CONTROL_C02            BIT(0)
to
+#define MSR_IA32_UMWAIT_CONTROL_C02_DISABLED            BIT(0)
?

Thanks.

-Fenghua
