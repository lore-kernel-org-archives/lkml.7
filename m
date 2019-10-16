Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56169FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F3920872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392259AbfJPKlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:41:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:18006 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJPKlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:41:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 03:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="220735670"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.130])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2019 03:41:11 -0700
Date:   Wed, 16 Oct 2019 13:41:10 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
Message-ID: <20191016104110.GB10184@linux.intel.com>
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
 <CAE=NcraH_6nDe4Ax9axsbsrMf+EggCQFibY3dpNNgGm7NYTtJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=NcraH_6nDe4Ax9axsbsrMf+EggCQFibY3dpNNgGm7NYTtJQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:02:01AM +0300, Janne Karhunen wrote:
> On Tue, Oct 15, 2019 at 3:50 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > Salt the result that comes from the TPM RNG with random bytes from the
> > kernel RNG. This will allow to use tpm_get_random() as a substitute for
> > get_random_bytes().  TPM could have a bug (making results predicatable),
> > backdoor or even an inteposer in the bus. Salting gives protections
> > against these concerns.
> 
> The current issue in the randomness from my point of view is that
> encrypted filesystems, ima etc in common deployments require high
> quality entropy just few seconds after the system has powered on for
> the first time. It is likely that people want to keep their keys
> device specific, so the keys need to be generated on the first boot
> before any of the filesystems mount.

This patch does not have the described issue.

Which call sites are you talking about?

/Jarkko
