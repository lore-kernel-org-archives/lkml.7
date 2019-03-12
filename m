Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6031CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C442087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCLO4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:56:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:54689 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfCLOz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:55:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 07:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="130978116"
Received: from djustese-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.184])
  by fmsmga008.fm.intel.com with ESMTP; 12 Mar 2019 07:55:54 -0700
Date:   Tue, 12 Mar 2019 16:55:53 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
Message-ID: <20190312145553.GB6682@linux.intel.com>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:54:04PM -0700, Calvin Owens wrote:
> We're having lots of problems with TPM commands timing out, and we're
> seeing these problems across lots of different hardware (both v1/v2).
> 
> I instrumented the driver to collect latency data, but I wasn't able to
> find any specific timeout to fix: it seems like many of them are too
> aggressive. So I tried replacing all the timeout logic with a single
> universal long timeout, and found that makes our TPMs 100% reliable.
> 
> Given that this timeout logic is very complex, problematic, and appears
> to serve no real purpose, I propose simply deleting all of it.
> 
> Signed-off-by: Calvin Owens <calvinowens@fb.com>

In the current form the commit is doing way too much. I would like to
consider duration (command-response latency) and timeouts (state change
latency) separately.

/Jarkko
