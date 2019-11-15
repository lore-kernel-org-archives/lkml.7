Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1BE2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKORng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:43:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:15679 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfKORng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:43:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 09:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="199269947"
Received: from sgaffney-mobl3.amr.corp.intel.com (HELO localhost) ([10.252.4.81])
  by orsmga008.jf.intel.com with ESMTP; 15 Nov 2019 09:43:31 -0800
Date:   Fri, 15 Nov 2019 19:43:29 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
Message-ID: <20191115174329.GA22029@linux.intel.com>
References: <20191111233418.17676-1-jsnitsel@redhat.com>
 <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca>
 <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
 <20191114165357.GA11107@linux.intel.com>
 <20191114165629.GC26068@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114165629.GC26068@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:56:29PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 14, 2019 at 06:55:06PM +0200, Jarkko Sakkinen wrote:
> > > Would it function with the timeout values set at the beginning of
> > > tpm_tis_core_init (max values)?
> > 
> > tpm_get_timeouts() should be replaced with:
> > 
> > if (tpm_chip_start()) {
> > 	dev_err(dev, "Could not get TPM timeouts and durations\n");
> > 	rc = -ENODEV;
> > 	goto out_err;
> > }
> > 
> > tpm_stop_chip(chip);
> > 
> > tpm_get_timeouts() is called by tpm_auto_startup(). Also the function
> > should be moved to tpm_chip.c and converted to a static function so
> > that it won't be called from random cal sites like above.
> 
> Careful, the design here was to allow a driver to do only
> get_timeouts, then additional setup work, then do auto_startup()
> 
> Forcing a driver to do auto_startup too early may not be good.

All drivers always do it anyway because all drivers always call
tpm_chip_register().

/Jarkko
