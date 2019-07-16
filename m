Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA20CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E16920693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 00:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfGPAcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 20:32:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:41711 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730383AbfGPAcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:32:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 17:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,494,1557212400"; 
   d="scan'208";a="318836457"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2019 17:32:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id F2220301AE9; Mon, 15 Jul 2019 17:32:22 -0700 (PDT)
Date:   Mon, 15 Jul 2019 17:32:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
Message-ID: <20190716003222.GJ32439@tassilo.jf.intel.com>
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <8736j7gsza.fsf@linux.intel.com>
 <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
 <CAFULd4bcB8tsgZuxZJm_ksp5zyDQXjO=v_Ov622Bmhx=fr7KuA@mail.gmail.com>
 <alpine.DEB.2.21.1907152129350.1767@nanos.tec.linutronix.de>
 <20190715193836.GF32439@tassilo.jf.intel.com>
 <CALCETrVonxn6tDkxZnbetM9W4Uxxm7-M-tv1e7YsieX3U5OBKA@mail.gmail.com>
 <20190715225305.GI32439@tassilo.jf.intel.com>
 <CALCETrW8yTRyP3qnOv04B2XvR5ZHDUky15CCBR2gtNVG3bea-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW8yTRyP3qnOv04B2XvR5ZHDUky15CCBR2gtNVG3bea-Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 04:10:36PM -0700, Andy Lutomirski wrote:
> On Mon, Jul 15, 2019 at 3:53 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > I haven't tested on a real kernel with i915.  Does i915 really hit
> > > this code path?  Does it happen more than once or twice at boot?
> >
> > Yes some workloads allocate/free a lot of write combined memory
> > for graphics objects.
> >
> 
> But where does that memory come from?  If it's from device memory
> (i.e. memory that's not in the kernel direct map), then, unless I
> missed something, we're never changing the cache mode per se -- we're
> just ioremap_wc-ing it, which doesn't require a flush.

Integraded graphics doesn't have device memory. There's an reserved
memory area, but a lot of the buffers the GPU works with
come from main memory.


-Andi
