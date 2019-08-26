Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B6C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5005321872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfHZUcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:32:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:9850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfHZUcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:32:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 13:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="181489287"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by fmsmga007.fm.intel.com with ESMTP; 26 Aug 2019 13:32:48 -0700
Date:   Mon, 26 Aug 2019 13:32:48 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
        patrick.colp@oracle.com, kanth.ghatraju@oracle.com,
        Jon.Grimm@amd.com, Thomas.Lendacky@amd.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/2] x86/microcode: Update late microcode in parallel
Message-ID: <20190826203248.GB49895@otc-nc-03>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085300.GB16813@zn.tnic>
 <2242cc6c-720d-e1bc-817b-c4bb7fddd420@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2242cc6c-720d-e1bc-817b-c4bb7fddd420@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 08:53:05AM -0400, Boris Ostrovsky wrote:
> On 8/24/19 4:53 AM, Borislav Petkov wrote:
> >  
> > +wait_for_siblings:
> > +	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
> > +		panic("Timeout during microcode update!\n");
> > +
> >  	/*
> > -	 * Increase the wait timeout to a safe value here since we're
> > -	 * serializing the microcode update and that could take a while on a
> > -	 * large number of CPUs. And that is fine as the *actual* timeout will
> > -	 * be determined by the last CPU finished updating and thus cut short.
> > +	 * At least one thread has completed update on each core.
> > +	 * For others, simply call the update to make sure the
> > +	 * per-cpu cpuinfo can be updated with right microcode
> > +	 * revision.
> 
> 
> What is the advantage of having those other threads go through
> find_patch() and (in Intel case) intel_get_microcode_revision() (which
> involves two MSR accesses) vs. having the master sibling update slaves'
> microcode revisions? There are only two things that need to be updated,
> uci->cpu_sig.rev and c->microcode.
> 

True, yes we could do that. But there is some warm and comfy feeling
that you really read the revision from the thread local copy of the revision
and it matches what was updated in the other thread sibling rather than
just hardcoding the fixup's. The code looks clean in the sense it looks like
you are attempting to upgrade but the new revision is reflected correctly
and you skip the update.

But if you feel complelled, i'm not opposed to it as long as Boris is 
happy with the changes :-).

Cheers,
Ashok



