Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5246DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21335206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfC1NV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:21:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:5371 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1NV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:21:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 06:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138019257"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2019 06:21:55 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9Uyf-0002nM-T2; Thu, 28 Mar 2019 15:21:53 +0200
Date:   Thu, 28 Mar 2019 15:21:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Message-ID: <20190328132153.GZ9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
 <20190328130317.GG22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328130317.GG22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:03:17PM +0100, Borislav Petkov wrote:
> On Tue, Mar 19, 2019 at 09:43:25PM +0300, Andy Shevchenko wrote:
> > If by BIOS or by other means the serial port is configured
> > user might want to skip reconfiguration in the boot code.
> 
> That needs more explanation: how can that happen? 

I didn't get what is 'that' here? You mean that serial interface becomes
configured before kernel even starts? See below.

> How is the user
> supposed to know whether the serial port is configured in order to use
> this cmdline param?

If the connection to the target is done via serial interface and
firmware and / or bootloader already did necessary configuration.

> Why can't the kernel detect whether the serial port is configured and
> not touch that configuration?

Because it can't at this stage. We simple can't afford to move all serial
drivers (even partially) to the _boot_ part of the kernel.

> A lot of why's and head scratching...

What other why's should be answered?

-- 
With Best Regards,
Andy Shevchenko


