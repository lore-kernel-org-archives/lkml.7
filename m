Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E00C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FD92189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfH1Iua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:50:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:20784 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1Iu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:50:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 01:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="171472029"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 01:50:27 -0700
Date:   Wed, 28 Aug 2019 17:00:44 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Greg KH <greg@kroah.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "x86/pm: Introduce quirk framework to save/restore extra
 MSR registers around suspend/resume" has been added to the 4.4-stable tree
Message-ID: <20190828090043.GA7589@chenyu-office.sh.intel.com>
References: <20190828041240.12F5221883@mail.kernel.org>
 <20190828084351.GC29927@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828084351.GC29927@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:43:51AM +0200, Greg KH wrote:
> On Wed, Aug 28, 2019 at 12:12:39AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
> > 
> > to the 4.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      x86-pm-introduce-quirk-framework-to-save-restore-ext.patch
> > and it can be found in the queue-4.4 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit d63273440aa0fdebc30d0c931f15f79beb213134
> > Author: Chen Yu <yu.c.chen@intel.com>
> > Date:   Wed Nov 25 01:03:41 2015 +0800
> > 
> >     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
> >     
> >     A bug was reported that on certain Broadwell platforms, after
> >     resuming from S3, the CPU is running at an anomalously low
> >     speed.
> >     
> >     It turns out that the BIOS has modified the value of the
> >     THERM_CONTROL register during S3, and changed it from 0 to 0x10,
> >     thus enabled clock modulation(bit4), but with undefined CPU Duty
> >     Cycle(bit1:3) - which causes the problem.
> >     
> >     Here is a simple scenario to reproduce the issue:
> >     
> >      1. Boot up the system
> >      2. Get MSR 0x19a, it should be 0
> >      3. Put the system into sleep, then wake it up
> >      4. Get MSR 0x19a, it shows 0x10, while it should be 0
> >     
> >     Although some BIOSen want to change the CPU Duty Cycle during
> >     S3, in our case we don't want the BIOS to do any modification.
> >     
> >     Fix this issue by introducing a more generic x86 framework to
> >     save/restore specified MSR registers(THERM_CONTROL in this case)
> >     for suspend/resume. This allows us to fix similar bugs in a much
> >     simpler way in the future.
> >     
> >     When the kernel wants to protect certain MSRs during suspending,
> >     we simply add a quirk entry in msr_save_dmi_table, and customize
> >     the MSR registers inside the quirk callback, for example:
> >     
> >       u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
> >     
> >     and the quirk mechanism ensures that, once resumed from suspend,
> >     the MSRs indicated by these IDs will be restored to their
> >     original, pre-suspend values.
> >     
> >     Since both 64-bit and 32-bit kernels are affected, this patch
> >     covers the common 64/32-bit suspend/resume code path. And
> >     because the MSRs specified by the user might not be available or
> >     readable in any situation, we use rdmsrl_safe() to safely save
> >     these MSRs.
> >     
> >     Reported-and-tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> >     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> >     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >     Acked-by: Pavel Machek <pavel@ucw.cz>
> >     Cc: Andy Lutomirski <luto@amacapital.net>
> >     Cc: Borislav Petkov <bp@alien8.de>
> >     Cc: Brian Gerst <brgerst@gmail.com>
> >     Cc: Denys Vlasenko <dvlasenk@redhat.com>
> >     Cc: H. Peter Anvin <hpa@zytor.com>
> >     Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Thomas Gleixner <tglx@linutronix.de>
> >     Cc: bp@suse.de
> >     Cc: len.brown@intel.com
> >     Cc: linux@horizon.com
> >     Cc: luto@kernel.org
> >     Cc: rjw@rjwysocki.net
> >     Link: http://lkml.kernel.org/r/c9abdcbc173dd2f57e8990e304376f19287e92ba.1448382971.git.yu.c.chen@intel.com
> >     [ More edits to the naming of data structures. ]
> >     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> No git id of the patch in Linus's tree, or your signed-off-by?
>
I think the commit id in Linus'tree should be 7a9c2dd08eadd5c6943115dbbec040c38d2e0822

Thanks,
Chenyu

> Sasha, did your scripts trigger this unintentionally somehow?
> 
> thanks,
> 
> greg k-h
