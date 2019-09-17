Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B0FC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12E720650
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 00:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfIQAbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 20:31:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:5870 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfIQAbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 20:31:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 17:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="187303784"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by fmsmga007.fm.intel.com with ESMTP; 16 Sep 2019 17:31:22 -0700
Date:   Mon, 16 Sep 2019 17:31:22 -0700
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
Message-ID: <20190917003122.GA3005@otc-nc-03>
References: <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de>
 <20190907003338.GA14807@araj-mobl1.jf.intel.com>
 <alpine.DEB.2.21.1909071236120.1902@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1909161227060.10731@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909161227060.10731@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 12:36:11PM +0200, Thomas Gleixner wrote:
> > On Fri, 6 Sep 2019, Raj, Ashok wrote:
> > > On Fri, Sep 06, 2019 at 11:16:00PM +0200, Thomas Gleixner wrote:
> > > > Now #1 is actually a sensible and feasible solution which can be pulled off
> > > > in a reasonably short time frame, avoids all the bound to be ugly and
> > > > failure laden attempts of fixing late loading completely and provides a
> > > > usable and safe solution for joe user, jack admin and the super experts at
> > > > big-cloud corporate.
> > > > 
> > > > That is not requiring any new format of microcode payload, as this can be
> > > > nicely done as a metadata package which comes with the microcode
> > > > payload. So you get the following backwards compatible states:
> > > > 
> > > >   Kernel  metadata	  result
> > > > 
> > > >   old	  don't care	  refuse late load
> > > > 
> > > >   new	  No   		  refuse late load
> > > > 
> > > >   new	  Yes		  decide based on metadata
> > > > 
> > > > Thoughts?
> > > 
> > > This is 100% in line with what we proposed... 
> > 
> > So what it hindering you to implement that? ucode teams whining about the
> > little bit of extra work?
> 
> That said, there is also a distinct lack of information about micro code
> loading in a safe way in general. We absolutely do not know whether a micro
> code update affects any instruction which might be in use during the update
> on a sibling. Right now it's all load and pray and the SDM is not really
> helpful with that either.
> 

Guilty as charged :-). In general we do not expect microcode updates to 
remove any cpuid bits (Not that it hasn't happened, but it slipped through
the cracks). 

microode updates should be of 3 types.

- Only loadable from BIOS (Only via FIT tables)
- Suitable for early load (things that take cpuid bits for e.g.)
- Suitable for late-load. (Where no cpuid bits should change etc).

Today the way we load after a stop_machine() all threads in the system are
held hostage until all the cores have done the update. The thread sibling
is also in the rendezvous loop. 

Do you think we still have that risk with a sibling thread? 
(Assuming future ucodes don't do weird things like what happened in 
that case where a cpuid was removed via an update)

Cheers,
Ashok
