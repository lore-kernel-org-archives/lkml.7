Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0067C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BA12147A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCLMuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:50:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:45513 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfCLMug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:50:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 05:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="281945649"
Received: from skalur-mobl.amr.corp.intel.com (HELO localhost) ([10.249.254.173])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2019 05:50:30 -0700
Date:   Tue, 12 Mar 2019 14:50:28 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Calvin Owens <calvinowens@fb.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
Message-ID: <20190312125028.GC9243@linux.intel.com>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
 <1552350463.23859.8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552350463.23859.8.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:27:43PM -0700, James Bottomley wrote:
> On Mon, 2019-03-11 at 16:54 -0700, Calvin Owens wrote:
> > e're having lots of problems with TPM commands timing out, and we're
> > seeing these problems across lots of different hardware (both v1/v2).
> > 
> > I instrumented the driver to collect latency data, but I wasn't able
> > to find any specific timeout to fix: it seems like many of them are
> > too aggressive. So I tried replacing all the timeout logic with a
> > single universal long timeout, and found that makes our TPMs 100%
> > reliable.
> > 
> > Given that this timeout logic is very complex, problematic, and
> > appears to serve no real purpose, I propose simply deleting all of
> > it.
> 
> "no real purpose" is a bit strong given that all these timeouts are
> standards mandated.  The purpose stated by the standards is that there
> needs to be a way of differentiating the TPM crashed from the TPM is
> taking a very long time to respond.  For a normally functioning TPM it
> looks complex and unnecessary, but for a malfunctioning one it's a
> lifesaver.

Standards should be only followed when they make practical sense and
ignored when not. The range is only up to 2s anyway.

/Jarkko
