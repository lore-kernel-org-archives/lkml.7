Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87332073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgAGWgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:36:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:60371 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgAGWgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:36:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 14:36:07 -0800
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="217894699"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 14:36:07 -0800
Date:   Tue, 7 Jan 2020 14:36:06 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Add support for fast short rep mov
Message-ID: <20200107223606.GA32598@agluck-desk2.amr.corp.intel.com>
References: <20191212225210.GA22094@zn.tnic>
 <20191216214254.26492-1-tony.luck@intel.com>
 <20200107184003.GK29542@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107184003.GK29542@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 07:40:03PM +0100, Borislav Petkov wrote:
> I don't mind this graph being part of the commit message - it shows
> nicely the speedup even if with some microbenchmark. Or you're not
> adding it just because it is a microbenchmark and not something more
> representative?

I'm not sure it should be archived forever in the commit message.
The benchmark was run on A-step silicon, so may not be representative
of production results.

> >  .Lmemmove_begin_forward:
> > +	ALTERNATIVE "cmp $0x20, %rdx; jb 1f", "", X86_FEATURE_FSRM
> 
> So the enhancement is for string lengths up to two cachelines. Why
> are you limiting this to 32 bytes?
> 
> I know, the function handles 32-bytes at a time but what I'd imagine
> here is having the fastest variant upfront which does REP; MOVSB for all
> lengths since FSRM means fast short strings and ERMS - and I'm strongly
> assuming here FSRM *implies* ERMS - means fast "longer" strings, so to
> speak, so FSRM would mean fast *all length* strings in the end, no?
> 
> Also, does the copy direction influence the FSRM's REP; MOVSB variant's
> performance? If not, you can do something like this:

Yes FSRM implies ERMS

You can't use REP MOVS for overlapping src/dst strings (not even with the fancy
newer, faster, shinier FSRM version). So your suggestion will not work.

The old memmove code looked something like:

	if (len < 32)
		copy tail (backwards ... 8/4/2/1 bytes. works for both overlap & non-overlap case)
		return
	else if overlap src/dst
		copy backwards 32-byte unrolled
		copy tail
		return
	else if (ERMS)
		REP MOVS;
		return
	else
		unrolled copy 32-byte
		copy tail

The new one with my changes looks something like

	if (! overlap src/dst)
		if (FSRM)
			rep movs
			return
		if (len < 32)
			copy tail
			return
		if (ERMS)
			rep movs
			return
		unrolled copy
	else
		if (len < 32)
			copy tail
			return
		copy backwards 32-byte unrolled
		copy tail

-Tony
