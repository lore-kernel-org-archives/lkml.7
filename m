Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876BBC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6518720867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfJGMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:05:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:3131 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfJGMFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:05:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 05:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,268,1566889200"; 
   d="scan'208";a="196267827"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2019 05:05:18 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHRlN-0007rE-Ff; Mon, 07 Oct 2019 15:05:17 +0300
Date:   Mon, 7 Oct 2019 15:05:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tuowen Zhao <ztuowen@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        bhelgaas@google.com, kai.heng.feng@canonical.com
Subject: Re: [PATCH] mfd: intel-lpss: use devm_ioremap_uc for mmio
Message-ID: <20191007120517.GX32742@smile.fi.intel.com>
References: <20190927175513.31054-1-ztuowen@gmail.com>
 <20190930110522.GT32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930110522.GT32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 02:05:22PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 27, 2019 at 11:55:13AM -0600, Tuowen Zhao wrote:
> > Write-combining BAR for intel-lpss-pci in MTRR causes system hangs
> > during boot.
> > 
> > This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
> > and with it forces the use of strongly uncachable mmio in intel-lpss.
> > 
> > This bahavior is seen on Dell XPS 13 7390 2-in-1:
> > 
> > [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
> > 
> > 4000000000-7fffffffff : PCI Bus 0000:00
> >   4000000000-400fffffff : 0000:00:02.0 (i915)
> >   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
> 
> +Cc: Luis as author of UC flavour of ioremap.
> 
> Luis, some BIOSes in the wild have wrong MTRR setting for PCI resource window
> and thus when Linux tries to allocate 64-bit MMIO address space (and in
> opposite to Windows, which does this from the end of available space towards
> beginning, Linux do this from the beginning towards end). Ideally we have to
> push vendors to fix firmware.
> 
> This patch AFAIU overrides MTTR/PAT settings for those pages and makes it
> possible to workaround firmware bug.
> 
> What do you think is the best approach here?

Tuowen,

since Luis didn't respond, I think we may proceed with v2 after addressing
Mika's comments.

-- 
With Best Regards,
Andy Shevchenko


