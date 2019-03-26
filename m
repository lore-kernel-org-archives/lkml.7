Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA24C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4EB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfCZW4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:56:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:60624 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfCZW4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:56:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 15:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="144145558"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Mar 2019 15:56:38 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 59A7C301BD4; Tue, 26 Mar 2019 15:56:38 -0700 (PDT)
Date:   Tue, 26 Mar 2019 15:56:38 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: New feature/ABI review process [was Re: [RESEND PATCH v6 04/12]
 x86/fsgsbase/64:..]
Message-ID: <20190326225638.GQ18020@tassilo.jf.intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1903251107300.1798@nanos.tec.linutronix.de>
 <20190326003804.GK18020@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1903261010380.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903261010380.1789@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> If you want to advocate the more complex design of mixed SWAPGS/FSGSBASE
> then provide numbers and not hand-waving. Numbers of real-world workloads,
> not numbers of artificial test cases which exercise the rare worst case.

Well you're proposing the much more complicated solution, not me.

SWAPGS is simple and it works everywhere except for paranoid.

> Yes, it's extra work and it's well spent. If the numbers are not
> significantly different then the simpler and consistent design is a clear
> win.

As long as everything is cache hot it's likely only a couple
of cycles difference (as Intel CPUs are very good executing
crappy code too), but if it's not then you end up with a huge cache miss
cost, causing jitter. That's a problem for real time for example.

>   > Accessing user GSBASE needs a couple of SWAPGS operations. It is
>   > avoidable if the user GSBASE is saved at kernel entry, being updated as
>   > changes, and restored back at kernel exit. However, it seems to spend
>   > more cycles for savings and restorations. Little or no benefit was
>   > measured from experiments.
> 
> So little or no benefit was measured. I don't see how that maps to your
> 'SWAPGS will be a lot faster' claim. One of those claims is obviously
> wrong.

If everything is cache hot it won't make much difference,
but if you have a cache miss you end up eating the cost.

> 
> Aside of this needs more than numbers:
> 
>   1) Proper documentation how the mixed bag is managed.

How SWAPGS is managed?

Like it always was since 20+ years when the x86_64
port was originally born.

The only case which has to do an two SWAPGS is the 
context switch when it switches the base. Everything else
just does SWAPGS at the edges for kernel entries.

> You have a track record of not caring much about either of these, but I
> very much care for good reasons. I've been bitten by glued on and half
> baked patches from Intel in the past 10 years so many times, that I'm
> simply refusing to take anything which is not properly structured and
> documented.

In this case you're proposing the change, the Intel patch just leaves
SWAPGS alone. So you have to describe why it's a good idea.
At least what you proposed on this wasn't convincing
and would be rejected by a proper code review.

-Andi

