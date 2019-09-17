Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A8C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701BD214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfIQO3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:29:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:41108 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfIQO3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:29:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 07:29:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; 
   d="scan'208";a="386556305"
Received: from araj-mobl1.jf.intel.com ([10.251.156.66])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2019 07:29:50 -0700
Date:   Tue, 17 Sep 2019 07:29:50 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johannes Erdfelt <johannes@erdfelt.com>,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20190917142949.GA28218@araj-mobl1.jf.intel.com>
References: <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
 <20190907003338.GA14807@araj-mobl1.jf.intel.com>
 <alpine.DEB.2.21.1909071236120.1902@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1909161227060.10731@nanos.tec.linutronix.de>
 <20190917003122.GA3005@otc-nc-03>
 <alpine.DEB.2.21.1909170824220.2066@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909170824220.2066@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Sep 17, 2019 at 08:37:10AM +0200, Thomas Gleixner wrote:
> > microode updates should be of 3 types.
> > 
> > - Only loadable from BIOS (Only via FIT tables)
> > - Suitable for early load (things that take cpuid bits for e.g.)
> > - Suitable for late-load. (Where no cpuid bits should change etc).
> > 
> > Today the way we load after a stop_machine() all threads in the system are
> > held hostage until all the cores have done the update. The thread sibling
> > is also in the rendezvous loop. 
> 
> I know. See below.
>  
> > Do you think we still have that risk with a sibling thread? 
> > (Assuming future ucodes don't do weird things like what happened in 
> > that case where a cpuid was removed via an update)
> 
> Well, yes. The sibling executes a limited set of instructions in a loop,
> but it might be hit by an NMI or MCE which executes even more instructions.

There is a plan to solve the NMI issue. Although there is one case we might
be showing as a spurious that might not be nice. If #MCE's showup there is
nothing we can do at that point. These are most likely unrecoverable. 
But we want to make sure we could atleast follow through with a proper reset.

Let me gather my thoughts on that when i have the patch ready to handle
those senarios.

> 
> So what happens if the ucode update "fixes" one of the executed
> instructions on the fly? Is that guaranteed to be safe? There is nothing
> which says so.
> 
> A decade ago I experimented with putting the spinning CPUs into MWAIT,
> which caused havoc. Did neither have time nor the stomach to dig into that
> further, but the ucode update _did_ fix an issue with MWAIT according to
> the version history.

Excellent point. 
> 
> That's why I'm worried about instructions being "fixed" which are executed
> in parallel on the sibling.
> 
> An authorative statement vs. that would be appreciated. Preferrably in form
> of an extension of the SDM, but an upfront statement in this thread would
> be a good start.

I have started the conversation internally. Once we have something solid
I'll share in the list, and also follow up with updates to SDM. 

Cheers,
Ashok

