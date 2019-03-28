Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14385217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfC1NLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:11:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:4272 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfC1NLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:11:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 06:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126627882"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 06:11:41 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9Uom-0002i8-D1; Thu, 28 Mar 2019 15:11:40 +0200
Date:   Thu, 28 Mar 2019 15:11:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] x86/boot: Introduce helpers for serial I/O
Message-ID: <20190328131140.GX9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-3-andriy.shevchenko@linux.intel.com>
 <20190328123250.GE22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328123250.GE22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:32:50PM +0100, Borislav Petkov wrote:
> On Tue, Mar 19, 2019 at 09:43:20PM +0300, Andy Shevchenko wrote:
> > As preparatory to enable earlyprintk on non-standard ports on x86,
> > introduce serial_in() and serial_out() helpers to perform serial I/O.
> > 
> > No functional change intended.
> 
> ...
> 
> > +/* Assign serial I/O accessors */
> > +static void early_serial_use_io_accessors(void)
> > +{
> > +	/* These will always be IO based ports */
> > +	serial_in = io_serial_in;
> > +	serial_out = io_serial_out;
> > +}
> 
> This and the early_serial_use_mmio_accessors() in a later patch is just
> silly because you need to export and forward-declare those serial_in and
> serial_out function pointers in a bunch of places.

This is the same approach as it's done in earlyprintk support in the main part
of the kernel. Besides the fact that many drivers do it in the same way.

And I wouldn't call 'few' a 'bunch'...

> Just define exactly *two* simple functions serial_in() and serial_out()
> which have enough logic to decide whether to do serial IO or MMIO and
> put all that logic in those functions. 

Any idea how it can be done?

> No need for all that function
> pointer assignment "fun".

-- 
With Best Regards,
Andy Shevchenko


