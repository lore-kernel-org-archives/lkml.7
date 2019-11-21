Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A565FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BAC20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfKUXCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:02:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:21331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfKUXCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:02:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 15:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,227,1571727600"; 
   d="scan'208";a="219259419"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2019 15:02:00 -0800
Date:   Thu, 21 Nov 2019 15:14:11 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 5/6] x86/split_lock: Handle #AC exception for split
 lock
Message-ID: <20191121231410.GD199273@romley-ivt3.sc.intel.com>
References: <1574297603-198156-6-git-send-email-fenghua.yu@intel.com>
 <5BDDAE0C-2D31-4779-B3A0-5BF206FF3E50@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BDDAE0C-2D31-4779-B3A0-5BF206FF3E50@amacapital.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:10:38PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Nov 20, 2019, at 5:45 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > 
> > +    if (!user_mode(regs) && split_lock_detect_enabled)
> > +        panic("Split lock detected\n");
> 
> NAK.
> 
> 1. Don’t say “split lock detected” if you don’t know that you detected a split lock.  Or is this genuinely the only way to get #AC from kernel mode?

Intel hardware design team confirmed that the only reason for #AC in ring 0 is
split lock.

> 
> 2. Don’t panic. Use die() just like every other error where nothing is corrupted.

Ok. Will change to die() which provides all the trace information and
allow multiple split lock in one boot.

> 
> And maybe instead turn off split lock detection and print a stack trace instead.  Then the kernel is even more likely to survive to log something useful.

How about we just use simple policy die() in this patch set to allow
detect and debug split lock issues and extend the code base to handle
split lock with different policies (panic, disable split lock, maybe other
options) in the future?

Thanks.

-Fenghua
 
