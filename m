Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB35DC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C313D2173B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393418AbfIGAdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:33:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:28273 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbfIGAdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:33:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 17:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,474,1559545200"; 
   d="scan'208";a="213333308"
Received: from araj-mobl1.jf.intel.com ([10.251.147.175])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2019 17:33:39 -0700
Date:   Fri, 6 Sep 2019 17:33:38 -0700
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
Message-ID: <20190907003338.GA14807@araj-mobl1.jf.intel.com>
References: <41cee473-321c-2758-032a-ccf0f01359dc@oracle.com>
 <D8A3D2BD-1FD4-4183-8663-3EF02A6099F3@alien8.de>
 <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:16:00PM +0200, Thomas Gleixner wrote:
> 
> So if we want to do late microcode loading in a sane way then there are
> only a few options and none of them exist today:
> 
>  1) Micro-code contains a description of CPUID bits which are going to be
>     exposed after the load. Then the kernel can sanity check whether this
>     changes anything relevant or not. If there is a relevant change it can
>     reject the load and tell the admin that a reboot is required.

This is pretty much what we had in mind when we suggested to the uCode teams.

Just a process of providing a meta data file to accompany every uCode release.

IMO new cpuid bits are probably less harmful than old ones dissappearing.



> 
>  2) Rework CPUID feature handling so that it can reevaluate and reconfigure
>     the running system safely. There are a lot of things you need for that:
> 
>     A) Introduce a safe state for CPUs to reach which guarantees that none
>        of the CPUs will return from that state via a code path which
>        depends on previous state and might now go the other route with data
>        on the stack which only fits the previous configuration.
> 
>     B) Make all the cpufeature thingies run time switchable. That means
>        that you need to keep quite some code around which is currently init
>        only. That also means that you have to provide backout code for
>        things which set up data corresponding to cpu feature bits and so
>        forth.
> 
> So #2 might be finished in about 20 years from now with the result that
> some of the code pathes might simply still have a

Maybe we can catch the kernel side in 20 years.. user space would still be 
busted, or have a fault way to control new cpuid much like how we do for
VM's. 

> 
>      if (cpufeature_changed())
>      	   panic();
> 
> because there are things which you cannot back out. So the only sane
> solution is to panic. Which is not a solution as it would be much more sane
> to prevent late loading upfront and force people to reboot proper.
> 
> Now #1 is actually a sensible and feasible solution which can be pulled off
> in a reasonably short time frame, avoids all the bound to be ugly and
> failure laden attempts of fixing late loading completely and provides a
> usable and safe solution for joe user, jack admin and the super experts at
> big-cloud corporate.
> 
> That is not requiring any new format of microcode payload, as this can be
> nicely done as a metadata package which comes with the microcode
> payload. So you get the following backwards compatible states:
> 
>   Kernel  metadata	  result
> 
>   old	  don't care	  refuse late load
> 
>   new	  No   		  refuse late load
> 
>   new	  Yes		  decide based on metadata
> 
> Thoughts?

This is 100% in line with what we proposed... 

Cheers,
Ashok
