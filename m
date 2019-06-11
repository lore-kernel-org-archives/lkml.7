Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3726FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1065220866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406198AbfFKRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:47:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:15394 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405488AbfFKRrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:47:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 10:46:55 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2019 10:46:55 -0700
Date:   Tue, 11 Jun 2019 10:37:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 0/5] x86/umwait: Enable user wait instructions
Message-ID: <20190611173733.GB180343@romley-ivt3.sc.intel.com>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <20190611090145.GU3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611090145.GU3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:01:45AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 07, 2019 at 03:00:32PM -0700, Fenghua Yu wrote:
> > Today, if an application needs to wait for a very short duration
> > they have to have spinloops. Spinloops consume more power and continue
> > to use execution resources that could hurt its thread siblings in a core
> > with hyperthreads. New instructions umonitor, umwait and tpause allow
> > a low power alternative waiting at the same time could improve the HT
> > sibling perform while giving it any power headroom. These instructions
> > can be used in both user space and kernel space.
> > 
> > A new MSR IA32_UMWAIT_CONTROL allows kernel to set a time limit in
> > TSC-quanta that prevents user applications from waiting for a long time.
> > This allows applications to yield the CPU and the user application
> > should consider using other alternatives to wait.
> 
> I'm confused on the purpose of this control; what do we win by limiting
> this time?

In previous patches, there is no time limit (max time is 0 which means no
time limit).

Andy Lutomirski proposed to set the time limit:

https://lkml.org/lkml/2019/2/26/735

"So I propose setting the timeout to either 100 microseconds or 100k
"cycles" by default.  In the event someone determines that they save
materially more power or gets materially better performance with a
longer timeout, we can revisit the value."

Does it make sense?

> 
> >  .../ABI/testing/sysfs-devices-system-cpu      |  21 ++
> >  arch/x86/include/asm/cpufeatures.h            |   1 +
> >  arch/x86/include/asm/msr-index.h              |   4 +
> >  arch/x86/power/Makefile                       |   1 +
> >  arch/x86/power/umwait.c                       | 182 ++++++++++++++++++
> 
> You seem to miss the arch/x86/lib/delay.c change to use this fancy new
> stuff for udelay(). I'm thinking that's exactly what TPAUSE is good for.

There may be other places to use the instructions. But I think this
patch set just first enables basic functionalities. We can focus on how to
use the instructions in the future.

Thanks.

-Fenghua
