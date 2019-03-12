Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B434C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761F32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfCLPjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:39:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:49949 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfCLPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:39:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 08:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="140141856"
Received: from djustese-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.184])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Mar 2019 08:39:32 -0700
Date:   Tue, 12 Mar 2019 17:39:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Calvin Owens <calvinowens@fb.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
Message-ID: <20190312153931.GA9927@linux.intel.com>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
 <1552350463.23859.8.camel@HansenPartnership.com>
 <20190312125028.GC9243@linux.intel.com>
 <1552401766.3083.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552401766.3083.3.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 07:42:46AM -0700, James Bottomley wrote:
> On Tue, 2019-03-12 at 14:50 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 11, 2019 at 05:27:43PM -0700, James Bottomley wrote:
> > > On Mon, 2019-03-11 at 16:54 -0700, Calvin Owens wrote:
> > > > e're having lots of problems with TPM commands timing out, and
> > > > we're seeing these problems across lots of different hardware
> > > > (both v1/v2).
> > > > 
> > > > I instrumented the driver to collect latency data, but I wasn't
> > > > able to find any specific timeout to fix: it seems like many of
> > > > them are too aggressive. So I tried replacing all the timeout
> > > > logic with a single universal long timeout, and found that makes
> > > > our TPMs 100% reliable.
> > > > 
> > > > Given that this timeout logic is very complex, problematic, and
> > > > appears to serve no real purpose, I propose simply deleting all
> > > > of it.
> > > 
> > > "no real purpose" is a bit strong given that all these timeouts are
> > > standards mandated.  The purpose stated by the standards is that
> > > there needs to be a way of differentiating the TPM crashed from the
> > > TPM is taking a very long time to respond.  For a normally
> > > functioning TPM it looks complex and unnecessary, but for a
> > > malfunctioning one it's a lifesaver.
> > 
> > Standards should be only followed when they make practical sense and
> > ignored when not. The range is only up to 2s anyway.
> 
> I don't disagree ... and I'm certainly not going to defend the TCG
> because I do think the complexity of some of its standards contributed
> to the lack of use of TPM 1.2.
> 
> However, I am saying we should root cause this problem rather than take
> a blind shot at the apparent timeout complexity.  My timeout
> instability is definitely related to the polling adjustments, so it's
> not unreasonable to think Facebooks might be as well.

Yeah, referring to my review comment, I think the very first thing
that should be done is to split patch into two. Then we can probably
give better feedback.

/Jarkko
