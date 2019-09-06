Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4211C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EED20838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393204AbfIFQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:55:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:57841 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392393AbfIFQz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:55:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 09:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="199554792"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2019 09:55:25 -0700
Date:   Fri, 6 Sep 2019 09:55:25 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906165525.GA6918@otc-nc-03>
References: <20190829130213.GA23510@araj-mobl1.jf.intel.com>
 <20190903164630.GF11641@zn.tnic>
 <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Sep 06, 2019 at 02:51:17PM +0200, Thomas Gleixner wrote:
> Raj,
> 
> On Thu, 5 Sep 2019, Raj, Ashok wrote:
> > On Thu, Sep 05, 2019 at 11:22:31PM +0200, Thomas Gleixner wrote:
> > > That's all nice, but what it the general use case for this outside of Intel's
> > > microcode development and testing?
> > > 
> > > We all know that late microcode loading has severe limitations and we
> > > really don't want to proliferate that further if not absolutely required
> > 
> > Several customers have asked this to check the safety of late loads. They want
> > to validate in production setup prior to rolling late-load to all production systems.
> 
> Groan. Late loading _IS_ broken by definition and it was so forever.

Lets tighten the seat belts :-).. I'm with you that late-loading has
shown weakness more recently than earlier. There are several obvious reasons
that you are well aware. But there is a lot that *must* be done to make sure
the guard rails are tight enough for deplopying late-load. 100% agree on that
to make sure the interface and mechanism needs to be improved for robustness
but not a candidate for removal. Certainly this is an argument that would help
me drive towards that objective internally.

> 
> What your customers are asking for is a receipe for disaster. They can
> check the safety of late loading forever, it will not magically become safe
> because they do so.
> 
> If you want late loading, then the whole approach needs to be reworked from
> ground up. You need to make sure that all CPUs are in a safe state,
> i.e. where switching of CPU feature bits of all sorts can be done with the
> guarantee that no CPU will return to the wrong code path after coming out
> of safe state and that any kernel internal state which depends on the
> previous set of CPU feature bits has been mopped up and switched over
> before CPUs are released.
> 
> That does not exist and unless it does, late loading is just going to cause
> trouble nothing else.
> 
> So, no. We are not merging something which is known to be broken and then
> we have to deal with the subtle fallout and the bug reports forever. Not to

When we did the late-load changes last year we added a warning if any
of the cpuid bits either dissappear or new ones appear. Maybe we should
have tainted the kernel to track that so its not that subtle anymore. 

> talk about having to fend of half baken duct tape patches which try to glue
> things together.
> 
> The only sensible patch for that is to remove any trace of late loading
> crappola once and forever.
> 
> Sorry, -ENOPONIES

:-)

Cheers,
Ashok
