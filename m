Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC1C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832762087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCMNWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:22:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:9210 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMNWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:22:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 06:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="126580762"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.103])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2019 06:22:33 -0700
Date:   Wed, 13 Mar 2019 15:22:32 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Calvin Owens <calvinowens@fb.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
Message-ID: <20190313132232.GB4261@linux.intel.com>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
 <1552410298.24794.73.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1552410298.24794.73.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:04:58PM -0400, Mimi Zohar wrote:
> On Mon, 2019-03-11 at 16:54 -0700, Calvin Owens wrote:
> > We're having lots of problems with TPM commands timing out, and we're
> > seeing these problems across lots of different hardware (both v1/v2).
> > 
> > I instrumented the driver to collect latency data, but I wasn't able to
> > find any specific timeout to fix: it seems like many of them are too
> > aggressive. So I tried replacing all the timeout logic with a single
> > universal long timeout, and found that makes our TPMs 100% reliable.
> > 
> > Given that this timeout logic is very complex, problematic, and appears
> > to serve no real purpose, I propose simply deleting all of it.
> 
> Normally before sending such a massive change like this, included in
> the bug report or patch description, there would be some indication as
> to which kernel introduced a regression.  Has this always been a
> problem?  Is this something new?  How new?

Also: is the problem in timeouts, durations or both. Does make sense
to fix something that isn't broken...

/Jarkko
