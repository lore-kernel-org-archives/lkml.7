Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C322173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1Nwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:52:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:20170 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1Nwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:52:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 06:52:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138153435"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 06:52:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9VSE-00034d-9J; Thu, 28 Mar 2019 15:52:26 +0200
Date:   Thu, 28 Mar 2019 15:52:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] x86/boot: Introduce helpers for serial I/O
Message-ID: <20190328135226.GB9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-3-andriy.shevchenko@linux.intel.com>
 <20190328123250.GE22720@zn.tnic>
 <20190328131140.GX9224@smile.fi.intel.com>
 <20190328132855.GH22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328132855.GH22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:28:55PM +0100, Borislav Petkov wrote:
> On Thu, Mar 28, 2019 at 03:11:40PM +0200, Andy Shevchenko wrote:
> > Any idea how it can be done?
> 
> Like this?
> 
> static u8 serial_inb(unsigned long addr, int offset)

It's not a generic serial_in()...

> {
> 	if (early_serial_do_mmio) {
> 		asm volatile("movb %1,%0" : "=q" (v) : "m" (*(volatile u8 __force *)addr));
> 
> 		return v;
> 	} else {
> 		 return inb(addr + offset);
> 	}
> }

What about mmio32 as next step?

Do we have to "fix" earlyprintk implementation in kernel to do the same?

-- 
With Best Regards,
Andy Shevchenko


